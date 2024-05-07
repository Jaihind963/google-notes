import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  void flutterToast(String mess) {
    Fluttertoast.showToast(
        msg: mess,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  void showBottomBar(BuildContext context, Function(String) setImage) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return ListView(
        padding: EdgeInsets.only(top: 20, bottom: 100),
        shrinkWrap: true,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Pick Profile Picture",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  // Pick an image.
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 80,
                  );

                  if (image != null) {
                    setImage(image.path);
                print("image path: ${image.path}");
                    Navigator.pop(context);
                  }
                },
                icon: Image.asset(
                  "assets/images/add_image.png",
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
                label: Text("Photo"),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  // Capture a photo.
                  final XFile? photo = await picker.pickImage(
                    source: ImageSource.camera,
                  );

                  if (photo != null) {
                    setImage(photo.path);
                    Navigator.pop(context);
                  }
                },
                icon: Image.asset(
                  "assets/images/camera.png",
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill,
                ),
                label: Text("Camera"),
              ),
            ],
          )
        ],
      );
    },
  );
}
}
