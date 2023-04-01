import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:saloon_app/Constants/ColorsManager.dart';
import 'package:saloon_app/Constants/custom_button.dart';
import 'package:saloon_app/Constants/custom_loading.dart';
import 'package:saloon_app/Constants/customdatetimepicker.dart';
import 'package:saloon_app/Constants/textstyles.dart';
import 'package:saloon_app/Constants/toast_messages.dart';
import 'package:saloon_app/Constants/upload_image_services.dart';
import 'package:saloon_app/data/controller/aws/aws.dart';
import 'package:saloon_app/data/controller/saloon_controller/saloon_profile_controller.dart';

class SaloonProfile extends StatefulWidget {
  String? saloonId;
  SaloonProfile({super.key, this.saloonId});

  @override
  State<SaloonProfile> createState() => _SaloonProfileState();
}

class _SaloonProfileState extends State<SaloonProfile> {
  var saloonsProfielController = Get.put(SaloonProfileController());
  XFile imagepath = XFile('');
  bool vacationdates = false;
  bool isActive = false;
  String vacStartingdate = '';
  String vacEndingdate = '';
  int count = 0;

  var items = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
    'Nill'
  ];

  String dropdownvalue = 'Nill';

  @override
  void initState() {
    saloonsProfielController.fetchSaloonDetails(widget.saloonId ?? "");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Obx(() {
              return Text(
                '${saloonsProfielController.saloonData['firstname']} ${saloonsProfielController.saloonData['lastname']}',
                style: const TextStyle(
                  fontFamily: "Tajawal",
                  fontWeight: FontWeight.w800,
                  fontSize: 17,
                  color: cappbarcolor,
                ),
              );
            }),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: backgroundColor,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                CupertinoIcons.back,
                color: black,
              )),
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Saloons')
                .doc(widget.saloonId)
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Customloading.cicularprogress(context);
              }

              return Obx(() => saloonsProfielController
                      .loadingSaloonProfiel.value
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 28, right: 27),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 37,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        log(snapshot.data!['image'].toString());

                                        String downloadurl = '';
                                        XFile image = await PickImageService()
                                            .pickImageFromGallery();

                                        setState(() {
                                          imagepath = image;
                                        });
                                      },
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: imagepath.path == '' &&
                                                snapshot.data!['image'] == ''
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: const Image(
                                                    image: NetworkImage(
                                                      'https://content3.jdmagicbox.com/comp/chennai/v4/044pxx44.xx44.190221122448.u8v4/catalogue/saloon-elite-chennai-016ennxq96.jpg?clr=333333',
                                                    ),
                                                    fit: BoxFit.cover),
                                              )
                                            : imagepath.path != ''
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: Image.file(
                                                      fit: BoxFit.cover,
                                                      File.fromUri(
                                                        Uri.parse(
                                                            imagepath.path),
                                                      ),
                                                    ),
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: Image(
                                                        image: NetworkImage(
                                                          snapshot
                                                              .data!['image'],
                                                        ),
                                                        fit: BoxFit.cover),
                                                  ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 55,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 11, right: 50, bottom: 10),
                                      child: Column(
                                        children: [
                                          CustomButton(
                                            buttondata: 'update'.tr,
                                            ontap: () async {
                                              try {
                                                if (imagepath.path != '') {
                                                  String downloadurl;
                                                  EasyLoading.show(
                                                      status: 'Loading....');
                                                  Navigator.pop(context);
                                                  String imageurl =
                                                      await UploadAwsFile()
                                                          .call(imagepath.path,
                                                              imagepath);
                                                  downloadurl = imageurl;

                                                  log('Image Download url is $downloadurl');
                                                  if (downloadurl.isNotEmpty) {
                                                    saloonsProfielController
                                                        .image
                                                        .text = downloadurl;
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('Saloons')
                                                        .doc(widget.saloonId)
                                                        .update({
                                                      'image': downloadurl
                                                    }).then((value) {
                                                      Utils.successtoastMessage(
                                                          'Image Updated Succesfully');
                                                      EasyLoading.dismiss();
                                                    });
                                                  } else {}
                                                }
                                              } catch (e) {
                                                log(e.toString());
                                                EasyLoading.dismiss();
                                              }
                                            },
                                            color: lightblue,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          CustomButton(
                                            buttondata: 'remove'.tr,
                                            ontap: () {},
                                            color: black,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                ////////////////////////////////
                                const SizedBox(
                                  height: 20,
                                ),

                                ///////////////////////////////////////
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(() {
                                      return Saloondetailcontainer(
                                        containertitle: 'state'.tr,
                                        initialvalue: saloonsProfielController
                                                    .saloonData ==
                                                {}
                                            ? " "
                                            : saloonsProfielController
                                                .saloonData['state'],
                                        onchanged: (value) {
                                          saloonsProfielController.state.text =
                                              value;
                                        },
                                      );
                                    }),
                                    Obx(() {
                                      return Saloondetailcontainer(
                                        containertitle: 'city'.tr,
                                        initialvalue: saloonsProfielController
                                                    .saloonData ==
                                                {}
                                            ? " "
                                            : saloonsProfielController
                                                .saloonData['city'],
                                        onchanged: (value) {
                                          saloonsProfielController.city.text =
                                              value;
                                        },
                                      );
                                    })
                                  ],
                                ),
                                const SizedBox(
                                  height: 23,
                                ),

                                //////////////////////////////////////////
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(() {
                                      return Saloondetailcontainer(
                                        containertitle: 'longitude'.tr,
                                        initialvalue: saloonsProfielController
                                                    .saloonData ==
                                                {}
                                            ? " "
                                            : saloonsProfielController
                                                .saloonData['long'],
                                        onchanged: (value) {
                                          saloonsProfielController.long.text =
                                              value;
                                        },
                                      );
                                    }),
                                    Obx(() {
                                      return Saloondetailcontainer(
                                        containertitle: 'latitude'.tr,
                                        initialvalue: saloonsProfielController
                                                    .saloonData ==
                                                {}
                                            ? " "
                                            : saloonsProfielController
                                                .saloonData['lat'],
                                        onchanged: (value) {
                                          saloonsProfielController.lat.text =
                                              value;
                                        },
                                      );
                                    })
                                  ],
                                ),
                                ////////////////////////////////////////////
                                const SizedBox(
                                  height: 20,
                                ),

                                Obx(() {
                                  return Editmanagernofield(
                                    containertitle: 'managerphonenumber'.tr,
                                    initialvalue:
                                        saloonsProfielController.saloonData ==
                                                {}
                                            ? " "
                                            : saloonsProfielController
                                                .saloonData['managerphno'],
                                    onchanged: (value) {
                                      saloonsProfielController
                                          .managernumber.text = value;
                                    },
                                    editbutton: () {},
                                  );
                                }),

                                //////////////////////////////////////////
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(() {
                                      return SaloonCRnumber(
                                        boxtitle: 'crnumber'.tr,
                                        initialvalue: saloonsProfielController
                                                .saloonData['CRNumber'] ??
                                            '',
                                        onChanged: (value) {
                                          saloonsProfielController
                                              .CRNumber.text = value;
                                        },
                                      );
                                    }),
                                    Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'crfile'.tr,
                                            style: style700x10,
                                          ),
                                        ),
                                        Container(
                                            width: 150,
                                            height: 37,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7)),
                                            child: Row(
                                              children: const [
                                                Text(
                                                  'mechsaloon.pdf',
                                                  style: lightstyle700x10,
                                                ),
                                                SizedBox(
                                                  width: 7.25,
                                                ),
                                                ImageIcon(
                                                  AssetImage(
                                                      'assets/download.png'),
                                                  color: lightprimarycolor,
                                                  size: 12,
                                                )
                                              ],
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 28,
                                ),

                                /////////////////////////////////////////

                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'workinghours'.tr,
                                    style: style700x15,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    WorkingHourscontainer(
                                      containertitle: 'starting'.tr,
                                      initialvalue: '10.00 AM',
                                      onchanged: (value) {},
                                    ),
                                    WorkingHourscontainer(
                                      containertitle: 'ending'.tr,
                                      initialvalue: '07:00 PM',
                                      onchanged: (value) {},
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Employeeoffdaydropdoencontainer(
                                          dropdownlist: items
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ))
                                              .toList(),
                                          containertitle: 'closingday'.tr,
                                          initialvalue: dropdownvalue,
                                          onchanged: (value) {
                                            print(value);
                                            setState(() {
                                              saloonsProfielController
                                                  .daysOff.text = value!;
                                              dropdownvalue = value;

                                              print(dropdownvalue);
                                            });
                                          },
                                          selectedValue: dropdownvalue,
                                        )),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Flexible(
                                        flex: 1,
                                        fit: FlexFit.loose,
                                        child: InkWell(
                                          onTap: () {},
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              height: 34,
                                              width: 34,
                                              decoration: BoxDecoration(
                                                  color: lightprimarycolor,
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: const Icon(
                                                Icons.add,
                                                color: white,
                                                size: 13,
                                              ),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 32,
                                ),

                                //////////////////////////////////////
                                const SizedBox(
                                  height: 32,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        children: [
                                          Text(
                                            'isactive?'.tr,
                                            style: style700x10,
                                          ),
                                          Obx(() {
                                            return Switch(
                                              activeColor: white,
                                              activeTrackColor:
                                                  lightprimarycolor,
                                              inactiveThumbColor: white,
                                              inactiveTrackColor:
                                                  Colors.grey.shade400,
                                              splashRadius: 50.0,
                                              value: saloonsProfielController
                                                          .saloonData ==
                                                      {}
                                                  ? isActive
                                                  : saloonsProfielController
                                                      .saloonData['isActive'],
                                              onChanged: (value) =>
                                                  setState(() {
                                                isActive = value;
                                                saloonsProfielController
                                                    .isActive = value;
                                                saloonsProfielController
                                                        .saloonData[
                                                    'isActive'] = value;
                                              }),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 110.6,
                                    ),
                                    Flexible(
                                      child: Column(
                                        children: [
                                          Text(
                                            'onvacation?'.tr,
                                            style: style700x10,
                                          ),
                                          Obx(() {
                                            return Switch(
                                              activeColor: white,
                                              activeTrackColor:
                                                  lightprimarycolor,
                                              inactiveThumbColor: white,
                                              inactiveTrackColor:
                                                  Colors.grey.shade400,
                                              splashRadius: 50.0,
                                              value: saloonsProfielController
                                                          .saloonData ==
                                                      {}
                                                  ? vacationdates
                                                  : saloonsProfielController
                                                      .saloonData['onVacation'],
                                              onChanged: (value) =>
                                                  setState(() {
                                                vacationdates = value;
                                                saloonsProfielController
                                                    .onVacation = value;
                                                saloonsProfielController
                                                        .saloonData[
                                                    'onVacation'] = value;
                                              }),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                ////////////////////////////////////////////////////////

                                saloonsProfielController
                                            .saloonData['onVacation'] ==
                                        true
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 28),
                                        child: Text(
                                          'vacationdates'.tr,
                                          style: style700x15,
                                        ),
                                      )
                                    : Container(),
                                saloonsProfielController
                                            .saloonData['onVacation'] ==
                                        true
                                    ? const SizedBox(
                                        height: 10,
                                      )
                                    : Container(),

                                saloonsProfielController
                                            .saloonData['onVacation'] ==
                                        true
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {},
                                                child:
                                                    Employeevacationscontainer(
                                                  containertitle: 'starting'.tr,
                                                  pickdate: vacStartingdate,
                                                  ontap: () {
                                                    getDate(
                                                      context,
                                                      (dateTime, available) {
                                                        setState(() {
                                                          saloonsProfielController
                                                              .vacationstatingime
                                                              .text = DateFormat(
                                                                  'yyyy-MM-dd')
                                                              .format(dateTime);
                                                          vacStartingdate =
                                                              DateFormat(
                                                                      'yyyy-MM-dd')
                                                                  .format(
                                                                      dateTime);
                                                        });

                                                        return true;
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                  onTap: () {},
                                                  child:
                                                      Employeevacationscontainer(
                                                    containertitle: 'ending'.tr,
                                                    pickdate: vacEndingdate,
                                                    ontap: () {
                                                      getDate(
                                                        context,
                                                        (dateTime, available) {
                                                          setState(() {
                                                            saloonsProfielController
                                                                .vacationendtime
                                                                .text = DateFormat(
                                                                    'yyyy-MM-dd')
                                                                .format(
                                                                    dateTime);

                                                            vacEndingdate =
                                                                DateFormat(
                                                                        'yyyy-MM-dd')
                                                                    .format(
                                                                        dateTime);
                                                          });

                                                          return true;
                                                        },
                                                      );
                                                    },
                                                  )),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),

                                ///////////////////////////////////////////////
                                const SizedBox(
                                  height: 35,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '',
                                      style: style700x10,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 139,
                                      alignment: Alignment.topLeft,
                                      decoration: BoxDecoration(
                                          color: white,
                                          boxShadow: containerboxShadow(),
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 9, top: 9, right: 9),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Obx(() {
                                            return TextFormField(
                                                textAlign: TextAlign.start,
                                                style: style700x14,
                                                maxLength: 500,
                                                maxLines: 10,
                                                decoration:
                                                    const InputDecoration
                                                            .collapsed(
                                                        hintText: ''),
                                                initialValue:
                                                    saloonsProfielController
                                                                .saloonData ==
                                                            {}
                                                        ? ''
                                                        : saloonsProfielController
                                                                .saloonData[
                                                            'aboutMe'],
                                                onChanged: (value) {
                                                  setState(() {
                                                    saloonsProfielController
                                                        .aboutMe.text = value;
                                                  });
                                                });
                                          }),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 35,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'salonimages'.tr,
                                      style: style700x10,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    SingleChildScrollView(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection('Saloons')
                                                .doc(widget.saloonId)
                                                .collection('Images')
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                              final documents =
                                                  snapshot.data!.docs;
                                              return GridView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    //mainAxisSpacing: 8.0,
                                                    childAspectRatio: 1,
                                                  ),
                                                  itemCount:
                                                      documents.length + 1,
                                                  itemBuilder:
                                                      (context, index) {
                                                    if (index <
                                                        documents.length) {
                                                      final data =
                                                          documents[index]
                                                                  .data()
                                                              as Map<String,
                                                                  dynamic>;
                                                      return Container(
                                                        width: 80,
                                                        height: 80,
                                                        alignment:
                                                            Alignment.topLeft,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7)),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          child:
                                                              CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            imageUrl:
                                                                data['image'],
                                                            placeholder: (context,
                                                                    url) =>
                                                                const CircularProgressIndicator(),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(Icons
                                                                    .error),
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      // Display add icon
                                                      return GridTile(
                                                          child: InkWell(
                                                        onTap: () async {
                                                          StreamBuilder<
                                                              QuerySnapshot>(
                                                            stream: FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Saloons')
                                                                .doc(widget
                                                                    .saloonId)
                                                                .collection(
                                                                    'Images')
                                                                .snapshots(),
                                                            builder: (BuildContext
                                                                    context,
                                                                AsyncSnapshot<
                                                                        QuerySnapshot>
                                                                    snapshot) {
                                                              if (snapshot
                                                                  .hasData) {
                                                                count = snapshot
                                                                    .data!
                                                                    .docs
                                                                    .length;
                                                                return Text(
                                                                    'Number of documents: $count');
                                                              } else if (snapshot
                                                                  .hasError) {
                                                                return Text(
                                                                    'Error: ${snapshot.error}');
                                                              } else {
                                                                return const CircularProgressIndicator();
                                                              }
                                                            },
                                                          );

                                                          if (count > 20) {
                                                            Utils.errortoastMessage(
                                                                'Upload Image Limit exceed');
                                                          } else {
                                                            String downloadurl =
                                                                '';
                                                            XFile imagepath =
                                                                await saloonsProfielController
                                                                    .pickImageFromGallery();

                                                            EasyLoading.show(
                                                                status:
                                                                    'Loading....');
                                                            Navigator.pop(
                                                                context);
                                                            String imageurl =
                                                                await UploadAwsFile().call(
                                                                    imagepath
                                                                        .path,
                                                                    imagepath);
                                                            downloadurl =
                                                                imageurl;
                                                            print('asdfgh');
                                                            print(downloadurl);

                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Saloons')
                                                                .doc(widget
                                                                    .saloonId)
                                                                .collection(
                                                                    'Images')
                                                                .add({
                                                              'id': '',
                                                              'image':
                                                                  downloadurl
                                                            }).then((value) async {
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Saloons')
                                                                  .doc(widget
                                                                      .saloonId)
                                                                  .collection(
                                                                      'Images')
                                                                  .doc(value.id)
                                                                  .update({
                                                                'id': value.id,
                                                              }).then((value) {
                                                                Utils.successtoastMessage(
                                                                    'Image Uploaded SuccesFully');
                                                                EasyLoading
                                                                    .dismiss();
                                                              });
                                                            });
                                                          }
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(30.0),
                                                          child: Container(
                                                            height: 100,
                                                            width: 100,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    lightprimarycolor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12)),
                                                            child: const Icon(
                                                              Icons.add,
                                                              color: white,
                                                              size: 40,
                                                            ),
                                                          ),
                                                        ),
                                                      ));
                                                    }
                                                  });
                                            }),
                                      ],
                                    ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 66,
                                ),

                                const SizedBox(
                                  height: 66,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: () async {
                                      int imagecount =
                                          await saloonsProfielController
                                              .getImageCount(
                                                  widget.saloonId ?? "");

                                      if (imagecount < 2) {
                                        Utils.errortoastMessage(
                                            'Please Add Atlease 2 Images');
                                      } else {
                                        //    controller.updateSaloon();
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Container(
                                        height: 45,
                                        width: 200,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: lightprimarycolor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          'update'.tr,
                                          style: stylewhite700x12,
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 46,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ));
            }));
  }
}

/////////////////////////////////////////////////////////
class Saloondetailcontainer extends StatelessWidget {
  String containertitle;
  String initialvalue;
  Function(String) onchanged;
  TextEditingController textcontroller = TextEditingController();

  Saloondetailcontainer(
      {required this.containertitle,
      required this.onchanged,
      required this.initialvalue});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          containertitle,
          style: style700x10,
          textAlign: TextAlign.start,
        ),
        Container(
          width: 150,
          height: 37,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: backgroundColor,
              boxShadow: containerboxShadow(),
              borderRadius: BorderRadius.circular(7)),
          child: TextFormField(
              textAlign: TextAlign.center,
              style: style700x14,
              decoration: const InputDecoration.collapsed(hintText: ''),
              initialValue: initialvalue,
              onChanged: onchanged),
        )
      ],
    );
  }
}

