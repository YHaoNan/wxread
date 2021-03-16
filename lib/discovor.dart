import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:wxread/horizontal_tags.dart';
import 'package:wxread/main.dart';
import 'package:wxread/top_input.dart';

import 'book.dart';
import 'loading_bar.dart';

class DiscovorState extends State<Discovor> with SingleTickerProviderStateMixin{
  List<List<Book>> bookLists;
  var bookListImgAndDesc = [
    ["https://weread-1258476243.file.myqcloud.com/assets/ranklist.rising.chart_title.d0fV1Wskta.png","近一周热度上涨最快的出版书"],
    ["https://weread-1258476243.file.myqcloud.com/assets/ranklist.newbook.chart_title.46TfWH1fmU.png","最近30天上线的热门出版书"],
    ["https://rescdn.qqmail.com/weread/cover/ranklist.all.chart_title.Ck2o3M5aVF.png","微信读书用户最喜欢的书籍"],
    ["https://rescdn.qqmail.com/weread/cover/ranklist.novel_male_series.chart_title.kNLNVq8D86.png","最近更新的热门男生小说"]
  ];
  var bookListColors = [
    Color(0xFFF95486),
    Color(0xFFFA605D),
    Color(0xFFD5B87B),
    Color(0xFF7290f2),
  ];
  var tags = ["纸书","分类","书单","免费","男生小说","听书","漫画","新书","有声剧","公众号"];
  var tagTextColors = {"纸书": Colors.redAccent};
  var tagBackColors = {"纸书": Color(0x30FF8A80)};
  var _isLoading = true;


  void _getWechatReadIndex() async{
    var httpClient = HttpClient();
    var uri = Uri.https('weread.qq.com','/');
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var responsBody = await response.transform(Utf8Decoder()).join();
    var document = parse(responsBody);
    var rankingLists = document.querySelectorAll(".ranking_block_body_left");

    print("GetWeChatReadIndex");

    bookLists = [];

    rankingLists.forEach((rankingList) {
      List<Book> _rankingList = [];
      rankingList.children.forEach((book) {
        var bookName = book.attributes['title'];
        var bookCovor = book.querySelector(".wr_bookCover_img").attributes['src'];
        var bookAuthor = book.querySelector(".ranking_block_book_author").text;
        _rankingList.add(Book(bookName, bookAuthor, bookCovor));

      });
      bookLists.add(_rankingList);
    });
    _startToDrawUI();
  }

  Widget _createHorizontalTags() => Container(
    height: 50,
    alignment: Alignment.centerLeft,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context,index){
        if(index==0 || index == tags.length+1){
          return Container(
            width: 10,
            height: 10,
          );
        }
        var element = tags[index-1];
        return HorizontalTag(
            tagTextColors.containsKey(element)?tagTextColors[element]:WXRead.textColor,
            tagBackColors.containsKey(element)?tagBackColors[element]:WXRead.backColor,
            element, (){});
      },
      itemCount: tags.length+2,
      separatorBuilder: (context,index){
        return VerticalDivider(
            width: 10,
            color: Color(0x00000000)
        );
      },
    ),
  );

  Widget _createMyBooks(){
    print(bookLists.length);
    return Container(
      padding: const EdgeInsets.only(left: 5,right: 5),
      height: 110.4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: bookLists.map((e) => BookCard(e[0])).toList(),
      ),
    );
  }

  void _startToDrawUI(){
    print("Start to draw UI");
    setState(() {
      this._isLoading = false;
    });
    _horizontalTags = _createHorizontalTags();
    _myBooks = _createMyBooks();
  }
  Widget _horizontalTags;
  Widget _myBooks;

  @override
  void initState() {
    _getWechatReadIndex();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopInput(),
        _isLoading?LoadingBar():Expanded(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              _horizontalTags,
              _myBooks,
              BookList(bookListImgAndDesc[0][0], bookListImgAndDesc[0][1],bookListColors[0], bookLists[0]),
              BookList(bookListImgAndDesc[1][0], bookListImgAndDesc[1][1],bookListColors[1], bookLists[1]),
              BookList(bookListImgAndDesc[2][0], bookListImgAndDesc[2][1],bookListColors[2], bookLists[2]),
              BookList(bookListImgAndDesc[3][0], bookListImgAndDesc[3][1],bookListColors[3], bookLists[3]),
            ],
          ),
        ),
      ],
    );
  }
}
class Discovor extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DiscovorState();
  }
}