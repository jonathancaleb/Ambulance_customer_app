import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../constants/app_colors.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(LineAwesomeIcons.angle_left),
              color: aSecondaryColor),
          title: Text("Chat", style: Theme.of(context).textTheme.headline4),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(LineAwesomeIcons.moon),
                color: aSecondaryColor)
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(() => ListView.builder(
                  itemCount: Get.find<ChatController>().messages.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 10,
                        decoration: const BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child:
                              Text(Get.find<ChatController>().messages[index]),
                        ),
                      ),
                    );
                  }))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                // focusNode: focusNode,
                onChanged: (value) =>
                    Get.find<ChatController>().message = value,
                decoration:
                    const InputDecoration(hintText: 'Type Message here'),
              ),
            ),
            ElevatedButton(
                onPressed: () => Get.find<ChatController>().sendMessage(),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: const StadiumBorder(),
                  foregroundColor: aWhiteColor,
                  backgroundColor: aSecondColor,
                  side: const BorderSide(color: aSecondaryColor),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
                child: const Text('Send')),
          ],
        ));
  }

  // @override
  // void dispose() {
  //   focusNode.dispose();
  //   super.dispose();
  // }
}

class ChatController extends GetxController {
  final messages = <String>[].obs;
  var message = '';

  void sendMessage() {
    messages.add(message);
    message = '';
    update();
  }
}
