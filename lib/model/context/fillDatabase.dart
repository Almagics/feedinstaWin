


import 'package:feedinsta/model/analysisRawModel.dart';
import 'package:feedinsta/model/comAnlysisBodyModel.dart';
import 'package:feedinsta/model/comBodyModel.dart';
import 'package:feedinsta/model/comModel.dart';
import 'package:feedinsta/model/elementModel.dart';
import 'package:feedinsta/model/groupComModel.dart';
import 'package:feedinsta/model/groupComanalysisModel.dart';
import 'package:feedinsta/model/groupRawModel.dart';
import 'package:feedinsta/model/itemmodel.dart';

import '../../service/ComAnlysisService.dart';
import '../../service/ComService.dart';
import '../../service/analysisRawService.dart';
import '../../service/comAnlysisBodyService.dart';
import '../../service/comBodyService.dart';
import '../../service/elementService.dart';
import '../../service/groupComAnalysis.dart';
import '../../service/groupComService.dart';
import '../../service/groupRawService.dart';
import '../../service/itemService.dart';
import '../comAnlysisModel.dart';
import 'dbcontext.dart';

class FillDatabase{

  final AnalysisRawService _analysisRawService = AnalysisRawService();
  final ComAnlysisBodyService _ComAnlysisBodyService = ComAnlysisBodyService();
  final ComAnlysisService _ComAnlysisService = ComAnlysisService();
  final ComBodyService _ComBodyService = ComBodyService();
  final ComService _ComService = ComService();
  final ElementService _elementService = ElementService();
  final GroupComAnalysisService _groupComAnalysisService = GroupComAnalysisService();
  final GroupComService _groupComService = GroupComService();
  final GroupRawService _groupRawService = GroupRawService();
  final ItemService _ItemService = ItemService();





