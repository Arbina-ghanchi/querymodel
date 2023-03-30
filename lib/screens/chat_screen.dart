import 'package:chatgpt/models/chat_model.dart';
import 'package:chatgpt/services/api_service.dart';
import 'package:chatgpt/services/assertmanager.dart';
import 'package:chatgpt/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../providers/models_provider.dart';
import '../services/services.dart';

class Chatscreen extends StatefulWidget {
  const Chatscreen({super.key});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  bool _isTyping = false;
  late TextEditingController textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();
  }

  List<ChatModel> chatList = [];

  @override
  Widget build(BuildContext context) {
    final modelprovider = Provider.of<modelsprovider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: FittedBox(
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_rounded),
                iconSize: 80
                ,
              ),
              Image(
                width: 100,
                image: AssetImage(AssertManager.userImage),
              ),
            ],
          ),
        ),
        title: Text(
          "Query Model",
          style: TextStyle(
              color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await Services.showModalSheet(context: context);
            },
            icon: Icon(
              Icons.account_tree_sharp,
              size: 30,
              color: Colors.blue[600],
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: chatList.length,
                itemBuilder: (context, index) {
                  return chatWidget(
                    msg: chatList[index].msg,
                    chatIndex: chatList[index].chatIndex,
                  );
                },
              ),
            ),
            if (_isTyping) ...[
              const SpinKitFadingFour(
                color: Colors.blue,
                size: 30,
              ),
            ],
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    onSubmitted: (value) async {
                      await sendMessageFct(modelprovider: modelprovider);
                    },
                    decoration: InputDecoration.collapsed(
                      hintText: "  Search Your Query",
                    ),
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await sendMessageFct(modelprovider: modelprovider);
                  },
                  icon: Icon(
                    Icons.send_outlined,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendMessageFct({required modelsprovider modelprovider}) async {
    try {
      String msg = textEditingController.text;
      setState(() {
        _isTyping = true;
        chatList.add(ChatModel(msg: msg, chatIndex: 0));
        textEditingController.clear();
      });

      print('Send message');

      chatList.addAll(await ApiService.sendMessage(
          message: msg, modelId: modelprovider.getCurrentModel));
    } catch (error) {
      print('error$error');
      setState(() {});
    } finally {
      setState(() {
        _isTyping = false;
      });
    }
  }
}
