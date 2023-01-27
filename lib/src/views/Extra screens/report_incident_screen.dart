import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../constants/app_colors.dart';
import '../../constants/sizes.dart';
import '../../constants/text_string.dart';

class ReportIncident extends StatefulWidget {
  const ReportIncident({Key? key}) : super(key: key);

  @override
  State<ReportIncident> createState() => _ReportIncidentState();
}

class _ReportIncidentState extends State<ReportIncident> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _input1Controller = TextEditingController();
  final _input2Controller = TextEditingController();
  final _input3Controller = TextEditingController();
  final _input4Controller = TextEditingController();
  final _input5Controller = TextEditingController();
  var _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(LineAwesomeIcons.angle_left),
              color: aSecondaryColor),
          title: Text(aProfile, style: Theme.of(context).textTheme.headline4),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(LineAwesomeIcons.moon),
                color: aSecondaryColor)
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 200.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: _image != null
                                ? FileImage(_image)
                                : const AssetImage("assets/failed.png")
                                    as ImageProvider,
                            fit: BoxFit.cover),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            onPressed: _getImage,
                            icon: const Icon(
                              Icons.camera_alt,
                              size: 30.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text("Take a Picture",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: _input1Controller,
                      decoration: InputDecoration(
                          filled: true,
                          contentPadding: const EdgeInsets.all(40.0),
                          labelText: "name of incident",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                          labelStyle: const TextStyle(color: aSecondaryColor),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                  width: 2.0, color: aSecondaryColor))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter incident";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _input2Controller,
                      decoration: InputDecoration(
                          filled: true,
                          contentPadding: const EdgeInsets.all(40.0),
                          labelText: "Type of incident",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                          labelStyle: const TextStyle(color: aSecondaryColor),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                  width: 2.0, color: aSecondaryColor))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter incident";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _input3Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          filled: true,
                          contentPadding: const EdgeInsets.all(40.0),
                          labelText: "number of casualities",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                          labelStyle: const TextStyle(color: aSecondaryColor),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                  width: 2.0, color: aSecondaryColor))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter incident";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _input4Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          filled: true,
                          contentPadding: const EdgeInsets.all(40.0),
                          labelText: "age bracket",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                          labelStyle: const TextStyle(color: aSecondaryColor),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                  width: 2.0, color: aSecondaryColor))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter incident";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _input5Controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          filled: true,
                          contentPadding: const EdgeInsets.all(40.0),
                          labelText: "contact details e.g Phone-No",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100)),
                          labelStyle: const TextStyle(color: aSecondaryColor),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                  width: 2.0, color: aSecondaryColor))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter incident";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const StadiumBorder(),
                            foregroundColor: aWhiteColor,
                            backgroundColor: aSecondaryColor,
                            side: const BorderSide(color: aSecondaryColor),
                            padding: const EdgeInsets.symmetric(
                                vertical: aButtonHeight),
                          ),
                          child: const Text("SUBMIT FORM")),
                    ),
                  ],
                ),
              )),
        ));
  }

  // XFile? imageFile;
  // _getImage() async {
  //   imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
  //   setState(() {
  //     _image = imageFile;
  //   });
  // }

  void _getImage() async {
    var selectedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(selectedImage!.path);
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      //do something with fields and image
      _formKey.currentState!.reset();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Form submitted successfully")));
    }
  }
}
