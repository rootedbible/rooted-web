import 'dart:typed_data';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// import 'package:image/image.dart' as img;


import '../../api/services/organizations_service.dart';
import '../../api/services/subscriptions_service.dart';
import '../../models/organization_model.dart';
import '../../models/plan_model.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_screen.dart';
import '../widgets/small_wheel.dart';

class CreateOrganizationScreen extends StatefulWidget {
  final Organization? organization;

  const CreateOrganizationScreen(this.organization, {super.key});

  @override
  State<CreateOrganizationScreen> createState() =>
      _CreateOrganizationScreenState();
}

class _CreateOrganizationScreenState extends State<CreateOrganizationScreen> {
  Uint8List? imageBytes;
  int _activeCurrentStep = 0;
  final _formKey = GlobalKey<FormState>();
  final double gapSize = 8.0;
  bool imageLoading = false;
  // CroppedFile? croppedFile;
  bool loading = false;
  bool _isInviteOnly = false;
  final List<bool> _selectedType = [
    true,
    false,
  ]; // Individual, Family, Group
  List<Plan> plans = [];

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

  bool isValidEmail(String email) {
    return EmailValidator.validate(email);
  }

  @override
  void initState() {
    super.initState();
    getPlans();
    if (widget.organization != null) {
      final Organization organization = widget.organization!;
      // Non-Null
      _isInviteOnly = organization.isPrivate;
      organizationUsernameController.text = organization.username;
      organizationNameController.text = organization.name;
      emailController.text = organization.email;
      // Nullable
      descriptionController.text = organization.description ?? '';
      phoneController.text = organization.phone ?? '';
      addressController.text = organization.address ?? '';
      addressTwoController.text = organization.addressTwo ?? '';
      cityController.text = organization.city ?? '';
      stateController.text = organization.state ?? '';
      zipController.text = organization.zip ?? '';
      instagramController.text = organization.instagram ?? '';
      facebookController.text = organization.facebook ?? '';
      twitterController.text = organization.x ?? '';
      tiktokController.text = organization.tiktok ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.organization != null ? "Edit" : "Create"} Organization',
        ),
      ),
      body: plans.isEmpty
          ? const LoadingScreen(
              text: 'Getting Plans...',
            )
          : Form(
              key: _formKey,
              child: Stepper(
                controlsBuilder: (context, controls) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (_activeCurrentStep != 0)
                          ElevatedButton(
                            onPressed: controls.onStepCancel,
                            child: const Text('Back'),
                          ),
                        ElevatedButton(
                          onPressed: controls.onStepContinue,
                          child: loading
                              ? const SmallWheel()
                              : Text(
                                  _activeCurrentStep == 2 &&
                                          widget.organization != null
                                      ? 'Update'
                                      : _activeCurrentStep == 2
                                          ? 'Create'
                                          : 'Continue',
                                ),
                        ),
                      ],
                    ),
                  );
                },
                type: StepperType.horizontal,
                currentStep: _activeCurrentStep,
                onStepContinue: () async {
                  if (_activeCurrentStep < 2) {
                    setState(() {
                      _activeCurrentStep += 1;
                    });
                  } else {
                    try {
                      await submitForm();
                    } catch (e) {
                      errorDialog(e.toString(), context);
                    }
                  }
                },
                onStepCancel: () {
                  if (_activeCurrentStep > 0) {
                    setState(() {
                      _activeCurrentStep -= 1;
                    });
                  }
                },
                onStepTapped: (int index) {
                  setState(() {
                    if (index < _activeCurrentStep) {
                      _activeCurrentStep = index;
                    }
                  });
                },
                steps: [
                  Step(
                    title: Text(
                      'Basic Info',
                      style: TextStyle(
                        fontWeight: _activeCurrentStep == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: _activeCurrentStep == 0
                            ? Theme.of(context).primaryColor
                            : null,
                      ),
                    ),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // TODO: Reimplement image picker
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: ClipOval(
                        //     child: imageLoading
                        //         ? const SizedBox(
                        //             width: 128,
                        //             height: 128,
                        //             child: CircularProgressIndicator(),
                        //           )
                        //         : imageBytes != null
                        //             ? Image.memory(
                        //                 imageBytes!,
                        //                 width: 128,
                        //                 height: 128,
                        //               )
                        //             : widget.organization != null
                        //                 ? CachedNetworkImage(
                        //                     imageUrl: widget
                        //                         .organization!.profileUrl!,
                        //                     height: 128,
                        //                     width: 128,
                        //                   )
                        //                 : const Icon(
                        //                     Icons.account_circle,
                        //                     size: 128,
                        //                   ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: TextButton(
                        //     onPressed: () async => await pickAndSaveImage(),
                        //     child: const Text('Edit Profile Picture'),
                        //   ),
                        // ),
                        if (widget.organization == null)
                          ToggleButtons(
                            isSelected: _selectedType,
                            onPressed: (index) {
                              setState(() {
                                for (int i = 0; i < _selectedType.length; i++) {
                                  _selectedType[i] = (i == index);
                                }
                              });
                            },
                            children: const [
                              SizedBox(
                                width: 104,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.family_restroom),
                                      Text('Family'),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 104,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Icon(Icons.groups),
                                      Text('Organization'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: organizationUsernameController,
                          decoration: const InputDecoration(
                            labelText: 'Organization Username*',
                            hintText: 'Enter organization username',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                        ),
                        Gap(gapSize),
                        TextFormField(
                          controller: organizationNameController,
                          decoration: const InputDecoration(
                            labelText: 'Organization Name*',
                            hintText: 'Enter organization name',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                        ),
                        Gap(gapSize),
                        TextFormField(
                          maxLength: 32,
                          controller: descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            hintText: 'Enter organization description',
                          ),
                        ),
                        Gap(gapSize),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Invite Only'),
                            Switch(
                              value: _isInviteOnly,
                              onChanged: (value) {
                                setState(() {
                                  _isInviteOnly = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Step(
                    title: Text(
                      'Contact',
                      style: TextStyle(
                        fontWeight: _activeCurrentStep == 1
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: _activeCurrentStep == 1
                            ? Theme.of(context).primaryColor
                            : null,
                      ),
                    ),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email*',
                            hintText: 'Enter email address',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email is required';
                            }
                            if (!isValidEmail(value)) {
                              return 'Invalid email format';
                            }
                            return null;
                          },
                        ),
                        Gap(gapSize),
                        TextFormField(
                          controller: phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Phone',
                            hintText: 'Enter phone number',
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        Gap(gapSize),
                        TextFormField(
                          controller: addressController,
                          decoration: const InputDecoration(
                            labelText: 'Address',
                            hintText: 'Enter address',
                          ),
                        ),
                        Gap(gapSize),
                        TextFormField(
                          controller: addressTwoController,
                          decoration: const InputDecoration(
                            labelText: 'Address Two',
                            hintText: 'Enter second address line',
                          ),
                        ),
                        Gap(gapSize),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'City',
                            hintText: 'Enter city',
                          ),
                        ),
                        Gap(gapSize),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: stateController,
                                decoration: const InputDecoration(
                                  labelText: 'State',
                                  hintText: 'Enter state',
                                ),
                              ),
                            ),
                            Gap(gapSize),
                            Expanded(
                              child: TextFormField(
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
                          ],
                        ),
                      ],
                    ),
                  ),
                  Step(
                    title: Text(
                      'Socials',
                      style: TextStyle(
                        fontWeight: _activeCurrentStep == 2
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: _activeCurrentStep == 2
                            ? Theme.of(context).primaryColor
                            : null,
                      ),
                    ),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: instagramController,
                          decoration: const InputDecoration(
                            prefixText: 'instagram.com/',
                            labelText: 'Instagram',
                            hintText: 'Enter Instagram username',
                          ),
                        ),
                        Gap(gapSize),
                        TextFormField(
                          controller: facebookController,
                          decoration: const InputDecoration(
                            prefixText: 'facebook.com/',
                            labelText: 'Facebook',
                            hintText: 'Enter Facebook username',
                          ),
                        ),
                        Gap(gapSize),
                        TextFormField(
                          controller: twitterController,
                          decoration: const InputDecoration(
                            prefixText: 'twitter.com/',
                            labelText: 'Twitter',
                            hintText: 'Enter Twitter username',
                          ),
                        ),
                        Gap(gapSize),
                        TextFormField(
                          controller: tiktokController,
                          decoration: const InputDecoration(
                            prefixText: 'tiktok.com/',
                            labelText: 'TikTok',
                            hintText: 'Enter TikTok username',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // TODO: Move this to the BLoC
  Future<void> submitForm() async {
    if (_formKey.currentState?.validate() == true && !loading) {
      setState(() {
        loading = true;
      });
      try {
        Organization? popOrganization;
        int id = -1;
        if (widget.organization == null) {
          id = await OrganizationsService().createOrganization(
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
            inviteOnly: _isInviteOnly,
          );
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
            inviteOnly: _isInviteOnly,
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
            isPrivate: _isInviteOnly,
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

  // TODO: Reimplement on web
  // Future<void> pickAndSaveImage() async {
  //   try {
  //     setState(() {
  //       imageLoading = true;
  //     });
  //     final file = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (file == null) {
  //       setState(() {
  //         imageLoading = false;
  //       });
  //       return;
  //     }
  //
  //     final croppedImage = await ImageCropper().cropImage(
  //       sourcePath: file.path,
  //       cropStyle: CropStyle.circle,
  //       aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
  //       aspectRatioPresets: [CropAspectRatioPreset.square],
  //     );
  //
  //     if (croppedImage == null) {
  //       setState(() {
  //         imageLoading = false;
  //       });
  //       return;
  //     } else {
  //       setState(() {
  //         croppedFile = croppedImage;
  //       });
  //     }
  //
  //     final receivePort = ReceivePort();
  //     await Isolate.spawn(
  //       handleIntenseIsolate,
  //       [croppedFile!.path, receivePort.sendPort],
  //     );
  //     final Uint8List pngBytes = await receivePort.first;
  //
  //     final Uint8List compressedBytes =
  //         await FlutterImageCompress.compressWithList(
  //       pngBytes,
  //       quality: 50,
  //     );
  //     setState(() {
  //       imageBytes = compressedBytes;
  //       imageLoading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       imageLoading = false;
  //     });
  //     debugPrint(e.toString());
  //   }
  // }

  // static void handleIntenseIsolate(List<dynamic> arguments) async {
  //   String path = arguments[0];
  //   SendPort sendPort = arguments[1];
  //
  //   try {
  //     final imageBytes = await File(path).readAsBytes();
  //     final img.Image image = img.decodeImage(imageBytes)!;
  //     final Uint8List finalBytes = img.encodePng(image);
  //
  //     sendPort.send(finalBytes);
  //   } catch (e) {
  //     debugPrint('Error handling intense decoding: $e');
  //     rethrow;
  //   }
  // }

  Future<void> getPlans() async {
    try {
      List<Plan> plans = (await SubscriptionsService().getPlans()).plans;
      setState(() {
        this.plans = plans;
      });
    } catch (e) {
      debugPrint('Error Getting plans: $e');
    }
  }
}
