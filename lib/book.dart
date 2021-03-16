import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:wxread/main.dart';

class Book {
  String name;
  String author;
  String imgUrl;

  Book(this.name, this.author, this.imgUrl);
}

class BookCard extends StatefulWidget {
  Book book;

  BookCard(this.book);

  @override
  State<StatefulWidget> createState() {
    return BookCardState(book);
  }
}

class BookCardState extends State<BookCard>
    with SingleTickerProviderStateMixin {
  Book book;

  BookCardState(this.book);

  ImageProvider _covor;
  Color _covorMainColor;

  Future<Color> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor.color;
  }

  @override
  void initState() {
    _covor = NetworkImage(book.imgUrl);
    getImagePalette(_covor).then((value) {
      setState(() {
        this._covorMainColor = value;
      });
      return true;
    });
    super.initState();
  }

  Color _getColorByBrightness(Color color) {
    if(color==null)return Colors.white;
    return (color.red + color.blue + color.green) / 3 > 128
        ? Colors.black
        : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.4,
      width: 82.4,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6))),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned(
              child: FittedBox(fit: BoxFit.cover, child: Image(image: _covor)),
              left: 0,
              bottom: 0,
              right: 0,
              top: 0,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 20,
                alignment: Alignment.centerLeft,
                color: _covorMainColor,
                child: Text(
                  book.name,
                  maxLines: 1,
                  style: TextStyle(
                      color: _getColorByBrightness(_covorMainColor),
                      fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class BookItem extends StatelessWidget{
  int index;
  Book book;
  BookItem(this.index,this.book);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: EdgeInsets.only(top: 5,bottom: 5),
      child: Row(
        children: [
          Image.network(book.imgUrl),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left:10,top: 15,bottom: 5),
                child: Text("${index+1} ${book.name}"),
              ),
              Container(
                margin: EdgeInsets.only(left: 20,bottom: 10),
                child: Text(book.author,style: TextStyle(fontSize: 10,color: Colors.grey)),
              ),
            ],
          )
        ],
      ),
    );
  }

}
class BookList extends StatelessWidget{
  String iconImage;
  String listDecribe;
  Color backColor;
  List<Book> books;
  BookList(this.iconImage,this.listDecribe,this.backColor,this.books);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
      child: Card(
        elevation: 10,
        shadowColor: Color(0xffeeeeee),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(iconImage,height: 32,),
              Container(
                height: 320,
                padding: EdgeInsets.only(top: 10,bottom: 10),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(0),
                  children: books.asMap().keys.map((i) => BookItem(i,books[i])).toList(),
                ),
              ),
              InkWell(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 46,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    color: backColor,
                  ),
                  child: Text("查看全部",style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        )
      ),
    );
  }

}
