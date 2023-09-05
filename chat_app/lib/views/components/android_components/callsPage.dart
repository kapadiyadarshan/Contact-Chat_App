import 'package:chat_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controller/chat_controller.dart';
import '../../../model/chat_model.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  call({required String phoneNum}) async {
    Uri callUri = Uri(
      scheme: "tel",
      path: phoneNum,
    );

    await launchUrl(callUri);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 2,
        left: 12,
        right: 12,
      ),
      child: Consumer<ChatController>(builder: (context, provider, _) {
        return SizedBox(
          height: 746,
          width: double.infinity,
          child: ListView.builder(
            itemBuilder: (context, index) {
              Chat tempChat = provider.getChatsDataList[index];

              return Card(
                child: ListTile(
                  title: Text(
                    "${tempChat.name}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text("${tempChat.phoneNumber}"),
                  leading: const CircleAvatar(
                    radius: 30,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      call(phoneNum: tempChat.phoneNumber!);
                    },
                    icon: Icon(
                      Icons.call,
                      size: 28,
                      color: MyColor.theme1,
                    ),
                  ),
                ),
              );
            },
            itemCount: provider.getChatsDataList.length,
          ),
        );
      }),
    );
  }
}
