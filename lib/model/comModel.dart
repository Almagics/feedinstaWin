

import 'dart:ffi';



class ComModel{


  final int? com_id;
  final String? com_name;
  final String? com_remarks;
  final int? com_ana_id;
  final double? total_amount;
  final double? com_qty;



  ComModel( {
    this.com_id,
    required this.com_name,
    required this.com_ana_id,
    required this.com_qty,
    required this.total_amount,
    this.com_remarks
  });



  Map<String, dynamic> toJson() {
    return {
      'com_id':com_id,
      'com_name': com_name,
      'com_qty': com_qty,
      'total_amount': total_amount,
      'com_remarks':com_remarks,
      'com_ana_id':com_ana_id

    };
  }

  /// Factory constructor to create a Person instance from a Map
  factory ComModel.fromMap(Map<String, dynamic> map) {
    return ComModel(
      com_id: map['com_id'],
      com_name: map['com_name'],
      com_qty: map['com_qty'],
      total_amount: map['total_amount'],
        com_remarks:map['com_remarks'],
        com_ana_id: map['com_ana_id']

    );
  }


}