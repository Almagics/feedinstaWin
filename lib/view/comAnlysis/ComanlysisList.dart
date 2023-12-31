import 'package:feedinsta/model/comAnlysisModel.dart';
import 'package:feedinsta/model/elementModel.dart';
import 'package:feedinsta/model/itemmodel.dart';
import 'package:feedinsta/service/ComAnlysisService.dart';
import 'package:feedinsta/service/elementService.dart';
import 'package:feedinsta/view/raw_item/addItem.dart';
import 'package:feedinsta/view/widget/alertMsg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/context/dbcontext.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../service/itemService.dart';
import '../widget/cardItem.dart';
import '../widget/dismissOption.dart';
import 'comAnlysisInfoView.dart';



class ComAnlysisListView extends StatefulWidget {
  const ComAnlysisListView({super.key});

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
          Navigator.pushReplacementNamed(context, Routes.addComAnlysis);
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
        title: const Center(child: Text("قائمة  تحاليل التركيبات")),
      ),

      body: FutureBuilder<List<ComAnlysisModel>>(
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
                return DisMissOption(nkey: data![index].com_ana_id.toString(),
                  name: data![index].com_ana_name,
                  widget:  CardWithImageAndText( onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => ComAnlysisInfoView(itemName: data![index].com_ana_name??'', itemId: data![index].com_ana_id??0,)));

                  }, name: data![index].com_ana_name ?? '', id: data![index].com_ana_id ?? 0,


                  ),
                  onPressed: () {
                    db.deleteItem(data![index].com_ana_id ?? 0);
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





