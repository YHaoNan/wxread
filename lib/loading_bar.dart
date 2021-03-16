import 'package:flutter/cupertino.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';
import 'package:wxread/main.dart';

class LoadingBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      alignment: Alignment.topCenter,
      child: LineScaleIndicator(lineColor: WXRead.textColor)
    );
  }

}