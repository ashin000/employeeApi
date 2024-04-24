import 'dart:developer';

import 'package:apiexam/respository/helper/api_helper.dart';

class HomescreenService {
  static Future<dynamic> getempList() async {
    try {
      var decodedData =
          await ApiHelper.getData(endPoint: "flutter_exam/employees/");
      log('service=>' + decodedData.toString());
      if (decodedData != null && decodedData["status"] == 1) {
        log("Data fetched successfully");
        return decodedData['data'];
      } else {
        log("Failed to fetch data: ${decodedData?["status"]}");
        return null;
      }
    } catch (e) {
      log("Error fetching data:$e");
      return null;
    }
  }

  static postEmp(Map<String, String> data) async {
    try {
      var decodedData = await ApiHelper.postData(
          endPoint: "flutter_exam/employees/create/", body: data);
      log(decodedData.toString());
      if (decodedData["status"] == 1) {
        return decodedData;
      } else {
        log(decodedData["status"].toString());
        return decodedData;
      }
    } catch (e) {
      log("$e");
    }
  }

  static deleteEmp(id) async {
    try {
      var decodedData =
          await ApiHelper.deleteData(endPoint: "flutter_exam/employees/$id/");
      if (decodedData["status"] == 1) {
        return decodedData;
      } else {
        log(decodedData["status"].toString());
        return decodedData;
      }
    } catch (e) {
      log("$e");
    }
  }

  static putEmp(
    Map<String, dynamic> data,
    id,
  ) async {
    try {
      var decodedData = await ApiHelper.updateData(
          endPoint: "flutter_exam/employees/update/$id/", body: data);
      log(decodedData.toString());
      if (decodedData["status"] == 1) {
        return decodedData;
      } else {
        log(decodedData["status"].toString());
        return decodedData;
      }
    } catch (e) {
      log("$e");
    }
  }
}
