import 'package:flutter/material.dart';

class StoryCollection {

  final String title;
  final String author;
  final String category;
  final String age;
  final String image;
  final String audio;

  StoryCollection({required this.title, required this.author, required this.category, required this.age, required this.image, required this.audio});

  factory StoryCollection.fromJson(Map<String, dynamic> json){
    return StoryCollection(  
      title: json['title'],
      author: json['author'],
      category: json['category'],
      age: json['age'],
      image: json['image'],
      audio: json['audio']
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'title': title,
      'author':author,
      'category':category,
      'age':age,
      'image':image,
      'audio':audio,
    };
  }
}