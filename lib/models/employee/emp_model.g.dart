// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmpModel _$EmpModelFromJson(Map<String, dynamic> json) => EmpModel(
      name: json['name'] as String,
      department: json['department'] as String,
      designation: json['designation'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      imageLing: json['imageLing'] as String,
    );

Map<String, dynamic> _$EmpModelToJson(EmpModel instance) => <String, dynamic>{
      'name': instance.name,
      'department': instance.department,
      'designation': instance.designation,
      'phone': instance.phone,
      'email': instance.email,
      'imageLing': instance.imageLing,
    };
