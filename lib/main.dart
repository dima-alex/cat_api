import 'package:cat_api/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cat_api/pages/input.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences pref = await SharedPreferences.getInstance();
  var email = pref.getString('email');
  var name = pref.getString('name');
  var photo = pref.getString('photo');
  runApp(MaterialApp(
    home: email == null
        ? Input()
        : HomePage(
            email: email,
            name: name,
            photo: photo,
          ),
    theme: ThemeData.dark(),
  ));
}
