// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GridModel {
  final String imagePath;
  GridModel({required this.imagePath});

  GridModel copyWith({String? imagePath}) {
    return GridModel(imagePath: imagePath ?? this.imagePath);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'imagePath': imagePath};
  }

  factory GridModel.fromMap(Map<String, dynamic> map) {
    return GridModel(imagePath: map['imagePath'] as String);
  }

  String toJson() => json.encode(toMap());

  factory GridModel.fromJson(String source) =>
      GridModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GridModel(imagePath: $imagePath)';

  @override
  bool operator ==(covariant GridModel other) {
    if (identical(this, other)) return true;

    return other.imagePath == imagePath;
  }

  @override
  int get hashCode => imagePath.hashCode;
}
