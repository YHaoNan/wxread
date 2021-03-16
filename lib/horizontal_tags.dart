import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalTag extends StatelessWidget {
  Color textColor;
  Color backColor;
  Function onTap;
  String text;

  HorizontalTag(this.textColor, this.backColor, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          child: Container(
            padding:
                const EdgeInsets.only(top: 6, bottom: 6, left: 14, right: 14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: backColor),
            child: Row(
              children: [
                Text(text,
                    style: TextStyle(
                        color: textColor, fontWeight: FontWeight.bold)),
                Icon(
                  IconData(0xe683, fontFamily: 'Iconfont'),
                  size: 12,
                  color: textColor,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
