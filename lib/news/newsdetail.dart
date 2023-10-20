import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:week2/api/getapi.dart';
import 'package:week2/modules/cardsandmodules.dart';

import '../Model/newsapi.dart';

class Newsdetail extends StatefulWidget {
  Articles article;
  Newsdetail(this.article);

  @override
  State<StatefulWidget> createState() {
    return NewsdetailState(article);
  }
}

class NewsdetailState extends State<Newsdetail> {
  Articles article;
  late Future<Newsapi?>? _futureverticallist;

  NewsdetailState(this.article);
  apicallv(){
    _futureverticallist = GetApi.getnewsdata();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apicallv();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          //top part
          // stack //image //icon //back button
          //text title, author, date and description
          Stack(
            children: [
              SizedBox(
                height: 60,
              ),
              Image.network(
                article.urlToImage!,
                height: size.height / 5.5,
                width: size.width,
                fit: BoxFit.cover,
              ),
              Positioned(
                  top: 15,
                  left: 20,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ))),
              Positioned(
                  top: 15,
                  right: 20,
                  child: Icon(
                    Icons.share,
                    color: Colors.white,
                    size: 30,
                  )),
              Container(
                  height: size.height / 3.5,
                  width: size.width,
                  child: Center(
                      child: Icon(
                    Icons.play_circle,
                    color: Colors.white,
                    size: 50,
                  )))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: size.width / 1.5,
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              article.title!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(article.author!, style: TextStyle(color: Colors.black,fontSize: 14, fontWeight: FontWeight.normal,),),
              Text(Cardsandmodules.formatDateTimestring(article.publishedAt!), style: TextStyle(color: Colors.black,
              fontSize: 14, fontWeight: FontWeight.normal,),),
              ],
            ),
          ),

          //description
          Container(
            width: size.width / 1.2,
            padding: EdgeInsets.only(bottom: 20, top: 15),
            child: Text(
              article.description!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
            ),
          ),
          //divider
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Divider(
              color: Colors.black, height: 10, thickness: 0.5,
            ),
          ),


          //bottom part
          //vertical list card
          FutureBuilder<Newsapi?>(
              future: _futureverticallist, //a previously obtained Future<String>
              builder: (BuildContext context, AsyncSnapshot<Newsapi?>snapshot){
                //switch
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  //error
                    return Container(); //paxi dialog box thapne
                  case ConnectionState.waiting: //loading
                    return Container(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.done:
                    if(snapshot.data==null || snapshot.data!.articles!.isEmpty){
                      return Center(
                        child: Container(
                          child: Text("No data or api issue"),
                        ),
                      );
                    }
                    else{
                      //data aayo
                      //show ui

                      return Container(
                        height: size.height/1.5,
                        width: size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.all(8),
                          itemCount: snapshot.data!.articles!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Cardsandmodules.verticalcarditem(context,size,snapshot.data!.articles![index]);
                          },
                        ),
                      );
                    }
                  default: //error
                    return Container(); //error paxi thapamla
                }
              }
          ),

      ],
    ),
        ));
  }
}
