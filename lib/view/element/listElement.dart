import 'package:feedinsta/model/elementModel.dart';
import 'package:feedinsta/model/itemmodel.dart';
import 'package:feedinsta/service/elementService.dart';
import 'package:feedinsta/view/raw_item/addItem.dart';
import 'package:feedinsta/view/widget/alertMsg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../l10n/l10n.dart';
import '../../model/context/dbcontext.dart';
import '../../model/context/fillDatabase.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../service/itemService.dart';
import '../raw_item/raw_item_edit.dart';
import '../widget/cardItem.dart';
import '../widget/dismissOption.dart';
import 'elementEdit.dart';



class ElementListView extends StatefulWidget {
  const ElementListView({super.key});

  @override
  State<ElementListView> createState() => _ElementListViewState();
}

class _ElementListViewState extends State<ElementListView> {
  final ElementService db = ElementService();
  final FillDatabase fillDb = FillDatabase();

  final List<ItemModel> items = [


  ];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fillDb.insertElements();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, Routes.addElement);
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
        title:  Center(child: Text(getTranslated(context, 'elmentsList'), style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),)),
      ),

      body: FutureBuilder<List<ElementModel>>(
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
                return DisMissOption(nkey: data![index].element_id.toString(),
                  name: data![index].element_name,
                  widget:  CardWithImageAndText( onPressed: () {



                  }, name: data![index].element_name ?? '', id: data![index].element_id ?? 0, iconlist:   Icon(Icons.bubble_chart,size: 50,color: Colors.white,),


                  ),
                  onPressed: () {
                    db.deleteItem(data![index].element_id ?? 0);
                    Navigator.of(context).pop(true);


                  }, index: index,
                  onEdit: ElementEditView(id: data![index].element_id ?? 0));
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





