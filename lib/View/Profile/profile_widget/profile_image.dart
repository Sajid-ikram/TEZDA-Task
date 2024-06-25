import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import '../../../Providers/profile_provider.dart';
import '../../../Utils/app_colors.dart';
import '../../auth/widgets/snackBar.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({Key? key}) : super(key: key);

  Future pickImage(BuildContext context, ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
        imageQuality: 20,
      );

      if (pickedFile != null) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: const Color(0xff2C3333),
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
          ],
        );

        if (croppedFile != null) {
          final File imageFile = File(croppedFile.path);
          Provider.of<ProfileProvider>(context, listen: false)
              .updateProfileUrl(imageFile, context);
        }
        Navigator.of(context).pop();
      }
    } catch (e) {
      Navigator.of(context).pop();
      snackBar(context, "Some error occur");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var pro = Provider.of<ProfileProvider>(context, listen: false);
    return SizedBox(
      height: size.height * 0.18,
      width: size.height * 0.155,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 4.0,
              ),
            ),
            height: size.height * 0.155,
            width: size.height * 0.155,
            child: buildClipRRect(pro, context),
          ),
          Positioned(
            right: 8.sp,
            bottom: 29.sp,
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.4),
                        blurRadius: 3,
                        offset: const Offset(3, 3), // Shadow position
                      ),
                    ]),
                child: InkWell(
                  onTap: () {
                    _showChoiceDialog(context);
                    //pickImage(context);
                  },
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showChoiceDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Make a Choice"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: const Text("Take a Picture"),
                    onTap: () {
                      pickImage(context, ImageSource.camera);
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: const Text("Select from Gallery"),
                    onTap: () {
                      pickImage(context, ImageSource.gallery);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget buildClipRRect(ProfileProvider pro, BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: pro.profileUrl != ""
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return PhotoView(
                          imageProvider: NetworkImage(pro.profileUrl),
                        );
                      }),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 21,
                    backgroundImage: NetworkImage(
                      pro.profileUrl,
                    ),
                  ),
                )
              : const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 21,
                  backgroundImage: AssetImage("assets/profile.jpg"),
                ),
        );
      },
    );
  }
}
