import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:filemanager/sizeconfig.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return LayoutBuilder(builder: (context,constraints){
      return OrientationBuilder(builder: (context,orientation){
        Responsive().init(constraints,orientation);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MediaPage(),
          title: 'Files App',
        );
      });
    });
  }
}

class MediaPage extends StatefulWidget {
  @override
  _MediaPageState createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        leading: Padding(
          padding: EdgeInsets.only(top:1.8*Responsive.heightMultiplier, left: 6*Responsive.widthMultiplier),
          child: GestureDetector(
            onTap: (){Navigator.pop(context);},
            child: Icon(Icons.arrow_back_ios)
          ),
        ),
      ),
      body: ListView(
        children:<Widget>[
          Container(
            height: 0.33*MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color:Colors.blueGrey[800],
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),
            ),
            child: Column(
              children:<Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 6*Responsive.imageSizeMultiplier, left: 6*Responsive.imageSizeMultiplier, right: Responsive.imageSizeMultiplier),
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/video.png',height: 4*Responsive.textMultiplier,),
                      Text('Media',style: TextStyle(fontSize:3.5*Responsive.textMultiplier,color:Colors.white),),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.more_horiz,color:Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8.0,top: 10.0),
                  child: Row(
                    children: <Widget>[
                      Text('32.9',style:TextStyle(color: Colors.white,fontSize:7.6*Responsive.textMultiplier,)),
                      Column(
                        children:<Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 2.5*Responsive.heightMultiplier, left: 5),
                            child: Row(
                              children: <Widget>[
                                Text('Gb',style:TextStyle(color: Colors.grey[400],)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}