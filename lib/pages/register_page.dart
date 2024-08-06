import 'package:chatty/pages/login_page.dart';
import 'package:chatty/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/register_bloc.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import 'package:chatty/utils/extensions.dart';

class RegisterPage extends StatefulWidget {
  final String phNo;
  const RegisterPage({Key? key, required this.phNo }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int _selectedRadio = 0;
  bool isTerm = false;

  String? day = null;
  String? selectedDay = "";
  String? selectedMonth = "";
  String? selectedYear = "";
  String? birthday = "";
  String? name = "";
  String? email = "";
  bool isPassFilled = false;



  void _handleRadioValueChange(int value) {
    setState(() {
      _selectedRadio = value;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.chevron_left)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                left: MARGIN_XLARGE, right: MARGIN_XLARGE),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: MARGIN_SMALL),
                const Text(
                  LBL_HI,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'YorkieDEMO',
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  LBL_CREATE_A_NEW_ACCOUNT,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: MARGIN_XXLARGE),
                Consumer<RegisterBloc>(
                  builder: (context, bloc, child) =>
                      TextField(
                        decoration: const InputDecoration(
                          labelText: LBL_NAME,
                          hintText: LBL_NAME,
                        ),
                        onChanged: (userName) {
                          setState(() {
                            name = userName;
                          });
                          bloc.onUserNameChanged(userName);
                        }
                      ),
                ),
                const SizedBox(height: MARGIN_XXLARGE),
                Consumer<RegisterBloc>(
                  builder: (context, bloc, child) =>
                      TextField(
                        decoration: const InputDecoration(
                          labelText: LBL_EMAIL,
                          hintText: LBL_EMAIL,
                        ),
                        onChanged: (userEmail) {
                          setState(() {
                            email = userEmail;
                          });
                          bloc.onEmailChanged(userEmail);
                        }
                      ),
                ),
                const SizedBox(height: MARGIN_XXLARGE),
                Row(
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
                    const SizedBox(width: MARGIN_LARGE),
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
                const SizedBox(height: MARGIN_XXLARGE),
                Consumer<RegisterBloc>(
                  builder: (context, bloc, child)=> Row(
                    children: [
                      Radio(
                        value: 0,
                        groupValue: _selectedRadio,
                        onChanged: (value) {
                          bloc.onGenderChanged(LBL_MALE);
                          _handleRadioValueChange(value!);
                        },
                      ),
                      const Text(LBL_MALE),
                      const SizedBox(width: 16.0),
                      Radio(
                        value: 1,
                        groupValue: _selectedRadio,
                        onChanged: (value) {
                          bloc.onGenderChanged(LBL_FEMALE);
                           _handleRadioValueChange(value!);
                        },
                      ),
                      const Text(LBL_FEMALE),
                      const SizedBox(width: 16.0),
                      Radio(
                        value: 2,
                        groupValue: _selectedRadio,
                        onChanged: (value) {
                          bloc.onGenderChanged(LBL_OTHER);
                          _handleRadioValueChange(value!);
                        },
                      ),
                      const Text(LBL_OTHER),
                    ],
                  ),
                ),
                const SizedBox(height: MARGIN_XLARGE),
                Consumer<RegisterBloc>(
                  builder: (context, bloc, child) =>
                  TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    onChanged: (password){
                      setState(() {
                        isPassFilled = true;
                      });
                      bloc.onPasswordChanged(password);
                    },
                  ),
                ),
                const SizedBox(height: MARGIN_XLARGE),
                Row(
                  children: [
                    GestureDetector(
                      child: Checkbox(
                        value: isTerm,
                        onChanged: (value) {
                          setState(() {
                            isTerm = value!;
                          });
                        },
                      ),
                    ),
                    const Text('Agree To Term And Service'),
                  ],
                ),
                const SizedBox(height: MARGIN_XLARGE),
                Consumer<RegisterBloc>(
                  builder: (context, bloc, child) => GestureDetector(
                    onTap: () {
                      if(selectedDay!.isEmpty || selectedMonth!.isEmpty || selectedYear!.isEmpty){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text(BIRTHDAY_REQUIRED)));
                      }else if(isTerm == false){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text(AGREEMENT_REQUIRED)));
                      }else if(name!.isEmpty || email!.isEmpty || !isPassFilled){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text(FILLED_REQUIRED)));
                      } else{
                        birthday = "$selectedDay/$selectedMonth/$selectedYear";
                        bloc.onTapRegister(widget.phNo,birthday!)
                            .then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage())))
                            .catchError((error) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(error.toString())));
                        });
                      }
                    },
                    child: Container(
                      width: 140,
                      height: BUTTON_HEIGHT,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(
                          MARGIN_SMALL,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          LBL_SIGN_UP,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: TEXT_SMALL,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
