import 'package:chatty/resources/colors.dart';
import 'package:flutter/material.dart';
import '../resources/dimens.dart';


class SecondaryButtonView extends StatefulWidget {
  final String label;
  final Color themeColor;
  final Function onTap;

  const SecondaryButtonView({
    Key? key,
    required this.label,
    required this.onTap,
    this.themeColor = primaryColor,
  }) : super(key: key);

  @override
  State<SecondaryButtonView> createState() => _SecondaryButtonViewState();
}

class _SecondaryButtonViewState extends State<SecondaryButtonView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onTap();
      },
      child: Container(
        width: 140,
        height: BUTTON_HEIGHT,
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor, width: 2.0),
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            MARGIN_SMALL,
          ),
        ),
        child: Center(
          child: Text(
            widget.label,
            style: const TextStyle(
              color: primaryColor,
              fontSize: TEXT_REGULAR_3X,
              fontWeight: FontWeight.bold,
              fontFamily: 'YorkieDEMO',
            ),
          ),
        ),
      ),
    );
  }
}
