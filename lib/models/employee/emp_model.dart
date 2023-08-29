import 'package:json_annotation/json_annotation.dart';

part 'emp_model.g.dart';

@JsonSerializable()
class EmpModel {
  final String name;
  final String department;
  final String designation;
  final String phone;
  final String email;
  final String imageLing;
  EmpModel({
    required this.name,
    required this.department,
    required this.designation,
    required this.phone,
    required this.email,
    required this.imageLing,
  });
  factory EmpModel.fromJson(Map<String, dynamic> json) =>
      _$EmpModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmpModelToJson(this);
}
