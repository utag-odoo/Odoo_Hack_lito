import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReportDialogView extends StatefulWidget {
  final Function(String) onProblemNameChanged;
  final Function(String) onProblemDetailChanged;
  final Function() onTakePicture;
  final Function() onGetLocation;
  final Function() onSubmit;
  final Function() onCancel;
  final String location;
  final XFile? image;

  const ReportDialogView({
    Key? key,
    required this.onProblemNameChanged,
    required this.onProblemDetailChanged,
    required this.onTakePicture,
    required this.onGetLocation,
    required this.onSubmit,
    required this.onCancel,
    required this.location,
    this.image,
  }) : super(key: key);

  @override
  _ReportDialogViewState createState() => _ReportDialogViewState();
}

class _ReportDialogViewState extends State<ReportDialogView> {
  @override
  Widget build(BuildContext context) {
    final purpleTheme = Theme.of(context).copyWith(
      primaryColor: Colors.purple,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple),
    );

    return Theme(
      data: purpleTheme,
      child: AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Report Garbage', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.camera_alt, color: Colors.white),
                label: Text(widget.image == null ? 'Take Picture' : 'Retake Picture', style: TextStyle(color: Colors.white)),
                onPressed: widget.onTakePicture,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Problem Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(Icons.title, color: Colors.purple),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: widget.onProblemNameChanged,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Problem Detail',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(Icons.description, color: Colors.purple),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: widget.onProblemDetailChanged,
                maxLines: 3,
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.purple),
                    SizedBox(width: 10),
                    Expanded(child: Text(widget.location, style: TextStyle(fontSize: 14))),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                icon: Icon(Icons.my_location, color: Colors.white),
                label: Text('Get Current Location', style: TextStyle(color: Colors.white)),
                onPressed: widget.onGetLocation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: widget.onCancel,
            child: Text('Cancel', style: TextStyle(color: Colors.purple)),
          ),
          ElevatedButton(
            onPressed: widget.onSubmit,
            child: Text('Report', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }
}