//////////////////////////////////////////
class Employeevacationscontainer extends StatelessWidget {
  String containertitle;
  String pickdate;
  VoidCallback ontap;

  Employeevacationscontainer(
      {required this.containertitle,
      required this.pickdate,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          containertitle,
          style: style700x10,
        ),
        InkWell(
          onTap: ontap,
          child: Container(
              width: 150,
              height: 37,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: white,
                  boxShadow: containerboxShadow(),
                  borderRadius: BorderRadius.circular(7)),
              child: Text(
                pickdate,
                style: style700x14,
              )),
        )
      ],
    );
  }
}

/////////////////////////////////////////////////////////////////////
class Editmanagernofield extends StatelessWidget {
  String containertitle;
  String initialvalue;
  Function(String) onchanged;
  VoidCallback editbutton;

  Editmanagernofield(
      {required this.containertitle,
      required this.onchanged,
      required this.editbutton,
      required this.initialvalue});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          containertitle,
          style: style700x10,
        ),
        Container(
            height: 37,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: white,
                boxShadow: containerboxShadow(),
                borderRadius: BorderRadius.circular(7)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                        style: style700x14,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            hintText: ''),
                        initialValue: initialvalue,
                        onChanged: onchanged),
                  ),
                ),
                InkWell(
                  onTap: editbutton,
                  child: Flexible(
                    fit: FlexFit.loose,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 7, bottom: 7, right: 11, left: 10),
                      child: Container(
                        height: 23,
                        width: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: offwhite,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          'edit'.tr,
                          style: style700x11,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ))
      ],
    );
  }
}

