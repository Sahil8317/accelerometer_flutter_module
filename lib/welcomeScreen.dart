
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() => runApp(WelcomeScreen());

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        body: WelcomeScreenBody(),
      ),
    );
  }
}

class WelcomeScreenBody extends StatefulWidget {
  @override
  _WelcomeScreenBodyState createState() => _WelcomeScreenBodyState();
}

class _WelcomeScreenBodyState extends State<WelcomeScreenBody> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Flexible(
                flex: 3,
                child: ClipPath(
                  clipper:MyClipper(),
                  child: Container(
                    padding: EdgeInsets.only(bottom: 70),
                    height: deviceHeight*0.38,
                    width: deviceWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff419CB1),
                          Color(0xff759AF3),
                        ]
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              Text("Acceler",style: TextStyle(color: Colors.white,letterSpacing: 2,fontSize: 35,fontWeight: FontWeight.w500,shadows: [
                                BoxShadow(blurRadius: 60)
                              ]),
                              ),
                              Icon(Icons.directions_bike,size: 31,color: Colors.white,),
                              Text("meter",style:TextStyle(color: Colors.white,letterSpacing: 2,fontSize: 35,fontWeight: FontWeight.w500,shadows: [
                                BoxShadow(blurRadius: 60)
                              ]) ,)
                            ],
                          )),
                  ),
                ),
              ),
              Flexible(
                flex:2 ,
                child: Container(
                  height: 43,
                  width: 210,
                 // padding: EdgeInsets.only(left: 30,right: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(18)) ,
                    border: Border.all(color: Colors.black45,width: 1)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 55,
                        width: 105,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                            borderRadius: BorderRadius.all(Radius.circular(18))),
                          child: Center(child: Text("Log IN",style: TextStyle(color: Colors.white,letterSpacing: 1,fontWeight: FontWeight.bold,fontSize: 15,),))),
                      Padding(
                        padding: const EdgeInsets.only(right:20.0),
                        child: Text("Sign Up",style: TextStyle(color: Colors.blueAccent,letterSpacing: 1,fontWeight: FontWeight.bold,fontSize: 15),),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left:18.0,right: 18),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email,size: 22,),
                        suffixIcon: Icon(Icons.check,color: Colors.green,size: 20,),
                        isDense: true,
                        hintText: "Enter your Email ID",
                        contentPadding: EdgeInsets.all(15) ,
                        focusColor: Colors.lightBlue,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left:18,right: 18),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock,size: 22),
                        suffixIcon: Icon(Icons.check,color: Colors.green),
                        hintText: "Enter Your Password",
                        isDense: true,
                        contentPadding: EdgeInsets.all(15),
                        focusColor: Colors.lightBlue,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50,),
              Flexible(
                flex: 1,
                child: Container(
                  height: 40,
                  width: 290,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)) ,
                    color: Colors.blueAccent
                    // gradient: LinearGradient(
                    //   begin: Alignment.centerLeft,
                    //   end: Alignment.centerRight,
                    //   colors: [
                    //    // Color(0xff419CB1),
                    //     Color(0xff759AF3),
                    //   ],
                    // )
                  ),
                  child: Center(child: Text("Log IN",style: TextStyle(color: Colors.white,letterSpacing: 1,fontSize: 16,fontWeight: FontWeight.bold))),
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.bottomCenter,
            child: ClipPath(
                clipper: BottomClipper(),
              child: Container(
                width: deviceWidth,
                height: deviceHeight*0.30,
                decoration: BoxDecoration(

                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color(0xff419CB1),
                          Color(0xff759AF3),
                        ]
                    ),
                ),
                child: Container(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 140);
    path.quadraticBezierTo(
        size.width/2, size.height, size.width, size.height - 85);
    path.lineTo(size.width, 0);
    path.close();
    return path;

    throw UnimplementedError();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }

}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height-140);
    path.quadraticBezierTo(size.width/2, 0, size.width+75, size.height+120);
    path.lineTo(0, size.height);
    path.close();
    return path;

    throw UnimplementedError();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }

}

