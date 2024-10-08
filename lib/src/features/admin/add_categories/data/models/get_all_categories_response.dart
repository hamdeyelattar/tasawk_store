import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_all_categories_response.g.dart';

@JsonSerializable()
class CategoriesGetAllResponse {
  CategoriesGetAllResponse(this.data);

  factory CategoriesGetAllResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesGetAllResponseFromJson(json);

  final CategoriesGetAllData data;

  List<CategoriesGetAllModel> get categoriesList {
    if (data.categoriesList.isEmpty) {
      return [];
    }
    return data.categoriesList.reversed.toList();
  }

  List<String> get categoryDropDownList {
    final list = data.categoriesList.map((e) => e.name ?? '').toList();

    return list;
  }
}

@JsonSerializable()
class CategoriesGetAllData {
  CategoriesGetAllData(this.categoriesList);
  factory CategoriesGetAllData.fromJson(Map<String, dynamic> json) =>
      _$CategoriesGetAllDataFromJson(json);

  @JsonKey(name: 'categories')
  final List<CategoriesGetAllModel> categoriesList;
}

@JsonSerializable()
class CategoriesGetAllModel {
  CategoriesGetAllModel(this.name, this.id, this.image);

  factory CategoriesGetAllModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesGetAllModelFromJson(json);

  final String? name;
  final String? id;
  final String? image;
}
