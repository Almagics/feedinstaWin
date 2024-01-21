

import 'dart:ffi';



class ComReportModel{


  final int? element_id;
  final String? element_name;
  final int? com_ana_id;
  final int? com_id;
  final double? cqty;
  final double? rqty;
  final String? stat;





  ComReportModel( {
    required this.element_id
    , required this.element_name,
    required this.com_ana_id,
    required this.com_id,
    required this.cqty,
    required this.rqty,
    required this.stat,

  });



  Map<String, dynamic> toJson() {
    return {
      'element_id':element_id,
      'element_name': element_name,
      'com_ana_id': com_ana_id,
      'com_id': com_id,
      'cqty': cqty,
      'rqty': rqty,
      'stat': stat,

    };
  }

  /// Factory constructor to create a Person instance from a Map
  factory ComReportModel.fromMap(Map<String, dynamic> map) {
    return ComReportModel(
      element_id: map['element_id'],
      element_name: map['element_name'],
      com_ana_id: map['com_ana_id'],
      com_id: map['com_id'],
      cqty: map['cqty'],
      rqty: map['rqty'],

      stat: map['stat'],



    );
  }


}