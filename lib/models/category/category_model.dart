import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CategoryModel extends Equatable {
  final String name;
  final String imageUrl;
  final Color backgroundColor;
  const CategoryModel({
    required this.name,
    required this.imageUrl,
    required this.backgroundColor,
  });

  CategoryModel copyWith({
    String? name,
    String? imageUrl,
    Color? backgroundColor,
  }) {
    return CategoryModel(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'imageUrl': imageUrl,
      'backgroundColor': backgroundColor.value,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      backgroundColor: Color(map['backgroundColor']),
    );
  }

  @override
  List<Object?> get props => [name, imageUrl, backgroundColor];
}

