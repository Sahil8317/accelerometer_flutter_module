
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserDetailScreen extends StatefulWidget {
  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final vehicleController = TextEditingController();
  static const platform = const MethodChannel("com.sahil.accelerometer");
  bool isEmailValid = true;
  bool _validateEmailAddress(String email){
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  Future<void> _saveDataAndProceed() async{
    String enteredData = nameController.text+","+emailController.text+","+ageController.text+","+vehicleController.text+",";
    try{
      final result =  await platform.invokeMethod("SaveAndContinue",enteredData);
      print(result);
      Navigator.pushNamed(context, result);
    }catch(e){
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15),
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
                            "User Details",
                            style: TextStyle(
                                fontSize: 25,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )),
                    )),
              ),
              SizedBox(height: 22),
              DetailsTextField("Enter Your Name",Icons.person,nameController),
              SizedBox(height: 20),
             Padding(
               padding: EdgeInsets.only(left:20,right: 20,bottom: 8),
               child: TextField(
                 controller: emailController,
                  decoration: InputDecoration(
                  hintText: "Enter Your Email Address",
                  isDense: true,
                  contentPadding: EdgeInsets.all(15),
                  focusColor: Colors.lightBlue,
                  prefixIcon: Icon(Icons.email,color: Colors.lightBlue,size: 18),
                     suffixIcon:isEmailValid?Container(height: 0,width: 0):Icon(Icons.error_sharp,color: Colors.redAccent)
              ),
            ),
          ),
              isEmailValid?Container(height: 0,width: 0):Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Align(
                  alignment: Alignment.bottomLeft,
                    child: Text("Enter valid email ID",style: TextStyle(color: Colors.redAccent,letterSpacing: 1))),
              ),
              SizedBox(height: 20),
              DetailsTextField("Enter Your Age",Icons.calendar_today,ageController),
              SizedBox(height: 20),
              DetailsTextField("Enter Your Vehicle Number",Icons.directions_bike_sharp,vehicleController),
              SizedBox(height: 55),
              GestureDetector(
                onTap: (){
                  setState(() {
                    isEmailValid = _validateEmailAddress(emailController.text);
                  });

                },
                child: GestureDetector(
                  onTap: (){
                    _saveDataAndProceed();
                  },
                  child: Container(
                      height: 40,
                      width: 250,
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
                      child: Center(child: Text("Save & Continue",style: TextStyle(color: Colors.white,letterSpacing: 1,fontSize: 16,fontWeight: FontWeight.bold)),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DetailsTextField extends StatefulWidget {
  final String  hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  DetailsTextField(this.hintText,this.prefixIcon,this.controller);
  @override
  _DetailsTextFieldState createState() => _DetailsTextFieldState();
}

class _DetailsTextFieldState extends State<DetailsTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left:20,right: 20),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
            hintText: widget.hintText,
            isDense: true,
            contentPadding: EdgeInsets.all(15),
            focusColor: Colors.lightBlue,
            prefixIcon: Icon(widget.prefixIcon,color: Colors.lightBlue,size: 18,)
        ),
      ),
    );
  }
}

