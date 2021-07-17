
import 'package:dlivrDriver/common/text.dart';
import 'package:flutter/material.dart';

class BuildSelectImageBottomSheet extends StatelessWidget {
  const BuildSelectImageBottomSheet({
    Key key,
    @required this.onGalleryTap,
    @required this.onCameraTap,
  }) : super(key: key);

  final VoidCallback onGalleryTap;
  final VoidCallback onCameraTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: BuildText('Pick from'),
          ),
          ListTile(
            leading: Icon(Icons.insert_photo_outlined),
            title: BuildText('Gallery'),
            onTap: onGalleryTap,
          ),
          ListTile(
            leading: Icon(Icons.camera_alt_outlined),
            title: BuildText('Camera'),
            onTap: onCameraTap,
          ),
        ],
      ),
    );
  }
}
