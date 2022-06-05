// import 'dart:html';
// @dart=2.9
import 'package:c_n_jokes/content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard_modified/flutter_tindercard.dart';

class ChuckCardPage extends StatefulWidget {
  const ChuckCardPage({Key key}) : super(key: key);

  @override
  State<ChuckCardPage> createState() => _ChuckCardPageState();
}

class _ChuckCardPageState extends State<ChuckCardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('God, help me'),
      ),
      backgroundColor: Colors.white,
      body: const SafeArea(
        minimum: EdgeInsets.all(10),
        child: BodyLoading(),
      ),
    );
  }
}

class BodyLoading extends StatelessWidget {
  const BodyLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> listOfCards =
        List<Widget>.filled(10, const Card(child: Text('Loading Data')));
    for (int i = 0; i < 10; i++) {
      listOfCards[i] = FutureBuilder(
        future: fetchContent(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Card(
                color: const Color(0xFFF5D042),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(width: 5, color: Color(0xFF0A174E)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
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
              color: const Color(0xFFF5D042),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(width: 5, color: Color(0xFF0A174E)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 10, right: 10),
                child: Text(
                  "Chuck Norris is coming...",
                  style: const TextStyle(
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A174E)),
                  textAlign: TextAlign.justify,
                ),
              ));
        },
      );
    }
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    CardController cardController = CardController();
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: screenHeight - 200,
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
    );
  }
}
