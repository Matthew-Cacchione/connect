import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../components/appbars.dart';
import '../../components/styles.dart';
import '../../constants.dart';
import '../../functions/user_service.dart';

class ProfileCreation extends StatefulWidget {
  const ProfileCreation({Key? key}) : super(key: key);

  @override
  _ProfileCreationState createState() => _ProfileCreationState();
}

class _ProfileCreationState extends State<ProfileCreation> {
  DateTime _selectedDate = DateTime.now();
  File? _profilePicture;

  final _profileCreationKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  Widget _drawName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter your first name',
          style: Styles.defaultBtnTxt(),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _nameController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          decoration: Styles.defaultTxtField('', const Icon(Icons.person)),
          validator: (name) {
            if (name!.isEmpty) return emptyError;

            if (name.length < 3) return nameNotValid;

            return null;
          },
        ),
      ],
    );
  }

  Widget _drawProfilePicture() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 100,
            backgroundImage: _profilePicture == null
                ? const AssetImage('assets/images/default_profile.jpg')
                : FileImage(File(_profilePicture!.path)) as ImageProvider,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: RawMaterialButton(
              elevation: 2,
              fillColor: colorPrimary,
              padding: const EdgeInsets.all(15),
              shape: const CircleBorder(),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => _drawSourceSelect()),
                );
              },
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawSourceSelect() {
    return Container(
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            selectProfilePrompt,
            style: TextStyle(fontSize: 22),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  _selectPhoto(ImageSource.camera);
                },
                icon: const Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                ),
                label: const Text(cameraTxt),
              ),
              const SizedBox(width: 15),
              TextButton.icon(
                onPressed: () {
                  _selectPhoto(ImageSource.gallery);
                },
                icon: const Icon(
                  Icons.image,
                  color: Colors.black,
                ),
                label: const Text(galleryTxt),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _selectPhoto(ImageSource source) async {
    final selectedPhoto = await ImagePicker().pickImage(source: source);

    if (selectedPhoto != null) {
      setState(() {
        _profilePicture = File(selectedPhoto.path);
      });
    }
  }

  Widget _drawDateSelection() {
    String _simpleDate = DateFormat.yMMMd().format(_selectedDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter your birthdate',
          style: Styles.defaultBtnTxt(),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => _showDatePicker(),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: colorPrimary),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              _simpleDate,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

  void _showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height * 0.25,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: _selectedDate,
            maximumDate: DateTime.now(),
            onDateTimeChanged: (value) {
              setState(() {
                _selectedDate = value;
              });
            },
          ),
        );
      },
    );
  }

  Widget _drawNextBtn() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          UserService.setCreationData(_nameController.text.trim(), _selectedDate, _profilePicture!, _profileCreationKey, context);
        },
        child: Text(
          nextBtn.toUpperCase(),
          style: Styles.defaultBtnTxt(),
        ),
        style: Styles.defaultBtn(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultBar('Profile Creation'),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _profileCreationKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _drawName(),
              const SizedBox(height: 80),
              Text(
                'Choose your profile picture',
                style: Styles.defaultBtnTxt(),
              ),
              const SizedBox(height: 20),
              _drawProfilePicture(),
              const SizedBox(height: 80),
              _drawDateSelection(),
              Expanded(child: Container()),
              _drawNextBtn(),
            ],
          ),
        ),
      ),
    );
  }
}
