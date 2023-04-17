// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yoyo/domain/entity/user_entity.dart';

import '../../../domain/usecases/firestore/fetch_user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(
    this.fetchUser,
  ) : super(UserInitial());

  final FetchUser fetchUser;

  void onFetchUser({required String uid}) async {
    emit(FetchingUser());
    final either = await fetchUser(uid: uid);
    either.fold(
        (l) => emit(UserError(msg: l.msg)), (r) => emit(UserFetched(user: r)));
  }
}
