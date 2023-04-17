import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:yoyo/core/router/custom_router.dart';
import 'package:yoyo/domain/entity/user_entity.dart';
import 'package:yoyo/presentation/widgets/customs/text.dart';

import '../../../core/constants/constant.dart';
import '../../../core/global/global.dart';
import '../../cubits/user/user_cubit.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  UserEntity? user;
  @override
  void initState() {
    super.initState();
    context
        .read<UserCubit>()
        .onFetchUser(uid: FirebaseAuth.instance.currentUser?.uid ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        print(state);
        if (state is UserFetched) {
          user = state.user;
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(1.h),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    height: 10.h,
                    width: 10.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor,
                      borderRadius: BorderRadius.circular(kMaxRadius),
                    ),
                    child: user?.imageLink != null
                        ? CachedNetworkImage(
                            imageUrl: user!.imageLink!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset('assets/image/MAIN_LOGO.png'),
                  ),
                  SizedBox(width: 4.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        user?.username ?? 'username',
                        size: 18.sp,
                      ),
                      CustomText(
                        user?.email ?? 'juandelacruz@example.com',
                        size: 15.sp,
                      ),
                      GestureDetector(
                        onTap: () {
                          AutoRouter.of(context)
                              .push(EditProfileRoute(user: user));
                        },
                        child: CustomText(
                          'Edit profile',
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              ListTile(
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    final BottomNavigationBar navigationBar =
                        globalNavigationKey.currentWidget
                            as BottomNavigationBar;
                    navigationBar.onTap!(0);
                  });
                },
                contentPadding: EdgeInsets.zero,
                leading: const CustomText('Log Out'),
              ),
            ],
          ),
        );
      },
    );
  }
}
