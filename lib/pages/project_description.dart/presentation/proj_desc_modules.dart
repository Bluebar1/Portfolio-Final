import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_constants.dart';
import '../../../constants/proj_desc_constants.dart';
import '../../../utils.dart';
import '../../projects/domain/project_model.dart';
import '../../projects/presentation/projects_modules.dart';
import 'proj_desc_state.dart';

class MarkdownData extends StatelessWidget {
  const MarkdownData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? data =
        context.select((ProjDescState p) => p.project.readmeText);

    return data != null
        ? ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1000),
            child: Markdown(
              data: data,
              onTapLink: (_, link, __) => Utils.openLink(link!),
              styleSheet:
                  MarkdownStyleSheet.fromTheme(ProjDescThemeData.mdTheme),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            ),
          )
        : Padding(
            padding: EdgeInsets.only(top: 100),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}

class AnimatedOpacityImageOverlay extends StatelessWidget {
  final Project project;
  final double height;

  const AnimatedOpacityImageOverlay(
      {super.key, required this.project, required this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: 130,
                decoration: BoxDecoration(
                    gradient: ProjDescThemeData.projDescImageCoverGradient),
                child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: kMaxForegroundWidth),
                    child: Center(
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Text(project.title!,
                                              style: kStatusTextStyle),
                                        ),
                                      ),
                                      IconButton(
                                          padding: EdgeInsets.all(10),
                                          color: SECONDARY_LIGHTER,
                                          iconSize: 40,
                                          icon: Icon(MyIcons.github),
                                          tooltip: 'View on Github',
                                          onPressed: () => Utils.openLink(
                                              project.githubLink!))
                                    ],
                                  ),
                                  TechUsedGrid(project),
                                ])))))));
  }
}

class ProjDescAppBar extends StatelessWidget {
  final Project project;

  const ProjDescAppBar({super.key, required this.project});
  @override
  Widget build(BuildContext context) {
    bool isShowingAppBar =
        context.select((ProjDescState p) => p.isShowingAppBar);

    var fadeIn = FadeTransition(
      opacity: context.read<Animation<double>>(),
      child: Container(
          height: 70,
          color: PRIMARY,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(project.title!, style: kStatusTextStyle),
            ],
          )),
    );
    return (isShowingAppBar)
        ? Align(alignment: Alignment.topCenter, child: fadeIn)
        : Container();
  }
}
