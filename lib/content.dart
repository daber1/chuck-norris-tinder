import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';



class Content {
  final String text;

  Content(this.text);

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      json['value'],
    );
  }
}


Future<Content> fetchContent() async {
  final response = await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));
  if (response.statusCode==200){
    return Content.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load content');
  }
}

