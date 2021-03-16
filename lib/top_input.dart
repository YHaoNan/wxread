import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:wxread/book.dart';
import 'package:wxread/main.dart';

class TopInput extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return TopInputState();
  }
}
class TopInputState extends State<TopInput>{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      margin: const EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
      padding: const EdgeInsets.only(left: 14,right: 14),
      decoration: BoxDecoration(
        color: WXRead.backColor,
        borderRadius: BorderRadius.all(Radius.circular(40))
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: const Icon(
              IconData(0xe6d4,fontFamily: 'Iconfont'),
              color: WXRead.textColor,
              size: 18,
            ),
          ),
          Expanded(
            child: Text("罗织经",style: WXRead.textStyle),
          ),
          Container(
            height: 16,
            width: 0.4,
            color: WXRead.textColor,
          ),
          TextButton(onPressed: (){}, child: Text("书城",style: WXRead.boldTextStyle))
        ],
      ),
    );
  }
}