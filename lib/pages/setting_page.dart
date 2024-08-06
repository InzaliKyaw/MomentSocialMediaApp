import 'package:chatty/blocs/contact_bloc.dart';
import 'package:chatty/blocs/setting_bloc.dart';
import 'package:chatty/pages/user_welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resources/colors.dart';
import '../resources/images.dart';
import '../resources/strings.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SettingBloc(),
        child:  Scaffold(
          body: CustomScrollView(
            slivers: [
              const SliverAppBar(
                expandedHeight: 100.0,
                floating: false,
                pinned: false,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                flexibleSpace:  FlexibleSpaceBar(
                  title: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                    child: Row(
                      children: [
                        Text(LBL_SETTING,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                            fontFamily: 'YorkieDEMO',
                          ),),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Consumer<SettingBloc>(
                    builder: ( context, bloc, child) =>
                     GestureDetector(
                      onTap: (){
                           bloc.onTapLogout();
                           Navigator.of(context).push(MaterialPageRoute(builder:(context)=> const UserWelcomePage()));
                      },
                      child: const Card(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 24.0,top: 14,bottom: 14),
                                child: Text(
                                  LBL_LOG_OUT,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.0),
                                child: Icon(Icons.logout),
                              )
                            ],
                          )),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),);
  }
}
