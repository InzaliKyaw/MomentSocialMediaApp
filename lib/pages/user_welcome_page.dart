import 'package:chatty/pages/login_page.dart';
import 'package:chatty/pages/register_page.dart';
import 'package:chatty/pages/verify_page.dart';
import 'package:chatty/resources/colors.dart';
import 'package:chatty/resources/dimens.dart';
import 'package:chatty/resources/images.dart';
import 'package:chatty/resources/strings.dart';
import 'package:chatty/utils/extensions.dart';
import 'package:chatty/widgets/primary_button_view.dart';
import 'package:chatty/widgets/secondary_button_view.dart';
import 'package:flutter/material.dart';

class UserWelcomePage extends StatelessWidget {
  const UserWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: MARGIN_XXLLARGE,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Image.asset(LOCAL_USER_WELCOME_LOGO,
                width: 200,
                height: 200,),
              ),
            ),
            Spacer(),
            const Text(
              LBL_TEXT_YOUR_FRIENDS_AND_SHARE_MOMENTS,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: TEXT_REGULAR_4X,
                  color: primaryColor,
                fontFamily: 'YorkieDEMO',
              ),
            ),
            const Text(
              LBL_END_TO_END_MESSAGE,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: TEXT_REGULAR,
                  color: primaryColor
              ),
            ),
            const SizedBox(
              height: MARGIN_XXLARGE,
            ),
             Row(
              children: [
                SecondaryButtonView(label: LBL_SIGN_UP, onTap: ()=> navigateToScreen(
                 context, const VerifyPage()
             ),),
                Spacer(),
                PrimaryButtonView(label: LBL_LOGIN, onTap:() => navigateToScreen(
                  context, LoginPage()
                ),),
              ],
            ),
            const SizedBox(
              height: MARGIN_LARGE,
            ),
          ],
        ),
      ),
    );
  }
}
