import 'package:cat_api/bloc/user_bloc.dart';
import 'package:cat_api/pages/favorites.dart';
import 'package:cat_api/pages/input.dart';
import 'package:cat_api/services/fact_repository.dart';
import 'package:cat_api/services/user_repository.dart';
import 'package:cat_api/widgets/user_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({this.user, this.email, this.name, this.photo});
  final User user;
  final String name;
  final String email;
  final String photo;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final usersRepository = UsersRepository();
  final factResponse = FactResponse();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future signOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('email');
    return await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) => UserBloc(
        usersRepository: usersRepository,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          actions: <Widget>[],
          backgroundColor: Colors.black,
          elevation: 0,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 10,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                  ),
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: Center(
            child: Text(
              'CATS',
            ),
          ),
        ),
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Colors.white10,
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            widget.user == null
                                ? widget.photo
                                : widget.user.photoURL,
                          )),
                      SizedBox(width: 20),
                      Column(
                        children: <Widget>[
                          Text(
                            widget.user == null
                                ? widget.name
                                : widget.user.displayName,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width / 16,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                          Text(
                            widget.user == null
                                ? widget.email
                                : widget.user.email,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.blueGrey,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton(
                            color: Colors.grey,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.star, color: Colors.yellow),
                                SizedBox(width: 5),
                                Text('favorites'.toUpperCase()),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Favorites()));
                            },
                          ),
                          RaisedButton(
                              color: Colors.black26,
                              child: Text('Sign out'),
                              onPressed: () {
                                signOut();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Input()));
                              }),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(child: UserList()),
            ],
          ),
        ),
      ),
    );
  }
}
