import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

Future<List<String>> uploadFiles(List<File> _images) async {
  var imageUrls =
      await Future.wait(_images.map((_image) => uploadFile(_image)));
  return imageUrls;
}

Future<String> uploadFile(File _image) async {
  Reference storageReference =
      FirebaseStorage.instance.ref().child('adverts/${basename(_image.path)}');
  UploadTask uploadTask = storageReference.putFile(_image);
  await uploadTask.whenComplete(() => null);
  return await storageReference.getDownloadURL();
}
