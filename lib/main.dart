import 'package:accelerometer_flutter_module/userDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'welcomeScreen.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

String screenName;

void main() async {
  WidgetsFlutterBinding .ensureInitialized();
  await getSharedPreferenceData();
  print("greattttttttttttttttttttttttttttttt");
  runApp(MyApp());
}
/// function to decide screen 
Future<void>getSharedPreferenceData() async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  String d = pref.getString('HomeOrDetailsScreen');
  if(d=="DetailsScreen"){
    screenName = "/userDetailScreen";
  }else {
    String data = pref.getString("loggedInfo");
    print(data);
    print("dddddddddddddddddddddddddddddd");
    if (data == "LoggedIN") {
      screenName = "/";
      print(screenName);
    } else {
      screenName = "/WelcomeScreen";
    }
  }
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     initialRoute: screenName,
      routes:{
        "/":(context)=> UserMainScreen(),
        "/WelcomeScreen":(context)=>WelcomeScreen(),
        "/userDetailScreen":(context)=>UserDetailScreen(),
      },
    );
  }
}

class UserMainScreen extends StatefulWidget {
  @override
  _UserMainScreenState createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen>
    with TickerProviderStateMixin {
  static const platform = const MethodChannel("com.sahil.accelerometer");
  AnimationController animationController, bottomController;
  Animation<double> animation;
  Animation<Offset> bottomAnimation;
  bool isOpen;
  bool isAnimationCompleted = false;
  double height;
  double width;
  double fontSize;


  @override
  void initState() {
    super.initState();
    isOpen = true;
    animationController =
        AnimationController(duration: Duration(milliseconds: 450), vsync: this);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    bottomController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    bottomAnimation = Tween(begin: Offset(0.0, 3.5), end: Offset.zero)
        .animate(bottomController);
    height = 0;
    fontSize = 0;
    width = 0;
  }

  Future<void> _startSearchAndConnectActivity() async {
    try {
      print("good to go");
      final result = await platform.invokeMethod("startSearchAndConnect");
      print(result);
    } catch (ex) {
      print(ex);
    }
  }

  Future<void> _formCSVFile() async {
    try {
      final res = await platform.invokeMethod("formCSVFile");
      print(res);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: isOpen ? 5 : 0,
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: RotationTransition(
          child: isOpen ? Icon(Icons.add, size: 29) : Icon(Icons.close),
          turns: animation,
        ),
        onPressed: () {
          setState(() {
            isOpen = !isOpen;
            if (isOpen) {
              animationController.reverse();
              bottomController.reverse();
            } else {
              animationController.forward();
              bottomController.forward();
            }
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 8,
        iconSize: 22,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(title: Text("Home"), icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              title: Padding(
                padding: const EdgeInsets.only(right: 35.0),
                child: Text("Updates"),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(right: 35.0),
                child: Icon(Icons.update),
              )),
          BottomNavigationBarItem(
              title: Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: Text("Profile"),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Icon(Icons.person),
              )),
          BottomNavigationBarItem(
              title: Text("Statistics"), icon: Icon(Icons.data_usage))
        ],
      ),
      body: SafeArea(
        child: Container(
          width: deviceWidth,
          height: deviceHeight,
          decoration: BoxDecoration(
              color: Color(0xff33CCFF),
              gradient: LinearGradient(colors: [
                // Color(0xff0066FF),
                Color(0xff000099),
                Color(0xff0066FF),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Stack(children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.blueAccent,
                                      Color(0xff759AF3),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight)),
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "DashBoard",
                              style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )),
                      )),
                ),
                SizedBox(height: 20),
                Expanded(
                  flex: 1,
                  child: SfRadialGauge(
                    title: GaugeTitle(
                        text: "Risk Percentage",
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                            fontSize: 24,
                            color: Colors.white)),
                    //   animationDuration: 2.0,
                    // enableLoadingAnimation: true,
                    axes: <RadialAxis>[
                      RadialAxis(
                          showAxisLine: true,
                          showLabels: false,
                          showTicks: false,
                          minimum: 0,
                          maximum: 100,
                          axisLineStyle: AxisLineStyle(
                              cornerStyle: CornerStyle.bothCurve,
                              thickness: 25,
                              color: Colors.blueAccent),
                          pointers: <GaugePointer>[
                            RangePointer(
                                value: 90,
                                enableAnimation: true,
                                animationDuration: 2000,
                                cornerStyle: CornerStyle.bothCurve,
                                width: 25,
                                sizeUnit: GaugeSizeUnit.logicalPixel,
                                gradient: SweepGradient(
                                    colors: [Colors.red, Color(0xff990000)],
                                    stops: <double>[0.25, 0.75])),
                            MarkerPointer(
                                value: 90,
                                enableDragging: false,
                                markerHeight: 34,
                                markerWidth: 34,
                                markerType: MarkerType.circle,
                                color: Colors.blue,
                                borderWidth: 2,
                                borderColor: Colors.white54,
                                enableAnimation: true,
                            ),
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                widget: Text(
                                  "90% Risk",
                                  style: TextStyle(
                                      color: Color(0xffFF0066),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32,
                                      letterSpacing: 1),
                                ),
                                angle: 90,
                                horizontalAlignment: GaugeAlignment.center)
                          ]),
                    ],
                  ),
                ),
                Container(
                  height: 28,
                  width: deviceWidth * 0.55,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.blueAccent,
                      Color(0xff759AF3),
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                  ),
                  child: Center(
                      child: Text("You are at HighRisk",
                          style: TextStyle(
                              color: Color(0xff990000),
                              letterSpacing: 1,
                              fontSize: 16))),
                ),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Container(
                    //height: 120,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(42),
                          topRight: Radius.circular(42)),
                    ),
                    width: deviceWidth,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 25),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Statistics",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                    shadows: [BoxShadow(blurRadius: 45)]),
                              ),
                              Text(
                                "See All",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    letterSpacing: 1,
                                    color: Colors.black38),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[
                                StatsContainer("Average","Alignment","50",Icons.check_box,Colors.green),
                                SizedBox(width: 12),
                                StatsContainer("Risk","Factor","76",Icons.warning,Colors.red),
                                SizedBox(width: 12),
                                StatsContainer("Engine","Temperature","36F",Icons.check_box,Colors.green)
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: deviceWidth,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: bottomAnimation,
                child: Container(
                  height: 180,
                  width: 200,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xff419CB1),
                        Color(0xff759AF3),
                      ], begin: Alignment.bottomLeft, end: Alignment.topRight),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 10, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              bottomController.reverse();
                              print("ss");
                              animationController.reverse();
                              _startSearchAndConnectActivity(); // migrating to kotlin
                            },
                            child: BuildRow(
                                Icons.directions_bike, "Start Ride", 15)),
                        GestureDetector(
                            onTap: () {
                              bottomController.reverse();
                              print("ss");
                              animationController.reverse();
                              _formCSVFile();
                            },
                            child: BuildRow(
                                Icons.file_download, "Download CSV File", 15)),
                        BuildRow(Icons.bluetooth_connected,
                            "Check Connectivity", 15),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class StatsContainer extends StatelessWidget {
  final String firstText;
  final String secondText;
  final String data;
  final IconData iconData;
  final Color iconColor;

  StatsContainer(this.firstText,this.secondText,this.data,this.iconData,this.iconColor);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180,
        width: 135,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            border: Border.all(color: Colors.blueAccent, width: 1.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 7),
            Text(firstText,style: TextStyle(fontSize: 17,letterSpacing: 1,color: Colors.blueAccent)),
            Text(secondText,style: TextStyle(fontSize: 17,letterSpacing: 1,color: Colors.blueAccent)),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(data,style: TextStyle(fontSize: 25,letterSpacing: 1,fontWeight: FontWeight.w500),),
                SizedBox(width: 5),
                Icon(iconData,color: iconColor,)
              ],
            ),
            SizedBox(height: 18),

          ],
        ));
  }
}

class BuildRow extends StatelessWidget {
  final String text;
  final IconData icon;
  final double size;

  BuildRow(this.icon, this.text, this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
              radius: 13,
              backgroundColor: Colors.indigo,
              child: Icon(
                icon,
                color: Colors.white,
                size: 15,
              )),
          SizedBox(
            width: 9,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: size),
          )
        ],
      ),
    );
  }
}
