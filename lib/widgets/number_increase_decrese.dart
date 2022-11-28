import 'package:flutter/material.dart';

class NumericStepButton extends StatefulWidget {
  final double minValue;
  final double maxValue;
  double value = 0;

  final ValueChanged<double>? onChanged;

  NumericStepButton({
    Key? key,
    this.minValue = 0,
    this.maxValue = double.maxFinite,
    this.onChanged,
    this.value = 0,
  }) : super(key: key);

  @override
  State<NumericStepButton> createState() {
    return _NumericStepButtonState();
  }
}

class _NumericStepButtonState extends State<NumericStepButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              if (widget.value > widget.minValue) {
                widget.value--;
              }
              widget.onChanged!(widget.value);
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
          '${widget.value.round()}',
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
              if (widget.value < widget.maxValue) {
                widget.value++;
              }
              widget.onChanged!(widget.value);
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
