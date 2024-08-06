import 'package:chatty/pages/home_page.dart';
import 'package:chatty/pages/verify_page.dart';
import 'package:chatty/resources/colors.dart';
import 'package:chatty/resources/images.dart';
import 'package:chatty/utils/extensions.dart';
import 'package:chatty/widgets/label_and_textfield_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/login_bloc.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../widgets/loading_view.dart';
import '../widgets/primary_button_view.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: const Icon(Icons.chevron_left)),
        ),
        body: SingleChildScrollView(
          child: Selector<LoginBloc, bool>(
            selector: (context, bloc) => bloc.isLoading,
            builder: (context, isLoading, child) => Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: LOGIN_SCREEN_TOP_PADDING,
                    bottom: MARGIN_LARGE,
                    left: MARGIN_XLARGE,
                    right: MARGIN_XLARGE,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        LBL_WELCOME,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: TEXT_BIG,
                          color: primaryColor,
                        ),
                      ),
                      const Text(
                        LBL_LOGIN_TO_CONTINUE,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: TEXT_REGULAR,
                            color: primaryColor
                        ),
                      ),
                      const SizedBox(
                        height: MARGIN_LARGE,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Image.asset(LOCAL_LOGIN_LOGO,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,),
                        ),
                      ),
                      const SizedBox(
                        height: MARGIN_LARGE,
                      ),
                      Consumer<LoginBloc>(
                        builder: (context, bloc, child) => LabelAndTextFieldView(
                          label: LBL_ENTER_YOUR_PHONE_NUMBER,
                          hint: HINT_EMAIL,
                          onChanged: (email) => bloc.onEmailChanged(email),
                        ),
                      ),
                      const SizedBox(
                        height: MARGIN_XLARGE,
                      ),
                      Consumer<LoginBloc>(
                        builder: (context, bloc, child) => LabelAndTextFieldView(
                          label: LBL_PASSWORD,
                          hint: HINT_PASSWORD,
                          onChanged: (password) =>
                          /// password
                              bloc.onPasswordChanged(password),
                          isSecure: true,
                        ),
                      ),
                      const SizedBox(
                        height: MARGIN_LARGE,
                      ),
                      const Align(
                        alignment: Alignment.topRight,
                        child: Text(LBL_FORGOT_PASSWORD,
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 16
                        ),),
                      ),
                      const SizedBox(
                        height: MARGIN_XLARGE,
                      ),
                      Consumer<LoginBloc>(
                        builder: (context, bloc, child) => TextButton(
                          onPressed: () {

                          },
                          child:  Center(
                            child: PrimaryButtonView(
                              label: LBL_LOGIN, onTap: (){
                              bloc.onTapLogin()
                                  .then((_) =>
                                  navigateToScreen(
                                      context, const HomePage()))
                                  .catchError((error) => showSnackBarWithMessage(
                                  context, error.toString()));
                            },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: MARGIN_LARGE,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: isLoading,
                  child: Container(
                    color: Colors.black12,
                    child: const Center(
                      child: LoadingView(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterTriggerView extends StatelessWidget {
  const RegisterTriggerView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          LBL_DONT_HAVE_AN_ACCOUNT,
        ),
        const SizedBox(width: MARGIN_SMALL),
        GestureDetector(
          onTap: () =>
              navigateToScreen(
                context,
                const VerifyPage(),
              )
          ,
          child: const Text(
            LBL_SIGN_UP,
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
