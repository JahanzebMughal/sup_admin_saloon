// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saloon_app/views/dashboard.dart';
import 'package:saloon_app/widgets/custom_button.dart';
import 'package:saloon_app/widgets/custom_textfield.dart';
import 'package:sizer/sizer.dart';

import '../../Constants/ColorsManager.dart';
import '../../data/controller/services/add_service_controller.dart';

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  bool _menSelected = false;
  bool _womenSelected = false;

  var serviceCOntroller = TextEditingController();
  var addServiceController = Get.put(AddServiceController());
  File? _image;
  String value = '';
  final picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: customappbar("services", true),

      // AppBar(
      //   backgroundColor: Colors.white,
      //   title: const Text(
      //     'Services',
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   leading: GestureDetector(
      //     onTap: () {
      //       Get.back();
      //     },
      //     child: const Icon(
      //       Icons.arrow_back,
      //       color: Colors.black,
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        _menSelected = true;
                        _womenSelected = false;

                        value = "Men";
                      });
                    },
                    child: Container(
                      height: 15.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                          border: Border.all(width: _menSelected ? 2 : 0),
                          borderRadius: BorderRadius.circular(20),
                          color:
                              _menSelected ? Colors.grey : Colors.grey.shade400,
                          boxShadow: containerboxShadow()),
                      child: const Center(
                          child: Text(
                        'Men',
                        style: TextStyle(fontSize: 18),
                      )),
                    )),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        _womenSelected = true;
                        _menSelected = false;
                        value = "Women";
                      });
                    },
                    child: Container(
                      height: 15.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                          border: Border.all(width: _womenSelected ? 2 : 0),
                          borderRadius: BorderRadius.circular(20),
                          color: _womenSelected
                              ? Colors.grey
                              : Colors.grey.shade400,
                          boxShadow: containerboxShadow()),
                      child: const Center(
                          child: Text(
                        'Women',
                        style: TextStyle(fontSize: 18),
                      )),
                    )),
              ],
            ),
            SizedBox(
              height: 30.sp,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomOutlineTextField(
                validator: (String) {
                  return null;
                },
                obscureText: false,
                labelText: 'Service Name',
                controller: serviceCOntroller,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              //  color: Colors.red,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _showBottomSheet(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      height: 170.sp,
                      width: 170.sp,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: _image == null
                          ? const Center(child: Text("Tap to select Image"))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 30.sp,
                  ),
                  Obx(() => CustomElevatedButton(
                        buttonText: "Add",
                        onPressed: () {
                          addServiceController.addService(
                              _image!, serviceCOntroller.text, value);
                        },
                        loading: addServiceController.loading.value,
                      ))
                ],
              ),
            )
            // : const SizedBox()
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: SizedBox(
                    height: 60,
                    child: InkWell(
                      onTap: () {
                        _pickImage(ImageSource.camera);
                        print("***************************");
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.camera_alt),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Camera")
                        ],
                      ),
                    ),
                    // color: Colors.red,
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      _pickImage(ImageSource.gallery);
                    },
                    child: SizedBox(
                      height: 60,
                      //  color: Colors.black,
                      child: Row(
                        children: const [
                          Icon(Icons.browse_gallery),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Gallery")
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ),
          );
        });
  }
}
