// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ListModel {
  final String listTitle;
  String listStatus;
  ListModel({required this.listTitle, required this.listStatus});

  ListModel copyWith({String? listTitle, String? listStatus}) {
    return ListModel(
      listTitle: listTitle ?? this.listTitle,
      listStatus: listStatus ?? this.listStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'listTitle': listTitle, 'listStatus': listStatus};
  }

  factory ListModel.fromMap(Map<String, dynamic> map) {
    return ListModel(
      listTitle: map['listTitle'] as String,
      listStatus: map['listStatus'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListModel.fromJson(String source) =>
      ListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ListModel(listTitle: $listTitle, listStatus: $listStatus)';

  @override
  bool operator ==(covariant ListModel other) {
    if (identical(this, other)) return true;

    return other.listTitle == listTitle && other.listStatus == listStatus;
  }

  @override
  int get hashCode => listTitle.hashCode ^ listStatus.hashCode;
}
