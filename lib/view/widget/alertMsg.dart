
import 'package:flutter/material.dart';

import 'app_text_form_filed.dart';
class AlertDailogMsg extends StatefulWidget {
  const AlertDailogMsg({super.key, required this.title, required this.supject, required this.onPressed});
  final String title;

  final String supject;

  final VoidCallback onPressed;

  @override
  State<AlertDailogMsg> createState() => _AlertDailogMsgState();
}

class _AlertDailogMsgState extends State<AlertDailogMsg> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [

            Center(child: Align(
              alignment: Alignment.centerRight,
              child: Text(widget.supject,
                style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              ),
            )),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('الغاء',style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),),
        ),
        TextButton(
          onPressed:  widget.onPressed,
          child: Text('تاكيد',style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),),
        ),
      ],
    );
  }
}
