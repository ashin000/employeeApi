import 'dart:developer';

import 'package:apiexam/respository/api/homescreen/model/homescreenmodel.dart';
import 'package:apiexam/respository/api/homescreen/service/homescreen_service.dart';
import 'package:flutter/material.dart';

class HomescreenController with ChangeNotifier {
  EmployeeModel employeeModel = EmployeeModel();

  bool isLoading = false;

  fetchEmpList() async {
    isLoading = true;
    notifyListeners();
    try {
      var data = await HomescreenService.getempList();
      if (data != null) {
        employeeModel = EmployeeModel.fromJson(data);
      } else {
        log("Failed to fetch employee list");
      }
    } catch (e) {
      log("error fetching employee list");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void addEmployee({required String name, required String role}) {
    var data = {"name": name, "role": role};
    HomescreenService.postEmp(data).then((decodedData) {
      print("success i.e status ==1");
      if (decodedData["status"] == 1) {
        print("employee Added Successfully");
      } else {
        var message = "error in api";
        print(message);
        // AppUtils.oneTimeSnackBar(message, context: context);
      }
    });
  }

  void deleteEmployee(id) {
    HomescreenService.deleteEmp(id).then((value) {
      if (value["status"] == 1) {
        log("delete success");
      } else {
        log("delete failed");
      }
    });
  }

  void updateEmployee({required String name, required String role, int? id}) {
    var data = {"name": name, "role": role};
    HomescreenService.putEmp(data, id).then((decodedData) {
      print("success i.e status ==1");
      if (decodedData["status"] == 1) {
        print("employee updated Successfully");
      } else {
        var message = "error in api";
        print(message);
        // AppUtils.oneTimeSnackBar(message, context: context);
      }
    });
  }
}

//   void updateEmployee({required String name, required String role, id}) {
//     var data ={"name":name,"role":role,"id":id
//   };
//     HomescreenService.putEmp(data).thedn((decodedData) {
//       print("success i.e status ==1");
//       if (decodedData["status"] == 1) {
//         print("employee Added Successfully");
//       } else {
//         var message = "error in api";
//         print(message);
//         // AppUtils.oneTimeSnackBar(message, context: context);
//       }
//     });
// }
