import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../model/data_model.dart';
import '../network/server.dart';

class DataProvider with ChangeNotifier {
  bool isLoading = false;
  List<DataModel> dataModel = [];
  Logger logger = Logger();

  getContentData() async {
    isLoading = true;
    dataModel = await requestData();
    isLoading = false;
    notifyListeners();
  }
}
