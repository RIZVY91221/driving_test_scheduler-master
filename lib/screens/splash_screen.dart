import 'package:driving_test_scheduler/screens/dashboard.dart';
import 'package:driving_test_scheduler/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}
String id=" ";
class SplashScreenState extends State<SplashScreen> {

  String status;

  Future data;

  bool isLoading = false;
  String lastId;

  _getId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id=(preferences.getString("id")??' ');
    });
    print(id.toString());
    return id;
  }

  Future<String> getStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("status");
  }

  @override
  void initState() {
    _getId().then((value){
      setState(() {
        lastId=value;
      });
    });
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      image: DecorationImage(
            image: AssetImage('assets/cover.jpg'),
            fit: BoxFit.cover
        ) ,
      ),

      child: StreamBuilder(
            stream: Firestore.instance.collection("drvlcnsbkng").document(lastId).snapshots(),
            builder: (context, snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                  case ConnectionState.active:
                case ConnectionState.done:
                  if(snapshot.hasError){
                    return Text("Error:${snapshot.error}");
                    //Text("Error:${snapshot.error}");
                  }else{
                    if(snapshot.hasData){
                      if(snapshot.data['status']=='process')
                      {
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top:200.0),
                              child: Text('Please Wait', style: TextStyle(
                                  decoration: TextDecoration.none, color: Colors.amber, fontWeight: FontWeight.w400, fontSize: 50
                              ),
                              ),
                            ),
              SizedBox(height: 20),
              Center(child:SpinKitWave(color: Colors.amberAccent, type: SpinKitWaveType.center),),
                          ],
                        );


                      }
                      if(snapshot.data['status']=='done'){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Dashboard(
                            )));

                       /* return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top:200.0),
                              child: Text('Varified', style: TextStyle(
                                  decoration: TextDecoration.none, color: Colors.green, fontWeight: FontWeight.w400, fontSize: 50
                              ),
                              ),
                            ),
                            SizedBox(height: 20),
                            OutlineButton(
                              onPressed: ()async{
                                final prefs = await SharedPreferences.getInstance();
                                prefs.setString("test_centure", snapshot.data['info']['test_center'].toString());
                                prefs.setString('DateAndTime',snapshot.data['info']['date_and_time'].toString() );
                                prefs.setString("DrivingLicenceNumber", snapshot.data['driving_licence_number'].toString());
                                prefs.setString("TheoryTestNumber", snapshot.data['theory_test_number'].toString());
                                prefs.setString("LastDateToChangeOrCancel", snapshot.data['info']['last_date_to_change_or_cancel'].toString());
                                prefs.setString("Fee", snapshot.data['info']['fee'].toString());
                                prefs.setString("TestStatus", snapshot.data['info']['test_status'].toString());
                                prefs.setString("TypeOfTest", snapshot.data['info']['type_of_test'].toString(),);
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => Dashboard()));
                              },
                              child: Text("Go to Dashboard",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ],
                        );*/
                      }else if(snapshot.data['status']=='fail'){

                         Fluttertoast.showToast(
                             msg: "Failed to verify",
                             toastLength: Toast.LENGTH_SHORT,
                             gravity: ToastGravity.BOTTOM,
                             timeInSecForIosWeb: 1,
                             backgroundColor: Colors.blue,
                             textColor: Colors.black,
                             fontSize: 16.0
                         );
                         Navigator.push(context, MaterialPageRoute(
                             builder: (context)=>LoginScreen()
                         ));


                      }
                      else{
                        Fluttertoast.showToast(
                            msg: "Failed to verify",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blue,
                            textColor: Colors.black,
                            fontSize: 16.0
                        );
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>LoginScreen()
                        ));
                      }
                    }
                  }
              }
            },

          )

    );
  }
}
