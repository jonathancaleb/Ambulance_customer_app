import 'package:flutter/material.dart';

class CotainerWidget extends StatelessWidget {
  const CotainerWidget({
    Key? key,
    required this.btnIcon,
    required this.ttle,
    required this.subTtle,
    required this.onTap,
  }) : super(key: key);

  final IconData btnIcon;
  final String ttle, subTtle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey.shade200),
        child: Row(
          children: [
            Icon(
              btnIcon,
              size: 60.0,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ttle,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  subTtle,
                  style: Theme.of(context).textTheme.bodyText2,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
