

import 'dart:ffi';



class ComBodyModel{


  final int? com_body_id;
  final int? ram_item_id;
  final double? com_body_qty;
  final double? total_price;

  final int? com_id;
  final String? item_name;



  ComBodyModel( {

     this.com_body_id,
    required this.ram_item_id,
    required this.com_body_qty,
    required this.total_price,
    this.com_id,
    this.item_name,
  });



  Map<String, dynamic> toJson() {
    return {
      'com_body_id':com_body_id,
      'ram_item_id': ram_item_id,
      'com_body_qty': com_body_qty,
      'total_price': total_price,
      'com_id':com_id,
      'item_name':item_name,


    };
  }

  /// Factory constructor to create a Person instance from a Map
  factory ComBodyModel.fromMap(Map<String, dynamic> map) {
    return ComBodyModel(
        com_body_id: map['com_body_id'],
        ram_item_id: map['ram_item_id'],
        com_body_qty: map['com_body_qty'],
        total_price: map['total_price'],
        com_id:map['com_id'],
      item_name:map['item_name'],

    );
  }


}