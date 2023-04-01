// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UploadAwsFile {
  bool? success;
  String? message;
  String? uploadedUrl;
  static var client = http.Client();
  bool? isUploaded;

  Future<String> call(String image, XFile? imagefile) async {
    log(image);
    try {
      //  http://54.157.145.4:4000/api/image-upload

      var url = Uri.parse("http://54.172.81.16:4000/api/image-upload");
      log(url.toString());
      var request = http.MultipartRequest("POST", url);
      http.MultipartFile singlefile =
          await http.MultipartFile.fromPath("singlefile", imagefile!.path);
      request.files.add(singlefile);

      StreamedResponse response = await request.send();
      String responseBody =
          await response.stream.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResult = json.decode(responseBody);
        if (jsonResult['result'] == 1 &&
            jsonResult['message'] == 'upload succesfully') {
          List<String> fnames = List<String>.from(jsonResult['fname']);
          String? fname = fnames.isNotEmpty ? fnames[0] : null;
          print(fname);
          String result = fname!.replaceAll(' ', '+');
          uploadedUrl = 'https://xpire-images.s3.amazonaws.com/single/$result';
          print(uploadedUrl);
          isUploaded = true;
        }
      } else {
        uploadedUrl = 'Empty';
        isUploaded = false;
      }
    } catch (e) {
      EasyLoading.dismiss();
      log(e.toString());
      rethrow;
    }
    return uploadedUrl!;
  }
}

class UpdateAwsFile {
  String? uploadedUrl;

  static var client = http.Client();
  Future<String> call(String? imagefile) async {
    try {
      var url = Uri.parse("http://54.172.81.16:4000/api/image-upload");
      // var url = Uri.http("http://13.231.143.150:5001/api/image-upload");

      log(url.toString());
      var request = http.MultipartRequest("POST", url);

      http.MultipartFile singlefile = await http.MultipartFile.fromPath(
        "singlefile",
        imagefile!,
      );

      request.files.add(singlefile);
      StreamedResponse response = await request.send();
      String responseBody =
          await response.stream.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResult = json.decode(responseBody);
        if (jsonResult['result'] == 1 &&
            jsonResult['message'] == 'upload succesfully') {
          List<String> fnames = List<String>.from(jsonResult['fname']);
          String? fname = fnames.isNotEmpty ? fnames[0] : null;
          print(fname);
          String result = fname!.replaceAll(' ', '+');
          uploadedUrl = 'https://xpire-images.s3.amazonaws.com/single/$result';
          log(uploadedUrl!);
        }
      } else {
        uploadedUrl = 'Empty';
      }
    } catch (e) {
      EasyLoading.dismiss();
      log(e.toString());

      rethrow;
    }

    return uploadedUrl!;
  }
}
