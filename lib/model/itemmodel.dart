

import 'dart:ffi';



class ItemModel{


  final int? item_id;
  final String? item_name;
  final String? remarks;
  final double? price;



  ItemModel( { this.item_id, required this.item_name, required this.remarks,required this.price});



  Map<String, dynamic> toJson() {
    return {
      'item_id':item_id,
      'item_name': item_name,
      'remarks': remarks,
      'price': price
    };
  }

/// Factory constructor to create a Person instance from a Map
  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      item_id: map['item_id'],
      item_name: map['item_name'],
      remarks: map['remarks'],
      price: map['price'],

    );
  }


}