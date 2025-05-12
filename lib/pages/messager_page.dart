import 'package:fibre_kits/function/notifier.dart';
import 'package:fibre_kits/function/snackbar.dart';
import 'package:fibre_kits/get/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class MessagerPage extends StatelessWidget {
  const MessagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    StringController contentStringController = Get.put(
      StringController(),
      tag: 'content',
    );
    StringController titleStringController = Get.put(
      StringController(),
      tag: 'title',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messager',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Ntfy消息推送',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Title',
                                hintText: 'English title only',
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              onChanged:
                                  (value) =>
                                      titleStringController.updateString(value),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Content',
                                hintText: 'Chinese and English supported',
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              onChanged:
                                  (value) => contentStringController
                                      .updateString(value),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    if (await NtfyNotifier.sendMessage(
                                      topic: 'broadcast',
                                      title:
                                          titleStringController
                                              .stringValue
                                              .value,
                                      message:
                                          contentStringController
                                              .stringValue
                                              .value,
                                      baseUrl:
                                          "https://ntfy.fibrecase.xin:55443/",
                                    )) {
                                      FloatingSnackbar.show(
                                        context,
                                        message: 'Message sent successfully',
                                        icon: Icons.check_circle,
                                      );
                                    } else {
                                      FloatingSnackbar.show(
                                        context,
                                        message: 'Failed to send message',
                                        icon: Icons.error,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .error,
                                        textColor: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                      );
                                    }
                                  },
                                  child: const Text('Send'),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
