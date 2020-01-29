import 'package:flutter/material.dart';

class KeyValueFirstRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
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
        Spacer(
          flex: 1,
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
      ],
    );
  }
}
