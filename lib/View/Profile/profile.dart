import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tezda_task/View/Auth/signin.dart';
import 'package:tezda_task/View/Profile/profile_widget/profile_image.dart';
import 'package:tezda_task/View/Profile/profile_widget/profile_list.dart';
import 'package:tezda_task/View/Profile/sub_page/edit_profile.dart';
import '../../Providers/auth_provider.dart';
import '../../Providers/profile_provider.dart';
import '../Auth/widgets/snackBar.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var pro = Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Container(
                  height: size.height * 0.21,
                  color: Colors.white,
                ),
                Container(
                  height: size.height - size.height * 0.21,
                  color: Colors.grey.withOpacity(0.1),
                ),
              ],
            ),
            topWidget(size, pro, context)
          ],
        ),
      ),
    );
  }
}

Widget topWidget(Size size, ProfileProvider pro, BuildContext context) {
  final List<String> listName = [
    "Edit Profile",
    "Privacy Policy",
    "LogOut",
  ];

  final List<IconData> listIcons = [
    Icons.person_outline,
    Icons.privacy_tip,
    Icons.login_outlined,
  ];

  return SingleChildScrollView(
    child: SizedBox(
      height: 800.h,
      width: 360.w,
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.12,
          ),
          const ProfileImage(),
          Consumer<ProfileProvider>(builder: (_, __, ___) {
            return Text(
              pro.profileName.isEmpty ? "Unknown Name" : pro.profileName,
              style: TextStyle(
                fontSize: 23.sp,
                fontWeight: FontWeight.bold,
              ),
            );
          }),

          const SizedBox(height: 10),
          Text(
            pro.email.isEmpty ? "Unknown Email" : pro.email,
            style: TextStyle(fontSize: 13.sp, color: Colors.grey),
          ),

          Consumer<ProfileProvider>(builder: (_, __, ___) {
            return Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      if (index == 0) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const EditProfile()));
                      } else if (index == 1) {
                        snackBar(context, "Not implemented yet!");
                      } else if (index == 2) {
                        Provider.of<Authentication>(context, listen: false)
                            .signOut();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const SignIn()));
                      }
                    },
                    child: profileList(
                      listName[index],
                      listIcons[index],
                    ),
                  );
                },
                itemCount: listIcons.length,
              ),
            );
          }),

          //const SizedBox(height: 55),
        ],
      ),
    ),
  );
}
