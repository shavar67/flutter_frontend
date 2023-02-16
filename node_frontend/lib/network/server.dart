import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../model/data_model.dart';

var logger = Logger();
Future<List<DataModel>> requestData() async {
  const baseUrl = "http://127.0.0.1:8080";
  Uri uri = Uri.parse(baseUrl);
  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      logger.i(response.body);
      var data = json.decode(response.body);
      var list =
          (data as List).map((item) => DataModel.fromJson(item)).toList();

      return list;
    } else {
      throw Exception(response.reasonPhrase);
    }
  } on SocketException catch (e) {
    logger.e('$e');
    throw SocketException(e.message);
  } on Exception catch (e) {
    throw Exception(e);
  }
}
