import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageClass {
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
        thumbnailUrl: json['thumbnailUrl']);
  }
}

Future<List<ImageClass>> getImage() async {
  final b =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  if (b.statusCode == 200) {
    final List<dynamic> data = jsonDecode(b.body);
    List<ImageClass> result =
        data.map((item) => ImageClass.fromJson(item)).toList();
    return result;
  }
  return [];
}

class ImageWidget extends StatelessWidget {
  final String networkurl;
  const ImageWidget({Key? key, required this.networkurl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(image: NetworkImage(networkurl)
        // style: TextStyle(fontSize: 24, color: Colors.black)
        );
  }
}

class TextExample extends StatelessWidget {
  final String text;
  const TextExample({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: 24, color: Colors.black));
  }
}

/**
 * Советую для постов сделать отдельный класс, т.к. это отдельный элемент UI
 */

class PostCard extends StatelessWidget {
  final String text;
  final String imageUrl;

  const PostCard({Key? key, required this.text, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(width: 1),
            right: BorderSide(width: 1),
            left: BorderSide(width: 1),
            top: BorderSide(width: 1)),
      ),
      child: Column(
        children: [
          Text(this.text, style: TextStyle(fontSize: 24, color: Colors.black)),
          Image(image: NetworkImage(this.imageUrl))
        ],
      ),
    );
  }
}

void main() async {
  final images = await getImage();
  /**
   * Можно сделать проще, с.м ниже
   */
  final List<Widget> title = [];
  for (int i = 0; i < 100; i++) {
    final temp = TextExample(text: images[i].title);
    final tempimage = ImageWidget(networkurl: images[i].url);
    title.add(temp);
    title.add(tempimage);
    title.add(SizedBox(height: 10));
  }
  /**
   * Вот так например
   */
  final List<Widget> posts = images
      .map((item) => PostCard(text: item.title, imageUrl: item.url))
      .toList()
      .sublist(0, 100);
  runApp(MaterialApp(
      home: Scaffold(
          // backgroundColor: Colors.blue,
          body: Center(
              child: ListView(
                  padding: const EdgeInsets.all(15), children: posts)))));
}


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageClass {
  final int albumId;
  final int id;
  final String title;
  @@ -19,79 +18,105 @@ class ImageClass{
  required this.thumbnailUrl,
  });

  factory ImageClass.fromJson(Map<String, dynamic> json) {
  return ImageClass(
  albumId: json['albumId'],
  id: json['id'],
  title: json['title'],
  url: json['url'],
  thumbnailUrl: json['thumbnailUrl']);
  }
}

Future<List<ImageClass>> getImage() async {
  final b =
  await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  if (b.statusCode == 200) {
    final List<dynamic> data = jsonDecode(b.body);
    List<ImageClass> result =
    data.map((item) => ImageClass.fromJson(item)).toList();
    return result;
  }
  return [];
}

class ImageWidget extends StatelessWidget {
  final String networkurl;
  const ImageWidget({Key? key, required this.networkurl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(image: NetworkImage(networkurl)
      // style: TextStyle(fontSize: 24, color: Colors.black)
    );
  }
}

class TextExample extends StatelessWidget {
  final String text;
  const TextExample({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: 24, color: Colors.black));
  }
}

/**
 * Советую для постов сделать отдельный класс, т.к. это отдельный элемент UI
 */

class PostCard extends StatelessWidget {
  final String text;
  final String imageUrl;

  const PostCard({Key? key, required this.text, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(width: 1),
            right: BorderSide(width: 1),
            left: BorderSide(width: 1),
            top: BorderSide(width: 1)),
      ),
      child: Column(
        children: [
          Text(this.text, style: TextStyle(fontSize: 24, color: Colors.black)),
          Image(image: NetworkImage(this.imageUrl))
        ],
      ),
    );
  }
}

void main() async {
  final images = await getImage();
  /**
   * Можно сделать проще, с.м ниже
   */
  final List<Widget> title = [];
  for (int i = 0; i < 100; i++) {
    final temp = TextExample(text: images[i].title);
    final tempimage = ImageWidget(networkurl: images[i].url);
    title.add(temp);
    title.add(tempimage);
    title.add(SizedBox(height: 10));
  }
  /**
   * Вот так например
   */
  final List<Widget> posts = images
      .map((item) => PostCard(text: item.title, imageUrl: item.url))
      .toList()
      .sublist(0, 100);
  runApp(MaterialApp(
      home: Scaffold(
        // backgroundColor: Colors.blue,
          body: Center(
              child: ListView(
                  padding: const EdgeInsets.all(15), children: posts)))));
}