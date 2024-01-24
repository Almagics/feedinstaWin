class ReportComModel {
  int comId;
  String comName;
  double? comTotalPrice;
  double? totalQty;
  int elementId;
  String elementName;
  double sumAnaBodyQty;
  double? sumElementItem;
  String? status;
  int? item_id;
  int? com_ana_id;


  ReportComModel({
    required this.comId,
    required this.comName,
     this.comTotalPrice,
     this.totalQty,
    required this.elementId,
    required this.elementName,
    required this.sumAnaBodyQty,
     this.sumElementItem,
     this.status,
     this.item_id,
     this.com_ana_id,
  });
}
