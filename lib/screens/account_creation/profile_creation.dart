import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/appbars.dart';
import '../../components/styles.dart';
import '../../constants.dart';

class ProfileCreation extends StatefulWidget {
  const ProfileCreation({Key? key}) : super(key: key);

  @override
  _ProfileCreationState createState() => _ProfileCreationState();
}

class _ProfileCreationState extends State<ProfileCreation> {
  File? _profilePicture;
  final profileCreationKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  Widget _drawName() {
    return TextFormField(
      controller: nameController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: Styles.defaultTxtField('', const Icon(Icons.person)),
      validator: (name) {
        if (name!.isEmpty) return emptyError;

        if (name.length < 3) return nameNotValid;

        return null;
      },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultBar('Profile Creation'),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your first name',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _drawName(),
            const SizedBox(height: 40),
            const Text(
              'Choose your profile picture',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _drawProfilePicture(),
            const SizedBox(height: 40),
            const Text('Enter your birthdate', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
