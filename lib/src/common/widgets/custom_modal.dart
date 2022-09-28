import 'package:flutter/material.dart';
import 'package:quiz_ui/src/common/extensions/int_extensions.dart';

class CustomModal extends StatefulWidget {
  const CustomModal({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  State<StatefulWidget> createState() => CustomModalState();
}

class CustomModalState extends State<CustomModal> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: 450.milliseconds);
    scaleAnimation = CurvedAnimation(parent: controller!, curve: Curves.elasticInOut);

    controller?.addListener(() {
      setState(() {});
    });

    controller?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ScaleTransition(
        scale: scaleAnimation!,
        child: Container(
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
