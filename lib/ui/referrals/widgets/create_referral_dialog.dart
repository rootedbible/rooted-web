import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:intl/intl.dart";
import "package:rooted_web/api/services/admin_service.dart";
import "package:rooted_web/bloc/admin/referral/referral_bloc.dart";
import "package:rooted_web/const.dart";
import "package:rooted_web/ui/widgets/error_dialog.dart";

class CreateReferralDialog extends StatefulWidget {
  const CreateReferralDialog({super.key});

  @override
  State<CreateReferralDialog> createState() => _CreateReferralDialogState();
}

class _CreateReferralDialogState extends State<CreateReferralDialog> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  Future<void> _handleCreate() async {
    try {
      setState(() {
        loading = true;
      });
      await AdminService().createReferral(
        meta: nameController.text.trim(),
        startTime: startDateController.text.trim().isNotEmpty
            ? startDateController.text.trim()
            : null,
        endTime: endDateController.text.trim().isNotEmpty
            ? endDateController.text.trim()
            : null,
      );
      context.read<ReferralBloc>().add(GetReferrals());
      setState(() {
        loading = false;
      });
      Navigator.pop(context);
    } catch (e) {
      setState(() {
        loading = false;
      });
      errorDialog(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        content: SizedBox(
          width: dialogWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Create Referral",style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nameController,
                  validator: (_) {
                    if (nameController.text.trim().isEmpty) {
                      return "Can't be empty!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Ex: Church Name",
                    labelText: "Display Name",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: startDateController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Date",
                  ),
                  readOnly: true,
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(3000),
                    );

                    if (pickedDate != null) {
                      final String formattedDate =
                          DateFormat("MM/dd/yyyy").format(pickedDate);
                      setState(() {
                        startDateController.text = formattedDate;
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: endDateController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Date",
                  ),
                  readOnly: true,
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(3000),
                    );

                    if (pickedDate != null) {
                      final String formattedDate =
                          DateFormat("MM/dd/yyyy").format(pickedDate);
                      setState(() {
                        endDateController.text = formattedDate;
                      });
                    }
                  },
                ),
              ),
              if (loading)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              if (!loading)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () async => _handleCreate(),
                      child: const Text("Create"),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
