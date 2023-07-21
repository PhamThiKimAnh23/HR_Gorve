import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'DateTimes.dart';

class FileUtils {
  static Future<String> getExternalStoragePath() async {
    Directory directory;
    if (Platform.isAndroid) {
      //directory = await getExternalStorageDirectory();
      directory = (await getExternalStorageDirectory())!;
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    return directory.path;
  }

  static Future<File> createAudio() async {
    try {
      String fileName = "AUDIO_" +
          DateTimes.today().toString() +
          "_" +
          DateTime.now().millisecondsSinceEpoch.toString();
      String external = await getExternalStoragePath();
      Directory directory;
      if (Platform.isAndroid) {
        directory = Directory(
            '$external/SyngentaAudit/Audios/' + DateTimes.today().toString() + '/');
      } else {
        directory =
            Directory('$external/Audios/' + DateTimes.today().toString() + '/');
      }
      if (!await directory.exists()) {
        directory = await directory.create(recursive: true);
      }
      return new File(join(directory.path, fileName + '.mp4'));
    } catch (ex) {
      throw ex;
    }
  }

  static Future<File> createImage() async {
    try {
      String fileName = "IMAGE_" +
          DateTimes.today().toString() +
          "_" +
          DateTime.now().millisecondsSinceEpoch.toString();
      String external = await getExternalStoragePath();
      Directory directory;
      if (Platform.isAndroid) {
        directory = Directory(
            '$external/SyngentaAudit/Images/' + DateTimes.today().toString() + '/');
      } else {
        directory =
            Directory('$external/Images/' + DateTimes.today().toString() + '/');
      }
      if (!await directory.exists()) {
        directory = await directory.create(recursive: true);
      }
      return new File(join(directory.path, fileName + '.jpg'));
    } catch (ex) {
      throw ex;
    }
  }

  static Future<ByteData> loadAsset(String path) async {
    return await rootBundle.load(path);
  }

  static Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }


}
