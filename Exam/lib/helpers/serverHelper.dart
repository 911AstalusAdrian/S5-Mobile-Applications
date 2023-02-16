import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../model/health.dart';

const String _url = "http://10.0.2.2:2307";

class ServerHelper{
  static final ServerHelper instance = ServerHelper._init();
  static final Dio dio = Dio();
  var logger = Logger();

  ServerHelper._init();

  Future<List<String>> getDates() async {
    logger.log(Level.info, 'getDays - Server Call');
    final res = await dio.get('$_url/days');
    logger.log(Level.info, res.data);
    if(res.statusCode == 200){
      final result = res.data as List;
      return result.map((e) => e.toString()).toList();
    } else { throw Exception("Could not retrieve Days!"); }
  }

  Future<List<HealthNote>> getSymptomsByDate(String date) async {
    logger.log(Level.info, 'getSymptomsByDay - Server Call');
    final res = await dio.get('$_url/symptoms/$date');
    logger.log(Level.info, res.data);
    if(res.statusCode == 200){
      final result = res.data as List;
      return result.map((e) => HealthNote.fromJson(e)).toList();
    } else { throw Exception("Could not retrieve Symptoms for this Day!"); }
  }


  Future<HealthNote> addHealthNote(HealthNote hn) async {
    logger.log(Level.info, 'addHealthNote - Server Call');
    final res = await dio.post('$_url/symptom', data: hn.toJsonNoId());
    logger.log(Level.info, res.data);
    if(res.statusCode == 200){
      return HealthNote.fromJson(res.data);
    } else { throw Exception("Could not add Health Note!"); }
  }

  void deleteHealthEntry(int id) async {
    logger.log(Level.info, 'deleteHealthEntry - Server Call');
    final res = await dio.delete('$_url/symptom/$id');
    logger.log(Level.info, res.data);
    if(res.statusCode != 200) { throw Exception("Could not delete Health Note!"); }
  }

  Future<Map<String, int>>getSymptomsForEachMonth() async {

    Map<String, int> finalResult = Map<String, int>();

    logger.log(Level.info, 'getSymptomsForEachMonth - Server Call');
    final res = await dio.get('$_url/entries');
    if(res.statusCode != 200) {throw Exception("Could not perform operation!");}
    final result = res.data as List;
    for(int i = 0; i < result.length; i++ ){
      var date = result[i]['date'];
      var month = date.split('-')[1];

      if(finalResult.containsKey(month)){
        finalResult.update(month, (value) => ++value);
      }
      else{
        finalResult[month] = 1;
      }
    }

    finalResult = Map.fromEntries(finalResult.entries.toList()..sort((e2, e1) => e1.value.compareTo(e2.value)));
    logger.log(Level.info, 'results: $finalResult');
    return finalResult;
  }

  Future<Map<String, int>> getTopDoctors() async {
    Map<String, int> finalResult = Map<String, int>();

    logger.log(Level.info, 'getTopDoctors - Server Call');
    final res = await dio.get('$_url/entries');
    if(res.statusCode != 200) {throw Exception("Could not perform operation!");}
    final result = res.data as List;
    for(int i = 0; i < result.length; i++ ){
      var doctor = result[i]['doctor'];
      if(finalResult.containsKey(doctor)){
        finalResult.update(doctor, (value) => ++value);
      }
      else{
        finalResult[doctor] = 1;
      }
    }

    finalResult = Map.fromEntries(finalResult.entries.toList()..sort((e2, e1) => e1.value.compareTo(e2.value))..sublist(0, 3));
    logger.log(Level.info, 'results: $finalResult');



    return finalResult;
  }
}