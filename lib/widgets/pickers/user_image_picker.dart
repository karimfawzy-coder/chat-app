import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) pickImageFn ;

  UserImagePicker({this.pickImageFn});

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  Future _pickImage() async {
    final picker = ImagePicker();
    final pickedImageFile = await picker.getImage(source: ImageSource.camera ,
    imageQuality: 50,maxHeight: 150,maxWidth: 150);
    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
    widget.pickImageFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 45,
          backgroundColor: Colors.grey.shade600,
          backgroundImage: _pickedImage == null ? null : FileImage(_pickedImage),
        ),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickImage,
          icon: Icon(
            Icons.image,
            color: Theme.of(context).primaryColor,
          ),
          label: Text('Add Image'),
        ),
      ],
    );
  }
}
