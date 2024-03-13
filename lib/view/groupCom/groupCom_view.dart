
import 'package:feedinsta/model/groupComModel.dart';

import 'package:feedinsta/model/itemmodel.dart';
import 'package:feedinsta/view/com/comListView.dart';
import 'package:feedinsta/view/raw_item/itemList.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../l10n/l10n.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';

import '../../service/groupComService.dart';
import '../raw_item/raw_item_edit.dart';
import '../widget/cardItem.dart';
import '../widget/dismissOption.dart';
import 'groupComEdit_view.dart';



class GroupComListView extends StatefulWidget {
  const GroupComListView({super.key});

  @override
  State<GroupComListView> createState() => _GroupComListViewState();
}

class _GroupComListViewState extends State<GroupComListView> {
  final GroupComService db = GroupComService();


  final List<ItemModel> items = [


  ];





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, Routes.addGroupCom);
        },


        child: Icon(Icons.add),
        backgroundColor: ColorManager.primary,
      ),
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: ColorManager.white,),
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.mainRoute);// Navigate back to the previous screen
          },
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.darkGrey,
            statusBarBrightness: Brightness.light
        ),

        elevation: 0.0,
        title:  Center(child: Text(getTranslated(context ,'listGroupfixture'), style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),)),
      ),

      body: FutureBuilder<List<GroupComModel>>(
        future: db.getAllData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final data = snapshot.data;

            // Display data in a ListView or other widget
            return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                return DisMissOption(nkey: data![index].group_com_id.toString(),
                  name: data![index].group_com_name,
                  widget:  CardWithImageAndText( onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => ComListView( groupId: data![index].group_com_id ?? 0)));

                  }, name: data![index].group_com_name ?? '', id: data![index].group_com_id ?? 0, iconlist:   Icon(Icons.account_tree,size: 50,color: Colors.white,),


                  ),
                  onPressed: () {
                    db.deleteItem(data![index].group_com_id ?? 0);
                    Navigator.of(context).pop(true);


                  }, index: index,
                  onEdit: GroupComEdit(id: data![index].group_com_id ?? 0));
              },

            );
          } else {
            return const Center(child: Text('No data found for'));
          }
        },
      ),

    );
  }
}





