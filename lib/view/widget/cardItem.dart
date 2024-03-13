import 'package:flutter/material.dart';

import '../../model/itemmodel.dart';
import '../../resources/color_manager.dart';

class CardWithImageAndText extends StatelessWidget {

  final String name;
  final String? desc;
  final int id;
  final VoidCallback onPressed;
  final Icon iconlist;
  final String? price;

  const CardWithImageAndText({super.key, required this.onPressed, required this.name, this.desc, required this.id, required this.iconlist, this.price});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: onPressed,
      child: Card(
        elevation: 4.0,
        margin: EdgeInsets.all(8.0),
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

                  iconlist
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(

                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(name ?? '',

                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,

                        ),


                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      children: [
                        Text(desc ??  ''),
                        SizedBox(width: 10,),

                        Text(price ?? '')

                      ],
                    ),
                  )


                ],
              ),



              // Text at the bottom of the card, centered with shadow

            ],
          ),
        ),
      ),
    );
  }
}
