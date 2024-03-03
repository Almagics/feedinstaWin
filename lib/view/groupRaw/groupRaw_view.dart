import 'package:feedinsta/model/elementModel.dart';
import 'package:feedinsta/model/groupRawModel.dart';
import 'package:feedinsta/model/itemmodel.dart';
import 'package:feedinsta/service/elementService.dart';
import 'package:feedinsta/service/groupRawService.dart';
import 'package:feedinsta/view/raw_item/addItem.dart';
import 'package:feedinsta/view/raw_item/itemList.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';

import '../raw_item/raw_item_edit.dart';
import '../widget/cardItem.dart';
import '../widget/dismissOption.dart';
import 'groupRowEdit.dart';



class GroupListView extends StatefulWidget {
  const GroupListView({super.key});

  @override
  State<GroupListView> createState() => _GroupListViewState();
}

class _GroupListViewState extends State<GroupListView> {
  final GroupRawService db = GroupRawService();


  final List<ItemModel> items = [


  ];





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, Routes.addGroupRaw);
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
        title: const Center(child: Text("قائمة مجموعات الخامات ", style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),)),
      ),

      body: FutureBuilder<List<GroupRawModel>>(
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
                return DisMissOption(nkey: data![index].group_raw_id.toString(),
                  name: data![index].group_raw_name,
                  widget:  CardWithImageAndText( onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => ItemListView( id: data![index].group_raw_id ?? 0)));

                  }, name: data![index].group_raw_name ?? '', id: data![index].group_raw_id ?? 0, iconlist:   Icon(Icons.grid_view_sharp,size: 50,color: Colors.white,),


                  ),
                  onPressed: () {
                    db.deleteItem(data![index].group_raw_id ?? 0);
                    Navigator.of(context).pop(true);


                  }, index: index,
                  onEdit: GroupRawEdit(id: data![index].group_raw_id ?? 0)
                  );
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





