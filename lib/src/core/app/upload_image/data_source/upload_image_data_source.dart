import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasawk/src/core/app/upload_image/model/upload_image_response.dart';
import 'package:tasawk/src/core/service/graphql/api_service.dart';

class UploadImageDataSource {
  UploadImageDataSource(this._apiService);

  final ApiService _apiService;

  Future<UploadImageResource> uploadImage({required XFile file}) async {
    final fromData = FormData();
    fromData.files
        .add(MapEntry('file', await MultipartFile.fromFile(file.path)));
    final res = await _apiService.uploadImage(fromData);
    return res;
  }
}
