import 'package:feedinsta/model/elementModel.dart';
import 'package:feedinsta/model/itemmodel.dart';
import 'package:feedinsta/service/elementService.dart';
import 'package:feedinsta/view/element/addElement.dart';
import 'package:feedinsta/view/raw_item/addItem.dart';
import 'package:feedinsta/view/raw_item/raw_item_edit.dart';
import 'package:feedinsta/view/widget/alertMsg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/context/dbcontext.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../service/itemService.dart';
import '../raw_analysis/addRawAnalysis.dart';
import '../widget/cardItem.dart';
import '../widget/dismissOption.dart';



class ItemListView extends StatefulWidget {
  const ItemListView({super.key, required this.id});

  final int id;

  @override
  State<ItemListView> createState() => _OrderListViewState();
}

class _OrderListViewState extends State<ItemListView> {
  final ItemService db = ItemService();


  final List<ItemModel> items = [


  ];





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, Routes.addItem);
        },


        child: Icon(Icons.add),
        backgroundColor: ColorManager.primary,
      ),
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: ColorManager.white,),
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.groupRawList);// Navigate back to the previous screen
          },
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.darkGrey,
            statusBarBrightness: Brightness.light
        ),

        elevation: 0.0,
        title: const Center(child: Text("قائمة  الخامات", style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),)),
      ),

      body: FutureBuilder<List<ItemModel>>(
        future:  db.getAllDataByGroup(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final data = snapshot.data;

            print("dataaa is : $data" );

            // Display data in a ListView or other widget
            return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                return DisMissOption(nkey: data![index].item_id.toString(),
                  name: data![index].item_name,

                  widget:  CardWithImageAndText(
                     onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => AddRawAnlysis(itemName: data![index].item_name ??"", itemId: data![index].item_id??0,)));

                    print('naame is : ${data![index].item_id}');

                  },
                    name: data![index].item_name.toString() ?? '',
                    id: data![index].item_id ?? 0,
                    iconlist:   Icon(Icons.inventory_2_outlined,size: 50,color: Colors.white,),
                    desc: "معدل الاضافة : ${data![index].ratio??""}",
                    price: "السعر : ${data![index].price??0}",


                  ),
                  onPressed: () {
                    db.deleteItem(data![index].item_id ?? 0);
                    Navigator.of(context).pop(true);


                  }, index: index,


                  onEdit: EditItemView(id: data![index].item_id ?? 0)

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





