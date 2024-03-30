import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfilePicture extends StatefulWidget {
  const UserProfilePicture({super.key, required this.selectedPickture});

  final void Function(File pickedImage) selectedPickture;

  @override
  State<UserProfilePicture> createState() => _UserProfilePictureState();
}

class _UserProfilePictureState extends State<UserProfilePicture> {
  File? pickedImageFile;

  void pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedImage == null) {
      return;
    }
    setState(() {
      pickedImageFile = File(pickedImage.path);
    });

    widget.selectedPickture(pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Foreground Image
        CircleAvatar(
          radius: 80,
          backgroundColor: Colors.grey.shade400,
          foregroundImage:
              pickedImageFile != null ? FileImage(pickedImageFile!) : null,
        ),
        // Camera Icon Container
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black26.withOpacity(0.8),
            ),
            child: IconButton(
              onPressed: pickImage,
              icon: const Icon(
                Icons.camera_enhance,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
