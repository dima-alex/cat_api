import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Cat extends StatefulWidget {
  Cat({
    this.image,
    this.index,
    this.height,
    this.factData,
    this.fact,
    this.width,
    this.catHeight,
  });
  final factData;
  final String image;
  final int index;
  final double catHeight;
  final double height;
  final double width;
  final String fact;

  @override
  _CatState createState() => _CatState();
}

class _CatState extends State<Cat> {
  final _firestore = FirebaseFirestore.instance;
  IconData icon = Icons.favorite_border;
  var listFacts;

  @override
  void initState() {
    super.initState();
    update(widget.factData);
  }

  void update(dynamic data) async {
    listFacts = await data;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Card(
            child: SizedBox(
              width: double.infinity,
              height: widget.height,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Hero(
                      tag: 'foto${widget.index}',
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.image),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    right: 30,
                    child: IconButton(
                      icon: Icon(
                        icon,
                        color: Colors.white54,
                        size: 50,
                      ),
                      onPressed: () {
                        setState(() {
                          if (icon == Icons.favorite_border) {
                            _firestore.collection('image').add({
                              'url': widget.image,
                              'fact': listFacts,
                              'width': widget.width,
                              'height': widget.catHeight,
                            });
                            icon = Icons.favorite;
                          } else {
                            icon = Icons.favorite_border;
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.white,
            height: 10,
            thickness: 2,
          ),
          Card(
            color: Colors.black,
            child: RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.white, fontSize: 25),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'FACT:',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 30)),
                    TextSpan(
                        text: listFacts,
                        style: TextStyle(fontStyle: FontStyle.italic)),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
