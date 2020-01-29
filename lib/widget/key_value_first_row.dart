import 'package:flutter/material.dart';

class KeyValueFirstRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Center(
            child: Text(
              'Key',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Center(
            child: Text(
              'Value',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Opacity(
            opacity: 0,
            child: Icon(
              Icons.delete,
            ),
          ),
        ),
      ],
    );
  }
}
