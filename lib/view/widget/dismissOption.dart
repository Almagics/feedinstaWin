import 'package:flutter/material.dart';

import 'alertMsg.dart';


class DisMissOption extends StatefulWidget {
  const DisMissOption({super.key, required this.nkey, required this.name, required this.widget, required this.onPressed, required this.index});
final String nkey;
  final String? name;
  final Widget widget;
  final VoidCallback onPressed;
  final int index;
  @override
  State<DisMissOption> createState() => _DisMissOptionState();
}

class _DisMissOptionState extends State<DisMissOption> {
  final List<String> items = [


  ];

  @override
  Widget build(BuildContext context) {
    return Dismissible(

        key:  Key(widget.nkey),
        confirmDismiss: (direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDailogMsg(title: 'تاكيد الحذف',

                  supject: "هل انت متاكد من رغبتك بحذف هذا العنصر  ${widget.name}?'",
                  onPressed: widget.onPressed

              );
            },
          );
        },

        onDismissed: (direction) {
          setState(() {
            items.removeAt(widget.index);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('تم الحذف'),
            ),
          );


        },

        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20.0),
          child: const Center(
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 50,
            ),
          ),
        ),





        child: widget.widget);
  }
}
