import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  // Constructor for the UserImagePicker widget.
  const UserImagePicker({
    super.key, // Key parameter for widget identification
    required this.onPickImage, // Callback function for when an image is picked
  });

  final void Function(File pickedImage) onPickImage;

  @override
  State<UserImagePicker> createState() {
    return _UserImagePickerState();
  }
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile; // Variable to store the picked image file

  // Function to pick an image from the camera using ImagePicker.
  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera, // Use the device's camera to capture the image
      imageQuality: 50, // Image quality (adjustable)
      maxWidth: 150, // Maximum width of the image (adjustable)
    );

    if (pickedImage == null) {
      return; // If no image is picked, exit the function
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path); // Update the picked image file
    });

    widget.onPickImage(_pickedImageFile!); // Call the callback with the picked image file
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage:
          _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage, // Call the _pickImage function when the button is pressed
          icon: const Icon(Icons.image),
          label: Text(
            'Add Image',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary, // Use the primary color from the theme
            ),
          ),
        )
      ],
    );
  }
}
