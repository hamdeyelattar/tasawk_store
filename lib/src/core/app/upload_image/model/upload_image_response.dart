import 'package:freezed_annotation/freezed_annotation.dart';
part 'upload_image_response.g.dart';

@JsonSerializable()
class UploadImageResource {
  UploadImageResource(this.location);
  factory UploadImageResource.fromJson(Map<String, dynamic> json) =>
      _$UploadImageResourceFromJson(json);

  final String? location;
}
