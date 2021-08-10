import 'dart:ui';

import 'package:csdynamics/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
          (Route<dynamic> route) => false);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage("assets/images/crops.jpg"),
            fit: BoxFit.cover
          ),
                    // fit: BoxFit.cover,
        ),
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 48.0),
                      child: SizedBox(
                        // height: MediaQuery.of(context).size.height * 0.3,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Image(
                                image: AssetImage('assets/images/tz_logo.png'),
                              ),
                            ),
                            Text("Crop Stock Dynamics",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.4,
                              decoration: new BoxDecoration(
                                color: Colors.grey.shade200.withOpacity(0.5),
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(15),
                                  topRight: const Radius.circular(15),
                                  bottomLeft: const Radius.circular(15),
                                  bottomRight: const Radius.circular(15)
                                )
                              ),
                              child: ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 28.0),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: username,
                                            validator: (value) => value!.isEmpty ? "username is required" : null,
                                            decoration: InputDecoration(
                                              labelText: "Username",
                                              labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                                              hintText: "Enter username",
                                              focusColor: Colors.white,
                                              errorStyle: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 15.0,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(5.0),
                                                borderSide: BorderSide(color: Colors.white),
                                              ),
                                            ),
                                          ),

                                          SizedBox(height: 10.0,),
                                          TextFormField(
                                            controller: password,
                                            obscureText: true,
                                            validator: (value) => value!.isEmpty ? "password is required" : null,
                                            style: TextStyle(
                                              // color: Colors.white,
                                              
                                            ),
                                            decoration: InputDecoration(
                                              labelText: "Passwords",
                                              labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                                              hintText: "Enter passwords",
                                              focusColor: Colors.white,
                                              // focusedBorder: OutlineInputBorder(
                                              //   borderSide: BorderSide(color: Colors.)
                                              // ),
                                              // enabledBorder: OutlineInputBorder(
                                              //   borderSide: BorderSide(color: Colors.white)
                                              // ),
                                              errorStyle: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 15.0,
                                              ),
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(5.0),
                                                borderSide: BorderSide(),
                                              ),
                                            ),
                                          ),

                                          SizedBox(height: 17.0),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        primary: Colors.green[700],
                                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                                                        textStyle: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold
                                                        ),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (_formKey.currentState!.validate()) {
                                                          // setState(() {
                                                          //   this._isLoading = true;
                                                          //   this._error = '';
                                                          // });
                                                          showAlertDialog(context);
                                                          signIn(username.text, password.text);
                                                        }
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.center,
                                                        children: [
                                                          Icon(Icons.login),
                                                          SizedBox(
                                                            width: 12.0,
                                                          ),
                                                          Text(
                                                            'Login',
                                                            textScaleFactor: 1.2,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ]
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // child: Column(
        //   children: [
        //     SizedBox(
        //       child: Column(
        //         children: [
        //           Image(
        //             image: AssetImage('assets/images/tz_logo.png'),
        //           ),
        //           Center(
        //             child: Text("Crop Stock Dynamics",
        //               style: TextStyle(
        //                 color: Colors.green[900],
        //                 fontSize: 25.0
        //               ),
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //     Stack(
        //       children: [
        //         Container(
        //           height: MediaQuery.of(context).size.height * 0.5,
        //           width: MediaQuery.of(context).size.width,
        //           decoration: BoxDecoration(
        //             color: Colors.grey.shade200.withOpacity(0.7),
        //             borderRadius: BorderRadius.only(
        //             topLeft: const Radius.circular(30),
        //             topRight: const Radius.circular(30),
        //             bottomLeft: const Radius.circular(15),
        //             bottomRight: const Radius.circular(15)
        //             )
        //           ),
        //           // child: Image(
        //           //   image: AssetImage('assets/images/crops.jpg'),
        //           //   fit: BoxFit.cover,
        //           // ),
        //         ),
        //         SizedBox(
        //           // height: MediaQuery.of(context).size.height * 0.8,
        //           child: Form(
        //             key: _formState,
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 ClipRRect(
        //                   borderRadius: BorderRadius.all(
        //                     Radius.circular(20),
        //                   ),
        //                   child: Container(
        //                     height: MediaQuery.of(context).size.height * 0.45,
        //                     width: MediaQuery.of(context).size.width * 0.9,
        //                     decoration: BoxDecoration(
        //                       color: Colors.white,
        //                     ),
        //                     child: Column(
        //                       children: [
        //                         TextFormField(
        //                             decoration: InputDecoration(
        //                               labelText: "Customer Name",
        //                               hintText: "Enter customer name",
        //                               labelStyle: TextStyle(fontSize: 18.0),
        //                               // border: ,
        //                               errorStyle: TextStyle(
        //                                 color: Colors.redAccent,
        //                                 fontSize: 15.0,
        //                               ),
        //                             ),
        //                         )
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         )
        //       ],
        //     )
        //     // ListView(
        //     //    children: [
                 
        //     //    ],
        //     // ),
        //   ],
        // ),
      
      ),
    );
  }

  signIn(String username, String password) async{
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final data = jsonEncode({
        'username': username,
        'password': password,
      });
      // var response = await http.post('http://10.0.2.2:8000/api/user',
      var response = await http.post(
          Uri.parse("http://stocks.multics.co.tz/public/api/login"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'accept': 'application/json'
          },
          body: data);

      print(response.statusCode);
      var resp = (jsonDecode(response.body));
      if (response.statusCode == 200) {
        print(resp['api_token']);
        if (resp != null) {
          sharedPreferences.setString("token", resp['api_token']);
          Navigator.pop(context);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomePage()));
        } 
      } else if (response.statusCode == 401) {
          final snackBar = SnackBar(
            content: Text(
                'username or password is wrong'),
          );
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    catch(_, e) {
      print(e.toString());
      final snackBar = SnackBar(
            content: Text(
                'login failed, try checking your internet connection'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}


  showAlertDialog(BuildContext context){
      AlertDialog alert=AlertDialog(
        content: new Row(
            children: [
               CircularProgressIndicator(),
               Container(margin: EdgeInsets.only(left: 5),child:Text("Loading" )),
            ],),
      );
      showDialog(barrierDismissible: false,
        context:context,
        builder:(BuildContext context){
          return alert;
        },
      );
    }