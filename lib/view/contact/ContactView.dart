import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/l10n.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';




class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
          color: ColorManager.white,
          child:   Center(
            child: Container(
              margin: const EdgeInsets.only(top: 150,right: 8,left: 8,bottom: 8),
              child:  Column(
                children: <Widget>[
                  const SizedBox(height: 20,),
                  Container(
                    height: 50.0,
                    margin: const EdgeInsets.only(left: 10.0,right: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: ColorManager.primary,




                    ),
                    child: Center(
                      child: Text(getTranslated(context, 'homePageTitle'),
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.white

                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  const Center(child: SizedBox(child: Image(image: AssetImage(ImageAssets.logo)),
                    height: 200,
                    width: 200,


                  )

                  ),
                  const SizedBox(height: 20,),

                Center(child: GestureDetector(

                  onTap: (){
                    _launchPhone();
                  },
                  child: Text('Phone Number: 01091545452',style: TextStyle(

                    color: Colors.red,
                    fontSize: 20

                  ),),
                ),),


                  Center(child: GestureDetector(
                    onTap: (){
                      _launchEmail();
                    },
                    child: Text('Email: Fayezshammekh@gmail.com',style: TextStyle(

                        color: Colors.red,
                        fontSize: 20

                    ),),
                  ),)







                ],
              ),
            ),
          ),
        )

    );
  }

  _launchPhone() async {
    const phoneNumber = '01091545452'; // Replace with the desired phone number
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  _launchEmail() async {
    const emailAddress = 'Fayezshammekh@gmail.com'; // Replace with the desired email address
    final subject = 'hi'; // Optionally, you can specify the email subject
    final url = 'mailto:$emailAddress?subject=$subject';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


}
