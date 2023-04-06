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
import 'package:sizer/sizer.dart';

import '../../data/controller/services/add_service_controller.dart';

class SubServices extends StatefulWidget {
  const SubServices({super.key});

  @override
  State<SubServices> createState() => _SubServicesState();
}

class _SubServicesState extends State<SubServices> {
  bool _menSelected = false;
  bool _womenSelected = false;
  var serviceCOntroller = TextEditingController();
  var addServiceController = Get.put(AddServiceController());

  File? _image;
  String value = '';
  final picker = ImagePicker();
  String selectedVal = "Select Service";
  List<String> items = ['Select Service'];
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
      appBar: customappbar("Subservice", true),
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
                List<DocumentSnapshot> documents = snapshot.data!.docs;

                for (var document in documents) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String fieldName = data['name'] as String;
                  items.add(fieldName);
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          color:
                              Colors.grey, //background color of dropdown button
                          border: Border.all(
                              color: Colors.black38,
                              width: 3), //border of dropdown button
                          borderRadius: BorderRadius.circular(
                              50), //border raiuds of dropdown button
                          boxShadow: const <BoxShadow>[
                            //apply shadow on Dropdown button
                            BoxShadow(
                                color: Color.fromRGBO(
                                    0, 0, 0, 0.57), //shadow for button
                                blurRadius: 5) //blur radius of shadow
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: DropdownButton(
                          isExpanded: true,
                          value: selectedVal,
                          onChanged: (newValue) {
                            setState(() {
                              selectedVal = newValue.toString();
                            });
                          },
                          icon: const Padding(
                              //Icon at tail, arrow bottom is default icon
                              padding: EdgeInsets.only(left: 20),
                              child: Icon(Icons.arrow_circle_down_sharp)),
                          iconEnabledColor: Colors.white, //Icon color
                          style: const TextStyle(
                              //te
                              color: Colors.black, //Font color
                              fontSize: 20 //font size on dropdown button
                              ),

                          dropdownColor:
                              Colors.grey.shade200, //dropdown background color
                          underline: Container(), //remove underline
                          items: items.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      )),
                );
              },
            ),
            const SizedBox(
              height: 15,
            ),
            //////////////drop down end
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
            SizedBox(
              height: 30.sp,
            ),
            SizedBox(
              // margin: const EdgeInsets.all(10),
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
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: _image == null
                          ? const Center(child: Text("Add Image"))
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
                    height: 20.sp,
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
