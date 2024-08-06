import 'dart:ui';

import 'package:chatty/pages/register_page.dart';
import 'package:chatty/resources/colors.dart';
import 'package:chatty/resources/images.dart';
import 'package:chatty/utils/extensions.dart';
import 'package:chatty/widgets/small_primary_button_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import '../blocs/login_bloc.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../widgets/loading_view.dart';
import '../widgets/primary_button_view.dart';


class VerifyPage extends StatefulWidget {

  const VerifyPage({Key? key}) : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {

  String phNumber = "";

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
                        LBL_HI,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: TEXT_BIG,
                          color: primaryColor,
                          fontFamily: 'YorkieDEMO',
                        ),
                      ),
                      const Text(
                        LBL_CREATE_A_NEW_ACCOUNT,
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
                      Row(
                        children: [
                          SizedBox(
                            width: 240,
                            child: TextFormField(
                              onChanged: (text) {
                                setState(() {
                                  phNumber = text;
                                });
                              },
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  hintText: LBL_ENTER_YOUR_PHONE_NUMBER,
                                  border: UnderlineInputBorder(
                                  ),
                                  labelText: LBL_ENTER_YOUR_PHONE_NUMBER
                              ),
                            ),
                          ),
                          Spacer(),
                          SmallPrimaryButtonView(label: LBL_GET_OTP, onTap: (){
                          })
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 42.0),
                        child: OtpTextField(
                          numberOfFields: 4,
                          borderColor: Color(0xFF512DA8),
                          //set to true to show as box or false to show as dash
                          showFieldAsBox: true,
                          //runs when a code is typed in
                          onCodeChanged: (String code) {
                            //handle validation or checks here
                          },
                          //runs when every textfield is filled
                          onSubmit: (String verificationCode){
                            // showDialog(
                            //     context: context,
                            //     builder: (context){
                            //       return AlertDialog(
                            //         title: Text("Verification Code"),
                            //         content: Text('Code entered is $verificationCode'),
                            //       );
                            //     }
                            // );
                          }, // end onSubmit
                        ),
                      ),
                      const SizedBox(
                        height: MARGIN_XXLLARGE,
                      ),
                       Align(
                        alignment: Alignment.center,
                        child: RichText(
                            text: TextSpan(
                              text: '',
                              style: DefaultTextStyle.of(context).style,
                              children: const <TextSpan>[
                                TextSpan(
                                  text: LBL_DONT_RECEIVE_THE_OTP,
                                  style: TextStyle(
                                    color: Colors.grey
                                  )
                                ),
                                TextSpan(
                                    text: LBL_RESEND_CODE,
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold
                                    )
                                )
                              ]
                            )),

                      ),
                      const SizedBox(
                        height: MARGIN_MEDIUM,
                      ),
                      Consumer<LoginBloc>(
                        builder: (context, bloc, child) => TextButton(
                          onPressed: () {
                          },
                          child:  Center(
                            child: PrimaryButtonView(
                              label: LBL_VERIFY, onTap: (){
                              if(phNumber.isEmpty){
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(content: Text(LBL_ENTER_YOUR_PHONE_NUMBER)));
                              }else{
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => RegisterPage(phNo: phNumber)),
                                );
                              }
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

