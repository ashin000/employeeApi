import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:apiexam/appconfig/app_config.dart';

class ApiHelper {
  static getData({
    required String endPoint,
    Map<String, String>? header,
  }) async {
    log("ApiHelper>getData");
    final url = Uri.parse(Appconfig.baseUrl + endPoint);
    try {
      var response = await http.get(url, headers: header);
      log("Api Called => status code=${response.statusCode}");
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        log(decodedData.toString());
        var data = {
          "data": decodedData,
          "status": 1,
        };
        return data;
      }
    } catch (e) {
      log("$e");
    }
  }

  //for post
  static Future postData(
      {
      //future added
      required String endPoint,
      Map<String, String>? header,
      required Map<String, dynamic> body,
      String? finalUrl}) async {
    log("Api-helper>postData 5");
    log("$body");

    final url = Uri.parse(Appconfig.baseUrl + endPoint);
    // final url = Uri.parse("http://10.11.0.236:8000/cropmapp/register/");
    //code from gpt
    log("Request URL: $url");
    try {
      final response = await http.post(url, body: body);
// After response
      log("Response Status Code: ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.body;
        var decodedData = jsonDecode(data);
        log(decodedData["status"].toString());
        return decodedData;
      } else {
        log("Else Condition -> Api failed");
        var data = response.body;
        var decodedData = jsonDecode(data);
        log(decodedData["status"].toString());
        return decodedData;
      }
    } catch (e) {
      var error = e.toString();
      log(">>>>>>>>>>>>: $error");
    }
  }

//for delete

  static Future<Map<String, dynamic>> deleteData(
      {required String endPoint,
      Map<String, String>? header,
      Map<String, dynamic>? body}) async {
    Uri url = Uri.parse(Appconfig.baseUrl + endPoint);
    try {
      final response =
          await http.delete(url, headers: header, body: jsonEncode(body));
      //jsonEncode il body pass akanam

      return _handleResponse(response);
    } catch (e) {
      print("Error: $e");
      return _handleError(e);
    }
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      var decodedData = jsonDecode(response.body);
      return {
        "data": decodedData,
        "status": 1,
      };
    } else {
      print("API Error: ${response.statusCode}");
      return {
        "data": null,
        "status": 0,
      };
    }
  }

  static Map<String, dynamic> _handleError(dynamic error) {
    print("API Error: $error");
    return {
      "data": null,
      "status": 0,
    };
  }
//put
  static Future<dynamic> updateData(
      {required String endPoint, required Map<String, dynamic> body}) async {
    Uri url = Uri.parse(Appconfig.baseUrl + endPoint);
    log("request url ==== $url");

    try {
      final response = await http.put(url, body: body);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        return decodedData;
      } else {
        log(" update api failed");
      }
    } catch (e) {
      log("$e");
    }
  }
}
