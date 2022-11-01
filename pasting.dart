// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:portfolio/models/project.dart';
// import 'package:portfolio/providers/background_provider.dart';
// import 'package:portfolio/style/style.dart';
// import 'package:provider/provider.dart';

// class FilterMenu extends StatefulWidget {
//   // FilterMenu();

//   // Widget _button(Project data) {
//   //   return
//   // }
//   @override
//   _FilterMenu createState() => _FilterMenu();
// }

// class _FilterMenu extends State<FilterMenu>
//     with SingleTickerProviderStateMixin {
//   Animation<double> animation;
//   AnimationController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller =
//         AnimationController(duration: Duration(seconds: 2), vsync: this);
//     animation = Tween<double>(begin: 0.0, end: 1.0)
//         .animate(CurvedAnimation(curve: Curves.linear, parent: controller));
//     animation.addListener(() {
//       setState(() {
//         // if (controller.value > .01) controller.stop();
//       });
//     });
//     print('starting delay');
//     Future.delayed(Duration(seconds: 1), () {
//       print('delay done');
//       controller.forward();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     // var bgp = Provider.of<BackGroundProvider>(context);
//     print('REBUILDING FILTER MENU TREEE');
//     double w = size.width;
//     int _itemCount = (w / 120).ceil();
//     if (_itemCount > 7) _itemCount = 7;
//     // const wc = w.toCon();
//     var h = size.height;
//     int counter = 0;
//     int _filterIndex = 0;
//     var bgp = context.read<BackGroundProvider>();
//     return ListView.builder(
//         shrinkWrap: true,
//         itemCount: (bgp.allTechUsed.length / _itemCount).ceil(),
//         physics: NeverScrollableScrollPhysics(),

//         // itemCount: 3,
//         itemBuilder: (BuildContext context, int index1) {
//           return SizedBox(
//             height: 35,
//             child: ListView.builder(
//                 physics: NeverScrollableScrollPhysics(),
//                 scrollDirection: Axis.horizontal,
//                 shrinkWrap: true,
//                 itemCount: (bgp.allTechUsed.length - counter < _itemCount)
//                     ? bgp.allTechUsed.length - counter
//                     : _itemCount, //bgp.allTechUsed.length,
//                 // itemCount: 5,
//                 itemBuilder: (BuildContext context, int index2) {
//                   int _CI = ((index1 * _itemCount) + index2);
//                   double _CV;
//                   if (_CI == 0 && controller.value == 0)
//                     _CV = 0.0;
//                   else if (_CI == 0)
//                     _CV = 1;
//                   else
//                     _CV = (controller.value / _CI) * 20;

//                   // double fixed = _CV;
//                   if (_CV >= 1) _CV = 1.0;
//                   if (_CV <= 0 || _CV == null) _CV = 0.0;
//                   print(_CV);

//                   return
//                       // FilterButton(bgp, counter++);
//                       Opacity(
//                     opacity: _CV,
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(0, 0, 8, 15),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           boxShadow: [
//                             BoxShadow(
//                                 spreadRadius: 1.5,
//                                 color: Color.fromRGBO(0, 0, 0, .2),
//                                 blurRadius: 1,
//                                 offset: Offset(2.0, 2.0))
//                           ],
//                           border: Border.all(
//                               color: (bgp.filterIndex == counter)
//                                   ? Theme.of(context).colorScheme.secondary
//                                   : Theme.of(context).colorScheme.primary,
//                               width: 1),
//                           borderRadius: BorderRadius.all(Radius.circular(3)),
//                         ),
//                         child: TextButton(
//                             onPressed: () {
//                               int _ind = (index1 * _itemCount) + index2;
//                               // _filterIndex = _ind;
//                               bgp.applyFilter(_ind);
//                             },
//                             style: TextButton.styleFrom(
//                                 animationDuration: Duration(milliseconds: 1),
//                                 padding: EdgeInsets.all(3),
//                                 fixedSize: Size.fromHeight(20),
//                                 // shadowColor: Colors.black,
//                                 elevation: 10.0,
//                                 backgroundColor:
//                                     Theme.of(context).colorScheme.primary,
//                                 textStyle: Theme.of(context)
//                                     .textTheme
//                                     .button
//                                     .copyWith(
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .secondary
//                                             .withOpacity(.5))),
//                             child: Container(
//                                 height: 20,
//                                 child: Stack(
//                                   // fit: StackFit.expand,
//                                   children: [
//                                     Text(
//                                       bgp.allTechUsed[counter],
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .button
//                                           .copyWith(
//                                               fontSize: Utils.fontsize(
//                                                   w,
//                                                   Theme.of(context)
//                                                       .textTheme
//                                                       .button
//                                                       .fontSize),
//                                               color: Theme.of(context)
//                                                   .colorScheme
//                                                   .secondary
//                                                   .withOpacity(.7)),
//                                     ),
//                                     Positioned(
//                                       top: 0,
//                                       child: Container(
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .secondary
//                                             .withOpacity(.1),
//                                         height: 10,
//                                         width:
//                                             bgp.allTechUsed[counter++].length *
//                                                     8.0 +
//                                                 10,
//                                       ),
//                                     )
//                                   ],
//                                 ))),
//                       ),
//                     ),
//                   );
//                 }),
//           );
//         });
//   }
// }
// //  FadeIn(
// //                     // delay: (((index1 * _itemCount) + index2) * 120) + 3000,
// //                     delay: 3000,
// //                     duration: ((index1 * _itemCount) + index2) * 120,
// //                     curve: Curves.easeInCirc,

// Widget _desktop(BuildContext context) {
//   print('DESKTOP');
//   // bgp.setPageController();
//   ScrollController _cont = ScrollController();
//   Size size = MediaQuery.of(context).size;

//   BackGroundProvider bgp = context.read<BackGroundProvider>();
//   // bgp.setPageController();
//   // var bgp = Provider.of<BackGroundProvider>(context);

//   return Stack(
//     children: [
//       // AnimatedOpacity(opacity: opacity, duration: duration),
//       BackGround(),
//       SmoothScrollWeb(
//         scrollSpeed: 150,
//         scrollAnimationLength: 150,
//         controller: bgp.controller,
//         child: SizedBox(
//           height: size.height,
//           width: size.width,
//           child: NotificationListener(
//             onNotification: (t) {
//               // if (t is Scroll)
//               print('ttttt');
//               // final ScrollDirection direction = t.direction;
//               // print('direction' + direction.toString());

//               if (t is ScrollStartNotification) {
//                 print(t.dragDetails.toString());

//                 bgp.setOffset(t.metrics.pixels);
//                 return true;
//                 // bgp.setOffset(t.metrics.pixels);
//               } else
//                 return false;
//             },
//             child: ListView(
//               scrollDirection: Axis.vertical,
//               controller: bgp.controller,
//               physics: NeverScrollableScrollPhysics(),
//               children: [
//                 IntroPage(),
//                 // Text('test'),
//                 Projects(_cont, NeverScrollableScrollPhysics())
//               ],
//             ),
//           ),
//         ),
//       ),
//       Header(),
//       // BottomButtons(bgp),
//       // ProjectDescription(bgp)
//     ],
//   );
// }
