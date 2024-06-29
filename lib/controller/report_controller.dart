import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:lito/model/report_model.dart';
import 'package:lito/view/report_dialog_view.dart';


class ReportController {
  String problemName = '';
  String problemDetail = '';
  String location = 'Fetching location...';
  XFile? image;

  Future<String?> uploadImageToFirebase(XFile image) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('report_images')
          .child('${DateTime.now().toIso8601String()}.jpg');
      await ref.putFile(File(image.path));
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<bool> saveReportToFirestore(Report report) async {
    try {
      await FirebaseFirestore.instance.collection('reports').add(report.toMap());
      return true;
    } catch (e) {
      print('Error saving report: $e');
      return false;
    }
  }

  Future<String> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      return '${position.latitude}, ${position.longitude}';
    } catch (e) {
      print('Error getting location: $e');
      return 'Location unavailable';
    }
  }

  String? getCurrentUserId() {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  void showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return ReportDialogView(
              onProblemNameChanged: (value) => problemName = value,
              onProblemDetailChanged: (value) => problemDetail = value,
              onTakePicture: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
                if (pickedImage != null) {
                  setState(() {
                    image = pickedImage;
                  });
                }
              },
              onGetLocation: () async {
                String currentLocation = await getCurrentLocation();
                setState(() {
                  location = currentLocation;
                });
              },
              onSubmit: () async {
                await submitReport(context);
              },
              onCancel: () => Navigator.of(context).pop(),
              location: location,
              image: image,
            );
          },
        );
      },
    );
  }

  Future<void> submitReport(BuildContext context) async {
    String? userId = getCurrentUserId();
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You must be logged in to submit a report.')),
      );
      return;
    }

    if (image != null) {
      String? imageUrl = await uploadImageToFirebase(image!);
      if (imageUrl != null) {
        Report report = Report(
          userId: userId,
          problemName: problemName,
          problemDetail: problemDetail,
          location: location,
          imageUrl: imageUrl,
        );

        bool success = await saveReportToFirestore(report);

        if (success) {
          print('Report submitted successfully');
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error submitting report. Please try again.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading image. Please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please take a picture before submitting the report.')),
      );
    }
  }
}