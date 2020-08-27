import 'package:flutter/material.dart';
import 'package:flutter_weather/src/widgets/empty_widget.dart';

class ValueTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData iconData;

  ValueTile(this.label, this.value, {this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          this.label,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        this.iconData != null
            ? Icon(
                iconData,
                color: Colors.black,
                size: 20,
              )
            : EmptyWidget(),
        SizedBox(
          height: 10,
        ),
        Text(
          this.value,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
