import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wxread/bookshelf.dart';
import 'package:wxread/discovor.dart';
import 'package:wxread/eye.dart';
import 'package:wxread/me.dart';
import 'package:wxread/top_input.dart';

void main() {
  runApp(WXRead());
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class WXRead extends StatefulWidget {
  static const textColor = Color.fromARGB(255, 113, 120, 130);
  static const textStyle = TextStyle(color: textColor);
  static const boldTextStyle = TextStyle(color: textColor,fontWeight: FontWeight.bold);
  static const backColor = Color.fromARGB(255,241, 242, 245);
  @override
  State<StatefulWidget> createState() => WXReadState();
}

class WXReadState extends State<WXRead> {
  final PageController _pageController = PageController(initialPage: 0);
  var _currentPage = 0;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "WXRead",
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
          child:PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Discovor(),
              BookShelf(),X@
              Eyes(),
              Me()
            ],
            onPageChanged: (i){
              setState(() {
                _currentPage = i;
              });
            },
          ) ,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Color.fromARGB(255, 73, 160, 241),
          unselectedItemColor: Color.fromARGB(255, 113, 120, 130),
          selectedFontSize: 10,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentPage,
          onTap: (i){
            _pageController.jumpToPage(i);
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(
                IconData(0xe675,fontFamily: 'Iconfont'),
                size: 24,
              ),
              label: '发现'
            ),
            BottomNavigationBarItem(
                icon: const Icon(
                  IconData(0xe6a6,fontFamily: 'Iconfont'),
                  size: 24,
                ),
                label: '书架'
            ),
            BottomNavigationBarItem(
                icon: const Icon(
                  IconData(0xe6ac,fontFamily: 'Iconfont'),
                  size: 24,
                ),
                label: '看一看'
            ),
            BottomNavigationBarItem(
                icon: const Icon(
                  IconData(0xe6b1,fontFamily: 'Iconfont'),
                  size: 24,
                ),
                label: '我'
            ),
          ],
        ),
      )
    );
  }
}
