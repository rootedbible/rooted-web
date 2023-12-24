import 'dart:typed_data';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:rooted_web/bloc/auth/auth_bloc.dart';
import 'package:rooted_web/const.dart';
import 'package:rooted_web/models/organization_model.dart';
import 'package:rooted_web/ui/widgets/divider_line.dart';
import 'package:rooted_web/utils/capitalize.dart';
import 'package:universal_html/html.dart';

import '../../api/services/organizations_service.dart';
import '../../api/services/subscriptions_service.dart';
import '../../models/plan_model.dart';
import '../widgets/error_dialog.dart';

class CreateOrgScreen extends StatefulWidget {
  final Organization? organization;

  const CreateOrgScreen(this.organization, {super.key});

  @override
  State<CreateOrgScreen> createState() => _CreateOrgScreenState();
}

class _CreateOrgScreenState extends State<CreateOrgScreen> {
  final _formKey = GlobalKey<FormState>();
  final double _formWidth = 400;
  bool imageLoading = false;

  String selectedDuration = monthlyDuration;

  // CroppedFile? croppedFile;
  bool loading = false;
  bool inviteOnly = false;
  List<Plan> plans = [];
  Plan currentPlan = Plan.empty;

  TextEditingController organizationUsernameController =
      TextEditingController();
  TextEditingController organizationNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressTwoController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController tiktokController = TextEditingController();

  Uint8List? imageBytes;

  int currentStep = 0;
  late List<Widget> steps;

  @override
  void initState() {
    super.initState();
    getPlans();
  }

  @override
  Widget build(BuildContext context) {
    steps = [
      _buildStepOne(),
    ];
    if (currentPlan.type != individualType) {
      steps.addAll([_buildStepTwo(), _buildStepThree(), _buildStepFour()]);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Create Subscription'),
      ),
      body: plans.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              // Moved up to wrap the entire page content
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildSteps(),
                      SizedBox(
                        width: _formWidth,
                        child: steps[currentStep],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildSteps() {
    return SizedBox(
      width: _formWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStepTile(index: 0, text: 'Plan'),
          if (currentPlan.type != individualType)
            const Expanded(child: DividerLine()),
          if (currentPlan.type != individualType)
            _buildStepTile(index: 1, text: 'Info'),
          if (currentPlan.type != individualType)
            const Expanded(child: DividerLine()),
          if (currentPlan.type != individualType)
            _buildStepTile(index: 2, text: 'Contact'),
          if (currentPlan.type != individualType)
            const Expanded(child: DividerLine()),
          if (currentPlan.type != individualType)
            _buildStepTile(index: 3, text: 'Socials'),
        ],
      ),
    );
  }

