import 'package:flutter/material.dart';

class NumericStepButton extends StatefulWidget {
  final double minValue;
  final double maxValue;

  final ValueChanged<double>? onChanged;

  NumericStepButton(
      {Key? key,
      this.minValue = 0,
      this.maxValue = double.maxFinite,
      this.onChanged})
      : super(key: key);

  @override
  State<NumericStepButton> createState() {
    return _NumericStepButtonState();
  }
}

class _NumericStepButtonState extends State<NumericStepButton> {
  double counter = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              if (counter > widget.minValue) {
                counter--;
              }
              widget.onChanged!(counter);
            });
          },
          child: Container(
            child: Icon(
              Icons.remove,
              size: 32.0,
              color: Theme.of(context).primaryColor,
            ),
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
          ),
        ),
        Text(
          '${counter.round()}',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              if (counter < widget.maxValue) {
                counter++;
              }
              widget.onChanged!(counter);
            });
          },
          child: Container(
            child: Icon(
              Icons.add,
              size: 32.0,
              color: Theme.of(context).primaryColor,
            ),
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
          ),
        ),
      ],
    );
  }
}
