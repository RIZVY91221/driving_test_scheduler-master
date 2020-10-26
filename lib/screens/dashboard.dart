import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driving_test_scheduler/screens/addTestCenter_paid.dart';
import 'package:driving_test_scheduler/screens/default_available_test_times.dart';
import 'package:driving_test_scheduler/screens/login_screen.dart';
import 'package:driving_test_scheduler/screens/settings.dart';
import 'package:driving_test_scheduler/screens/splash_screen.dart';
import 'package:driving_test_scheduler/utilities/custom_list_Tile.dart';
import 'package:flutter/material.dart';
import 'package:driving_test_scheduler/screens/notifications.dart';
import 'package:driving_test_scheduler/screens/available_test_times_all.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

String id=" ";
class Dashboard extends StatefulWidget {

  @override
  _DashboardState createState() => _DashboardState();
}
class _DashboardState extends State<Dashboard> {

  String status;

  Future data;
  bool payment;


  //bool isLoading = false;
  bool isLoading = false;
  String lastId;
  String date1;
  String ref;
  String d;
  String ldofChangeAndCancel;
  String typeOfTest;
  String fee;
  String testCenture;

  Future <bool>isPayment()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isPayment');
  }

  _getId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id=(preferences.getString("id")??' ');
    });
    return id;
  }

  Future<String> getStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("status");
  }
  Future<String> getDateTime() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("DateAndTime");
  }
  Future<String> getDlicence() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("DrivingLicenceNumber");
  }
  Future<String> getDRef() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("TheoryTestNumber");
  }
  Future<String> getLastDateToChangeOrCancel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("LastDateToChangeOrCancel");
  }
  Future<String> getTestCenter() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("test_centure");
  }
  Future<String> getTypeOfTest() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("TypeOfTest");
  }
  Future<String> getFee() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("TypeOfTest");
  }
  Future<String> getTestStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("TestStatus");
  }

//  Future getWork()async{
//    getId().then((value)=>id=value);
//    var firestore=Firestore.instance;
//    QuerySnapshot qn =await firestore.collection("drvlcnsbkng").document(id).;
//    print(qn.documents.toString());
//    return qn.documents;
//  }


//  Future<void> getWork() async {
//    //getId().then((value) => id = value);
//    var data = Firestore.instance.collection("drvlcnsbkng").document(id).get().then((snapshot){
//      this.DrivingLicenceNumber =
//          snapshot.data['driving_licence_number'].toString();
//      // print(DrivingLicenceNumber.toString());
//     this.DateAndTime = snapshot.data['info']['date_and_time'].toString();
//     this.Fee = snapshot.data['info']['fee'].toString();
//      this.LastDateToChangeOrCancel =
//          snapshot.data['info']['last_date_to_change_or_cancel'].toString();
//      this.TestCenter = snapshot.data['info']['test_center'].toString();
//      this.TestStatus = snapshot.data['info']['test_status'].toString();
//      this.TypeOfTest = snapshot.data['info']['type_of_test'].toString();
//      this.TheoryTestNumber = snapshot.data['theory_test_number'].toString();
//    });
//    return;
  // getStatus().then((value) => status = value);
  /*if (status == "process") {
      return CircularProgressIndicator();
    } else {
      document.get().then((snapshot) {
        if (snapshot.data['status'] == 'process') {
          setState(() {
            isLoading = true;
          });
        }
        else if (snapshot.data['status'] == 'done') {
          setState(() {
            isLoading = false;
          });
          DrivingLicenceNumber =
              snapshot.data['driving_licence_number'].toString();
          // print(DrivingLicenceNumber.toString());
          DateAndTime = snapshot.data['info']['date_and_time'].toString();
          Fee = snapshot.data['info']['fee'].toString();
          LastDateToChangeOrCancel =
              snapshot.data['info']['last_date_to_change_or_cancel'].toString();
          TestCenter = snapshot.data['info']['test_center'].toString();
          TestStatus = snapshot.data['info']['test_status'].toString();
          TypeOfTest = snapshot.data['info']['type_of_test'].toString();
          TheoryTestNumber = snapshot.data['theory_test_number'].toString();
          setState(() {
            isLoading = false;
          });
        } else {
          return null;
        }
        setState(() {
          isLoading = false;
        });
      });
    }*/
  //}

