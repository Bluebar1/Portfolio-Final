import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../responsive.dart';
import 'contact_modules.dart';

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
