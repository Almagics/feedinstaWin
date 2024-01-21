

import 'dart:ffi';



class ItemModel{


  final int? item_id;
  final String? item_name;
  final String? remarks;
  final double? price;
  final String? ratio;
  final int? group_raw_id;



  ItemModel( {
    this.item_id,
    required this.item_name,
    required this.remarks,
    required this.price,
    required this.ratio,
    required this.group_raw_id

  });



  Map<String, dynamic> toJson() {
    return {
      'item_id':item_id,
      'item_name': item_name,
      'remarks': remarks,
      'price': price,
      'ratio':ratio,
      'group_raw_id':group_raw_id
    };
  }

/// Factory constructor to create a Person instance from a Map
  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      item_id: map['item_id'],
      item_name: map['item_name'],
      remarks: map['remarks'],
      price: map['price'],
      ratio: map['ratio'],
      group_raw_id: map['group_raw_id']

    );
  }


}