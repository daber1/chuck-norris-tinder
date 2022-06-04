// import 'dart:html';

import 'package:c_n_jokes/content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class ChuckCardPage extends StatefulWidget {
  ChuckCardPage({Key? key}) : super(key: key);

  @override
  State<ChuckCardPage> createState() => _ChuckCardPageState();
}

class _ChuckCardPageState extends State<ChuckCardPage>
    with TickerProviderStateMixin {

  // List<Content> cardTexts = []

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('God, help me'),
      ),
      backgroundColor: Colors.white,
      body: bodyLoading(),
    );
  }
}
class bodyLoading extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    List<Widget> listOfCards = List<Widget>.filled(10, Card(child:Text('123')));
    for (int i = 0; i < 10; i++) {
      listOfCards[i] = FutureBuilder(
        future: fetchContent(),
        builder: (context, snapshot) {
          if (snapshot.data!=null) {
            return Card(child: Text((snapshot.data as Content).text),
            color:Colors.grey[400],);
          }
          return Card();
        },
      );
    }
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    CardController cardController = CardController();
    return Center(
      child: Column(
        children: [
          Container(
            height: screenHeight-200,
            // width: MediaQuery.of(context).size.width,
            child: TinderSwapCard(
              cardController: cardController,
              allowVerticalMovement: false,
              orientation: AmassOrientation.TOP,
              totalNum: 10,
              stackNum: 2,
              maxWidth: screenWidth*0.5,
              maxHeight: screenHeight*0.3,
              minWidth: screenWidth*0.5-1,
              minHeight: screenHeight*0.3-1,
              cardBuilder: (context, index) {
                return listOfCards[index];
              },
            ),
          ),
          IconButton(onPressed: () {
            cardController.triggerRight();
          }, icon: Icon(Icons.thumb_up),)
        ],
      ),

    );
  }

}
