import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tasawk/src/core/app/upload_image/repo/upload_image_repo.dart';
import 'package:tasawk/src/core/utils/image_picker.dart';

part 'upload_image_state.dart';
part 'upload_image_cubit.freezed.dart';

class UploadImageCubit extends Cubit<UploadImageState> {
  UploadImageCubit(this._repo) : super(const UploadImageState.initial());
  final UploadImageRepo _repo;
  String getImageUrl = '';
  List<String> imageList = ['', '', ''];
  List<String> imageUpdateList = [];
  //pick Image and save it :
  Future<void> uploadImage() async {
    final pickImage = await PicImageUtils().pickImage();
    if (pickImage == null) return;
    emit(const UploadImageState.loading());
    final res = await _repo.uploadImage(pickImage);
    res.when(
      success: (image) {
        getImageUrl = image.location ?? '';
        emit(const UploadImageState.success());
      },
      failure: (error) {
        emit(UploadImageState.error(error: error));
      },
    );
  }

  Future<void> uploadImageList({required int indexId}) async {
    final pickImage = await PicImageUtils().pickImage();
    if (pickImage == null) return;
    emit(UploadImageState.loadingList(indexId));
    final res = await _repo.uploadImage(pickImage);
    res.when(
      success: (image) {
        imageList
          ..removeAt(indexId)
          ..insert(indexId, image.location ?? '');
        emit(const UploadImageState.success());
      },
      failure: (error) {
        emit(UploadImageState.error(error: error));
      },
    );
  }

  Future<void> uploadUpdateImageList({
    required int indexId,
    required List<String> productImageList,
  }) async {
    final pickImage = await PicImageUtils().pickImage();
    if (pickImage == null) return;
    emit(UploadImageState.loadingList(indexId));
    final res = await _repo.uploadImage(pickImage);
    res.when(
      success: (image) {
        imageUpdateList = productImageList;
        imageUpdateList
          ..removeAt(indexId)
          ..insert(indexId, image.location ?? '');
        emit(const UploadImageState.success());
      },
      failure: (error) {
        emit(UploadImageState.error(error: error));
      },
    );
  }

  // remove Image
  void removeImage() {
    getImageUrl = '';
    emit(UploadImageState.removeImage(imageUrl: getImageUrl));
  }
}
