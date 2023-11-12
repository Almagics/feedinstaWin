
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
      content: Column(
        children: [
           AppTextFormFiled(
            keyboardType:  TextInputType.number,
            iconData: Icons.numbers,
            //controller: qtyController,
            hintText: 'Enter your Phone number',

          ),
          Text(widget.supject),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('الغاء'),
        ),
        TextButton(
          onPressed:  widget.onPressed,
          child: Text('تاكيد'),
        ),
      ],
    );
  }
}
