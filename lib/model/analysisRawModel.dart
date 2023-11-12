

import 'dart:ffi';



class AnalysisRawModel{


  final int? raw_ana_id;
  final int? raw_id;
  final int? element_id;
  final String? element_name;
  final double? raw_ana_qty;




  AnalysisRawModel( { this.raw_ana_id, required this.raw_id,  this.element_id,this.element_name,required this.raw_ana_qty});



  Map<String, dynamic> toJson() {
    return {
      'raw_ana_id':raw_ana_id,
      'raw_id': raw_id,
      'element_id': element_id,
      "element_name":element_name,
      "raw_ana_qty":raw_ana_qty

    };
  }

  /// Factory constructor to create a Person instance from a Map
  factory AnalysisRawModel.fromMap(Map<String, dynamic> map) {
    return AnalysisRawModel(
      raw_ana_id: map['raw_ana_id'],
      raw_id: map['raw_id'],
      element_id: map['element_id'],
        element_name:map['element_name'],
        raw_ana_qty:map["raw_ana_qty"]


    );
  }


}