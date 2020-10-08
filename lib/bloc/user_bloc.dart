import 'package:cat_api/bloc/user_event.dart';
import 'package:cat_api/bloc/user_state.dart';
import 'package:cat_api/models/url.dart';
import 'package:cat_api/services/fact_repository.dart';
import 'package:cat_api/services/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UsersRepository usersRepository;
  final FactResponse factResponse;
  int index;

  UserBloc({this.usersRepository, this.factResponse, this.index})
      : super(UserEmptyState());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserLoadEvent) {
      yield UserLoadingState();
      try {
        final List<Url> _loadedUrlList = await usersRepository.getAllUrl();
        yield UserLoadedState(
          loadedUrl: _loadedUrlList,
        );
      } catch (_) {
        yield UserErrorState();
      }
    } else if (event is UserClearEvent) {
      yield UserEmptyState();
    }
  }
}
