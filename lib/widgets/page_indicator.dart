import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    Key? key,
    this.currentValue = 0,
  }) : super(key: key);
  final int currentValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: AnimatedContainer(
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 250),
            width: index == currentValue ? 35 : 10,
            height: 7,
            decoration: BoxDecoration(
              color:
                  index == currentValue ? Color(0xff2F6782) : Color(0xffE2EBF5),
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        ),
      ),
    );
  }
}
