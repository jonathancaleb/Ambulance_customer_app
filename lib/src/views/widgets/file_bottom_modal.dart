import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FileBottomModal extends StatelessWidget {
  final Function(File? file)? onCameraTap;
  final Function(File? file)? onFolderTap;

  const FileBottomModal({Key? key, this.onCameraTap, this.onFolderTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 26,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFFDFDFD),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: 3,
            decoration: const ShapeDecoration(
              shape: StadiumBorder(),
              color: Color(0xFFF4F5F4),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Choose image to upload',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          // SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 18),

          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom + 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    color: const Color.fromRGBO(252, 175, 69, 1),
                    child: Material(
                      borderRadius: BorderRadius.circular(100),
                      clipBehavior: Clip.hardEdge,
                      color: Colors.transparent,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          File? file = await takeImage();
                          if (onCameraTap != null) onCameraTap!(file);
                        },
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    color: const Color(0xFF429BED),
                    child: Material(
                      borderRadius: BorderRadius.circular(100),
                      clipBehavior: Clip.hardEdge,
                      color: Colors.transparent,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          File? file = await selectImage();
                          if (onFolderTap != null) onFolderTap!(file);
                        },
                        child: const Icon(
                          Icons.folder_special,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

    /// Take image with camera
  Future<File?> takeImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    File? file;
    if (image != null) {
      file = File(image.path);
    }
    return file;
  }

    /// Select image from the user file system
  static Future<File?> selectImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    File? file;
    if (image != null) {
      file = File(image.path);
    }
    return file;
  }

}
