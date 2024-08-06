import 'dart:ui';

import 'package:chatty/blocs/profile_bloc.dart';
import 'package:chatty/resources/colors.dart';
import 'package:chatty/widgets/primary_button_view.dart';
import 'package:chatty/widgets/secondary_button_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../resources/dimens.dart';
import '../resources/images.dart';
import '../resources/strings.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedRadio = 0;
  String name = "";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? selectedDay = "";
  String? selectedMonth = "";
  String? selectedYear = "";
  String? birthday = "";

  @override
  void initState() {
    /// This ensures that the base class's initState method runs first,
    super.initState();
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _selectedRadio = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileBloc(),
      child: Scaffold(
        body: CustomScrollView(slivers: [
          SliverAppBar(
            expandedHeight: 100.0,
            floating: false,
            pinned: false,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  children: [
                    const Text(
                      LBL_ME,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontFamily: 'YorkieDEMO',
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      MARGIN_CARD_MEDIUM_2),
                                  child: Container(
                                    height: 400,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      MARGIN_CARD_MEDIUM_2),
                                                  child: Icon(Icons.close),
                                                ))),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: TextField(
                                            controller: _nameController,
                                            decoration: const InputDecoration(
                                              labelText: LBL_NAME,
                                              hintText: LBL_NAME,
                                            ),
                                            onChanged: (userName) {
                                              // setState(() {
                                              //   name = userName;
                                              // });
                                              // bloc.onUserNameChanged(userName);
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: TextField(
                                            controller: _emailController,
                                            decoration: const InputDecoration(
                                              labelText: LBL_EMAIL,
                                              hintText: LBL_EMAIL,
                                            ),
                                            onChanged: (userName) {
                                              // setState(() {
                                              //   name = userName;
                                              // });
                                              // bloc.onEmailChanged(userName);
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: DropdownButtonFormField<String>(
                                                    value: days.first,
                                                    items: days
                                                        .map(
                                                          (item) => DropdownMenuItem(
                                                        value: item,
                                                        child: Text(item),
                                                      ),
                                                    )
                                                        .toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedDay = value;
                                                      });
                                                    },
                                                  )),
                                              const SizedBox(width: 8.0),
                                              Expanded(
                                                child: DropdownButtonFormField<String>(
                                                  value: months.first,
                                                  items: months
                                                      .map(
                                                        (item) => DropdownMenuItem(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  )
                                                      .toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedMonth = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width:  8.0),
                                              Expanded(
                                                child: DropdownButtonFormField<String>(
                                                  value: years.first,
                                                  items: years
                                                      .map((item) => DropdownMenuItem(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ))
                                                      .toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedYear = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            SecondaryButtonView(label: LBL_SIGN_UP, onTap: () {

                                            },),
                                            Spacer(),
                                            PrimaryButtonView(label: LBL_LOGIN, onTap:(){

                                            },
                                        ),
                                        // Row(
                                        //   children: [
                                        //     Radio(
                                        //       value: 0,
                                        //       groupValue: _selectedRadio,
                                        //       onChanged: (value) {
                                        //         // bloc.onGenderChanged(LBL_MALE);
                                        //         _handleRadioValueChange(value!);
                                        //       },
                                        //     ),
                                        //     const Text(LBL_MALE),
                                        //     Radio(
                                        //       value: 1,
                                        //       groupValue: _selectedRadio,
                                        //       onChanged: (value) {
                                        //         // bloc.onGenderChanged(LBL_FEMALE);
                                        //         _handleRadioValueChange(value!);
                                        //       },
                                        //     ),
                                        //     const Text(LBL_FEMALE),
                                        //     Radio(
                                        //       value: 2,
                                        //       groupValue: _selectedRadio,
                                        //       onChanged: (value) {
                                        //         // bloc.onGenderChanged(LBL_OTHER);
                                        //         _handleRadioValueChange(value!);
                                        //       },
                                        //     ),
                                        //     const Text(LBL_OTHER),
                                        //   ],
                                        // ),
                                      ],
                                    ),]
                                  ),
                                ),
                              ),);
                            });
                      },
                      child: Image.asset(
                        EDIT_ICON,
                        height: 26,
                        width: 26,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<ProfileBloc>(builder: (context, bloc, child) {
                _nameController.text = bloc.profileVO?.userName ?? "";
                _emailController.text = bloc.profileVO?.email ?? "";
                return Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: Stack(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(PROFILE_RADIUS),
                              child: Image.network(
                                (bloc.profileVO?.profilePicture == null) ? NETWORK_IMAGE_POST_PLACEHOLDER
                                    : bloc.profileVO?.profilePicture ?? "",
                                height: PROFILE_IMG_H_W,
                                width: PROFILE_IMG_H_W,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return QRDialog(
                                        name: bloc.profileVO?.userName ?? "",
                                        id: bloc.profileVO?.id ?? "",
                                        profilePic:
                                            bloc.profileVO?.profilePicture ??
                                                "",
                                      );
                                    });
                              },
                              child: QrImageView(
                                data: bloc.profileVO?.id ?? "",
                                version: QrVersions.auto,
                                backgroundColor: Colors.white,
                                size: 40.0,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 24.0, left: 18, right: 14),
                            child: Text(
                              bloc.profileVO?.userName ?? "",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: MARGIN_MEDIUM_3),
                            ),
                          ),
                          Row(children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 8.0, bottom: 8.0, left: 14, right: 14),
                              child: Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                            ),
                            Text(bloc.profileVO?.phone ?? "",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: MARGIN_MEDIUM_2)),
                          ]),
                          Row(children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 8.0, bottom: 8.0, left: 14, right: 14),
                              child: Icon(
                                Icons.date_range,
                                color: Colors.white,
                              ),
                            ),
                            Text(bloc.profileVO?.birthday ?? "",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: MARGIN_MEDIUM_2)),
                          ]),
                          Row(children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 8.0, bottom: 8.0, left: 14, right: 14),
                              child: Icon(
                                Icons.person_pin_circle_outlined,
                                color: Colors.white,
                              ),
                            ),
                            Text(bloc.profileVO?.gender ?? "",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: MARGIN_MEDIUM_2)),
                          ]),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          )
        ]),
      ),
    );
  }
}

class QRDialog extends StatelessWidget {
  final String name;
  final String id;
  final String profilePic;

  const QRDialog(
      {super.key,
      required this.name,
      required this.id,
      required this.profilePic});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(MARGIN_CARD_MEDIUM_2),
                      child: Icon(Icons.close),
                    ))),
            Padding(
              padding: const EdgeInsets.only(top: MARGIN_CARD_MEDIUM_2),
              child: Text(
                name,
                style: const TextStyle(
                    fontSize: TEXT_REGULAR_4X, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                "Moment Contact",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 240,
              width: 240,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: QrImageView(
                      data: id,
                      version: QrVersions.auto,
                      backgroundColor: Colors.white,
                      size: 200.0,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(CHAT_DETAIL_RADIUS),
                      child: Image.network(
                        profilePic.isEmpty ? NETWORK_IMAGE_POST_PLACEHOLDER : profilePic,
                        height: CHAT_IMG_DETAIL_H_W,
                        width: CHAT_IMG_DETAIL_H_W,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
