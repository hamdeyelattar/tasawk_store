import 'package:image_picker/image_picker.dart';
import 'package:tasawk/src/core/app/upload_image/data_source/upload_image_data_source.dart';
import 'package:tasawk/src/core/app/upload_image/model/upload_image_response.dart';
import 'package:tasawk/src/core/service/graphql/api_result.dart';

class UploadImageRepo {
  UploadImageRepo(this._dataSource);

  final UploadImageDataSource _dataSource;

  Future<ApiResult<UploadImageResource>> uploadImage(XFile imageFile) async {
    try {
      final res = await _dataSource.uploadImage(file: imageFile);
      return ApiResult.success(res);
    } catch (e) {
      return const ApiResult.failure('Please, try agian we have error');
    }
  }
}
