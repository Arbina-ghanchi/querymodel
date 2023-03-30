import 'package:chatgpt/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class NormalScreen extends StatelessWidget {
  const NormalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            child: Stack(
              children: [
                const Image(
                  width: 10000,
                  height: 1800,
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      "https://media.giphy.com/media/l41lO3XKps6PUdUsw/giphy.gif"),
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Chatscreen(),
                        ),
                      );
                    },
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Enter",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                        Text(
                          "QUERY_MODEL!!",
                          style: TextStyle(fontSize: 35, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child:const  Text(
                    'image model in new update!!',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
