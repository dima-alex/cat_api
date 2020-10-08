import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

abstract class UserState {}

class UserEmptyState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  List<dynamic> loadedUrl;
  UserLoadedState({
    @required this.loadedUrl,
  }) : assert(loadedUrl != null);
}

class UserErrorState extends UserState {}
