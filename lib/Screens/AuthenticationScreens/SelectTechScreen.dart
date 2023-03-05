import 'package:dev_connect/Model/TechModel.dart';
import 'package:dev_connect/Services/AuthServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SelectTechScreen extends StatefulWidget {
  const SelectTechScreen({super.key});

  @override
  State<SelectTechScreen> createState() => _SelectTechScreenState();
}

class _SelectTechScreenState extends State<SelectTechScreen> {
  // MARK: Function to get all tech on the platform for user to select

  List<Tech> _techs = [];
  List<String> _selectedTech = [];

  Future<void> _getAllTech() async {
    var techs = await AuthService().getAllTechs();

    print("$techs");

    if (techs != null) {
      setState(() {
        _techs = techs;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getAllTech();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("ihdwgs"),
    );
  }
}
