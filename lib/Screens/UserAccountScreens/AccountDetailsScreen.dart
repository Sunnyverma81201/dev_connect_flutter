import 'dart:convert';
import 'dart:io';

import 'package:dev_connect/Model/ProjectModel.dart';
import 'package:dev_connect/Model/TechModel.dart';
import 'package:dev_connect/Model/UserModel.dart';
import 'package:dev_connect/Screens/AuthenticationScreens/LoginScreen.dart';
import 'package:dev_connect/Services/UserServices.dart';
import 'package:dev_connect/widgets/ProjectCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool _isLoading = true;

  var _firstName, _lastName, _email, _location, _img;
  List<String>? _interests = [];
  List<ProjectModel>? _projects = [];
  List<Tech> _techs = [];
  DateTime _createdAt = DateTime.now(), _updatedAt = DateTime.now();

// Logout User Function
  Future<bool> logoutUser() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.clear();
  }

  // MARK: Function to get user data from the backend based on the access token and store it in the local storage
  Future<void> _getUserData() async {
    final SharedPreferences prefs = await _prefs;

    var projectsData = await UserServices()
        .getUserProjects(prefs.getString('token').toString());

    setState(() {
      _firstName = prefs.getString('firstName');
      _lastName = prefs.getString('lastName');
      _email = prefs.getString('email');
      _location = prefs.getString('location');
      _img = prefs.getString('img');
      _interests = prefs.getStringList('interests');
      // _projects
      _projects = projectsData!;
      // _techs
      for (var tech in JsonDecoder().convert(prefs.getString('tech')!)) {
        _techs.add(
            Tech(name: tech['name'], score: tech['score'], id: tech['id']));
      }
      _createdAt = DateTime.parse(prefs.getString('createdAt')!);
      _updatedAt = DateTime.parse(prefs.getString('updatedAt')!);
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 56),
        child: Column(
          children: [
            Padding(
              //Custom Top Bar
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                  Hero(
                    tag: "logo",
                    child: Material(
                      type: MaterialType.transparency,
                      child: Row(
                        children: const [
                          Image(
                            image:
                                AssetImage("assets/images/devconnect-logo.png"),
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
                  TextButton(
                      onPressed: () async {
                        if (await logoutUser()) {
                          print("Logout successful");
                        }
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (Route route) => false);
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.power_settings_new),
                          SizedBox(
                            width: 2,
                          ),
                          Text("Logout"),
                        ],
                      ))
                ],
              ),
            ),

            // page Body starts here
            Column(
              children: [
                // Basic details
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _isLoading
                        ? []
                        : [
                            CircleAvatar(
                              radius: 40,
                              child: Text(
                                "${_firstName.substring(0, 1)}${_lastName.substring(0, 1)}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$_firstName $_lastName",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text("$_location",
                                    style: const TextStyle(fontSize: 12))
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                  size: 20,
                                ))
                          ],
                  ),
                ),

                // Account details
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Row(
                        children: [Text(_email ?? "")],
                      ),
                      Row(
                        children: [
                          Text(
                              "User since ${_createdAt.month} ${_createdAt.year}"),
                        ],
                      )
                    ],
                  ),
                ),

                // Techs followed by user
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        children: [
                          // Tech Section Header
                          Row(children: [
                            const Text(
                              "Tech",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.more_horiz)),
                          ]),
                          // Tech Section Body
                          Wrap(
                            spacing: 4,
                            runSpacing: 4,
                            children: _techs != null
                                ? _techs.isNotEmpty
                                    ? List.generate(_techs.length, (tech) {
                                        return Chip(
                                          label: Text(_techs[tech].name),
                                          avatar: Text(
                                              _techs[tech].score.toString()),
                                        );
                                      })
                                    : [
                                        const Center(
                                            child: Text(
                                          "You have not shown interest in any tech yet",
                                        ))
                                      ]
                                : [
                                    const Center(
                                        child:
                                            Text("Unable to Fetch Interests"))
                                  ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        children: [
                          // Projects Section Header
                          Row(children: [
                            const Text(
                              "Projects",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.more_horiz)),
                          ]),
                          // Project Section Body
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: _projects != null
                                    ? _projects!.isNotEmpty
                                        ? List.generate(_projects!.length,
                                            (project) {
                                            return ProjectCard(
                                                projectModel:
                                                    _projects![project]);
                                          })
                                        : [
                                            const Center(
                                                child: Text(
                                              "No Projects created or joined yet",
                                            ))
                                          ]
                                    : [
                                        const Center(
                                            child: Text(
                                                "Unable to Fetch Projects"))
                                      ],
                              ))
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
