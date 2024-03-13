



import 'package:feedinsta/model/groupRawModel.dart';



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../l10n/l10n.dart';
import '../../model/groupComModel.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';

import '../../service/groupComService.dart';
import '../widget/app_text_form_filed.dart';
import 'groupCom_view.dart';






class GroupComAdd extends StatefulWidget {
  const GroupComAdd({Key? key}) : super(key: key);

  @override
  State<GroupComAdd> createState() => _GroupComAddState();
}

class _GroupComAddState extends State<GroupComAdd> {

  final GroupComService db = GroupComService();


  final GroupNameController = TextEditingController();

  // final remarksController = TextEditingController();




  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: ColorManager.white,),
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.groupcomaList);// Navigate back to the previous screen
          },
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.darkGrey,
            statusBarBrightness: Brightness.light
        ),

        elevation: 0.0,
        title:  Center(child: Text(getTranslated(context, 'listGroupfixture'), style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),)),
      ),
      body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SafeArea(child: SizedBox.shrink()),
                Container(
                  margin: EdgeInsets.all(AppPadding.p8),
                  child:  Padding(padding: EdgeInsets.all(AppPadding.p8),
                    child: Center(child: Text(getTranslated(context, 'listGroupfixture'))),


                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    getTranslated(context, 'groupName'),
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium,
                  ),
                ),

                Padding(padding: EdgeInsets.all(AppPadding.p8),
                    child: AppTextFormFiled(

                      controller: GroupNameController,
                    //  hintText: "ادخل اسم المجموعة",
                    )
                ),




                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                  child: Center(
                    child: SizedBox(width: 380, height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          //pageController.animateToPage(getNextIndex, duration: const Duration(microseconds: AppConstants.splashDelay), curve: Curves.bounceInOut);
                          _saveitem();
                        },


                        style: Theme
                            .of(context)
                            .elevatedButtonTheme
                            .style,
                        child:  Text(getTranslated(context, 'save')),

                      ),
                    ),
                  ),
                ),


              ],
            ),
          )
      ),
    );
  }

  void _saveitem() async {
    String name = GroupNameController.text;


    var model = new GroupComModel( group_com_name: name,);

    int insertedRowId =await db.insertData(model);

    // Check if insertion was successful
    if (insertedRowId != -1) {
      print('Data inserted successfully. Row ID: $insertedRowId');
      print(db.getAllData());

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (ctx) => GroupComListView()));

    } else {
      print('Error inserting data.');
    }


  }


}
