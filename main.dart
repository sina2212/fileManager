import 'package:filemanager/MediaPage.dart';
import 'package:filemanager/sizeconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return LayoutBuilder(builder: (context,constraints){
      return OrientationBuilder(builder: (context,orientation){
        Responsive().init(constraints,orientation);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MyHomePage(),
          title: 'Files App',
        );
      });
    });
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double sizing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircleAvatar(
        radius:7.8 * Responsive.widthMultiplier,
        backgroundColor: Colors.blueGrey[800],
        child: Icon(Icons.add,color: Colors.white,),
      ),
      appBar: AppBar(
        backgroundColor:Colors.white,
        elevation:0.0,
        leading:Icon(Icons.menu,color: Colors.grey[600],),
        title: Text('File Manager', style:TextStyle(color:Colors.grey[700]))
      ),
      body: ListView(
        children:<Widget>[
          Padding(//My Files
            padding: const EdgeInsets.all(8.0),
            child: Text('MyFiles',style: TextStyle(color:Colors.grey,fontSize:5*Responsive.textMultiplier),),
          ),
          SizedBox(height: 6 * Responsive.heightMultiplier,),
          Row(//chart and box percentage
            children:<Widget>[
              Stack(//circule charts
                alignment:Alignment.center,
                children:<Widget>[
                  _circlechart(40,83.33,56.67,color: Colors.purple[900]),
                  _circlechart(30,73.33,56.67,color: Colors.red[900]),
                  _circlechart(20,63.33,36.67,color: Colors.black),
                ],
              ),
              Padding(padding: EdgeInsets.only(right:10 * Responsive.widthMultiplier)),
              Container(//box percentage
                width: 40 * Responsive.widthMultiplier,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _filepercent('Photo','56%',color: Colors.green[800]),
                    _filepercent('Media','32%',color: Colors.yellow),
                    _filepercent('Document','12%',color: Colors.blue),
                  ],
                ),
              ),
            ]
          ),
          SizedBox(height:6*Responsive.heightMultiplier),
          Container(
            height: 40 * Responsive.heightMultiplier,
            child: ListView(
              scrollDirection:Axis.horizontal,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 6 * Responsive.imageSizeMultiplier),
                  child: _mediaStack(
                    "assets/image.png",
                    "Photos",
                    "8585",
                    "Private Folders",
                    Icon(Icons.lock_outline,color: Colors.black,size: 40),
                    Colors.grey[300],
                  ),
                ),
                SizedBox(width:15),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MediaPage()));
                  },
                  child: _mediaStack(
                    "assets/video.png",
                    "Media",
                    "5321",
                    "Public Folders",
                    Icon(Icons.play_circle_outline,color: Colors.black,size: 40,),
                    Colors.grey[300],
                  ),
                ),
                SizedBox(width:15),
              ],
            ),
          ),
          //SizedBox(height: 0),
          Padding(
            padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
            child: Row(
              children:<Widget>[
                Text('Latest Files',style: TextStyle(fontSize: 3.4 * Responsive.textMultiplier),),
                Spacer(),
                Icon(Icons.more_horiz),
              ],
            ),
          ),
          _medialist("spotify.com/playlist/sina1","32Mb march 21,2020",Colors.amber[500],Colors.amber[100],Icons.library_music),
          _medialist("Extraction 2019","1.2Gb September 11,2019",Colors.amber[500],Colors.amber[100],Icons.video_library),
          _medialist("ReputationTour 2019","3.2Gb Desember 11,2019",Colors.amber[500],Colors.amber[100],Icons.video_library),
          _medialist("Visa 2019","98Kb October 20,2019",Colors.indigo[500],Colors.indigo[100],Icons.insert_drive_file),
        ],
      ),
    );
  }

  Widget _medialist(String title,String meta,Color icon,Color accent,IconData mediaicon){
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Center(//design
            child:Container(
              decoration: BoxDecoration(color:accent,borderRadius:BorderRadius.circular(6)),
              child: Icon(mediaicon,size:40,color:icon),
            ),
          ),
          Padding(//texts
            padding: EdgeInsets.only(left:8.0),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children:<Widget>[
                Text(title,style:TextStyle(color: Colors.grey[600], fontSize: 3 * Responsive.textMultiplier ,fontWeight: FontWeight.w600)),
                SizedBox(height: 5,),
                Text(meta,style:TextStyle(color: Colors.grey[400], fontSize: 2.5 * Responsive.textMultiplier ,fontWeight: FontWeight.w400)),
                SizedBox(height: 5,)
              ]
            ),
          )
        ],
      ),
    );
  }

  Widget _mediaStack(String image,String media,String items,String privacy,Icon lock,Color color){
    return Stack(
      children: <Widget>[
        Opacity(//design
          opacity: 0.8,
          child: Container(
            width: 55 * Responsive.widthMultiplier,
            height: 35 * Responsive.heightMultiplier,
            decoration: BoxDecoration(
              color: color,
              borderRadius:BorderRadius.circular(32.0),
            ),
          ),
        ),
        Positioned(//image
          top: 3* Responsive.heightMultiplier,
          left: 3* Responsive.widthMultiplier,
          child: Container(
            child: Opacity(
              opacity: 0.6,
              child: Image.asset(image,height: 20* Responsive.imageSizeMultiplier,),
            ),
          ),
        ),
        Positioned(//media and items
          top: 16 * Responsive.heightMultiplier,
          left: 6 * Responsive.widthMultiplier,
          child: Column(
            children:<Widget>[
              Text(media, style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey[800], fontSize: 3.4 * Responsive.textMultiplier)),
              SizedBox(height: 1*Responsive.heightMultiplier,),
              Text(items, style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey[700], fontSize: 3.4 * Responsive.textMultiplier)),
              SizedBox(height: 2*Responsive.heightMultiplier,),
            ],
          ),
        ),
        Positioned(//icons
          top: 28 * Responsive.heightMultiplier,
          left: Responsive.widthMultiplier,
          child: Row(
            mainAxisAlignment:MainAxisAlignment.end,
            children:<Widget>[
              Padding(padding: EdgeInsets.only(left:Responsive.widthMultiplier),child:lock)
            ],
          ),
        ),
      ],
    );
  }

  Widget _filepercent(String name,String percent, {Color color}){
    return Row(
      children: <Widget>[
        Padding(//little circle
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: color,
                radius: 1 * Responsive.imageSizeMultiplier,
              ),
            ],
          ),
        ),
        Text(name,style:TextStyle(color: Colors.black,fontWeight: FontWeight.w600)),
        Spacer(),
        Text(percent,style:TextStyle(color: Colors.black,fontWeight: FontWeight.w600,letterSpacing: 0.25)),
      ],
    );
  }

  Widget _circlechart(double sizing, double complete, double incomplete,{Color color}){//chart
    return AnimatedCircularChart(
      size: Size(sizing * Responsive.imageSizeMultiplier, 0.0), 
      initialChartData: <CircularStackEntry>[
        new CircularStackEntry(
          <CircularSegmentEntry>[
            new CircularSegmentEntry(
              complete,
              color,
              rankKey: 'completed',
            ),
            new CircularSegmentEntry(
              complete,
              Colors.grey,
              rankKey: 'remaining',
            ),
          ],
          rankKey: 'in progress'
        ),
      ],
      chartType: CircularChartType.Radial,
      edgeStyle: SegmentEdgeStyle.round,
      percentageValues: true,
    );
  }
}
