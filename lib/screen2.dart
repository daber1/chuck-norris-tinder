import 'package:c_n_jokes/content.dart';
import 'package:flutter/material.dart';


class LikesScreen extends StatelessWidget {
  LikesScreen({super.key, required this.likes, required this.stored});

  List<FutureBuilder<Content>> likes;
  List<dynamic> stored;
  @override
  Widget build(BuildContext context) {
    // print(stored);
    return Scaffold(
      appBar: AppBar(
        title: const Text('You have chucked these jokes'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                textStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back to home')
            )
          ),
          FutureBuilder(
            future: getLikes(),
            builder:(context, snapshot){
              if (!snapshot.hasData){
                return Container(child: Text('X'),);
              }
              else {
                    return
                      Expanded(
                        child:ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: (snapshot.data! as List<FutureBuilder<Content>>).length,
                            itemBuilder: (context, index) {
                              return (snapshot.data! as List<FutureBuilder<Content>>)[index];
                            }
                        )
                      );
              }
            }
          )
        ],
      )
    );
  }
  Future<Content> getContent(data) async {
    return await Content.fromJsonAsync(data);
  }
  getLikes() async {
    if (stored.isNotEmpty && !isLoaded){
      isLoaded = true;
      for (int i=0;i<stored.length;i++){
        likes.add(FutureBuilder(
          future: getContent(stored[i]['value']),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Card(
                  color: const Color(0xFFF5D042),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(width: 5, color: Color(0xFF0A174E)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10,bottom:10, left: 10, right: 10),
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
                  padding: EdgeInsets.only(top: 50.0, left: 10, right: 10),
                  child: Text(
                    "Chuck Norris is coming...",
                    style: TextStyle(
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A174E)),
                    textAlign: TextAlign.justify,
                  ),
                ));
          },
        ));
      }
    }
    // print(stored);
    // await Future.delayed(const Duration(seconds: 2), (){});
    return likes;
  }

}

