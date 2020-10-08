import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'cat.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final _firestore = FirebaseFirestore.instance;

  // void getImage() async {
  //   await for (var snapshot in _firestore.collection('image').snapshots()) {
  //     for (var image in snapshot.docs) {}
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: <Widget>[],
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Center(
          child: Text(
            'FAVORITES',
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('image').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final cats = snapshot.data.docs;
              List<Cats> list = [];
              for (var cat in cats) {
                final fact = cat.data()['fact'];
                final url = cat.data()['url'];
                final height = cat.data()['height'];
                final width = cat.data()['width'];
                final data = Cats(
                  fact: fact,
                  url: url,
                  height: height,
                  width: width,
                );
                list.add(data);
              }
              return Expanded(
                child: ListView(
                  children: list,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Cats extends StatelessWidget {
  final String fact;
  final String url;
  final double height;
  final double width;
  Cats({this.url, this.width, this.height, this.fact});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: GestureDetector(
        onTap: () {
          String foto = url;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Cat(
                        factData: fact,
                        image: foto,
                        height: height /
                            (width / MediaQuery.of(context).size.width),
                      )));
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          child: SizedBox(
            width: double.infinity,
            height: height / (width / MediaQuery.of(context).size.width),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.white24, width: 5),
                      image: DecorationImage(
                        image: NetworkImage(url),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
