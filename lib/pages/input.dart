import 'package:cat_api/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Input extends StatefulWidget {
  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String userName;
  String userEmail;

  Future signInFb() async {
    var facebookLogin = FacebookLogin();
    var result = await facebookLogin.logIn(['email']);
    AuthCredential credential =
        FacebookAuthProvider.credential(result.accessToken.token);
    UserCredential userResult = await _auth.signInWithCredential(credential);
    User user = userResult.user;
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('email', user.email);
    pref.setString('name', user.displayName);
    pref.setString('photo', user.photoURL);
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage(user: user)),
      );
    }
  }

  Future signInGoogle() async {
    final GoogleSignInAccount account = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication authentication =
        await account.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken);
    UserCredential result = await _auth.signInWithCredential(credential);
    User user = result.user;
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('email', user.email);
    pref.setString('name', user.displayName);
    pref.setString('photo', user.photoURL);
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  user: user,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              SignInButton(
                Buttons.FacebookNew,
                text: 'Facebook',
                onPressed: () {
                  signInFb();
                },
              ),
              SizedBox(height: 10),
              SignInButton(
                Buttons.Google,
                text: 'Google',
                onPressed: () {
                  signInGoogle();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
