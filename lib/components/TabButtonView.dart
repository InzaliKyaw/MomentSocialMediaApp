import 'package:chatty/resources/colors.dart';
import 'package:chatty/resources/dimens.dart';
import 'package:flutter/material.dart';

class TabButtonView extends StatelessWidget {

  final bool isSelected;
  final String label;
  final double fontSize;
  final Function onTapButton;

  const TabButtonView({super.key,required this.isSelected, required this.label, required this.fontSize,required this.onTapButton});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
          onTapButton();
        },
        child: Container(
          margin: const EdgeInsets.all(MARGIN_MEDIUM),
          decoration: BoxDecoration(
            // color: (isSelected)? kPrimaryColor: null,
              borderRadius: BorderRadius.circular(MARGIN_SMALL),
              border: Border(
                bottom: BorderSide(width: 3.0,
                    color:  (isSelected)? primaryColor: primaryColor),
              )
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: (isSelected) ? primaryColor : kUnSelectedTextColor,
                fontSize: fontSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        )
    );
  }
}
