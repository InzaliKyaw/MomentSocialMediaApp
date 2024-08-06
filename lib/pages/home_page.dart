import 'package:chatty/pages/chat_page.dart';
import 'package:chatty/pages/contact_page.dart';
import 'package:chatty/pages/moment_page.dart';
import 'package:chatty/pages/profile_page.dart';
import 'package:chatty/pages/setting_page.dart';
import 'package:chatty/resources/colors.dart';
import 'package:chatty/resources/dimens.dart';
import 'package:chatty/resources/images.dart';
import 'package:chatty/resources/strings.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String selectedText = LBL_MOMENT;
  bool visibleBookList = true;
  int currentIndex = 0;
  List<Widget> screenWidgets = [const MomentPage(), const ChatPage(),const ContactPage(),const ProfilePage(),const SettingPage()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 0,
                blurRadius: 20,
                offset: const Offset(4, 0),
              ),
            ]
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          selectedItemColor: primaryColor,
          selectedFontSize: TEXT_SMALL,
          unselectedFontSize: TEXT_SMALL,
          unselectedItemColor: kBottonNavigationUnSelectedColor,
          showUnselectedLabels: true,
          backgroundColor: kBackgroundColor,
          type: BottomNavigationBarType.fixed,
          items: _getBottomNavigationItems(),
          onTap: (selectedIndex) {
            setState(() {
              currentIndex = selectedIndex;
            });
          },
        ),
      ),
      body: screenWidgets[currentIndex],
    );
  }

  List<BottomNavigationBarItem> _getBottomNavigationItems(){
    return [
      BottomNavigationBarItem(icon:
      Image.asset(
        MOMENT,
        width: MARGIN_LARGE,
        height: MARGIN_LARGE,
        color: kBottonNavigationUnSelectedColor,
      ),
          activeIcon: Image.asset(
            MOMENT,
            width: MARGIN_LARGE,
            height: MARGIN_LARGE,
            color: primaryColor,
          ),
          label: LBL_MOMENT
      ),
      BottomNavigationBarItem(icon:
      Image.asset(
        CHAT,
        width: MARGIN_LARGE,
        height: MARGIN_LARGE,
        color: kBottonNavigationUnSelectedColor,
      ),
          activeIcon: Image.asset(
            CHAT,
            width: MARGIN_LARGE,
            height: MARGIN_LARGE,
            color: primaryColor,
          ),
          label: LBL_CHAT
      ),
      BottomNavigationBarItem(icon:
      Image.asset(
        CONTACTS,
        width: MARGIN_LARGE,
        height: MARGIN_LARGE,
        color: kBottonNavigationUnSelectedColor,
      ),
          activeIcon: Image.asset(
            CONTACTS,
            width: MARGIN_LARGE,
            height: MARGIN_LARGE,
            color: primaryColor,
          ),
          label: LBL_CONTACT
      ),
      BottomNavigationBarItem(icon:
      Image.asset(
        ME,
        width: MARGIN_LARGE,
        height: MARGIN_LARGE,
        color: kBottonNavigationUnSelectedColor,
      ),
          activeIcon: Image.asset(
            ME,
            width: MARGIN_LARGE,
            height: MARGIN_LARGE,
            color: primaryColor,
          ),
          label: LBL_ME
      ),
      BottomNavigationBarItem(icon:
      Image.asset(
        SETTING,
        width: MARGIN_LARGE,
        height: MARGIN_LARGE,
        color: kBottonNavigationUnSelectedColor,
      ),
          activeIcon: Image.asset(
            SETTING,
            width: MARGIN_LARGE,
            height: MARGIN_LARGE,
            color: primaryColor,
          ),
          label: LBL_SETTING
      ),
    ];
  }

}

