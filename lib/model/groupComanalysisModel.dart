class GroupComAnalysisModel{


  final int? group_com_analysis_id;
  final String? group_com_analysis_name;





  GroupComAnalysisModel( { this.group_com_analysis_id, required this.group_com_analysis_name});



  Map<String, dynamic> toJson() {
    return {
      'group_com_analysis_id':group_com_analysis_id,
      'group_com_analysis_name': group_com_analysis_name,


    };
  }

  /// Factory constructor to create a Person instance from a Map
  factory GroupComAnalysisModel.fromMap(Map<String, dynamic> map) {
    return GroupComAnalysisModel(
      group_com_analysis_id: map['group_com_analysis_id'],
      group_com_analysis_name: map['group_com_analysis_name'],



    );
  }


  Map<String, dynamic> toMap() {
    return {
      'group_com_analysis_id': group_com_analysis_id,
      'group_com_analysis_name': group_com_analysis_name,


    };
  }


}
