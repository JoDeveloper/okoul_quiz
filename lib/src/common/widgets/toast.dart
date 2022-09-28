import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ErrorFlash extends StatelessWidget {
  final String message;
  final Color? color;
  final IconData? icon;
  final Color? iconColor;
  final Color? textColor;
  final String? image;
  final AlignmentGeometry? alignment;
  final dynamic elevation;

  const ErrorFlash({
    Key? key,
    required this.message,
    this.color,
    this.icon,
    this.iconColor,
    this.textColor,
    this.image,
    this.alignment = Alignment.bottomCenter,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Dialog(
        alignment: alignment,
        backgroundColor: color ?? const Color(0xFFFDEDEE),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        elevation: elevation,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              child: image != null
                  ? Image.asset(
                      image!,
                      width: 30,
                      height: 30,
                    )
                  : Icon(
                      icon ?? Icons.error,
                      color: iconColor ?? const Color(0xFFF14E63),
                    ),
            ),
            Expanded(
              child: Text(
                message,
                style: TextStyle(fontStyle: FontStyle.normal, color: textColor),
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SuccessFlash extends StatelessWidget {
  final String message;
  final Color? color;
  final IconData? icon;
  final Color? iconColor;
  final Color? textColor;
  final String? image;
  final AlignmentGeometry? alignment;
  final dynamic elevation;

  const SuccessFlash({
    Key? key,
    required this.message,
    this.color,
    this.iconColor,
    this.icon,
    this.textColor,
    this.image,
    this.alignment = Alignment.bottomCenter,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Dialog(
        alignment: alignment,
        backgroundColor: color ?? const Color(0xFFEAF7EE),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        elevation: elevation,
        child: Row(
          children: [
            Container(
                margin: const EdgeInsets.all(10.0),
                child: image != null
                    ? Image.asset(
                        image!,
                        width: 30,
                        height: 30,
                      )
                    : Icon(
                        icon ?? Icons.check_circle,
                        color: iconColor ?? const Color(0xFF3BB55D),
                      )),
            Expanded(
              child: Text(
                message,
                style: TextStyle(fontStyle: FontStyle.normal, color: textColor),
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ShowFlash {
  errorFlash(BuildContext context,
      {required final String message,
      final Color? backgroundColor,
      final IconData? icon,
      final Color? iconColor,
      final Color? textColor,
      final String? image,
      final AlignmentGeometry? alignment = Alignment.bottomCenter,
      final int duration = 1500,
      final dynamic elevation = 0.0}) {
    return showDialog(
        barrierDismissible: false,
        barrierColor: Colors.white.withOpacity(0),
        context: context,
        builder: (_) {
          Future.delayed(Duration(milliseconds: duration), () {
            SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
          });
          return ErrorFlash(
            message: message,
            color: backgroundColor,
            icon: icon,
            iconColor: iconColor,
            textColor: textColor,
            image: image,
            alignment: alignment,
            elevation: elevation,
          );
        });
  }

  successFlash(
    BuildContext context, {
    required final String message,
    final Color? backgroundColor,
    final IconData? icon,
    final Color? iconColor,
    final Color? textColor,
    final String? image,
    final AlignmentGeometry? alignment = Alignment.bottomCenter,
    final int duration = 1500,
    final dynamic elevation = 0.0,
  }) {
    return showDialog(
        barrierDismissible: false,
        barrierColor: Colors.white.withOpacity(0),
        context: context,
        builder: (_) {
          Future.delayed(Duration(milliseconds: duration), () {
            SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
          });
          return SuccessFlash(
            message: message,
            color: backgroundColor,
            icon: icon,
            iconColor: iconColor,
            textColor: textColor,
            image: image,
            alignment: alignment,
            elevation: elevation,
          );
        });
  }
}

final flash = ShowFlash();
