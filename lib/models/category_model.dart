
import 'dart:convert';

CategoryModel categoryModelFromJson(String str)=>CategoryModel.fromJson(json.decode(str));
// String categoryModelToJson(CategoryModel data)=>json.encode(data.toJson());

class CategoryModel{

  CategoryModel({
    required this.categories,
});
  List<Category> categories;

  factory CategoryModel.fromJson(Map<String, dynamic> json)=>CategoryModel(
    categories: List<Category>.from(json["categories"].map((e) =>Category.fromJson(e)))
  );
  // Map<String, dynamic> toJson()=>{
  //   "categories":List<dynamic>.from(categories.map((e) =>e.toJson())),
  // };

}
class Category{
 String name;
 List<String> subCategory;
 Category({
   required this.name,
   required this.subCategory
});

 factory Category.fromJson(Map<String, dynamic> json)=>Category(
   name: json["name"],
   subCategory: List<String>.from(json["subCategory"].map((e) =>e))
 );
 // Map<String, dynamic> toJson()=>{
 //   "name": name,
 //   "subCategory": List<dynamic>.from(subCategory.map((e) =>e))
 // };
}
