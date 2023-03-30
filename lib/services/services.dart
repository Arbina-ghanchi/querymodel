import 'package:chatgpt/widgets/drop_down.dart';
import 'package:flutter/material.dart';

class Services {
  static Future<void> showModalSheet({required BuildContext context}) async {
    await showModalBottomSheet(
      backgroundColor: Colors.grey[300],
      context: context,
      builder: (context) {
        return Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'Text MODELS :',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Flexible(flex: 2, child: modelDropDown())
          ],
        );
      },
    );
  }
}
