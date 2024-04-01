
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../business_logic/auth/auth.dart';
import '../../l10n/l10n.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';
import '../widget/app_text_form_filed.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final Auth _auth = Auth();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [




            SizedBox(width: 50),

              Container(padding: const EdgeInsets.only(top: 50,bottom: 8,right: 4,left: 4),
                child: const Center(child: Image(image: AssetImage(ImageAssets.logo),height: 150,width: 150,)),




              ),
              Container(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                  child: Text(
                    getTranslated(context, 'loginMsg'),
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(4.0),
                child: Center(
                  child: Text(

                    getTranslated(context, 'logintouraccount')
                   ,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),

              SizedBox(height: 5,),
              Container(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  getTranslated(context, 'username'),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),

              Container(padding: const EdgeInsets.all(8),
                  child: AppTextFormFiled(
                    iconData: Icons.email_outlined,
                    controller: emailController,
                    hintText:  getTranslated(context, 'entermail'),
                  )),


              const SizedBox(
                height: 5.0,
              ),

              Container(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  getTranslated(context, 'password'),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),

              Container(padding: const EdgeInsets.all(8),
                child: AppTextFormFiled(
                  obscureText: true,
                  suffixIcon: true,
                  iconData: Icons.lock,
                  controller: passwordController,
                  hintText: getTranslated(context, 'enterpassword'),
                ),),



              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.fromLTRB(3,0,3,0),
                child: Center(
                  child: SizedBox(width: 380,height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        //pageController.animateToPage(getNextIndex, duration: const Duration(microseconds: AppConstants.splashDelay), curve: Curves.bounceInOut);
                        // Navigator.pushReplacementNamed(context, Routes.mainRoute);
                         _signin();
                      },


                      style: Theme.of(context).elevatedButtonTheme.style,
                      child:  Text(getTranslated(context, 'login'),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold

                        ),


                      ),

                    ),
                  ),
                ),
              ),








              const SizedBox(height: 10,),




              SizedBox(height: MediaQuery.of(context).size.height * .01,),
              Padding(
                padding: const EdgeInsets.fromLTRB(3,0,3,0),
                child: Center(
                  child: GestureDetector(
                    onTap: (){
                    //  Navigator.pushReplacementNamed(context, Routes.registerRoute);
                      _displaySignUp();
                    },
                    child: Text(
                      getTranslated(context, 'donthaveaccount'),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
              ),



            ],
          ),
        ),
      ),
    );


  }



  void _displayDialog(String message) {
    showDialog(
      context: context,
      builder: ( context) {
        return AlertDialog(
          title: const Text('Error',
            textAlign: TextAlign.center,

          ),
          content: Text(message,
            textAlign: TextAlign.center,),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }


  void _displaySignUp() {
    showDialog(
      context: context,
      builder: ( context) {
        return AlertDialog(
          title: const Text('ٌRegister',
            textAlign: TextAlign.center,

          ),
          content: Text('Contact Admin to regiister ',
            textAlign: TextAlign.center,),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }



  void _signin() async{


   // _auth.clearSharedPreferences();

    String email = emailController.text;
    //String birthday = birthDayController.text;
    String password = passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);


    // Navigator.pushReplacementNamed(context, Routes.newhome);


    if(user!= null){
      print("User is successfully login");

     // var role = await _auth.getRole();


        Navigator.pushReplacementNamed(context, Routes.mainRoute);


      }






    else{
      _displayDialog("Wrong Password Or Username");
    }



  }






}



