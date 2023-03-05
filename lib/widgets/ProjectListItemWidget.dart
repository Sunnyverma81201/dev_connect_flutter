import 'package:dev_connect/Model/ProjectModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProjectListItem extends StatefulWidget {
  final ProjectModel projectModel;

  const ProjectListItem({Key? key, required this.projectModel})
      : super(key: key);

  @override
  State<ProjectListItem> createState() => _ProjectListItemState();
}

class _ProjectListItemState extends State<ProjectListItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(70, 70, 70, 0.302),
                blurRadius: 4.0,
                spreadRadius: 0.1,
              ),
            ],
          ),
          child: Column(
              // Row()
              ),
        )
      ],
    );
  }
}
