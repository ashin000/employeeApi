// To parse this JSON data, do
//
//     final employeeModel = employeeModelFromJson(jsonString);

import 'dart:convert';

EmployeeModel employeeModelFromJson(String str) => EmployeeModel.fromJson(json.decode(str));

String employeeModelToJson(EmployeeModel data) => json.encode(data.toJson());

class EmployeeModel {
  int? status;
  String? message;
  Data? data;

  EmployeeModel({
    this.status,
    this.message,
    this.data,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  List<Employee>? employee;

  Data({
    this.employee,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    employee: json["employee"] == null ? [] : List<Employee>.from(json["employee"]!.map((x) => Employee.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "employee": employee == null ? [] : List<dynamic>.from(employee!.map((x) => x.toJson())),
  };
}

class Employee {
  int? id;
  String? name;
  String? role;

  Employee({
    this.id,
    this.name,
    this.role,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    name: json["name"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "role": role,
  };
}
