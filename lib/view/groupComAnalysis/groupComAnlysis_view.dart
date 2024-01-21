import 'package:feedinsta/model/elementModel.dart';
import 'package:feedinsta/model/groupComanalysisModel.dart';
import 'package:feedinsta/model/groupRawModel.dart';
import 'package:feedinsta/model/itemmodel.dart';
import 'package:feedinsta/service/elementService.dart';
import 'package:feedinsta/service/groupComAnalysis.dart';
import 'package:feedinsta/service/groupRawService.dart';
import 'package:feedinsta/view/raw_item/addItem.dart';
import 'package:feedinsta/view/raw_item/itemList.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';

import '../comAnlysis/ComanlysisList.dart';
import '../widget/cardItem.dart';
import '../widget/dismissOption.dart';



class GroupComAnalysisListView extends StatefulWidget {
  const GroupComAnalysisListView({super.key});

  @override
  State<GroupComAnalysisListView> createState() => _GroupComAnalysisListViewState();
}

class _GroupComAnalysisListViewState extends State<GroupComAnalysisListView> {
  final GroupComAnalysisService db = GroupComAnalysisService();


  final List<ItemModel> items = [


  ];





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, Routes.addGroupComAnalysis);
        },


        child: Icon(Icons.add),
        backgroundColor: ColorManager.primary,
      ),
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: ColorManager.white,),
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.mainRoute);
          },
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.darkGrey,
            statusBarBrightness: Brightness.light
        ),

        elevation: 0.0,
        title: const Center(child: Text("دليل  السلالات", style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),)),
      ),

      body: FutureBuilder<List<GroupComAnalysisModel>>(
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
                return DisMissOption(nkey: data![index].group_com_analysis_id.toString(),
                  name: data![index].group_com_analysis_name,
                  widget:  CardWithImageAndText( onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => ComAnlysisListView(id: data![index].group_com_analysis_id ?? 0)));

                  }, name: data![index].group_com_analysis_name ?? '', id: data![index].group_com_analysis_id ?? 0, iconlist:   Icon(Icons.auto_graph_outlined,size: 50,color: Colors.white,),


                  ),
                  onPressed: () {
                    db.deleteItem(data![index].group_com_analysis_id ?? 0);
                    Navigator.of(context).pop(true);


                  }, index: index,);
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





