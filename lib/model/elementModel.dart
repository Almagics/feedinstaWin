

import 'dart:ffi';



class ElementModel{


  final int? element_id;
  final String? element_name;
  final String? element_remarks;




  ElementModel( { this.element_id, required this.element_name,  this.element_remarks});



  Map<String, dynamic> toJson() {
    return {
      'element_id':element_id,
      'element_name': element_name,
      'element_remarks': element_remarks,

    };
  }

  /// Factory constructor to create a Person instance from a Map
  factory ElementModel.fromMap(Map<String, dynamic> map) {
    return ElementModel(
      element_id: map['element_id'],
      element_name: map['element_name'],
      element_remarks: map['element_remarks'],


    );
  }


  Map<String, dynamic> toMap() {
    return {
      'element_id': element_id,
      'element_name': element_name,
      'element_remarks':element_remarks

    };
  }




}