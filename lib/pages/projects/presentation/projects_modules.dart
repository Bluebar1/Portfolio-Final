import 'package:flutter/material.dart';
import 'package:portfolio/pages/projects/presentation/project_tile.dart';

import 'package:portfolio/pages/projects/presentation/projects_state.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_constants.dart';
import '../domain/project_model.dart';
import '../../../constants/projects_constants.dart';

class ProjectsIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100, right: 15, left: 15),
      child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            'Software Engineer Portfolio',
            style: kStatusTextStyle,
            textAlign: TextAlign.left,
          ),
        ),
        Text(
          SUMMARY,
          style: kParagraphTextStyle,
          textAlign: TextAlign.left,
        )
      ])),
    );
  }
}

class MostUsedTech extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _techIcon(MyIcons.java, "Java"),
        _techIcon(MyIcons.python, "Python"),
        _techIconImage()
      ],
    );
  }

  Widget _techIcon(IconData icon, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(children: [
        Icon(icon, size: 35, color: SECONDARY),
        Text(
          name,
          style: LanguageTextStyle,
        )
      ]),
    );
  }

  Widget _techIconImage() {
    return Image.asset(
      "img/dart.png",
      height: 100,
      width: 100,
      filterQuality: FilterQuality.high,
      isAntiAlias: true,
      color: SECONDARY,
    );
  }
}

class FilterMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pfp = context.read<ProjectsState>();
    List<String> _filters =
        context.select((ProjectsState pfp) => pfp.allTechUsed);

    int filterIndex = context.select((ProjectsState pfp) => pfp.filterIndex);

    return Padding(
      padding: const EdgeInsets.only(right: 7, left: 7),
      child: Align(
        alignment: Alignment.topLeft,
        child: Wrap(
            children: List.generate(
                _filters.length,
                (index) => Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                      child: Container(
                        height: 25,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 1.5,
                                color: Color.fromRGBO(0, 0, 0, .4),
                                blurRadius: 1,
                                offset: Offset(2.0, 2.0))
                          ],
                          border: Border.all(
                              color:
                                  (filterIndex == index) ? SECONDARY : PRIMARY,
                              width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: TextButton(
                            onPressed: () {
                              _pfp.applyFilter(index);
                            },
                            style: TextButton.styleFrom(
                              animationDuration: Duration(milliseconds: 1),
                              padding: EdgeInsets.all(3),
                              elevation: 10.0,
                              backgroundColor: PRIMARY,
                            ),
                            child: Container(
                                child: Text(
                              _pfp.allTechUsed[index],
                              style: FilterMenuStyle,
                            ))),
                      ),
                    ))),
      ),
    );
  }
}

class CurrentlyShowing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _pfp = context.read<ProjectsState>();
    var _filterIndex = context.select((ProjectsState pfp) => pfp.filterIndex);

    String _plural = (_pfp.filteredProjects.length == 1) ? '' : 's';

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
          padding:
              const EdgeInsets.only(top: 10, right: 15, left: 15, bottom: 10),
          child: (_filterIndex == 0)
              ? Text(
                  'Showing all Projects. Use the filter to list them by technology.',
                  textAlign: TextAlign.left,
                  style: kParagraphTextStyle)
              : RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                      text: 'Showing ',
                      style: kParagraphTextStyle,
                      children: [
                        TextSpan(
                            text: _pfp.filteredProjects.length.toString(),
                            style: ParagraphBoldTextStyle),
                        TextSpan(
                            text: ' project$_plural filtered by ',
                            style: kParagraphTextStyle),
                        TextSpan(
                            text: _pfp.label, style: ParagraphBoldTextStyle),
                      ]),
                )),
    );
  }
}

/// Listen for changes to [filteredProjects].
/// To re-animate the grid, [filteredProjects] is emptied then filled with
/// the correct projects, triggering a rebuild both times.
class ProjectsGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    context.select((ProjectsState pfp) => pfp.filteredProjects.length);

    var _pfp = context.read<ProjectsState>();
    return ConstrainedBox(
        constraints: BoxConstraints(minHeight: size.height),
        child: Align(
          alignment: Alignment.topLeft,
          child: CustomScrollView(
            shrinkWrap: true,
            primary: false,
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverGrid.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 1,
                  children:
                      List.generate(_pfp.filteredProjects.length, (index) {
                    return Hero(
                      tag: _pfp.filteredProjects[index].title.toString(),
                      child: ProjectGridTile(
                        project: _pfp.filteredProjects[index],
                        type: GridType.small,
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ));
  }
}

class TechUsedGrid extends StatelessWidget {
  final Project project;

  TechUsedGrid(this.project);

  @override
  Widget build(BuildContext context) {
    List<dynamic> techUsed = project.technologyUsed!;
    return Wrap(
        alignment: WrapAlignment.center,
        direction: Axis.horizontal,
        children: List.generate(
            techUsed.length,
            (index) => Padding(
                  padding: const EdgeInsets.only(
                      bottom: 2, top: 2, left: 2, right: 2),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: SECONDARY, width: 1),
                        color: PRIMARY,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3, right: 3),
                        child: Text(
                          techUsed[index],
                          style: FilterMenuStyle,
                        ),
                      )),
                )));
  }
}
