import 'package:ambulance_app/src/constants/image_strings.dart';
import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget(
      {Key? key, required this.title, required this.subTitle})
      : super(key: key);

  final String title, subTitle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
            image: const AssetImage(aWelcomeScreenImage),
            height: size.height * 0.2),
        Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
        Text(subTitle, style: Theme.of(context).textTheme.bodyText1)
      ],
    );
  }
}
