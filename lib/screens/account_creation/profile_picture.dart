import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/appbar.dart';
import '../../components/buttons.dart';
import '../../constants.dart';
import '../../functions/alerts.dart';
import '../../functions/user_service.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({Key? key}) : super(key: key);

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  File? _profilePicture;

  Widget _drawPicture() {
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

  Widget _drawNextBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_profilePicture != null) {
            UserService.setProfilePhoto(_profilePicture!, context);
          } else {
            Alerts.showErrorSnackBar(noPictureSelected, context);
          }
        },
        child: Text(
          nextBtn.toUpperCase(),
          style: Buttons.getTextStyle(),
        ),
        style: Buttons.getStyle(),
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
      appBar: AppBars.drawAppBar(profilePictureTitle),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _drawPicture(),
            Expanded(child: Container()),
            _drawNextBtn(),
          ],
        ),
      ),
    );
  }
}
