

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: WelcomeScreenBody(),
      );

  }
}

class WelcomeScreenBody extends StatefulWidget {
  @override
  _WelcomeScreenBodyState createState() => _WelcomeScreenBodyState();
}

class _WelcomeScreenBodyState extends State<WelcomeScreenBody> {
 static const platform =  const MethodChannel("com.sahil.accelerometer");   // channel 1
 final numberController = TextEditingController();
 final otpFieldController = TextEditingController();
 bool readOnly = false;

 bool otpSend = false;
 bool isNumberValid = true;
 bool onClickListener = false;
 String mobileNumber;

/// function for automatic verification
  Future<void> startLoginProcess(String number) async {
    try{
      print("good to go");
     final result =  await platform.invokeMethod("startLogin",number);
      print(result);
      print("wowww");
      if(result=="failed 1"){
        // invalid code resend otp

      }else{
        if(result=="failed 2"){
          // try after some time
        }else{
          Navigator.pushNamed(context, result);  // push to second screen
        }
      }
    }catch(exception){
      print("error");
      print(exception);
    }
  }
 void _showLoadingDialog(){
   showDialog(
       context: context,
       barrierDismissible: false,
       builder: (BuildContext context){
         return AlertDialog(

           content: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               CircularProgressIndicator(color: Colors.blueAccent),
               SizedBox(height: 8),
               Text("Verifying OTP...",style: TextStyle(color:  Color(0xff759AF3)))
             ],
           ),
         );
       });

 }
  /// function for manual verification from user

  Future<void> verifyOTP(String otp) async{
    try{
      _showLoadingDialog();
      print("good to goo");
      print(otp);
      final result = await platform.invokeMethod("verifyOTP",otp);
      print("yessssssssss");
      print(result);
      if(result=="invalid code"){
        Navigator.pop(context);
      }else{
        // on success
        Navigator.pop(context);
        Navigator.pushNamed(context, result);
      }
    }catch(ex){
      print(ex);
    }
  }



  void _validateNumber(String value){
    RegExp regex = new RegExp(r'^[6-9]\d{9}$');
    if(regex.hasMatch(value)){
      isNumberValid=true;
    }else{
      isNumberValid=false;
    }
  }

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
                      maxLength: 10,
                      controller: numberController,
                      readOnly: readOnly,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      decoration: InputDecoration(
                        counterText: "",
                        prefixIcon: Icon(Icons.phone,size: 22,),
                        suffixIcon:onClickListener?isNumberValid? Icon(Icons.check,color: Colors.green,size: 20,):Icon(Icons.error,color: Colors.redAccent,)
                            :Container(height: 0,width: 0,),
                        isDense: true,
                        hintText: "Enter your Number",
                        contentPadding: EdgeInsets.all(15) ,
                        focusColor: Colors.lightBlue,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
              ),
             isNumberValid?Container(height: 0,width: 0,):
             Align(
               alignment: Alignment.bottomLeft,
                 child: Padding(
                   padding: const EdgeInsets.only(left: 20),
                   child: Text("Enter valid Phone Number",style: TextStyle(color: Colors.redAccent,letterSpacing: 1)),
                 )),
             otpSend? Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left:18,right: 18),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    child: TextField(
                      controller: otpFieldController,
                      maxLength: 6,
                      autofocus: true,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      decoration: InputDecoration(
                       counter: Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           Icon(Icons.autorenew_sharp,color: Colors.redAccent,size: 17),
                           Text("Auto-Detecting",style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold)),
                         ],
                       ),
                       prefixIcon: Icon(Icons.lock,size: 22),
                        //suffixIcon: Icon(Icons.check,color: Colors.green),
                        hintText: "Enter OTP",
                        isDense: true,
                        contentPadding: EdgeInsets.all(15),
                        focusColor: Colors.lightBlue,
                      ),

                      keyboardType: TextInputType.number,
                    ),
                  ),
                )
              ):Container(height: 0,width: 0,),
              SizedBox(height: 20,),
              Flexible(
                flex: 1,
                child: otpSend?GestureDetector(
                  onTap: (){
                    print("verifying");
                    verifyOTP(otpFieldController.text);
                  },
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
                    child: Center(child: Text("Verify OTP",style: TextStyle(color: Colors.white,letterSpacing: 1,fontSize: 16,fontWeight: FontWeight.bold)),
                  ))
                ):GestureDetector(
                  onTap: (){
                    print("started");
                    setState(() {
                      _validateNumber(numberController.text);
                      onClickListener=true;
                      if(isNumberValid){
                        otpSend=true;
                        readOnly = true;
                        startLoginProcess(numberController.text);
                      }
                    });
                  },
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
                    child: Center(child:Text("Send OTP",style: TextStyle(color: Colors.white,letterSpacing: 1,fontSize: 16,fontWeight: FontWeight.bold))),
                  ),
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

