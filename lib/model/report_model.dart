import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final String userId;
  final String problemName;
  final String problemDetail;
  final String location;
  final String imageUrl;

  Report({
    required this.userId,
    required this.problemName,
    required this.problemDetail,
    required this.location,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'problemName': problemName,
      'problemDetail': problemDetail,
      'location': location,
      'imageUrl': imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}