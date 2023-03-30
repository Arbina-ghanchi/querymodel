import 'package:chatgpt/services/assertmanager.dart';
import 'package:flutter/material.dart';

class chatWidget extends StatelessWidget {
  const chatWidget({super.key, required this.msg, required this.chatIndex});

  final String msg;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                chatIndex == 0
                    ? AssertManager.botimage2
                    : AssertManager.userImage,
                height: 30,
                width: 30,
              ),
            ),
            Expanded(child: Text(msg))
          ],
        )
      ],
    );
  }
}
