import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamataSrt/bloc/AuthBloc/cubit/authcubit_cubit.dart';
import 'package:tamataSrt/repastory/authRepastory.dart';

import 'authUi/loginScreen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F0F0),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        centerTitle: true,
        title: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              "الحساب",
              style: TextStyle(fontSize: 22),
            )),
      ),
      body: BlocProvider(
        create: (context) {
          return AuthcubitCubit(AuthRepostary())..Profile(context);
        },
        child: BlocBuilder<AuthcubitCubit, AuthcubitState>(
            builder: (context, state) {
          if (state is AuthcubitLoading) {
            return Center(
              child: Container(child: CircularProgressIndicator()),
            );
          }
          if (state is ProfileLoaded) {
            return Container(
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.all(5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                state.profile.user.name,
                                style: TextStyle(fontSize: 20),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.person,
                            color: Theme.of(context).primaryColorDark,
                            size: 25,
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                state.profile.user.phone,
                                style: TextStyle(fontSize: 20),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.phone,
                            color: Theme.of(context).primaryColorDark,
                            size: 25,
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.all(5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                state.profile.user.address==null?"": state.profile.user.address,
                                style: TextStyle(fontSize: 20),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.pin_drop,
                            color: Theme.of(context).primaryColorDark,
                            size: 25,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      //   return OrderScreen();
                      // }));
                    },
                    child: Card(
                      margin: EdgeInsets.all(5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  "طلباتي",
                                  style: TextStyle(fontSize: 20),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.local_offer,
                              color: Theme.of(context).primaryColorDark,
                              size: 25,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.clear();
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (_) {
                        return LoginScreen();
                      }));
                    },
                    child: Card(
                      margin: EdgeInsets.all(5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  "تسجيل الخروج",
                                  style: TextStyle(fontSize: 20),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.screen_lock_rotation,
                              color: Theme.of(context).primaryColorDark,
                              size: 25,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
