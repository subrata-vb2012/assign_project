import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../models/media_response.dart.dart';
import '../repositories/media_repository.dart';

class MediaController extends GetxController {
  final MediaRepository _repo = MediaRepository();
  final mediaList = <MediaResponse>[].obs;

  final ImagePicker _picker = ImagePicker();


  Future<void> pickAndUploadImage({bool fromCamera = false}) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    );

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final url = await _repo.uploadMedia(file, 'image');
      await _repo.saveMediaToFirestore(url, 'image');
      mediaList.add(MediaResponse(url: url, type: 'image'));
    }
  }

  Future<void> pickAndUploadVideo() async {
    final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final url = await _repo.uploadMedia(file, 'video');
      await _repo.saveMediaToFirestore(url, 'video');
      mediaList.add(MediaResponse(url: url, type: 'video'));
    }
  }

  Future<void> fetchMedia() async {
    final data = await _repo.fetchAllMedia();
    mediaList.assignAll(data.map((e) => MediaResponse.fromMap(e)).toList());
  }



  @override
  void onInit() {
    // TODO: implement onInit
    fetchMedia();
    print("mediaList.length>>> ${mediaList.length}");
  }
}
