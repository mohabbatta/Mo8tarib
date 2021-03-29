import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/dashboard/property/add_property.dart';
import 'package:mo8tarib/app/Screen/dashboard/property/pending_proprty.dart';
import 'package:mo8tarib/app/bloc/navigation_bloc.dart';

import 'package:mo8tarib/constants/global.dart';

class MyProperty extends StatefulWidget with NavigationStates {
  final Function onMenuTap;

  const MyProperty({Key key, this.onMenuTap}) : super(key: key);

  @override
  _MyPropertyState createState() => _MyPropertyState();
}

class _MyPropertyState extends State<MyProperty>
    with SingleTickerProviderStateMixin {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      decoration: BoxDecoration(
//        //borderRadius: BorderRadius.all(Radius.circular(30)),
//        color: Colors.deepOrange,
//      ),
//      child: Center(
//        child: IconButton(
//          icon: Icon(
//            Icons.menu,
//            size: 30,
//            color: foregroundColor,
//          ),
//          onPressed: widget.onMenuTap,
//        ),
//      ),
//    );
//  }
//}
  List<Widget> containers = [AddProperty.create(), PendingProperty()];

  final List<Tab> tabs = <Tab>[
    new Tab(text: "Add Property"),
    new Tab(text: "Pending Property"),
  ];

  TabController _tabController;

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
        centerTitle: true,
        title: Text(
          "Moغtrab",
          style: TextStyle(
            color: foregroundColor,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            size: 30,
            color: foregroundColor,
          ),
          onPressed: widget.onMenuTap,
        ),
        bottom: new TabBar(
          isScrollable: true,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: new BubbleTabIndicator(
            indicatorHeight: 40,
            indicatorColor: foregroundColor,
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
          ),
          tabs: tabs,
          controller: _tabController,
        ),
      ),
      body: new TabBarView(controller: _tabController, children: containers),
    );
  }
}
