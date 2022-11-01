# portfolio

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

class ScrollDemoPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final animation = Provider.of<Animation<double>>(context, listen: false);
//     final size = MediaQuery.of(context).size;
//     final sdp = context.read<ScrollDemoProvider>();

//     sdp.initScreenSize(size);
//     return Scaffold(
//         backgroundColor: Colors.transparent,
//         body: ScrollDemo(controller: animation, size: size)
//         // ReadmeDisplay(),

//         );
//   }
// }

// class ScrollDemo extends StatelessWidget {
//   ScrollDemo({Key? key, required this.controller, required this.size})
//       : bg_top = Tween<double>(
//           begin: size.height / 2,
//           end: size.height - 70,
//         ).animate(
//           CurvedAnimation(
//             parent: controller,
//             curve: const Interval(
//               0.5,
//               1.0,
//               curve: Curves.ease,
//             ),
//           ),
//         ),
//         bg_box_width = Tween<double>(
//           begin: 0,
//           end: size.width,
//         ).animate(
//           CurvedAnimation(
//             parent: controller,
//             curve: const Interval(
//               0.0,
//               .5,
//               curve: Curves.ease,
//             ),
//           ),
//         ),
//         opacity = Tween<double>(
//           begin: 0,
//           end: 1,
//         ).animate(
//           CurvedAnimation(
//             parent: controller,
//             curve: const Interval(
//               .7,
//               1.0,
//               curve: Curves.ease,
//             ),
//           ),
//         ),
//         super(key: key);

//   final Animation<double> controller;
//   final Animation<double> opacity;
//   final Animation<double> bg_top;
//   final Animation<double> bg_box_width;

//   final Size size;
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(builder: _buildAnimation, animation: controller);
//   }

//   Widget _buildAnimation(BuildContext context, Widget? child) {
//     return Stack(
//       children: [
//         Positioned(
//             width: bg_box_width.value,
//             height: size.height / 2 + 1,
//             right: 0,
//             child: Container(color: BACKGROUND_ACCENT2)),
//         Positioned(
//             width: bg_box_width.value,
//             top: size.height - bg_top.value,
//             height: size.height,
//             child: Container(
//               color: BACKGROUND_ACCENT,
//             )),
//         Positioned(
//           top: size.height - bg_top.value + 20,
//           width: size.width,
//           child: Opacity(
//             opacity: opacity.value,
//             child: Center(child: ScrollGraphs()),
//           ),
//         )
//       ],
//     );
//   }
// }