import "package:flutter/material.dart";
import "package:flutter/services.dart";

void errorDialog(String error, BuildContext context) {
  if (error.contains("429")) {
    error = "Organization Username Already Taken!";
  }
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: SizedBox(
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Error!",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(error),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () async =>
                        await Clipboard.setData(ClipboardData(text: error)),
                    child: const Text("Copy"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Okay"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
