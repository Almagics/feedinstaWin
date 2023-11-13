

import 'dart:ffi';



class ComAnlysisModel{


  final int? com_ana_id;
  final String? com_ana_name;
  final String? com_ana_remarks;




  ComAnlysisModel( { this.com_ana_id, required this.com_ana_name,  this.com_ana_remarks});



  Map<String, dynamic> toJson() {
    return {
      'com_ana_id':com_ana_id,
      'com_ana_name': com_ana_name,
      'com_ana_remarks': com_ana_remarks,

    };
  }

  /// Factory constructor to create a Person instance from a Map
  factory ComAnlysisModel.fromMap(Map<String, dynamic> map) {
    return ComAnlysisModel(
      com_ana_id: map['com_ana_id'],
      com_ana_name: map['com_ana_name'],
      com_ana_remarks: map['com_ana_remarks'],


    );
  }


}