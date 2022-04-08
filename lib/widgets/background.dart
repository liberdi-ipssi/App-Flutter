import 'package:flutter_application_1/widgets/Custom.dart';
import 'package:flutter/material.dart';

class Background extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return backgroundState();
  }
}

class backgroundState extends State<Background>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10))
          ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: bodyPage(),
    );
  }

  Widget bodyPage() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 150),
      duration: Duration(seconds: 8),
      curve: Curves.elasticOut,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.red,
      ),
      builder: (context, value, child) {
        return ClipPath(clipper: Custom(value), child: child);
      },
    );
  }
}