//  void getData() {
//    var databaseReference=Firestore.instance;
//    try{
//      databaseReference
//          .collection("drvlcnsbkng")
//          .getDocuments()
//          .then((QuerySnapshot snapshot) {
//        snapshot.documents.forEach((f) => print('${f.data}}'));
//      });
//    }catch(e){
//      e.toString();
//    }
//
//  }
  @override
  void initState() {
    // TODO: implement initState
    //getData();
    //data=getWork();
    _getId().then((value){
      setState(() {
        lastId=value;
      });
    });
    getDateTime().then((value){
      setState(() {
        date1=value;
      });
    });
    getDlicence().then((value){
      setState(() {
        d=value;
      });
    });
    getDRef().then((value){
      setState(() {
        ref=value;
      });
    });
    getLastDateToChangeOrCancel().then((v){
      setState(() {
        ldofChangeAndCancel=v;
      });
    });
    getTestCenter().then((v){
      setState(() {
        testCenture=v;
      });
    });
    getTypeOfTest().then((v){
      setState(() {
        typeOfTest=v;
      });
    });
    getFee().then((v){
      setState(() {
        fee=v;
      });
    });
    getTestStatus().then((v){
      setState(() {
        status=v;
      });
    });
    isPayment().then((value) {
      setState(() {
        //print(value);
        payment=value;
        print(payment);
      });
    });


    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    //return isLoading?SplashScreen():Scaffold(
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Color(0xFF0d6898),
          title:Text("Dashboard"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              iconSize: 40,
              color: Colors.white,
              onPressed: () =>payment==null?
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Settings())):Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Notifications()))
            )
          ],
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(
                0xFF0d6898), //This will change the drawer background to blue
          ),

          child: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Driving licence number",style: TextStyle(color: Colors.white),),
                      Text(
                        d.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ],
                  ),
                  accountEmail: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Theory Test Number",style: TextStyle(color: Colors.white),),
                      Text(
                        ref.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ],
                  ),

                ),
                //CustomListTile(Icons.dashboard,'Home',()=>[]),
                SizedBox(height: 20.0),
                CustomListTile(Icons.watch_later, 'Test Centers & Time', () =>
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => DefaultAvailableTestTimes(testCenture: testCenture))),),
                //CustomListTile(Icons.notifications,'Notifications',()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SplashScreen())),),
                CustomListTile(Icons.add, 'Add Test Center', () =>payment==null?
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings())):Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddTestCentur())),),
                CustomListTile(Icons.notifications, 'Notification', () =>payment!=null?
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Notifications())):
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings())),),
                CustomListTile(Icons.lock, 'Logout', () async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove('status');
                  prefs.clear();
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => LoginScreen()));
                }
                   ),
              ],
            ),
          ),
        ),
        body:Container(
          child:ListView(
            children: <Widget>[

              SizedBox(height: 8.0),

              Dbox1(DrivingLicenceNumber: d,
                TheoryTestNumber: ref,),

              SizedBox(height: 8.0),

              Dbox2(
                DateAndTime:date1,
                LastDateToChangeOrCancel:ldofChangeAndCancel,
                TestCenter: testCenture,
                TypeOfTest: typeOfTest,
                Fee: fee,
                TestStatus: status,
              )

            ],
          ),
        ) /*StreamBuilder(
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

                         //Navigator.push(context,MaterialPageRoute(builder: (context) => SplashScreen()));

                        // Navigator.push(context,MaterialPageRoute(builder: (context) => SplashScreen()));
                        return SplashScreen();
                          //Center(child:SpinKitWave(color: Colors.amberAccent, type: SpinKitWaveType.center),);
                       // Text("");
                        //SplashScreen();
                    }
//
                    else if(snapshot.data['status']=='done'){
                      return
                    }
                    else{
                      return Text("No data Available");
                    }

                  }
                  else{
                    return Text("no data");
                  }
                }
            }
          },

        )*/
    );
  }
}

class Dbox1 extends StatelessWidget {

  final String DrivingLicenceNumber;
  final String TheoryTestNumber;

  const Dbox1({Key key, this.DrivingLicenceNumber, this.TheoryTestNumber}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          //SizedBox(height: 10.0),
          CustomCard1(TheoryTestNumber.toString(),DrivingLicenceNumber.toString()),

        ],
      ),
    );
  }
}

class CustomCard1 extends StatelessWidget {