/////////////////////////////////////////
class SaloonCRnumber extends StatelessWidget {
  String boxtitle;
  String initialvalue;
  Function(String) onChanged;

  SaloonCRnumber(
      {required this.boxtitle,
      required this.initialvalue,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          boxtitle,
          style: style700x10,
        ),
        Container(
          width: 150,
          height: 37,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: offwhite,
              boxShadow: containerboxShadow(),
              borderRadius: BorderRadius.circular(7)),
          child: TextFormField(
              textAlign: TextAlign.center,
              style: style700x14,
              decoration: const InputDecoration.collapsed(hintText: ''),
              initialValue: initialvalue,
              onChanged: onChanged),
        )
      ],
    );
  }
}

//////////////////////////////////////
class WorkingHourscontainer extends StatelessWidget {
  String containertitle;
  String initialvalue;
  Function(String) onchanged;
  TextEditingController textcontroller = TextEditingController();

  WorkingHourscontainer(
      {required this.containertitle,
      required this.onchanged,
      required this.initialvalue});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          containertitle,
          style: style700x10,
        ),
        Container(
          width: 150,
          height: 37,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: white,
              boxShadow: containerboxShadow(),
              borderRadius: BorderRadius.circular(7)),
          child: TextFormField(
              textAlign: TextAlign.center,
              style: style700x14,
              decoration: const InputDecoration.collapsed(hintText: ''),
              initialValue: initialvalue,
              onChanged: onchanged),
        )
      ],
    );
  }
}

