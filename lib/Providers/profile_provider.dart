import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../Utils/custom_loading.dart';
import '../Utils/error_dialoge.dart';
import 'dart:io';

class ProfileProvider extends ChangeNotifier {
  String profileUrl = '';
  String profileName = '';
  String role = '';
  String email = '';
  String currentUserUid = '';
  List<String> favList = [];

  bool refreshAssignBus = false;

  getUserInfo() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userInfo = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      profileUrl = userInfo["url"];
      profileName = userInfo["name"];
      role = userInfo["role"];
      email = userInfo["email"];
      favList = List<String>.from(userInfo["favourite"]);
      currentUserUid = user.uid;
      notifyListeners();
    }
  }

  Future updateProfileInfo({
    required String name,
    required BuildContext context,
  }) async {
    try {
      FirebaseFirestore.instance.collection("users").doc(currentUserUid).update(
        {
          "name": name,
        },
      );
      profileName = name;

      notifyListeners();
    } catch (e) {
      return onError(context, "Having problem connecting to the server");
    }
  }

  void addToFavorites(String id) async {
    final docRef =
        FirebaseFirestore.instance.collection('users').doc(currentUserUid);
    favList.add(id);
    await docRef.update({
      'favourite': FieldValue.arrayUnion([id]),
    });
  }

  void removeFromFavorites(String id) async {
    final docRef =
        FirebaseFirestore.instance.collection('users').doc(currentUserUid);
    favList.remove(id);
    await docRef.update({
      'favourite': FieldValue.arrayRemove([id]),
    });
  }

  Future updateProfileUrl(File _imageFile, BuildContext context) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      buildLoadingIndicator(context);
      final ref = FirebaseStorage.instance
          .ref()
          .child("profileImage")
          .child(auth.currentUser!.uid);
      final result = await ref.putFile(_imageFile);
      final url = await result.ref.getDownloadURL();
      FirebaseFirestore.instance.collection("users").doc(currentUserUid).update(
        {"url": url},
      );
      profileUrl = url;
      Navigator.of(context, rootNavigator: true).pop();
      notifyListeners();
    } catch (e) {
      return onError(context, "Having problem connecting to the server");
    }
  }
}
