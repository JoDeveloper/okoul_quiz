import 'package:flutter/material.dart';

class Option extends StatelessWidget {
  const Option({
    Key? key,
    required this.text,
    required this.index,
    required this.press,
  }) : super(key: key);
  final String text;
  final int index;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.withOpacity(0.4)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${index + 1}. $text",
              style: const TextStyle(color: Colors.black87, fontSize: 16),
            ),
            Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                color: Colors.transparent, //checke answer
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              // child: getTheRightColor() == Colors.grey ? null : Icon(getTheRightIcon(), size: 16),
            )
          ],
        ),
      ),
    );
  }
}