  Widget _buildStepTile({required int index, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        width: 96,
        decoration: BoxDecoration(
          color: index == currentStep
              ? Theme.of(context).colorScheme.secondary
              : null,
          border: index == currentStep
              ? Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 2,
                )
              : null,
          borderRadius: BorderRadius.circular(45),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text),
          ),
        ),
      ),
    );
  }

  Widget _buildPlanTypes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _planTypeTile(0, individualType, Icons.person),
        _planTypeTile(1, coupleType, Icons.group),
        _planTypeTile(2, familyType, Icons.groups),
      ],
    );
  }

  Widget _planTypeTile(int index, String type, IconData iconData) {
    final bool isSelected = currentPlan.type == type;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: InkWell(
        onTap: () => switchType(type),
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: isSelected
              ? BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .outline, // Directly use context
                    width: 2,
                  ),
                )
              : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(iconData),
              const Gap(4),
              Text(capitalizeFirstLetter(type)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepOne() {
    return Column(
      children: [
        _buildPlanTypes(),
        if (currentPlan.type != individualType) _buildSizes(),
        _buildDurations(),
        if (currentPlan.type != individualType)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Invite Only'),
                Switch(
                  value: inviteOnly,
                  onChanged: (value) {
                    setState(() {
                      inviteOnly = value;
                    });
                  },
                ),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            onPressed: () async {
              if (currentPlan.type == individualType) {
                await submitForm();
              } else {
                setState(() {
                  currentStep += 1;
                });
              }
            },
            child: Text(
              currentPlan.type == individualType
                  ? 'Proceed to Checkout'
                  : 'Continue',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSizes() {
    // TODO: Make it more flexible for organizations
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (currentPlan.type == coupleType) _buildQuantity(2),
          if (currentPlan.type == familyType) _buildQuantity(5),
          if (currentPlan.type == familyType) _buildQuantity(10),
          if (currentPlan.type == familyType) _buildQuantity(20),
        ],
      ),
    );
  }

  Widget _buildQuantity(int maxMembers) {
    return Container(
      width: 128,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        border:
            maxMembers == currentPlan.maxMembers ? Border.all(width: 2) : null,
        color: maxMembers == currentPlan.maxMembers
            ? Theme.of(context).colorScheme.secondary
            : null,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () => setQuantity(maxMembers),
            child: Text(
              'Up to $maxMembers members',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDurations() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: _formWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              border: selectedDuration == monthlyDuration
                  ? Border.all(width: 2)
                  : null,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () => setState(() {
                    selectedDuration = monthlyDuration;
                  }),
                  child: Text(
                    'Monthly @ \$${currentPlan.monthlyPrice}/mo\n(Most Popular)',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: _formWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              border: selectedDuration == yearlyDuration
                  ? Border.all(width: 2)
                  : null,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () => setState(() {
                    selectedDuration = yearlyDuration;
                  }),
                  child: Text(
                    'Annually @ \$${currentPlan.monthlyPrice}/yr\n(Two Months Free)',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepTwo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        formTile(
          'Group Username*',
          TextFormField(
            controller: organizationUsernameController,
            decoration: const InputDecoration(hintText: 'ex: smithFamily'),
            validator: (_) {
              if (organizationUsernameController.text.trim().length < 4) {
                'Must be at least 4 Characters';
              }
              return null;
            },
          ),
        ),
        formTile(
          'Group Name*',
          TextFormField(
            controller: organizationNameController,
            decoration: const InputDecoration(hintText: 'ex: The Smiths'),
            validator: (_) {
              if (organizationNameController.text.trim().length < 4) {
                'Must be at least 4 Characters';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Group Description'),
              SizedBox(
                height: 250,
                child: TextFormField(
                  maxLength: 250,
                  minLines: 5,
                  maxLines: 5,
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText:
                        'ex. Pursuing Jesus together on Rooted since 2024',
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => setState(() {
                currentStep -= 1;
              }),
              child: const Text('Back'),
            ),
            ElevatedButton(
              onPressed: () => setState(() {
                currentStep += 1;
              }),
              child: const Text('Continue'),
            ),
          ],
        ),
      ],
    );
  }

  Widget formTile(String title, TextFormField textFormField) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [Text(title), textFormField],
      ),
    );
  }

  Widget _buildStepThree() {
    return Column(
      children: [
        formTile(
          'Email*',
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              hintText: 'Enter email address',
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Email is required';
              }
              if (!EmailValidator.validate(value)) {
                return 'Invalid email format';
              }
              return null;
            },
          ),
        ),
        formTile(
          'Phone',
          TextFormField(
            controller: phoneController,
            decoration: const InputDecoration(
              hintText: 'Enter phone number',
            ),
            keyboardType: TextInputType.phone,
          ),
        ),
        formTile(
          'Address',
          TextFormField(
            controller: addressController,
            decoration: const InputDecoration(
              hintText: 'Enter address',
            ),
          ),
        ),
        formTile(
          'Address Two',
          TextFormField(
            controller: addressTwoController,
            decoration: const InputDecoration(
              hintText: 'Enter second address line',
            ),
          ),
        ),
        formTile(
          'City',
          TextFormField(
            controller: cityController,
            decoration: const InputDecoration(
              hintText: 'City',
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: formTile(
                'State',
                TextFormField(
                  controller: stateController,
                  decoration: const InputDecoration(
                    labelText: 'State',
                    hintText: 'Enter state',
                  ),
                ),
              ),
            ),
            const Gap(8),
            Expanded(
              child: formTile(
                'Zip',
                TextFormField(
                  controller: zipController,
                  decoration: const InputDecoration(
                    labelText: 'Zip',
                    hintText: 'Enter ZIP code',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      if (value.length != 5) {
                        return 'A Zip Code is 5 Digits';
                      }
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => setState(() {
                  currentStep -= 1;
                }),
                child: const Text('Back'),
              ),
              ElevatedButton(
                onPressed: () => setState(() {
                  currentStep += 1;
                }),
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStepFour() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        formTile(
          'Instagram',
          TextFormField(
            controller: instagramController,
            decoration: const InputDecoration(
              prefixText: 'instagram.com/',
            ),
          ),
        ),
        formTile(
          'Facebook',
          TextFormField(
            controller: facebookController,
            decoration: const InputDecoration(
              prefixText: 'facebook.com/',
            ),
          ),
        ),
        formTile(
          'X',
          TextFormField(
            controller: twitterController,
            decoration: const InputDecoration(
              prefixText: 'x.com/',
            ),
          ),
        ),
        formTile(
          'TikTok',
          TextFormField(
            controller: tiktokController,
            decoration: const InputDecoration(
              prefixText: 'tiktok.com/',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => setState(() {
                  currentStep -= 1;
                }),
                child: const Text('Back'),
              ),
              ElevatedButton(
                onPressed: () async => await submitForm(),
                child: const Text('Proceed to Checkout'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // TODO: Move this to the BLoC
  Future<void> submitForm() async {
    if ((currentPlan.type == individualType ||
            _formKey.currentState?.validate() == true) &&
        !loading) {
      setState(() {
        loading = true;
      });
      try {
        Organization? popOrganization;
        int id = -1;
        if (currentPlan.type == individualType &&
            context.read<AuthBloc>().user.subscription != null &&
            context.read<AuthBloc>().user.subscription!.isActive) {
          throw 'You already have an active individual account';
        } else if (widget.organization == null) {
          final String url = await SubscriptionsService().createSubscription(
            currentPlan.type,
            planId: currentPlan.id,
            priceId: selectedDuration == monthlyDuration
                ? currentPlan.stripeMonthly
                : currentPlan.stripeAnnual,
            frequency: selectedDuration,
            uniqueName: organizationUsernameController.text.trim(),
            email: emailController.text.trim(),
            name: organizationNameController.text.trim(),
            description: descriptionController.text.trim().isEmpty
                ? null
                : descriptionController.text.trim(),
            phone: phoneController.text.trim().isEmpty
                ? null
                : phoneController.text.trim(),
            address: addressController.text.trim().isEmpty
                ? null
                : addressController.text.trim(),
            addressTwo: addressTwoController.text.trim().isEmpty
                ? null
                : addressTwoController.text.trim(),
            city: cityController.text.trim().isEmpty
                ? null
                : cityController.text.trim(),
            state: stateController.text.trim().isEmpty
                ? null
                : stateController.text.trim(),
            zip: zipController.text.trim().isEmpty
                ? null
                : zipController.text.trim(),
            website: null,
            facebook: facebookController.text.trim().isEmpty
                ? null
                : facebookController.text.trim(),
            instagram: instagramController.text.trim().isEmpty
                ? null
                : instagramController.text.trim(),
            tiktok: tiktokController.text.trim().isEmpty
                ? null
                : tiktokController.text.trim(),
            x: twitterController.text.trim().isEmpty
                ? null
                : twitterController.text.trim(),
            inviteOnly: inviteOnly,
          );
          window.location.href = url;
        } else {
          id = widget.organization!.uniqueId;
          await OrganizationsService().editOrganization(
            widget.organization!.uniqueId,
            uniqueName: organizationUsernameController.text.trim(),
            email: emailController.text.trim(),
            name: organizationNameController.text.trim(),
            description: descriptionController.text.trim().isEmpty
                ? null
                : descriptionController.text.trim(),
            phone: phoneController.text.trim().isEmpty
                ? null
                : phoneController.text.trim(),
            address: addressController.text.trim().isEmpty
                ? null
                : addressController.text.trim(),
            addressTwo: addressTwoController.text.trim().isEmpty
                ? null
                : addressTwoController.text.trim(),
            city: cityController.text.trim().isEmpty
                ? null
                : cityController.text.trim(),
            state: stateController.text.trim().isEmpty
                ? null
                : stateController.text.trim(),
            zip: zipController.text.trim().isEmpty
                ? null
                : zipController.text.trim(),
            website: null,
            facebook: facebookController.text.trim().isEmpty
                ? null
                : facebookController.text.trim(),
            instagram: instagramController.text.trim().isEmpty
                ? null
                : instagramController.text.trim(),
            tiktok: tiktokController.text.trim().isEmpty
                ? null
                : tiktokController.text.trim(),
            x: twitterController.text.trim().isEmpty
                ? null
                : twitterController.text.trim(),
            inviteOnly: inviteOnly,
          );
          popOrganization = widget.organization!.copyWith(
            username: organizationUsernameController.text.trim(),
            email: emailController.text.trim(),
            name: organizationNameController.text.trim(),
            description: descriptionController.text.trim().isEmpty
                ? null
                : descriptionController.text.trim(),
            phone: phoneController.text.trim().isEmpty
                ? null
                : phoneController.text.trim(),
            address: addressController.text.trim().isEmpty
                ? null
                : addressController.text.trim(),
            addressTwo: addressTwoController.text.trim().isEmpty
                ? null
                : addressTwoController.text.trim(),
            city: cityController.text.trim().isEmpty
                ? null
                : cityController.text.trim(),
            state: stateController.text.trim().isEmpty
                ? null
                : stateController.text.trim(),
            zip: zipController.text.trim().isEmpty
                ? null
                : zipController.text.trim(),
            website: null,
            facebook: facebookController.text.trim().isEmpty
                ? null
                : facebookController.text.trim(),
            instagram: instagramController.text.trim().isEmpty
                ? null
                : instagramController.text.trim(),
            tiktok: tiktokController.text.trim().isEmpty
                ? null
                : tiktokController.text.trim(),
            x: twitterController.text.trim().isEmpty
                ? null
                : twitterController.text.trim(),
            isPrivate: inviteOnly,
          );
        }
        if (imageBytes != null) {
          await OrganizationsService().updateProfileImage(imageBytes!, id);
          if (widget.organization != null) {
            popOrganization =
                await OrganizationsService().getOrganizationById(id);
          }
        }
        setState(() {
          loading = false;
        });
        Navigator.pop(context, popOrganization);
      } catch (e) {
        setState(() {
          loading = false;
        });
        errorDialog(e.toString(), context);
        debugPrint('Failed to create organization: $e');
      }
    } else {
      errorDialog('Not all fields were filled out correctly!', context);
    }
  }

  Future<void> getPlans() async {
    try {
      List<Plan> plans = (await SubscriptionsService().getPlans()).plans;
      setState(() {
        this.plans = plans;
        currentPlan = plans.first;
      });
    } catch (e) {
      debugPrint('Error Getting plans: $e');
    }
  }

  void switchType(String type) {
    setState(() {
      currentPlan = plans.firstWhere((element) => element.type == type);
    });
  }

  void setQuantity(int maxMembers) {
    setState(() {
      currentPlan = plans.firstWhere(
        (element) =>
            element.type == currentPlan.type &&
            element.maxMembers == maxMembers,
      );
    });
  }
}
