import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../app_state.dart';
import '../../../constants/global_constants.dart';
import '../../../route.dart';
import '../domain/project_model.dart';
import 'projects_modules.dart';

@immutable
class ProjectTile extends StatefulWidget {
  final Project project;
  final int index;

  const ProjectTile({super.key, required this.project, required this.index});

  @override
  State<ProjectTile> createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> {
  Project get project => widget.project;
  Image? image;
  @override
  void initState() {
    super.initState();
    image = Image.asset('img/${project.imgPath}');
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.project.title.toString(),
      child: ProjectGridTile(
        project: widget.project,
        type: GridType.small,
      ),
    );
  }
}

enum GridType { small, large }

class ProjectGridTile extends StatelessWidget {
  final Project project;
  final GridType type;

  ProjectGridTile({
    Key? key,
    required this.project,
    required this.type,
  }) : super(key: key);

  // _height(ScreenType type) => {
  //   ScreenType.desktop:
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: type == GridType.small ? 200 : double.infinity,
      // width: (context.read<Responsive>().screenType == ScreenType.desktop)
      //     ? 200
      //     : double.infinity,
      child: Stack(children: [
        if (type == GridType.small) _backgroundShadow(),
        Align(alignment: Alignment.bottomCenter, child: _image()),
        if (type == GridType.small)
          _foreground(context)
        else
          _largeForeground(context),
      ]),
    );
  }

  Widget _backgroundShadow() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(3)),
        boxShadow: [
          BoxShadow(
              spreadRadius: 2,
              color: Color.fromRGBO(0, 0, 0, .6),
              blurRadius: 2,
              offset: Offset(6.0, 5.0))
        ],
      ),
    );
  }

  Widget _image() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            image: DecorationImage(
                fit: BoxFit.cover, image: project.image!.image)));
  }

  Widget _largeForeground(BuildContext context) {
    return Container();
  }

  Widget _foreground(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: PRIMARY, width: 3),
      ),
      child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: SECONDARY,
            padding: EdgeInsets.zero,
            textStyle: FilterMenuStyle,
          ),
          onPressed: () {
            // context.read<ProjDescState>().load(project);
            context.read<AppState>().selectedProject = project;
            context.pushNamed(projectDetailsRouteName,
                params: {'project': project.title!});
          },
          child: Column(
            children: [
              Container(
                color: PRIMARY,
                height: 50,
                width: double.infinity,
                child: Center(
                  child: Text(
                    project.title!,
                    style: DegreeTextStyle.copyWith(color: SECONDARY),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              TechUsedGrid(project),
              // Text(proj.details)
            ],
          )),
    );
  }
}
