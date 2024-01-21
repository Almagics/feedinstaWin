class GroupComModel{


  final int? group_com_id;
  final String? group_com_name;





  GroupComModel( { this.group_com_id, required this.group_com_name});



  Map<String, dynamic> toJson() {
    return {
      'group_com_id':group_com_id,
      'group_com_name': group_com_name,


    };
  }

  /// Factory constructor to create a Person instance from a Map
  factory GroupComModel.fromMap(Map<String, dynamic> map) {
    return GroupComModel(
      group_com_id: map['group_com_id'],
      group_com_name: map['group_com_name'],



    );
  }
}
