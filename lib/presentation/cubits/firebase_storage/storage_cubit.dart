import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/storage/upload_image.dart';

part 'storage_state.dart';

class StorageCubit extends Cubit<StorageState> {
  StorageCubit(this.uploadImage) : super(StorageInitial());

  final UploadImage uploadImage;

  void onUploadImage({required String path, required File file}) async {
    emit(StorageLoading());
    await uploadImage(path: path, file: file).then((value) {
      emit(StorageDone(path: path));
    });
  }
}
