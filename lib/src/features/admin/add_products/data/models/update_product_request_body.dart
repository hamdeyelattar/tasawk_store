import 'package:json_annotation/json_annotation.dart';

part 'update_product_request_body.g.dart';

@JsonSerializable()
class UpdateProductRequestBody {
  UpdateProductRequestBody({
    required this.title,
    required this.imageList,
    required this.categoryId,
    required this.description,
    required this.price,
    required this.productId,
  });

  final String title;
  final double price;
  final List<String> imageList;
  final String description;
  final double? categoryId;
  final String productId;

  Map<String, dynamic> toJson() => _$UpdateProductRequestBodyToJson(this);
}
