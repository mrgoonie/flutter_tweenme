import 'package:flutter/material.dart';
import 'package:flutter_tweenme/screens/basic_example.dart';
import 'package:flutter_tweenme/screens/easing_example.dart';
import 'package:flutter_tweenme/screens/animated_column_chart.dart';
import 'package:flutter_tweenme/screens/depth_carousel.dart';
import 'package:flutter_tweenme/screens/yoyo_example.dart';
import 'package:flutter_tweenme/screens/counting_number.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new HomeScreen(),
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext context) => HomeScreen(),
        '/basic_example' : (BuildContext context) => BasicExample(),
        '/easing_example' : (BuildContext context) => EasingExample(),
        '/animated_column_chart' : (BuildContext context) => AnimatedColumnChart(),
        '/depth_carousel' : (BuildContext context) => DepthCarousel(),
        '/yoyo_example': (BuildContext context) => YoyoExample(),
        '/counting_number': (BuildContext context) => CountingNumber(),
      }
    );
  } 
}

class ExampleItem {
  final String title;
  final String route;

  ExampleItem(this.title, this.route);
}

class HomeScreen extends StatelessWidget {

  final List<ExampleItem> examples = [
    ExampleItem("Basic Example", "/basic_example"),
    ExampleItem("All Eases of TweenMe", "/easing_example"),
    ExampleItem("Animated Column Chart", "/animated_column_chart"),
    ExampleItem("Depth Carousel", "/depth_carousel"),
    ExampleItem("Yoyo Example", "/yoyo_example"),
    ExampleItem("Counting Number with Eases", "/counting_number"),
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("TweenMe Examples"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: examples.length,
          itemBuilder: (context, index){
            return Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[300]))
              ),
              child: FlatButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                // color: Colors.red,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "${(index + 1)}. ${examples[index].title}",
                        textAlign: TextAlign.left,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 16
                        ),
                      )
                    ),
                    Icon(Icons.keyboard_arrow_right)
                  ],
                ),
                
                onPressed: (){
                  Navigator.of(context).pushNamed(examples[index].route);
                },
              ),
            );
          },
        ),
      ),
    );
    
  }
}