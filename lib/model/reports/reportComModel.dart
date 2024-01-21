class ReportComModel {
  int comId;
  String comName;
  double comTotalPrice;
  double totalQty;
  int elementId;
  String elementName;
  double sumAnaBodyQty;
  double sumElementItem;
  String status;

  ReportComModel({
    required this.comId,
    required this.comName,
    required this.comTotalPrice,
    required this.totalQty,
    required this.elementId,
    required this.elementName,
    required this.sumAnaBodyQty,
    required this.sumElementItem,
    required this.status,
  });
}
