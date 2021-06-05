import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ImageClass{
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  ImageClass({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });


  factory ImageClass.fromJson(Map<String, dynamic> json) {
    return ImageClass(
      albumId: json['albumId'],
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json ['thumbnailUrl']
    );
  }
}
Future <List<ImageClass>> getImage() async{
  final b = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  if (b.statusCode==200){
    final List<dynamic> data= jsonDecode(b.body);
    List<ImageClass> result=
    data.map((item)=>ImageClass.fromJson(item)).toList();
    return result;
  }
  return [];
}


class ImageWidget extends StatelessWidget{
  final String networkurl;
  const ImageWidget({Key? key, required this.networkurl}): super (key: key);

  @override
  Widget build(BuildContext context){
    return Image (
        image: NetworkImage(networkurl)
       // style: TextStyle(fontSize: 24, color: Colors.black)
    );
  }

}

class TextExample extends StatelessWidget{
  final String text;
  const TextExample({Key? key, required this.text}): super (key: key);
  @override
  Widget build(BuildContext context){
    return Text (
      text,
      style: TextStyle(fontSize: 24, color: Colors.black)
    );
  }

}

void main () async {
  final images = await getImage();
  final List <Widget> title=[];
  for (int i=0; i<100; i++){
    final temp=TextExample (text: images[i].title);
    final tempimage =ImageWidget (networkurl: images[i].url);
    title.add(temp);
    title.add(tempimage);
    title.add(SizedBox(height: 10));
  }

  runApp(
      MaterialApp(
          home: Scaffold(
             // backgroundColor: Colors.blue,
              body: Center(
                child: ListView(
                    padding: const EdgeInsets.all(15),

                    children:title
                )
              )
          )
      )
  );
}
