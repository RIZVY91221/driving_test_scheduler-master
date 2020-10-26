import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  Notifications() : super();

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: iconYellow,
          title: Text("Notifications"),
          centerTitle: true,
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              SizedBox(height: 8.0),
              AvailableTime(),
            ],
          ),
        ));
  }
}

class AvailableTime extends StatelessWidget {
  const AvailableTime({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //SizedBox(height: 10.0),
          CustomCard('08:10 AM', 'Tuesday 25 April 2020', Colors.amberAccent,
              '25', 'December', '12'),
          CustomCard('09:10 AM', 'Tuesday 26 April 2020', Colors.amberAccent,
              '26', 'April', '22'),
          CustomCard('09:10 AM', 'Tuesday 26 April 2020', Colors.amberAccent,
              '26', 'Novemver', '23'),
          CustomCard('08:10 AM', 'Tuesday 25 April 2020', Colors.amberAccent,
              '25', 'december', '12'),
          CustomCard('09:10 AM', 'Tuesday 26 April 2020', Colors.amberAccent,
              '26', 'April', '22'),
          CustomCard('09:10 AM', 'Tuesday 26 April 2020', Colors.amberAccent,
              '26', 'April', '23'),
          CustomCard('08:10 AM', 'Tuesday 25 April 2020', Colors.amberAccent,
              '25', 'december', '12'),
          CustomCard('09:10 AM', 'Tuesday 26 April 2020', Colors.amberAccent,
              '26', 'April', '22'),
          CustomCard('09:10 AM', 'Tuesday 26 April 2020', Colors.amberAccent,
              '26', 'April', '23'),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  String posttime;
  String time;
  String day;
  Color color;
  String date;
  String month;

  CustomCard(this.time, this.day, this.color, this.date, this.month,
      [this.posttime]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2,right: 2,bottom: 3,top: 3),
      child: Container(
        //color: Colors.blueAccent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:2.0),
                child: Container(child:
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Color(0xFF0d6898),
                      child: Padding(
                        padding: const EdgeInsets.only(top:10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                date,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                month,
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                      ),
                    ),
                ),
              ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left:15.0),
                      child: Container(
                          //color: Colors.grey,
                          width: MediaQuery.of(context).size.width*0.70,
                          //height:40,
                          child: Text(
                            day + ' ' + time + ' time is available',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                            maxLines: 3,

                          ),
                        //child: Text(posttime + ' hr ago')
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          //color: color,
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Padding(
                          padding: const EdgeInsets.only(left:15.0),
                          child: Text(posttime + ' hr ago',style: TextStyle(color: Colors.grey),)),
                    ),
                  ],
                ),
            ],
          ),
      ),
    );
  }
}
