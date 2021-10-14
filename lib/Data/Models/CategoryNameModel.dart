import 'dart:convert';

List<CategoryNameModel> categoryNameModelFromJson(String str) => List<CategoryNameModel>.from(json.decode(str).map((x) => CategoryNameModel.fromJson(x)));

String categoryNameModelToJson(List<CategoryNameModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryNameModel {
  CategoryNameModel({
    required this.id,
    required this.categoryId,
    required this.categoryName,
  });

  String id;
  String categoryId;
  String categoryName;

  factory CategoryNameModel.fromJson(Map<String, dynamic> json) => CategoryNameModel(
    id: json["_id"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "category_id": categoryId,
    "category_name": categoryName,
  };
}
