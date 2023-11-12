import 'package:flutter/material.dart';

import '../../model/itemmodel.dart';
import '../../resources/color_manager.dart';

class CardWithImageAndText extends StatelessWidget {

  final String name;
  final String? desc;
  final int id;
  final VoidCallback onPressed;

  const CardWithImageAndText({super.key, required this.onPressed, required this.name, this.desc, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: onPressed,
      child: Card(
        elevation: 4.0,
        margin: EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          color: ColorManager.primary,
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Image at the top of the card, stretched to fill
              Column(
                children: [
                  Icon(Icons.info,size: 50,color: Colors.grey,)

                ],
              ),

              Column(
                children: [
                  Text(name ?? ''),
                  //Text(item.price.toString() ?? '0')
                  Text(desc ??  ''),
                ],
              ),

              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [

                   // Text('Code : ' + (item.item_id.toString() ?? '')),


                  ],
                ),
              ),

              // Text at the bottom of the card, centered with shadow

            ],
          ),
        ),
      ),
    );
  }
}
