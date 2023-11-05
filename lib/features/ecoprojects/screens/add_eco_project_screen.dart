import 'dart:io';

import 'package:econexus/common/custom_continue_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../common/drawer_file.dart';
import '../../../constants/constants.dart';
import '../../../theme/Theme.dart';

class AddEcoProjectScreen extends StatefulWidget {
  const AddEcoProjectScreen({Key? key}) : super(key: key);

  @override
  State<AddEcoProjectScreen> createState() => _AddEcoProjectScreenState();
}

class _AddEcoProjectScreenState extends State<AddEcoProjectScreen> {
  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController goalController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate),
      );

      if (selectedTime != null) {
        picked = DateTime(
          picked.year,
          picked.month,
          picked.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        setState(() {
          selectedDate = picked!;
        });
      }
    }
  }

  Future<void> _getImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("$appName"),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              "Add an Eco Project 🚀",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.headingTextColor,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Placeholder color
                    ),
                    child: _image != null
                        ? Image.file(
                            File(_image!.path),
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.cloud_upload,
                              size: 60,
                              color: Colors.white,
                            ),
                            onPressed: _getImage,
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: projectNameController,
              decoration: InputDecoration(labelText: "Project Name"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: "Location"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "Description"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: goalController,
              decoration: InputDecoration(labelText: "Goal"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: TextEditingController(
                text: DateFormat('yyyy-MM-dd').format(selectedDate),
              ),
              decoration: InputDecoration(
                labelText: "Start Date",
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    _selectDate(context);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomContinueButton(
              onPressed: () {},
              text: "Let's do this 💫",
            )
          ],
        ),
      ),
    );
  }
}
