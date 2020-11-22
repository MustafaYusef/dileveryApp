import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tamataSrt/bloc/AuthBloc/cubit/authcubit_cubit.dart';
import 'package:tamataSrt/model/provinesModel.dart';
import 'package:tamataSrt/repastory/authRepastory.dart';
import 'package:toast/toast.dart';

class RegesterScreen extends StatefulWidget {
  RegesterScreen({Key key}) : super(key: key);

  @override
  _RegesterScreenState createState() => _RegesterScreenState();
}

List<Province> provList;
Province prov;

class _RegesterScreenState extends State<RegesterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  Province selectedValue;

  bool flage = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Directionality(
            textDirection: TextDirection.rtl,
            child: Text("أنشاء حساب",
                style: TextStyle(color: Colors.black, fontSize: 22))),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) {
          return AuthcubitCubit(AuthRepostary())..getProvines(context);
        },
        child: SingleChildScrollView(
          child: Container(
            child: BlocBuilder<AuthcubitCubit, AuthcubitState>(
                builder: (context, state) {
              if (state is ProvinesLoaded) {
                provList = state.provines.provinces;
                // selectedObject = state.provines.provinces[0];
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Directionality(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Theme(
                              data: new ThemeData(
                                primaryColor: Colors.blueAccent,
                                primaryColorDark: Colors.red,
                              ),
                              child: TextField(
                                controller: usernameController,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 20),
                                decoration: new InputDecoration(
                                    border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(20.0),
                                      ),
                                    ),
                                    hoverColor: Colors.amber,
                                    filled: true,
                                    hintStyle:
                                        new TextStyle(color: Colors.grey[800]),
                                    alignLabelWithHint: true,
                                    labelText: "أسم المستخدم",
                                    hasFloatingPlaceholder: true,
                                    labelStyle: TextStyle(
                                        fontSize: 18,
                                        backgroundColor: Colors.transparent,
                                        decorationColor: Colors.transparent),
                                    // counter: Text("${count}/${10}"),
                                    helperText: "يجب ادخال الأسم",
                                    prefixIcon: const Icon(
                                      Icons.person,
                                    ),

                                    // counterText: "${count}/${10}",
                                    contentPadding: EdgeInsets.only(
                                        left: 6, right: 6, top: 0, bottom: 15),
                                    fillColor: Colors.white70),
                              ),
                            ),
                          ),
                          textDirection: TextDirection.rtl),
                    ),
                    Directionality(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Theme(
                            data: new ThemeData(
                              primaryColor: Colors.blueAccent,
                              primaryColorDark: Colors.red,
                            ),
                            child: TextField(
                              controller: phoneNumController,
                              maxLength: 11,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(fontSize: 20),
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(20.0),
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                  hintText: "07712345678",
                                  alignLabelWithHint: true,
                                  labelText: "رقم الهاتف",
                                  hasFloatingPlaceholder: true,
                                  labelStyle: TextStyle(
                                      fontSize: 18,
                                      backgroundColor: Colors.transparent,
                                      decorationColor: Colors.transparent),
                                  // counter: Text("${count}/${10}"),
                                  helperText: "يجب ان يتكون الرقم من 11 مراتب",
                                  prefixIcon: const Icon(Icons.phone),

                                  // counterText: "${count}/${10}",
                                  contentPadding: EdgeInsets.only(
                                      left: 6, right: 6, top: 0, bottom: 15),
                                  fillColor: Colors.white70),
                            ),
                          ),
                        ),
                        textDirection: TextDirection.rtl),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20)),
                        child: DropdownButton(
                            hint: Text(
                              "المحافظة",
                              style: TextStyle(fontSize: 18),
                            ),
                            underline: Container(),
                            dropdownColor: Colors.grey[300],
                            isExpanded: true,
                            icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              size: 24,
                            ),
                            value: selectedValue,
                            items: provList.map((e) {
                              return DropdownMenuItem(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        e.name,
                                        style: TextStyle(fontSize: 18),
                                      )),
                                    ],
                                  ),
                                ),
                                value: e,
                              );
                            }).toList(),
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                selectedValue = value;
                                // selectedObject = value;
                                // selectedId = value.id;
                                // prov = value;

                                // print("value   id :" +
                                //     widget.selectedValue.id.toString());
                                // print("value  :" + widget.selectedValue.name);
                              });

                              //  selectedId = value.id;
                            }),
                      ),
                    ),
                    Directionality(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Theme(
                            data: new ThemeData(
                              primaryColor: Colors.blueAccent,
                              primaryColorDark: Colors.red,
                            ),
                            child: TextField(
                              controller: locationController,
                              keyboardType: TextInputType.text,
                              style: TextStyle(fontSize: 20),
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(20.0),
                                    ),
                                  ),
                                  hoverColor: Colors.amber,
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                  alignLabelWithHint: true,
                                  labelText: "الموقع",
                                  hasFloatingPlaceholder: true,
                                  labelStyle: TextStyle(
                                      fontSize: 18,
                                      backgroundColor: Colors.transparent,
                                      decorationColor: Colors.transparent),
                                  // counter: Text("${count}/${10}"),
                                  helperText: "يجب ادخال الموقع",
                                  prefixIcon: const Icon(
                                    Icons.location_city,
                                  ),

                                  // counterText: "${count}/${10}",
                                  contentPadding: EdgeInsets.only(
                                      left: 6, right: 6, top: 0, bottom: 15),
                                  fillColor: Colors.white70),
                            ),
                          ),
                        ),
                        textDirection: TextDirection.rtl),
                    Directionality(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Theme(
                            data: new ThemeData(
                              primaryColor: Colors.blueAccent,
                              primaryColorDark: Colors.red,
                            ),
                            child: TextField(
                              controller: passController,
                              keyboardType: TextInputType.visiblePassword,
                              style: TextStyle(fontSize: 20),
                              decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(20.0),
                                    ),
                                  ),
                                  hoverColor: Colors.amber,
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                  hintText: "",
                                  alignLabelWithHint: true,
                                  labelText: "كلمة المرور",
                                  hasFloatingPlaceholder: true,
                                  labelStyle: TextStyle(
                                      fontSize: 18,
                                      backgroundColor: Colors.transparent,
                                      decorationColor: Colors.transparent),
                                  prefixIcon: const Icon(Icons.lock),
                                  suffix: Container(
                                    height: 40,
                                    child: IconButton(
                                      icon: flage
                                          ? Icon(
                                              Icons.visibility_off,
                                              size: 20,
                                            )
                                          : Icon(
                                              Icons.visibility,
                                              size: 20,
                                            ),
                                      color: Colors.blueAccent,
                                      onPressed: () {
                                        setState(() {
                                          if (flage) {
                                            flage = false;
                                          } else {
                                            flage = true;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  helperText: "ادخل كلمة المرور",
                                  contentPadding: EdgeInsets.only(
                                      left: 6, right: 6, top: 0, bottom: 15),
                                  fillColor: Colors.white70),
                              obscureText: flage,
                            ),
                          ),
                        ),
                        textDirection: TextDirection.rtl),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          elevation: 5,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text("تسجيل",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ),
                          onPressed: () async {
                            if (passController.text.isNotEmpty &&
                                phoneNumController.text.isNotEmpty &&
                                locationController.text.isNotEmpty &&
                                usernameController.text.isNotEmpty) {
                              BlocProvider.of<AuthcubitCubit>(context)
                                  .RegesterRequest(
                                context,
                                usernameController.text.toString(),
                                phoneNumController.text.toString(),
                                passController.text.toString(),
                                selectedValue.id,
                                locationController.text.toString(),
                              );
                            } else {
                              Toast.show("أكمل جميع الحقول", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            }
                          },
                        ),
                      ),
                    )
                  ],
                );
              }
              if (state is AuthcubitLoading) {
                return Container(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}

// class provinesWidget extends StatefulWidget {
//   provinesWidget({Key key}) : super(key: key);
//   Province selectedValue = provList[0];
//   int selectedId = provList[0].id;

//   @override
//   _provinesWidgetState createState() => _provinesWidgetState();
// }

// class _provinesWidgetState extends State<provinesWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey),
//             borderRadius: BorderRadius.circular(20)),
//         child: DropdownButton(
//             underline: Container(),
//             dropdownColor: Colors.grey[300],
//             isExpanded: true,
//             icon: Icon(
//               Icons.keyboard_arrow_down_outlined,
//               size: 24,
//             ),
//             value: widget.selectedValue,
//             items: provList.map((e) {
//               return DropdownMenuItem(
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   child: Row(
//                     children: [
//                       Expanded(
//                           child: Text(
//                         e.name,
//                         style: TextStyle(fontSize: 18),
//                       )),
//                     ],
//                   ),
//                 ),
//                 value: e,
//               );
//             }).toList(),
//             onChanged: (value) {
//               print(value);
//               setState(() {
//                 widget.selectedValue = value;
//                 // selectedObject = value;
//                 widget.selectedId = value.id;
//                 prov = value;

//                 print("value   id :" + widget.selectedValue.id.toString());
//                 print("value  :" + widget.selectedValue.name);
//               });

//               //  selectedId = value.id;
//             }),
//       ),
//     );
//   }
// }
