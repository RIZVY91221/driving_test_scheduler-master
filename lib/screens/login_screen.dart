import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driving_test_scheduler/screens/dashboard.dart';
import 'package:driving_test_scheduler/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:driving_test_scheduler/utilities/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  //SharedPreferences sharedPreferences;
  int statusCheck=0;
  String id;
  String licence;
  String ref;

  String failCheck = "";

  _launchURL() async {
    const url = 'https://driverpracticaltest.dvsa.gov.uk/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  TextEditingController licenceController = TextEditingController();
  TextEditingController refController = TextEditingController();
  bool _rememberMe = false;

  void checkLicence(String drivingLicence, String theoryTest) async {
    var jsonResponse;
    var response = await http.get(
      "http://34.215.169.95/api/app_detum/drvlcnsbkng/DrvUser/${drivingLicence.toString()}",
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      jsonResponse = jsonDecode(response.body);
      if (jsonResponse.toString().isEmpty) {
        print('nai data');
        Customtoast("License Number is Not valid");
        signIn(drivingLicence, theoryTest);
      } else {

        print(jsonResponse.toString());
        String id = jsonResponse['ID'].toString();
        print(id);
        print('check');
        checkfirebaseID(id, drivingLicence, theoryTest);
      }
    }
  }

  void checkfirebaseID(String docId, String drvlcn, String theoryTest) async {
    final snapShot = await Firestore.instance
        .collection('drvlcnsbkng')
        .document(docId)
        .get();

    if (snapShot == null || !snapShot.exists) {
      print("not get id from firebase");
      signIn(drvlcn, theoryTest);
    } else {
      setState(() {
        _isLoading = false;
      });
      print(snapShot.data.toString());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("id", docId.toString());
        await prefs.setString("status", snapShot.data['status'].toString());
        await prefs.setString("test_centure", snapShot.data['info']['test_center'].toString());
        await prefs.setString('DateAndTime',snapShot.data['info']['date_and_time'].toString() );
        await prefs.setString("DrivingLicenceNumber", snapShot.data['driving_licence_number'].toString());
        await prefs.setString("TheoryTestNumber", snapShot.data['theory_test_number'].toString());
        await prefs.setString("LastDateToChangeOrCancel", snapShot.data['info']['last_date_to_change_or_cancel'].toString());
        await prefs.setString("Fee", snapShot.data['info']['fee'].toString());
        await prefs.setString("TestStatus", snapShot.data['info']['test_status'].toString());
        await prefs.setString("TypeOfTest", snapShot.data['info']['type_of_test'].toString(),);

        statusCheck=0;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => Dashboard()),
            (Route<dynamic> route) => false);
      } catch (e) {
        e.toString();
      }
    }
  }

  signIn(String drivingLicence, String theoryTest) async {
//    Map <String,String> data2= {
//      "driving_licence_number":drivingLicence,
//      "theory_test_number":theoryTest

    //   };
    Map data = {
      "short_name": drivingLicence,
      "search_text": drivingLicence,
      "doc": {
        "driving_licence_number": drivingLicence,
        "theory_test_number": theoryTest
      }
    };
    var body = jsonEncode(data);
    var jsonResponse;
    var response = await http.post(
      "http://34.215.169.95/api/app_detum/drvlcnsbkng/DrvUser",
      body: body,
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );
    //print(response.statusCode.toString());
    if (response.statusCode == 201) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("id", jsonResponse['ID'].toString());

          print(jsonResponse['ID'].toString());
          id = jsonResponse['ID'].toString();
          Map<String, dynamic> tasks = {
            "driving_licence_number": drivingLicence,
            "status": "process",
            "theory_test_number": theoryTest
          };

          Firestore.instance
              .collection("drvlcnsbkng")
              .document(id)
              .setData(tasks)
              .then((value) => Firestore.instance
                      .collection("drvlcnsbkng")
                      .document(id)
                      .snapshots()
                      .listen((DocumentSnapshot result) {
                    print(result['status'].toString());
                    if (result['status'] == 'process') {
                      Customtoast("Please wait until check");
                      setState(() {
                        _isLoading = true;
                      });
                      return;
                    } else if (result['status'] == 'done') {
                      prefs.setString("status", result['status'].toString());
                      prefs.setString("test_centure", result['info']['test_center'].toString());
                      prefs.setString('DateAndTime',result['info']['date_and_time'].toString() );
                      prefs.setString("DrivingLicenceNumber", result['driving_licence_number'].toString());
                      prefs.setString("TheoryTestNumber", result['theory_test_number'].toString());
                      prefs.setString("LastDateToChangeOrCancel", result['info']['last_date_to_change_or_cancel'].toString());
                      prefs.setString("Fee", result['info']['fee'].toString());
                      prefs.setString("TestStatus", result['info']['test_status'].toString());
                      prefs.setString("TypeOfTest",result['info']['type_of_test'].toString(),);
                      statusCheck=0;
                      setState(() {
                        _isLoading = false;
                      });
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) => Dashboard()),
                          (Route<dynamic> route) => false);
                    } else {
                      statusCheck=1;
                      failCheck =
                      "A booking cannot be found for the details you have given please check the details and try again";
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  }))
              .catchError((e) => print(e.toString()));
          //createWork(id);
          setState(() {
            _isLoading = false;
          });
        } catch (e) {
          e.toString();
        }
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  Future createWork(String uid) async {
    DocumentReference ds =
        Firestore.instance.collection("drvlcnsbkng").document(uid);
    Map<String, dynamic> tasks = {
      "driving_licence_number": licenceController.text.toString(),
      "status": "process",
      "theory_test_number": refController.text.toString()
    };

    ds.setData(tasks).whenComplete(() {
      print("task updated");
    });
  }

  Future updateStatus(Map newMap){
    Firestore.instance
        .collection("drvlcnsbkng")
        .document(id)
        .updateData(newMap).whenComplete((){
          print("update status done");
    }).then((value) => failedProcess()).catchError((e)=>print(e.toString()));
  }
  Future failedProcess()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Firestore.instance
        .collection("drvlcnsbkng")
        .document(id)
        .snapshots()
        .listen((DocumentSnapshot result) {
      print(result['status'].toString());
      if (result['status'] == 'process') {
        Customtoast("Please wait until check");
        setState(() {
          _isLoading = true;
        });
        return;
      } else if (result['status'] == 'done') {
        prefs.setString("status", result['status'].toString());
        prefs.setString("test_centure", result['info']['test_center'].toString());
        prefs.setString('DateAndTime',result['info']['date_and_time'].toString() );
        prefs.setString("DrivingLicenceNumber", result['driving_licence_number'].toString());
        prefs.setString("TheoryTestNumber", result['theory_test_number'].toString());
        prefs.setString("LastDateToChangeOrCancel", result['info']['last_date_to_change_or_cancel'].toString());
        prefs.setString("Fee", result['info']['fee'].toString());
        prefs.setString("TestStatus", result['info']['test_status'].toString());
        prefs.setString("TypeOfTest",result['info']['type_of_test'].toString(),);
        statusCheck=0;
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => Dashboard()),
                (Route<dynamic> route) => false);
      } else {
        statusCheck=1;
        failCheck =
        "A booking cannot be found for the details you have given please check the details and try again";
        setState(() {
          _isLoading = false;
        });
      }
    });
  }
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
//        Text(
//          'Driving Licence Number',
//          style: kLabelStyle,
//        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 40.0,
          child: TextField(
            controller: licenceController,
            onChanged: (value) {
              setState(() {
                licence = value;
              });
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              //errorText: failCheck.isNotEmpty?'check driving licence Number':null,
              contentPadding: EdgeInsets.only(left: 20.0, bottom: 5),
//              prefixIcon: Icon(
//                Icons.directions_car,
//                color: Color(0xFF094869),
//              ),
              hintText: 'Driving licence number',

              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
//        Text(
//          'Theory or Reference Number',
//          style: kLabelStyle,
//        ),
        SizedBox(height: 15.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 40.0,
          child: TextField(
            // obscureText: true,
            controller: refController,
            onChanged: (value) {
              setState(() {
                ref = value;
              });
              //print(.toString());
            },
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              //errorText: failCheck.isNotEmpty?"A booking cannot be found for the details\n you have given please check the details and try again":null,
              contentPadding: EdgeInsets.only(left: 20.0, bottom: 5.0),
//              prefixIcon: Icon(
//                Icons.vpn_key,
//                color: Color(0xFF094869),
//              ),
              hintText: 'Theory or reference number',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
        failCheck.isNotEmpty
            ? Text(
                failCheck,
                style: TextStyle(color: Colors.red),
              )
            : Text("")
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.amberAccent,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildTryAgainBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: RaisedButton(
        color: Colors.amberAccent,
        elevation: 5.0,
        onPressed: () async {
          if (licenceController.text == "" || refController.text == "") {
            Customtoast("Enter driving licence Number");
          } else {
            setState(() {
              _isLoading = true;
            });
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('licence', licenceController.text);
            Map<String, dynamic> tasks = {
              "driving_licence_number": licenceController.text.toString(),
              "status": "process",
              "theory_test_number": refController.text.toString()
            };
            updateStatus(tasks);

          }
//          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
//              builder: (BuildContext context) => Dashboard()), (
//              Route<dynamic> route) => false);
        },
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        //color: Colors.amberAccent,
        child: Text(
          'TRY AGAIN',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: RaisedButton(
        color: Colors.amberAccent,
        elevation: 5.0,
        onPressed: () async {
          if (licenceController.text == "" || refController.text == "") {
            Customtoast("Enter driving licence Number");
          } else {
            setState(() {
              _isLoading = true;
            });
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('licence', licenceController.text);
            checkLicence(licenceController.text, refController.text);
          }
//          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
//              builder: (BuildContext context) => Dashboard()), (
//              Route<dynamic> route) => false);
        },
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        //color: Colors.amberAccent,
        child: Text(
          'CONTINUE',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign in with',
          style: kLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () => print('Login with Facebook'),
            AssetImage(
              'assets/logos/facebook.jpg',
            ),
          ),
          _buildSocialBtn(
            () => print('Login with Googley'),
            AssetImage(
              'assets/logos/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        _launchURL();
      },
      child: Column(
        children: <Widget>[
          Text(
            'Not Regesterd Yet?',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
          ),
          SizedBox(height: 20.0),
          Text(
            'Book Your Test Now',
            style: TextStyle(
                color: Colors.amberAccent.shade100,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/cover.jpg"), fit: BoxFit.cover),
                ),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/cover3.png"),
                      fit: BoxFit.cover),
                ),
              ),
              _isLoading
                  ? Center(
                      child: SpinKitWave(
                          color: Colors.white, type: SpinKitWaveType.center),
                    )
                  : Container(
                      height: double.infinity,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.0,
                          vertical: 100.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
//                      Text(
//                        'Driving Test Scheduler',
//                        style: TextStyle(
//                          color: Colors.white,
//                          fontFamily: 'OpenSans',
//                          fontSize: 30.0,
//                          fontWeight: FontWeight.bold,
//                        ),
//                      ),
                            Padding(
                                padding: EdgeInsets.only(left: 40, right: 40),
                                child: Container(
                                  child: Image.asset(
                                    "assets/logo.png",
                                    height: 200,
                                    width: 300,
                                  ),
                                )),
                            SizedBox(height: 70.0),
                            _buildEmailTF(),
                            SizedBox(
                              height: 10.0,
                            ),
                            _buildPasswordTF(),
                            //_buildForgotPasswordBtn(),
                            //_buildRememberMeCheckbox(),

                            statusCheck==0?_buildLoginBtn():_buildTryAgainBtn(),
                            //_buildSignInWithText(),
                            //_buildSocialBtnRow(),
                            //_buildSignupBtn(),
                          ],
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Customtoast(String msg) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}
