import 'package:chatty/resources/colors.dart';
import 'package:flutter/material.dart';
import '../resources/dimens.dart';


class PrimaryButtonView extends StatefulWidget {
  final String label;
  final Color themeColor;
  final Function onTap;

  const PrimaryButtonView({
    Key? key,
    required this.label,
    this.themeColor = primaryColor,
    required this.onTap,
  }) : super(key: key);

  @override
  State<PrimaryButtonView> createState() => _PrimaryButtonViewState();
}

class _PrimaryButtonViewState extends State<PrimaryButtonView> {
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
          color: widget.themeColor,
          borderRadius: BorderRadius.circular(
            MARGIN_SMALL,
          ),
        ),
        child: Center(
          child: Text(
            widget.label,
            style: const TextStyle(
              color: Colors.white,
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
