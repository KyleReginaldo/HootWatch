// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:yoyo/domain/entity/user_entity.dart';
import 'package:yoyo/presentation/cubits/image/image_cubit.dart';
import 'package:yoyo/presentation/cubits/firebase_storage/storage_cubit.dart';
import 'package:yoyo/presentation/widgets/customs/textfield.dart';

import '../../../core/constants/constant.dart';
import '../../cubits/user/user_cubit.dart';
import '../../cubits/user/user_fn/user_fn_cubit.dart';
import '../../widgets/customs/text.dart';

class EditProfileScreen extends StatefulWidget {
  final UserEntity? user;
  const EditProfileScreen({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final username = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    if (widget.user?.username != null) username.text = widget.user!.username;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(),
      body: Builder(builder: (context) {
        final imageFile = context.select((ImageCubit image) => image.state);
        return Padding(
          padding: EdgeInsets.all(1.h),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    height: 12.h,
                    width: 12.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor,
                      borderRadius: BorderRadius.circular(kMaxRadius),
                    ),
                    child: imageFile != null
                        ? Image.file(
                            File(imageFile.path),
                            fit: BoxFit.cover,
                          )
                        : widget.user?.imageLink != null
                            ? CachedNetworkImage(
                                imageUrl: widget.user!.imageLink!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/image/MAIN_LOGO.png',
                              ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: -2.h,
                    child: GestureDetector(
                      onTap: () {
                        scaffoldKey.currentState?.showBottomSheet(
                          (context) {
                            return Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    context
                                        .read<ImageCubit>()
                                        .pickImage(source: ImageSource.gallery)
                                        .then(
                                            (value) => Navigator.pop(context));
                                  },
                                  iconColor: Colors.white,
                                  leading: const Icon(Icons.image_rounded),
                                  title: const CustomText('Gallery'),
                                ),
                                ListTile(
                                  onTap: () {
                                    context
                                        .read<ImageCubit>()
                                        .pickImage(source: ImageSource.camera)
                                        .then(
                                            (value) => Navigator.pop(context));
                                  },
                                  iconColor: Colors.white,
                                  leading:
                                      const Icon(Icons.camera_enhance_rounded),
                                  title: const CustomText('Camera'),
                                ),
                              ],
                            );
                          },
                          backgroundColor:
                              Theme.of(context).secondaryHeaderColor,
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 4.h,
                        width: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(kMaxRadius),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              CustomTextField(
                hint: 'Username',
                label: 'Username',
                controller: username,
                fontColor: Colors.white,
              ),
              SizedBox(height: 2.h),
              BlocConsumer<StorageCubit, StorageState>(
                listener: (context, state) {
                  if (state is StorageDone) {
                    final user = UserEntity(
                      uid: FirebaseAuth.instance.currentUser?.uid ?? '',
                      username: username.text,
                      email: FirebaseAuth.instance.currentUser?.email ?? '',
                    );
                    context
                        .read<UserFnCubit>()
                        .onSetupUser(user: user, path: state.path);
                  }
                },
                builder: (context, state) {
                  return GestureDetector(
                    onTap: state is StorageLoading
                        ? null
                        : () async {
                            context.read<StorageCubit>().onUploadImage(
                                  path:
                                      'user/${FirebaseAuth.instance.currentUser?.uid}',
                                  file: File(imageFile!.path),
                                );
                          },
                    child: AnimatedContainer(
                      width: state is StorageLoading ? 6.h : 100.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor,
                        borderRadius: BorderRadius.circular(
                          state is StorageLoading ? 100 : kMinRadius,
                        ),
                      ),
                      alignment: Alignment.center,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.ease,
                      child: state is StorageLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const CustomText(
                              'Update',
                              color: Colors.white,
                            ),
                    ),
                  );
                },
              ),
              BlocListener<UserFnCubit, UserFnState>(
                listener: (context, state) {
                  if (state is UpdateError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: CustomText(state.msg)));
                  } else if (state is UpdateDone) {
                    Future.delayed(const Duration(seconds: 1), () async {
                      AutoRouter.of(context).pop();
                      context.read<UserCubit>().onFetchUser(
                            uid: FirebaseAuth.instance.currentUser?.uid ?? '',
                          );
                    });
                  }
                },
                child: const SizedBox.shrink(),
              ),
            ],
          ),
        );
      }),
    );
  }
}
