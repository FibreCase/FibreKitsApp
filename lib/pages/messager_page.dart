import 'package:fibre_kits/function/notifier.dart';
import 'package:fibre_kits/get/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagerPage extends StatelessWidget {
  const MessagerPage({super.key});

  @override
  Widget build(BuildContext context) {

    StringController contentStringController = Get.put(StringController(), tag: 'content');
    StringController titleStringController = Get.put(StringController(), tag: 'title');

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
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Text(
                    'Ntfy消息推送',
                    style:
                        Theme.of(context).textTheme.headlineSmall?.copyWith(),
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
                                hintText: 'some title',
                                // border: const OutlineInputBorder(
                                //   borderRadius: BorderRadius.all(
                                //     Radius.circular(20),
                                //   ),
                                // ),
                              ),
                              // onEditingComplete: () {
                              //   FocusScope.of(context).unfocus();
                              // },
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
                                hintText: 'some content',
                                // border: const OutlineInputBorder(
                                //   borderRadius: BorderRadius.all(
                                //     Radius.circular(20),
                                //   ),
                                // ),
                              ),
                              onChanged:
                                  (value) => contentStringController
                                      .updateString(value),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
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
                                      Get.snackbar(
                                        'Success',
                                        'Message sent successfully',
                                        icon: Icon(
                                          Icons.check,
                                        ),
                                        snackPosition: SnackPosition.TOP,
                                      );
                                    } else {
                                      Get.snackbar(
                                        'Error',
                                        'Failed to send message',
                                        snackPosition: SnackPosition.BOTTOM,
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
