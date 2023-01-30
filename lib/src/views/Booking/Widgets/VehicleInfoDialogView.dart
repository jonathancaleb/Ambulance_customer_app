import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class VehicleInfoDialogView extends StatelessWidget {
  const VehicleInfoDialogView({Key? key, required this.category})
      : super(key: key);
  final category;

  Widget renderHtml() {
    return Html(
      data: category.information,
      style: {
        'p': Style(fontFamily: 'Poppins', fontSize: FontSize(1.0)),
        'h1': Style(fontFamily: 'Poppins', fontSize: FontSize(1.1)),
        'h2': Style(fontFamily: 'Poppins', fontSize: FontSize(1.0)),
        'h3': Style(fontFamily: 'Poppins', fontSize: FontSize(1.0)),
        'li': Style(
          padding: const EdgeInsets.only(left: 10, top: 15),
          fontFamily: 'Poppins',
          fontSize: FontSize(1.0),
        )
      },
    );
  }

  // Widget renderHtml() {
  //   return Html(
  //     data: category.information,
  //     style: {
  //       'p': Style(fontFamily: 'Poppins', fontSize: 14.0),
  //       'h1': Style(fontFamily: 'Poppins', fontSize: 16.0),
  //       'h2': Style(fontFamily: 'Poppins', fontSize: 14.0),
  //       'h3': Style(fontFamily: 'Poppins', fontSize: 14.0),
  //       'li': Style(
  //         margin: const EdgeInsets.only(left: 10, top: 15),
  //         fontFamily: 'Poppins',
  //         fontSize: 14.0,
  //       )
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        // height: MediaQuery.of(context).size.height * 0.75,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75,
          minHeight: MediaQuery.of(context).size.height * 0.45,
        ),
        margin: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildBody(context),
              ),
              _buildCloseButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Positioned _buildCloseButton(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(4.0),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(4.0),
          ),
          child: InkWell(
            highlightColor: Colors.transparent,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(4.0),
            ),
            onTap: Navigator.of(context).pop,
            child: const Center(
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 10, width: double.infinity),
        CachedNetworkImage(
          imageUrl: category.image,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          height: 90,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          category.name ?? '',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontSize: 16.0,
              ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: renderHtml(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
