import 'dart:ui' as ui;
import 'package:flutter/material.dart';


class SurveyPage extends StatefulWidget {
  SurveyPage();
  @override
  SurveyPageState createState() {
    return SurveyPageState();
  }
}

class Feedback {
  final String displayContent;
  bool isSelected;
  Feedback(this.displayContent, this.isSelected);
}

class SurveyPageState extends State<SurveyPage> {

  String msg = 'Areas of Work List';
  List<Feedback> feedbackList = [
        Feedback('Care of  children ', false),
        Feedback('Care of  elderly', false),
        Feedback('Care of  disable', false),
        Feedback('General housework ', false),
         Feedback('Cooking', false),
  ];

  @override
  Widget build(BuildContext context) {
    
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _width = logicalSize.width;

    return Scaffold(
    backgroundColor :Theme.of(context).primaryColor,
      body: Container(
          decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                    topLeft:  const  Radius.circular(40.0),
                    topRight: const  Radius.circular(40.0))
              ),
            padding: EdgeInsets.all(16.0),
              child: getPages(_width)
          ),
    );
  }

  Widget getPages(double _width) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 24.0 ,bottom: 24.0),
            height: 10.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(4, (int index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  ),
                  height: 10.0,
                  width: (_width - 32.0 - 15.0) / 4.0,
                  margin: EdgeInsets.only(left: index == 0 ? 0.0 : 5.0),
                );
              }),
            ),
          ),
          _getContent(),
        ],
    );
  }

  Widget _getContent() {

    return Expanded(
      child: Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(msg, textAlign: TextAlign.center,),
            Expanded(
              // child: Center(
                child: Container(
                  margin: EdgeInsets.only(top:50.0),
                  height: 50.0 * feedbackList.length + 8.0 + 1.0 * (feedbackList.length),
                  child: Card(
                    child: Column(
                      children:
                      List.generate(feedbackList.length, (int index) {
                        Feedback question = feedbackList[index];
                        return Column(
                          children: <Widget>[
                            GestureDetector(
                              onTapUp: (detail) {
                                setState(() {
                                  question.isSelected = !question.isSelected;
                                });
                              },
                              child: Container(
                                height: 50.0,
                                color: question.isSelected
                                    ? Colors.orangeAccent.withAlpha(100)
                                    : Colors.white,
                                child: Row(
                                  children: <Widget>[
                                    Checkbox(
                                        activeColor: Colors.orangeAccent,
                                        value: question.isSelected,
                                        onChanged: (bool value) {
                                          setState(() {
                                            question.isSelected = value;
                                          });
                                         
                                        }),
                                    Text(question.displayContent)
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: index < feedbackList.length ? 1.0 : 0.0,
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              // ),
            )
          ],
        ),
      ),
    );
  }

}