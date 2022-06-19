// import 'dart:html';
// @dart=2.9
import 'dart:convert';

import 'package:c_n_jokes/content.dart';
import 'package:c_n_jokes/screen2.dart';
import 'package:flutter/material.dart';

import 'package:flutter_tindercard_modified/flutter_tindercard.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ChuckCardPage extends StatefulWidget {
  const ChuckCardPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChuckCardPageState();
}


class _ChuckCardPageState extends State<ChuckCardPage> {
  List _items = [];
  bool internet = true;
  var listOfLikedCards = <FutureBuilder<Content>>[];

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/likes.json');
  }

  Future<void> readJson() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();
      final data = await json.decode(contents);

      setState(() {
        _items = data;
      });
    } catch (e) {
      final file = await _localFile;
      file.create();
      final data = json.encode([]);
      file.writeAsString(data);
      setState(() {
        _items = [];
      });
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<void> writeJson(data) async {
    final file = await _localFile;
    final contents = await file.readAsString();
    final storedData = await json.decode(contents);
    storedData.add(data);
    // Write the file
    final dataToStore = json.encode(storedData);
    return file.writeAsString(dataToStore);
  }

  Future<void> checkInternet() async {
    internet = await InternetConnectionChecker().hasConnection;
  }

  @override
  void initState() {
    super.initState();
    readJson();
    checkInternet();
  }

  @override
  Widget build(BuildContext context) {
    if (internet) {
      List<Widget> listOfCards = getListOfCards();
      double screenHeight = MediaQuery.of(context).size.height;
      double screenWidth = MediaQuery.of(context).size.width;
      CardController cardController = CardController();
      return Scaffold(
        appBar: AppBar(
          title: const Text('Do you Chuck this joke?'),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          minimum: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                IconButton(
                    onPressed: () {
                      // throw Exception();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return LikesScreen(
                              likes: listOfLikedCards, stored: _items);
                        }),
                      );
                    },
                    icon: const Icon(Icons.info)),
                SizedBox(
                  height: screenHeight - 300,
                  // width: MediaQuery.of(context).size.width,
                  child: TinderSwapCard(
                    cardController: cardController,
                    allowVerticalMovement: false,
                    orientation: AmassOrientation.top,
                    totalNum: 10,
                    stackNum: 2,
                    maxWidth: screenWidth * 0.7,
                    maxHeight: screenHeight * 0.5,
                    minWidth: screenWidth * 0.7 - 1,
                    minHeight: screenHeight * 0.5 - 1,
                    cardBuilder: (context, index) {
                      return listOfCards[index];
                    },
                    swipeCompleteCallback:
                        (CardSwipeOrientation orientation, int index) {
                      listOfLikedCards.add(listOfCards[index]);
                      Map<String, String> newJson = {
                        'value': listOfLikedCardsText[index]
                      };
                      writeJson(newJson);
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    cardController.triggerRight();
                  },
                  icon: const Icon(Icons.thumb_up),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          minimum: EdgeInsets.all(10),
          child: Card(
              color: Color(0xFFF5D042),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(width: 5, color: Color(0xFF0A174E)),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                child: Center(
                  child: Text(
                    "It seems that you don't have enough Internet for Chuck Norris",
                    style: TextStyle(
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A174E)),
                    textAlign: TextAlign.justify,
                  ),
                ),
              )),
        ),
      );
    }
  }
}
