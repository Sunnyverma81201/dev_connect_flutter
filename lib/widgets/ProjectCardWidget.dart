import 'package:dev_connect/Model/ProjectModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({Key? key, required this.projectModel}) : super(key: key);

  final ProjectModel projectModel;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(5),
      decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          Row(
            children: [
              Text(widget.projectModel.name),
            ],
          ),
        ],
      ),
    );
  }
}
