import 'package:dev_connect/Screens/TabScreens/ExploreTabContent/ExploreTab.dart';
import 'package:dev_connect/Screens/TabScreens/FavouriteTabContent/FavouriteTab.dart';
import 'package:dev_connect/Screens/TabScreens/HomeTabContent/HomeTab.dart';
import 'package:dev_connect/Screens/TabScreens/ProjectsTabContent/ProjectTab.dart';
import 'package:dev_connect/Screens/UserAccountScreens/AccountDetailsScreen.dart';
import 'package:dev_connect/Services/UserServices.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int _selectedIndex = 0;

  // MARK: Function to get user data from the backend based on the access token and store it in the local storage
  Future<void> getUserData() async {
    final SharedPreferences prefs = await _prefs;

    var userDataResponse = await UserServices()
        .getUserData(await prefs.getString('token').toString());

    if (userDataResponse != null) {
      List<String> intrestList = [];
      List<String> projectList = [];

      for (var intrest in userDataResponse.interest!) {
        intrestList.add(intrest.toString());
      }

      for (var project in userDataResponse.projects!) {
        projectList.add(project);
      }
// user data saved here

      await prefs.setString('firstName', userDataResponse.firstName);
      await prefs.setString('lastName', userDataResponse.lastName);
      await prefs.setString('email', userDataResponse.email);
      await prefs.setString('location', userDataResponse.location ?? "");
      await prefs.setString('img', userDataResponse.img ?? "");
      await prefs.setStringList('interests', intrestList);
      await prefs.setStringList('projects', projectList);
      await prefs.setString(
          'tech', const JsonEncoder().convert(userDataResponse.tech));
      await prefs.setString(
          'createdAt', userDataResponse.createdAt!.toIso8601String());
      await prefs.setString(
          'updatedAt', userDataResponse.updatedAt!.toIso8601String());
    }
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
// List of tabs
  static const List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    FavouriteTab(),
    ExploreTab(),
    ProjectTab()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> logoutUser() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.clear();
  }

  @override
  void initState() {
    // this function loads the user data from backend into the localStorage
    getUserData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 56),
          child: Column(
            children: [
              Padding(
                //Custom Top Bar
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Hero(
                      tag: "logo",
                      child: Material(
                        type: MaterialType.transparency,
                        child: Row(
                          children: const [
                            Image(
                              image: AssetImage(
                                  "assets/images/devconnect-logo.png"),
                              height: 40,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Dev Connect",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AccountDetailsScreen()));
                      },
                      icon: const Icon(
                        Icons.person,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [_widgetOptions.elementAt(_selectedIndex)],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.yellowAccent,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.code),
              label: 'Projects',
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.teal,
          enableFeedback: true,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
