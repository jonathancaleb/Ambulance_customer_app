import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../../services/authService.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    final ProgressDialog progressDialog = ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: false, showLogs: true);

    return DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Image(
                image: Svg('assets/bukk_logo_large.svg'),
              ),
            ),
            bottom: PreferredSize(
              preferredSize:const Size(double.infinity, 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Feedback",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black.withOpacity(1.0),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(
                    color: Color(0xffF1CA2D),
                    height: 3,
                    thickness: 3,
                  )
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40.0, horizontal: 20),
                      child: Card(
                        elevation: 8,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text("Write your feedback",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Regular",
                                        fontSize: 18)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SizedBox(
                                height: height * 0.2,
                                child: TextFormField(
                                  minLines: 7,
                                  maxLines: 7,
                                  keyboardType: TextInputType.multiline,
                                  controller: _controller,
                                  decoration: const InputDecoration(
                                    hintText: 'Write your feedback',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5, bottom: 10),
                              child: SizedBox(
                                width: width / 3.5,
                                child: MaterialButton(
                                  onPressed: () {
                                    if (_controller.text.isEmpty) {
                                    } else {
                                      progressDialog.show();
                                      sendFeedback(_controller.text)
                                          .then((value) {
                                        if (value) {
                                          progressDialog.hide();
                                          const snackBar = SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text(
                                              "Feedback Submitted successfully",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          _controller.clear();
                                        } else {
                                          progressDialog.hide();
                                          const snackBar = SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                              "Failed to submit Feedback",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        }
                                      });
                                    }
                                  },
                                  color: const Color(0xff042B52),
                                  child: const Text(
                                    "Send",
                                    style: TextStyle(
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