  String th_test_no;
  String driving_l_no;
  CustomCard1(this.th_test_no,this.driving_l_no);


  @override
  Widget build(BuildContext context) {
    return
      Container(
        decoration: BoxDecoration(
            color: Color(0xFFB5C8D2),
            borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Container(color: Colors.grey,
              // child:
              Padding(
                padding: const EdgeInsets.only(left:8.0,top: 8.0),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Driving Licence Number',style: TextStyle(fontSize: 16.0,color: Color(0xFF0d6898),fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.only(left : 10.0 ,top: 5.0),
                      child: Text(driving_l_no,style: TextStyle(fontSize: 22.0,color: Colors.black87,fontWeight: FontWeight.bold,)),
                    ),
                    SizedBox(height: 15.0),
                    Text('Theory Test Number',style: TextStyle(fontSize: 16.0,color: Color(0xFF0d6898),fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.only(left : 10.0 ,top: 5.0),
                      child: Text(th_test_no,style: TextStyle(fontSize: 22.0,color: Colors.black87,fontWeight: FontWeight.bold,)),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}

class Dbox2 extends StatelessWidget {
  final String DateAndTime;
  final String LastDateToChangeOrCancel;
  final String TestCenter;
  final String TypeOfTest;
  final String Fee;
  final String TestStatus;

  const Dbox2({Key key, this.DateAndTime,this.LastDateToChangeOrCancel,this.TestCenter,this.TypeOfTest,this.Fee,this.TestStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          //SizedBox(height: 10.0),
          CustomCard2(DateAndTime.toString(),LastDateToChangeOrCancel.toString(),TestCenter.toString(),TypeOfTest.toString(),Fee.toString(),TestStatus.toString()),

        ],
      ),
    );
  }
}

class CustomCard2 extends StatelessWidget {

  String last_date;
  String date_time;
  String test_center;
  String type_of_test;
  String test_fee;
  String test_status;


  CustomCard2(this.date_time,this.last_date,this.test_center,this.type_of_test,this.test_fee,this.test_status);


  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: MediaQuery.of(context).size.height*0.67,
        decoration: BoxDecoration(
            color: Color(0xFFB5C8D2),
            borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Container(color: Colors.grey,
              // child:
              Padding(
                padding: const EdgeInsets.only(left:8.0,top:8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Date And Time Of Test',style: TextStyle(fontSize: 16.0,color: Color(0xFF0d6898),fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.only(left : 10.0 ,top: 5.0),
                      child: Text(date_time,style: TextStyle(fontSize: 22.0,color: Colors.black87,fontWeight: FontWeight.bold,)),
                    ),
                    SizedBox(height: 15.0),
                    Text('Last Date To Change or Cancel',style: TextStyle(fontSize: 16.0,color: Color(0xFF0d6898),fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.only(left : 10.0 ,top: 5.0),
                      child: Text(last_date,style: TextStyle(fontSize: 22.0,color: Colors.black87,fontWeight: FontWeight.bold,)),
                    ),
                    SizedBox(height: 15.0),
                    Text('Test Center',style: TextStyle(fontSize: 16.0,color: Color(0xFF0d6898),fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.only(left : 10.0 ,top: 5.0),
                      child: Text(test_center,style: TextStyle(fontSize: 22.0,color: Colors.black87,fontWeight: FontWeight.bold,)),
                    ),
                    SizedBox(height: 15.0),
                    Text('Type Of Test',style: TextStyle(fontSize: 16.0,color: Color(0xFF0d6898),fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.only(left : 10.0 ,top: 5.0),
                      child: Text(type_of_test,style: TextStyle(fontSize: 22.0,color: Colors.black87,fontWeight: FontWeight.bold,)),
                    ),
                    SizedBox(height: 15.0),
                    Text('Fee',style: TextStyle(fontSize: 16.0,color: Color(0xFF0d6898),fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.only(left : 10.0 ,top: 5.0),
                      child: Text(test_fee,style: TextStyle(fontSize: 22.0,color: Colors.black87,fontWeight: FontWeight.bold,)),
                    ),
                    SizedBox(height: 15.0),
                    Text('Test Status',style: TextStyle(fontSize: 16.0,color: Color(0xFF0d6898),fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.only(left : 10.0 ,top: 5.0),
                      child: Text(test_status,style: TextStyle(fontSize: 22.0,color: Colors.black87,fontWeight: FontWeight.bold,)),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}