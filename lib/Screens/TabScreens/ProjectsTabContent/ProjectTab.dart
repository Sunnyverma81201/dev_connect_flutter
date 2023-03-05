import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProjectTab extends StatefulWidget {
  const ProjectTab({super.key});

  @override
  State<ProjectTab> createState() => _ProjectTabState();
}

class _ProjectTabState extends State<ProjectTab> {
  Future<void> _getProjects() async {
    // var projectsData = await
  }

  @override
  void initState() {
    super.initState();
    _getProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
