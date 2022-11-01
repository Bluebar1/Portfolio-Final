import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/constants/global_constants.dart';
import 'package:portfolio/utils.dart';
import 'package:provider/provider.dart';

import '../../responsive.dart';
import 'presentation/contact_state.dart';

class Contact extends StatelessWidget {
  static Page<void> builder(BuildContext context, GoRouterState state) {
    return CustomTransitionPage<void>(
        transitionDuration: Duration(milliseconds: 1000),
        key: state.pageKey,
        child: Provider<ContactData>(
          lazy: false,
          create: (BuildContext context) => ContactData(context),
          child: LayoutBuilder(builder: (context, constraints) {
            final resp = context.read<Responsive>();
            resp.screenSize = constraints;

            return const Contact();
          }),
        ),
        transitionsBuilder: (context, animation, _, child) {
          return ListenableProvider.value(
              builder: (context, _) => child, value: animation);
        });
  }

  const Contact();

  @override
  Widget build(BuildContext context) {
    final screenType = context.read<Responsive>().screenType;
    final pageAnimation = context.read<ContactData>().pageAnimation;
    return SlideTransition(
      position: pageAnimation,
      child: Scaffold(
          backgroundColor: SECONDARY,
          body: SafeArea(child: contactResponsiveMap[screenType]!)),
    );
  }
}

class ContactDesktop extends StatelessWidget {
  const ContactDesktop({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const ContactHeader(), const ContactBody()]),
    );
  }
}

class ContactBody extends StatelessWidget {
  const ContactBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Material(
        elevation: 30,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800, maxHeight: 600),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: Row(children: [
              Expanded(
                  child: Container(
                      color: Colors.redAccent, child: ContactIconButtons())),
              Expanded(flex: 2, child: ContactInfoArea()),
            ]),
          ),
        ),
      ),
    );
  }
}

class ContactTablet extends StatelessWidget {
  const ContactTablet({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(color: Colors.redAccent, child: ContactHeader()),
        Expanded(
            child: Row(
          children: [
            Expanded(child: ContactIconButtons()),
            Expanded(child: ContactInfoArea()),
          ],
        ))
      ]),
    );
  }
}

class ContactMobile extends StatelessWidget {
  const ContactMobile({super.key});
  @override
  Widget build(BuildContext context) {
    final maxHeight = context.read<Responsive>().maxHeight;
    return ListView(children: [
      Container(color: Colors.redAccent, child: ContactHeader()),
      Container(
        height: maxHeight - 100,
        child: Column(children: [
          Flexible(child: ContactInfoArea()),
          Flexible(child: ContactIconButtons()),
        ]),
      )
    ]);
  }
}

class ContactIconButtons extends StatelessWidget {
  const ContactIconButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenType = context.read<Responsive>().screenType;
    final _buttons = [
      Expanded(
        child: Column(
          children: [
            Text(
              'Github',
              style: kHeaderTextStyleDark,
            ),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    color: PRIMARY,
                    iconSize: 90,
                    icon: Icon(MyIcons.github),
                    onPressed: () => Utils.openLink(githubLink)),
              ),
            ),
          ],
        ),
      ),
      Expanded(
        child: Column(
          children: [
            Text(
              'LinkedIn',
              style: kHeaderTextStyleDark,
            ),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    color: PRIMARY,
                    iconSize: 100,
                    icon: FaIcon(FontAwesomeIcons.linkedin),
                    onPressed: () => Utils.openLink(linkedInLink)),
              ),
            ),
          ],
        ),
      ),
    ];
    return Container(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Center(
                  child: Text('LINKS',
                      style: kStatusTextStyle.copyWith(color: PRIMARY)))),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.topCenter,
              child: (screenType == ScreenType.desktop)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _buttons,
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _buttons),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactInfoArea extends StatelessWidget {
  const ContactInfoArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Center(child: Text('EMAIL', style: kStatusTextStyle))),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  SelectableText(email, style: kParagraphTextStyle),
                  kPaddingWidget,
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Copy to clipboard',
                                  style: kParagraphTextStyle),
                              IconButton(
                                  iconSize: 40,
                                  tooltip: 'Copy to clipboard',
                                  icon: Icon(Icons.copy),
                                  color: Colors.grey,
                                  onPressed: () => Clipboard.setData(
                                      ClipboardData(text: email))),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Open in mail app',
                                  style: kParagraphTextStyle),
                              IconButton(
                                  iconSize: 40,
                                  tooltip: 'Open mail',
                                  icon: Icon(Icons.mail),
                                  color: Colors.grey,
                                  onPressed: () => Utils.openLink(mailtoLink)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactRedArea extends StatelessWidget {
  const ContactRedArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
        ));
  }
}

class ContactHeader extends StatelessWidget {
  const ContactHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SlideTransition(
        position: context.read<ContactData>().headerTextPosition,
        child: SizedBox(
          height: 100,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'CONTACT',
              style: NameTextStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 90,
                color: PRIMARY,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(5.0, 5.0),
                    blurRadius: 3.0,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
