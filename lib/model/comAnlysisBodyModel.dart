

import 'dart:ffi';



class ComAnlysisBodyModel{


  final int? com_ana_body_id;
  final int? com_ana_id;
  final int? element_id;
  final String? element_name;
  final double? ana_body_qty;




  ComAnlysisBodyModel( { this.com_ana_body_id, required this.ana_body_qty,  this.element_id,this.element_name,required this.com_ana_id});



  Map<String, dynamic> toJson() {
    return {
      'com_ana_body_id':com_ana_body_id,
      'com_ana_id': com_ana_id,
      'element_id': element_id,
      "element_name":element_name,
      "ana_body_qty":ana_body_qty

    };
  }

  /// Factory constructor to create a Person instance from a Map
  factory ComAnlysisBodyModel.fromMap(Map<String, dynamic> map) {
    return ComAnlysisBodyModel(
        com_ana_body_id: map['com_ana_body_id'],
        com_ana_id: map['com_ana_id'],
        element_id: map['element_id'],
        element_name:map['element_name'],
        ana_body_qty:map["ana_body_qty"]


    );
  }


}