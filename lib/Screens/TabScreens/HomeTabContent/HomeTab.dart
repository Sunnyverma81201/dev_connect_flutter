import 'dart:async';

import 'package:dev_connect/Model/LoginModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var _token;

  void _loadData() async {
    SharedPreferences prefs = await _prefs;
    setState(() {
      _token = prefs.getString('email');
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Center(child: Text(_token ?? '')),
    );
  }
}
