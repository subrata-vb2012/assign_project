import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class MediaRepository {
  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<String> uploadMedia(File file, String type) async {
    final fileName = basename(file.path);
    final ref = _storage.ref().child("media/$fileName");
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  Future<void> saveMediaToFirestore(String url, String type) async {
    await _firestore.collection('media').add({'url': url, 'type': type});
  }

  Future<List<Map<String, dynamic>>> fetchAllMedia() async {
    final snapshot = await _firestore.collection('media').get();
    return snapshot.docs.map((e) => e.data()).toList();
  }
  Future<String> downloadMedia(String url, String filename) async {
    final dir = await getExternalStorageDirectory();
    final filePath = '${dir!.path}/$filename';

    final response = await Dio().download(
      url,
      filePath,
      options: Options(responseType: ResponseType.bytes),
    );

    if (response.statusCode == 200) {
      return filePath;
    } else {
      throw Exception("Failed to download file");
    }
  }
}