////////////////////////////////////////////////
class Employeeoffdaydropdoencontainer extends StatelessWidget {
  String containertitle;
  String initialvalue;
  List<DropdownMenuItem<String>> dropdownlist;
  dynamic Function(String?)? onchanged;
  TextEditingController textcontroller = TextEditingController();

  Employeeoffdaydropdoencontainer(
      {required this.containertitle,
      required this.onchanged,
      required this.dropdownlist,
      required this.selectedValue,
      required this.initialvalue});
  String selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          containertitle,
          style: style700x10,
        ),
        Container(
          width: 150,
          height: 37,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: white,
              boxShadow: containerboxShadow(),
              borderRadius: BorderRadius.circular(7)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              hint: Row(
                children: const [
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      '',
                      style: style400x16,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              items: dropdownlist,
              value: selectedValue,
              onChanged: onchanged,
              icon: const Icon(
                CupertinoIcons.chevron_down,
              ),
              iconSize: 14,
              iconEnabledColor: black,
              iconDisabledColor: Colors.grey,
              buttonHeight: 50,
              buttonWidth: double.infinity,
              buttonPadding: const EdgeInsets.only(left: 14, right: 14),
              buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: containerboxShadow(),
                color: white,
              ),
              buttonElevation: 0,
              itemHeight: 40,
              itemPadding: const EdgeInsets.only(left: 14, right: 14),
              dropdownMaxHeight: 400,
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: white,
              ),
              scrollbarRadius: const Radius.circular(40),
              scrollbarThickness: 6,
              scrollbarAlwaysShow: true,
            ),
          ),
        )
      ],
    );
  }
}

///////////////////////////////////////////////////
class SaloonProfileImage extends StatelessWidget {
  String SaloonImage;

  SaloonProfileImage({required this.SaloonImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 137,
      width: double.infinity,
      decoration: BoxDecoration(
          color: white,
          boxShadow: containerboxShadow(),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 29),
              child: SizedBox(
                height: 120,
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: SaloonImage,
                    placeholder: (context, url) => const CircleAvatar(
                      backgroundColor: white,
                      //  radius: 150,
                    ),
                    imageBuilder: (context, image) => CircleAvatar(
                      backgroundImage: image,
                      //  radius: 150,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 41,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 41, right: 50),
              child: Column(
                children: [
                  CustomButton(
                    buttondata: 'update'.tr,
                    ontap: () {},
                    color: lightblue,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    buttondata: 'remove.tr',
                    ontap: () {},
                    color: black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
