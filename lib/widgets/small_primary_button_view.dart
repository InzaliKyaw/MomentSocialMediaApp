import 'package:chatty/resources/colors.dart';
import 'package:flutter/material.dart';

import '../resources/dimens.dart';

class SmallPrimaryButtonView extends StatefulWidget {
  final String label;
  final Color themeColor;
  final Function onTap;

  const SmallPrimaryButtonView({
    Key? key,
    required this.label,
    this.themeColor = primaryColor,
    required this.onTap,
  }) : super(key: key);

  @override
  State<SmallPrimaryButtonView> createState() => _SmallPrimaryButtonViewState();
}

class _SmallPrimaryButtonViewState extends State<SmallPrimaryButtonView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onTap();
      },
      child: Container(
        width: SMALL_BUTTON_WIDTH,
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
              fontSize: TEXT_REGULAR_2X,
              fontWeight: FontWeight.bold,
              fontFamily: 'YorkieDEMO',
            ),
          ),
        ),
      ),
    );
  }
}