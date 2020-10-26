import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:url_launcher/url_launcher.dart';


class  ThirdAvailableTestTimes extends StatefulWidget {

  ThirdAvailableTestTimes() : super();

  @override
  _ThirdAvailableTestTimesState createState() => _ThirdAvailableTestTimesState();
}

class _ThirdAvailableTestTimesState extends State<ThirdAvailableTestTimes> {
  List availabeTest=[
    availableModel('08:10 AM','Tuesday 25 April 2020','25','January','Non Refundable'),
    availableModel('09:10 AM','Tuesday 26 April 2020','26','Februrary','Non Refundable'),
    availableModel('10:10 AM','Tuesday 27 April 2020','27','March','Non Refundable'),
    availableModel('08:10 AM','Tuesday 28 April 2020','28','April'),
    availableModel('08:10 AM','Tuesday 29 April 2020','29','May'),
    availableModel('08:10 AM','Tuesday 25 April 2020','25','June','Non Refundable'),
    availableModel('09:10 AM','Tuesday 26 April 2020','26','july','Non Refundable'),
    availableModel('10:10 AM','Tuesday 27 April 2020','27','August','Non Refundable'),
    availableModel('08:10 AM','Tuesday 28 December 2020','28','December','non Refundable'),
    availableModel('08:10 AM','Tuesday 29 April 2020','29','September'),
    availableModel('08:10 AM','wednesday 25 november 2020','25','November','Non Refundable'),
    availableModel('09:10 AM','Tuesday 26 April 2020','26','October','Non Refundable'),
    availableModel('08:10 AM','Tuesday 29 April 2020','29','April'),
  ];

  _launchURL() async {
    const url = 'https://driverpracticaltest.dvsa.gov.uk/login';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          // backgroundColor: iconYellow,
//          title: Text("Available Test Times"),
//          centerTitle: true,
//        ),
        body: Container(
          child: ListView.builder(
              itemCount: availabeTest.length,
              itemBuilder:(context,index) {
                return listTileTimeTest(context, index);
              }
          ),
        )
    );
  }

  Widget listTileTimeTest(BuildContext context,int index){
    return Padding(
      padding: const EdgeInsets.only(bottom: 2,top:2),
      child: Container(
          color: Color(0xFFB5C8D2),
          //height: 200,
          //child: Card(
          // elevation: 5.5,
          child:ListTile(
            leading: Container(
              //height: 200,
                width: 90,
                //color: Colors.grey,
                decoration: BoxDecoration(color: Colors.black54,
                    borderRadius: BorderRadius.circular(5.0)
                ),

                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0,left: 5,right: 5,bottom: 5),
                  child: Column(children: <Widget>[
                    Text(availabeTest[index].date,style: TextStyle(fontSize: 22.0,color: Colors.white,fontWeight: FontWeight.bold),),
                    Text(availabeTest[index].month,style: TextStyle(fontSize: 14.0,color: Colors.white,fontWeight: FontWeight.bold),),
                  ],
                  ),
                )
            ),
            title:Container(
              //color: Colors.grey,

              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(availabeTest[index].time,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25),
                    ),
                    Container(
                      //color: Colors.grey,
                        child: Text(availabeTest[index].day,style: TextStyle(color: Colors.black,fontSize: 14),)
                    ),
                    fundAlert(availabeTest[index].alart_box,index)
                  ],
                ),
              ),
            ),
            trailing: Container(
              decoration: BoxDecoration(color: Color(0xFF0d6898),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [new BoxShadow(color: Colors.black, blurRadius: 10.0,),]
              ),

              //color: Colors.blue,
              child: Padding(padding: const EdgeInsets.only(top: 10.0,left: 15,right: 15,bottom: 10),
                child: InkWell(
                  onTap: () {dialog(context, index);
                  },


                  child: Column(
                    children: <Widget>[
                      Text('BOOK',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),
                      Text('NOW',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),

                    ],
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }
  Widget fundAlert(String alertvalue,int index){
    if(availabeTest[index].alart_box==null){
      return Text("");
    }
    else{
      return  Container(
        decoration: BoxDecoration(
            color:Colors.amberAccent,
            borderRadius: BorderRadius.circular(4.0)),
        child: Padding(
            padding: const EdgeInsets.all(2.0),
            child:
            Text(alertvalue,style: TextStyle(fontSize: 10),)
        ),
      );
    }
  }
  Widget dialog(BuildContext context,int index){
    showDialog(
        context: context,builder: (_) => AssetGiffyDialog(
      image: Image.asset(
        'assets/yes.gif',
        fit: BoxFit.cover,
      ),
      title: Text(availabeTest[index].time,
        style: TextStyle(
            fontSize: 40.0, fontWeight: FontWeight.w800),
      ),
      description: Text(availabeTest[index].day,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
      entryAnimation: EntryAnimation.RIGHT,
      buttonCancelColor: Colors.red.shade400,
      onOkButtonPressed: () {_launchURL();},
      onCancelButtonPressed: () {Navigator.of(context).pop();},
    ) );
  }
}
class availableModel{
  String alart_box;
  String time;
  String day;
  String date;
  String month;
  availableModel(this.time,this.day,this.date,this.month,[this.alart_box]);
}
