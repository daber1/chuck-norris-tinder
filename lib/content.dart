import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

bool isLoaded = false;

@JsonSerializable()
class Content {
  final String text;

  Content(this.text);

  factory Content.fromJson(Map<String, dynamic> json) => Content(json['value']);

  static Future<Content> fromJsonAsync(String data) async {
    Future.delayed(const Duration(milliseconds: 100));
    return Content(data);
  }
}

Future<Content> fetchContent() async {

    final response =
    await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));
    if (response.statusCode == 200) {
      return Content.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load content');
    }

}
List<String> listOfLikedCardsText = List<String>.filled(10, '');
List<Widget> getListOfCards() {
  List<Widget> listOfCards = List<Widget>.filled(10, const Card(child: Text('Loading Data')));
  for (int i = 0; i < 10; i++) {
    listOfCards[i] = FutureBuilder(
      future: fetchContent().catchError((e) {}),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          listOfLikedCardsText[i] = (snapshot.data as Content).text;
          return Card(
              color: const Color(0xFFF5D042),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(width: 5, color: Color(0xFF0A174E)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                child: Center(
                  child: Text(
                    (snapshot.data as Content).text,
                    style: const TextStyle(
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A174E)),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ));
        }
        return const Card(
            color: Color(0xFFF5D042),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(width: 5, color: Color(0xFF0A174E)),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
              child: Center(
                child: Text(
                  "Chuck Norris is coming...",
                  style: TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A174E)),
                  textAlign: TextAlign.justify,
                ),
              ),
            ));
      },
    );
  }
  return listOfCards;
}


