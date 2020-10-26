
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:driving_test_scheduler/screens/default_available_test_times.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AllAvailableTestCenters extends StatefulWidget {
  final String testCenture;


  AllAvailableTestCenters({this.testCenture});

  @override
  _AllAvailableTestCentersState createState() => _AllAvailableTestCentersState(testCenture:testCenture);
}

class _AllAvailableTestCentersState extends State<AllAvailableTestCenters>with SingleTickerProviderStateMixin {

  final String testCenture;
  var tc;

  _AllAvailableTestCentersState({this.testCenture});

  TabController _tabController;
  List<Tab>tabs=<Tab>[
    Tab(text: "Cardington",)
  ];
  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('test_centure');
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Color(0xFF094869),
          title: Text('Available Test Times',style: TextStyle(color: Colors.white,fontSize: 20.0),),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
          bottom: new TabBar(
            unselectedLabelStyle: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
            isScrollable: true,
            labelColor: Colors.white,
            labelStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: new BubbleTabIndicator(
              indicatorHeight: 30.0,
              indicatorColor: Colors.white30,
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
            ),
            tabs: tabs,
            controller: _tabController,
          ),
        ),
        body:TabBarView(
          controller: _tabController,
          children: <Widget>[
            //SizedBox(height: 10),
            DefaultAvailableTestTimes(),
           // SecondAvailableTestTimes(),
            //ThirdAvailableTestTimes()
          ],
        )
    );
  }
}
