import 'package:flutter/material.dart';
import '../admin_screens.dart/admin_chat_screen.dart';
import '../admin_screens.dart/admin_edit_del_post_screen.dart';
import '../admin_screens.dart/admin_post_permission_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  static final String route = '/Admin';
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen>
    with SingleTickerProviderStateMixin {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  TabController _tabController;

  static final  _kTabPages = <Widget>[
    
    AdminEditDelPost(),
    AdminPostPermission(),
    AdminChat(),
  ];

  static const _kTabs = <Tab>[
    Tab(
      icon: Icon(Icons.cloud),
      text: 'All Posts',
    ),
    Tab(
      icon: Icon(Icons.notifications_active),
      text: 'Pending Posts',
    ),
    Tab(
      icon: Icon(Icons.forum),
      text: 'Chats',
    ),
  ];

  @override
  initState() {
    _tabController = TabController(length: _kTabPages.length, vsync: this,initialIndex: 1);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(),
      body: TabBarView(
        children: _kTabPages,
        controller: _tabController,
      ),
      bottomNavigationBar: Material(
        color: Colors.blue,
        child: TabBar(
          tabs: _kTabs,
          controller: _tabController,
        ),
      ),
    );
  }
}
