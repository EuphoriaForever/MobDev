 
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
 
void main() => runApp(myApp());
 
class myApp extends StatefulWidget{
  @override
  State createState() => AppState();
}
 
class ImageModel{
  String title, url;
  int id;

  ImageModel( int id, String title,String url){
    this.id=id;
    this.title=title;
    this.url=url;
  }

  ImageModel.fromJson(Map<String, dynamic> parsedJson){
    id=parsedJson['id'];
    title=parsedJson['title'];
    url=parsedJson['url'];
  }

  int get g_id{
    return id;
  }

  String get g_title{
    return title;
  }

  String get g_url{
    return url;
  }

}
 
class AppState extends State<myApp> {
  String json;
  int counter = 1;
  ImageModel mowdel= new ImageModel();
  List<ImageModel> listItems = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Corona Cannot Stop Us"),
        ),
        body: Center(
            child: ListView.builder(
              itemCount: listItems.length,
              itemBuilder: (BuildContext ctxt, int Index) {
                return Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: Column(
                      children: <Widget>[
                        Image.network(listItems[Index].url),
                        Text(listItems[Index].title),
                      ],
                    )
                  ),
                );
              } 
            )
          ),
        
        floatingActionButton: FloatingActionButton(
          onPressed: () {
           fetchImage();
          },
          child: Icon(Icons.add)
        ),
      )
    );
  }
 
  void fetchImage() async{
    var response= await http.get('https://jsonplaceholder.typicode.com/photos/$counter');
    setState((){
      counter++;
      mowdel = ImageModel.fromJson(jsonDecode(response.body));
      listItems.add(mowdel);
    });
  }
}
 

