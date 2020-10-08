import 'package:cat_api/bloc/user_bloc.dart';
import 'package:cat_api/bloc/user_state.dart';
import 'package:cat_api/services/fact_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cat_api/pages/cat.dart';
import '../bloc/user_event.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  IconData icon = Icons.favorite_border;
  String fact;
  String image;

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserEmptyState) {
          userBloc.add(UserLoadEvent());
        }
        if (state is UserLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is UserLoadedState) {
          return ListView.builder(
              itemCount: state.loadedUrl.length,
              itemBuilder: (context, index) {
                return Container(
                  child: ListTile(
                    title: GestureDetector(
                      onTap: () {
                        int ind = index;
                        String foto = state.loadedUrl[index].url;
                        double height =
                            state.loadedUrl[index].height.toDouble() /
                                (state.loadedUrl[index].width.toDouble() /
                                    MediaQuery.of(context).size.width);
                        var dataFact = FactResponse().getData(index);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Cat(
                                      factData: dataFact,
                                      image: foto,
                                      index: ind,
                                      height: height,
                                      catHeight: state.loadedUrl[index].height
                                          .toDouble(),
                                      width: state.loadedUrl[index].width
                                          .toDouble(),
                                    )));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        child: SizedBox(
                          width: double.infinity,
                          height: state.loadedUrl[index].height.toDouble() /
                              (state.loadedUrl[index].width.toDouble() /
                                  MediaQuery.of(context).size.width),
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: Hero(
                                  tag: 'foto$index',
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Colors.white24, width: 5),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            state.loadedUrl[index].url),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                left: 15,
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                      color: Colors.deepPurple, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        }
        if (state is UserErrorState) {
          return Center(
            child: Text(
              'Error fetching users',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        }
        return Center(child: Text('error'));
      },
    );
  }
}
