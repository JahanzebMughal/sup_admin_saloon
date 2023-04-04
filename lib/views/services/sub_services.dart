// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saloon_app/Constants/ColorsManager.dart';
import 'package:saloon_app/views/dashboard.dart';
import 'package:saloon_app/widgets/custom_button.dart';
import 'package:saloon_app/widgets/custom_textfield.dart';

import '../../data/controller/services/add_service_controller.dart';

class SubServices extends StatefulWidget {
  const SubServices({super.key});

  @override
  State<SubServices> createState() => _SubServicesState();
}

class _SubServicesState extends State<SubServices> {
  bool isClicked = false;

  var serviceCOntroller = TextEditingController();
  var addServiceController = Get.put(AddServiceController());

  File? _image;
  String value = '';
  final picker = ImagePicker();
  String selectedVal = "Select value";
  List<String> items = ['Select value'];
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: customappbar("Subservice", true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isClicked = !isClicked;
                  value = "Men";
                });
              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: containerboxShadow()),
                child: const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20, left: 10),
                  child: Text("Men"),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isClicked = !isClicked;
                  value = "Women";
                });
              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: containerboxShadow()),
                child: const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20, left: 10),
                  child: Text("Women"),
                ),
              ),
            ),
            isClicked
                ? Container(
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
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            child: _image == null
                                ? const Center(child: Text("Add Image"))
                                : Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),

                        StreamBuilder<QuerySnapshot>(
                          stream: value == 'Men'
                              ? FirebaseFirestore.instance
                                  .collection('SuperServices')
                                  .doc('Men')
                                  .collection('Services')
                                  .snapshots()
                              : FirebaseFirestore.instance
                                  .collection('SuperServices')
                                  .doc('Women')
                                  .collection('Services')
                                  .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            List<DocumentSnapshot> documents =
                                snapshot.data!.docs;

                            for (var document in documents) {
                              Map<String, dynamic> data =
                                  document.data() as Map<String, dynamic>;
                              String fieldName = data['name'] as String;
                              items.add(fieldName);
                            }
                            return DropdownButton(
                              isExpanded: true,
                              value: selectedVal,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedVal = newValue.toString();
                                });
                              },
                              items: items.map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            );
                          },
                        ),

                        //////////////drop down end
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CustomOutlineTextField(
                            validator: (String) {
                              return null;
                            },
                            obscureText: false,
                            labelText: 'Service Name',
                            controller: serviceCOntroller,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(() => CustomElevatedButton(
                              buttonText: "Add",
                              onPressed: () {
                                addServiceController.addSubService(_image!,
                                    serviceCOntroller.text, value, selectedVal);
                              },
                              loading: addServiceController.loading.value,
                            ))
                      ],
                    ),
                  )
                : const SizedBox()
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
