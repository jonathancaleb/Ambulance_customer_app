import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../constants/app_colors.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({Key? key}) : super(key: key);

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
        title: Text("Articles", style: Theme.of(context).textTheme.headline4),
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
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GetX<ArticleController>(builder: (_) {
                return Text(_.article.value);
              }),
            ),
          ))
        ],
      ),
    );
  }
}

class ArticleController extends GetxController {
  RxString article = "".obs;
  void fetchArticle(String topic) {
    //here you make a call to an api to retrieve the article.
    //once the api call is successful update the `article` property with response
    //e.g.
    article.value = "This is an example article about health.";
  }
}