  Future<void> insertAll() async {

  //add elements
   await _elementService.insertData(ElementModel(element_name: 'الطاقة'));
   await _elementService.insertData(ElementModel(element_name: 'البروتين'));
   await _elementService.insertData(ElementModel(element_name: 'الدهن'));
   await  _elementService.insertData(ElementModel(element_name: 'الكالسيوم'));
   await _elementService.insertData(ElementModel(element_name: 'فسفور'));


   // add group items
   await _groupRawService.insertData(GroupRawModel(group_raw_name: 'الحبوب'));
   await _groupRawService.insertData(GroupRawModel(group_raw_name: 'الاكساب'));
   await _groupRawService.insertData(GroupRawModel(group_raw_name: 'الاحماض الامينية'));
   await _groupRawService.insertData(GroupRawModel(group_raw_name: 'مركزات'));
   await _groupRawService.insertData(GroupRawModel(group_raw_name: 'الدهون'));
   await _groupRawService.insertData(GroupRawModel(group_raw_name: 'الاضافات'));
   await _groupRawService.insertData(GroupRawModel(group_raw_name: 'خامات اخدي'));


   //add items
   await _ItemService.insertData(ItemModel(item_name: 'ذرة', remarks: '', price: 10, ratio: '', group_raw_id: 1));
   await _ItemService.insertData(ItemModel(item_name: 'صويا', remarks: '', price: 15, ratio: '', group_raw_id: 1));


   //add group anlayis items


    await _analysisRawService.insertData(AnalysisRawModel(raw_id: 1,element_id:1 , raw_ana_qty: .20));
   await _analysisRawService.insertData(AnalysisRawModel(raw_id: 1,element_id:2 , raw_ana_qty: .10));
   await _analysisRawService.insertData(AnalysisRawModel(raw_id: 1,element_id:3 , raw_ana_qty: .5));
   await _analysisRawService.insertData(AnalysisRawModel(raw_id: 1,element_id:4 , raw_ana_qty: .60));
   await _analysisRawService.insertData(AnalysisRawModel(raw_id: 1,element_id:5 , raw_ana_qty: .25));



   //add com analyisis group

   await _groupComAnalysisService.insertData(GroupComAnalysisModel(group_com_analysis_name: 'دجاج التسمين'));
   await _groupComAnalysisService.insertData(GroupComAnalysisModel(group_com_analysis_name: 'دجاج البياض'));
   await _groupComAnalysisService.insertData(GroupComAnalysisModel(group_com_analysis_name: 'دجاج الامهات'));
   await _groupComAnalysisService.insertData(GroupComAnalysisModel(group_com_analysis_name: 'دجاج الساسو'));
   await _groupComAnalysisService.insertData(GroupComAnalysisModel(group_com_analysis_name: 'الدجاج البلدي'));
   await _groupComAnalysisService.insertData(GroupComAnalysisModel(group_com_analysis_name: 'السمان'));
   await _groupComAnalysisService.insertData(GroupComAnalysisModel(group_com_analysis_name: 'الطيور المائية'));
   await _groupComAnalysisService.insertData(GroupComAnalysisModel(group_com_analysis_name: 'الرومي'));
   await _groupComAnalysisService.insertData(GroupComAnalysisModel(group_com_analysis_name: 'النعام'));




  //add com analysis
    await _ComAnlysisService.insertData(ComAnlysisModel(com_ana_name: 'بادي كب ٥٠٠', group_com_analysis_id: 1));
   await _ComAnlysisService.insertData(ComAnlysisModel(com_ana_name: 'ناهي ٢٥', group_com_analysis_id: 1));
   await _ComAnlysisService.insertData(ComAnlysisModel(com_ana_name: 'بادي ٢٥', group_com_analysis_id: 1));


   //add com analysis body
   await _ComAnlysisBodyService.insertData(ComAnlysisBodyModel(ana_body_qty: 20,element_id:1, com_ana_id: 1));
   await _ComAnlysisBodyService.insertData(ComAnlysisBodyModel(ana_body_qty: 10,element_id:2, com_ana_id: 1));
   await _ComAnlysisBodyService.insertData(ComAnlysisBodyModel(ana_body_qty: 30,element_id:3, com_ana_id: 1));
   await _ComAnlysisBodyService.insertData(ComAnlysisBodyModel(ana_body_qty: 34,element_id:4, com_ana_id: 1));
   await _ComAnlysisBodyService.insertData(ComAnlysisBodyModel(ana_body_qty: 11,element_id:5, com_ana_id: 1));




   //add group com

    await _groupComService.insertData(GroupComModel(group_com_name: 'تركيبات دجاج التسمين'));
   await _groupComService.insertData(GroupComModel(group_com_name: 'تركيبات دجاج البياض'));
   await _groupComService.insertData(GroupComModel(group_com_name: 'تركيبات دجاج الأمهات'));
   await _groupComService.insertData(GroupComModel(group_com_name: 'تركيبات دجاج الساسو'));
   await _groupComService.insertData(GroupComModel(group_com_name: 'تركيبات الدجاج البلدي'));
   await _groupComService.insertData(GroupComModel(group_com_name: 'تركيبات السمان'));
   await _groupComService.insertData(GroupComModel(group_com_name: 'تركيبات الطيور المائية'));
   await _groupComService.insertData(GroupComModel(group_com_name: 'تركيبات الرومي'));
   await _groupComService.insertData(GroupComModel(group_com_name: 'تركيبات النعام'));


   //add com

    await _ComService.insertData(ComModel(com_name: 'تركيبة بادي ٢٣', com_ana_id: 1, com_qty: 1000, total_amount: 2000, group_com_id: 1));
   await _ComService.insertData(ComModel(com_name: 'تركيبة ناهي', com_ana_id: 2, com_qty: 100, total_amount: 1500, group_com_id: 1));

   //add com body
   await _ComBodyService.insertData(ComBodyModel(ram_item_id: 1, com_body_qty: 20, total_price: 240)) ;
   await _ComBodyService.insertData(ComBodyModel(ram_item_id: 2, com_body_qty: 50, total_price: 240)) ;

  }
}
  
  
  
  
  
  





