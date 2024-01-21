class GroupRawModel{


  final int? group_raw_id;
  final String? group_raw_name;





  GroupRawModel( { this.group_raw_id, required this.group_raw_name});



  Map<String, dynamic> toJson() {
    return {
      'group_raw_id':group_raw_id,
      'group_raw_name': group_raw_name,


    };
  }

  /// Factory constructor to create a Person instance from a Map
  factory GroupRawModel.fromMap(Map<String, dynamic> map) {
    return GroupRawModel(
      group_raw_id: map['group_raw_id'],
      group_raw_name: map['group_raw_name'],



    );
  }
}
