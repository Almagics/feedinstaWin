



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






class GroupComEdit extends StatefulWidget {
  const GroupComEdit({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<GroupComEdit> createState() => _GroupComEditState();
}

class _GroupComEditState extends State<GroupComEdit> {

  final GroupComService db = GroupComService();


  var GroupNameController = TextEditingController();

  // final remarksController = TextEditingController();




  final _formKey = GlobalKey<FormState>();




  GroupComModel model =  GroupComModel(group_com_name: '' );



  Future<GroupComModel> getinfo() async {

    model = await db.getItemById(widget.id);
    print('group: ${GroupNameController.text}');
    return model;

  }


  @override
  void dispose() {
    GroupNameController.dispose();


    super.dispose();
  }


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
        title:  Center(child: Text(getTranslated(context ,'editGroupfixture'), style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),)),
      ),
      body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child:


            FutureBuilder(
              future: getinfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Display a loading indicator while waiting for the future to complete
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // Display an error message if the future encounters an error
                  return Text('Error: ${snapshot.error}');
                } else {

                  GroupNameController = TextEditingController(text: snapshot.data!.group_com_name);

                  // Display the data once the future is complete
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SafeArea(child: SizedBox.shrink()),
                      Container(
                        margin: EdgeInsets.all(AppPadding.p8),
                        child:  Padding(padding: EdgeInsets.all(AppPadding.p8),
                          child: Center(child: Text(getTranslated(context ,'editGroupfixture'))),


                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                getTranslated(context ,'groupName'),
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
                              child:  Text(getTranslated(context ,'save')),

                            ),
                          ),
                        ),
                      ),


                    ],
                  );
                }
              },
            ),



          )
      ),
    );
  }

  void _saveitem() async {
    String name = GroupNameController.text;


    var model = new GroupComModel( group_com_name: name, group_com_id: widget.id);

    int? insertedRowId =await db.updateItem(model);

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
