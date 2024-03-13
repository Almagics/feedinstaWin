import 'package:feedinsta/model/comAnlysisModel.dart';
import 'package:feedinsta/model/elementModel.dart';
import 'package:feedinsta/model/itemmodel.dart';
import 'package:feedinsta/service/ComAnlysisService.dart';
import 'package:feedinsta/service/elementService.dart';
import 'package:feedinsta/view/comAnlysis/AddComAnlysis.dart';
import 'package:feedinsta/view/raw_item/addItem.dart';
import 'package:feedinsta/view/widget/alertMsg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../l10n/l10n.dart';
import '../../model/context/dbcontext.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../service/itemService.dart';
import '../raw_item/raw_item_edit.dart';
import '../widget/cardItem.dart';
import '../widget/dismissOption.dart';
import 'EditComAnalysisView.dart';
import 'comAnlysisInfoView.dart';



class ComAnlysisListView extends StatefulWidget {
  const ComAnlysisListView({super.key, required this.id});

  final int id;

  @override
  State<ComAnlysisListView> createState() => _ComAnlysisListViewState();
}

class _ComAnlysisListViewState extends State<ComAnlysisListView> {
  final ComAnlysisService db = ComAnlysisService();


  final List<ItemModel> items = [


  ];





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (ctx) => AddComAnalysisView(groupId: widget.id)));
        },


        child: Icon(Icons.add),
        backgroundColor: ColorManager.primary,
      ),
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: ColorManager.white,),
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.groupcomanalysisList);// Navigate back to the previous screen
          },
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.darkGrey,
            statusBarBrightness: Brightness.light
        ),

        elevation: 0.0,
        title:  Center(child: Text(getTranslated(context ,'BreeGuide'), style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),)),
      ),

      body: FutureBuilder<List<ComAnlysisModel>>(
        future: db.getAllDataByGroup(widget.id),
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
                return DisMissOption(nkey: data![index].com_ana_id.toString(),
                  name: data![index].com_ana_name,
                  widget:  CardWithImageAndText( onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => ComAnlysisInfoView(itemName: data![index].com_ana_name??'', itemId: data![index].com_ana_id??0, groupId: widget.id,)));

                  }, name: data![index].com_ana_name ?? '', id: data![index].com_ana_id ?? 0, iconlist:   Icon(Icons.analytics,size: 50,color: Colors.white,),


                  ),
                  onPressed: () {
                    db.deleteItem(data![index].com_ana_id ?? 0);
                    Navigator.of(context).pop(true);


                  }, index: index,

                  onEdit: EditComAnalysisView(id: data![index].com_ana_id ?? 0, groupId: data![index].group_com_analysis_id ?? 0,));
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





