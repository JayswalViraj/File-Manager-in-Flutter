import 'dart:io';

import 'package:file_manager/extention.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class FileManager2 {
  static String? localAppPath;
  static String? logFileData;

  ///Get Local Path
  static Future<String> get localPath async {
    debugPrint("Directory: ");
    final directory = await getExternalStorageDirectory();
    //  final directory = await getApplicationDocumentsDirectory();
    debugPrint("Directory: " + directory.toString());
    debugPrint("Directory Path: " + directory!.path.toString());
    // debugPrint("Directory absolute: " + directory.absolute.toString());
    // debugPrint("Directory Uri: " + directory.uri.toString());
    //debugPrint("Directory Parent: " + directory.parent.toString());
    //debugPrint("Directory Parent of Parent path: " +
    //  directory.parent.parent.path.toString());

    return directory.path;
  }

  ///Create File
  static Future<File> localFile({required String? fileName}) async {
    return File('${FileManager2.localAppPath}/${fileName}.txt');
  }

  /// Write Data

  /// static Future writeData(
  ///     {required String data, required String fileName}) async {
  ///   final file = await localFile(fileName: fileName);
  ///
  ///   if (await file.exists() == true) {
  ///     debugPrint("File exist");
  ///
  ///     var sink = file.openWrite(mode: FileMode.append);
  ///     sink.write(getCurrentTime() + data + "\n");
  ///
  ///     // Close the IOSink to free system resources.
  ///     sink.close();
  ///
  ///     return file;
  ///   } else {
  ///     debugPrint("File exist not Exist");
  ///     String fileDeleteMessage = await localFileDelet();
  ///     debugPrint(fileDeleteMessage.toString());
  ///     return file.writeAsString(getTodayDate() +
  ///         "Device Information: " +
  ///         deviceInformation.toString() +
  ///         '\n' +
  ///         data);
  ///   }
  /// }
  ///
  static Future<File> createNewFile({required String fileName}) async {
    try {
      final file = await localFile(fileName: fileName);
      debugPrint("Create New File Fun");
      String fileDeleteMessage = await localFileDelet();

      String data = getTodayDate() +getCurrentTime()+
          "Device Information: " +
          deviceInformation.toString() +
          '\n\n';

      debugPrint(fileDeleteMessage.toString());
      return file.writeAsString(data);
    } catch (e) {
      debugPrint("File exception");

      throw (FileSystemException);
    }
  }

  static Future appendDataInFile(
      {required String data, required String fileName}) async {
    try {
      final file = await localFile(fileName: fileName);

      debugPrint("File exist");

      var sink = file.openWrite(mode: FileMode.append);
      sink.write(getCurrentTime() + data + "\n");

      // Close the IOSink to free system resources.
      sink.close();
    } catch (e) {
      debugPrint("File Exception" + e.toString());
    }
  }

  ///Local File Delete
  static Future<String> localFileDelet() async {
    DateTime dateTime = DateTime.now();

    DateTime dateTimePrev = dateTime.subtract(Duration(days: 3));

    DateTime prevDate = DateTime.parse(dateTimePrev.toString());

    debugPrint("If aviable this name file that will be deleted:-" +
        prevDate.day.toString());

    final file = await localFile(fileName: prevDate.day.toString());

    if (await file.exists() == true) {
      debugPrint("File exist");

      file.delete();
      // Close the IOSink to free system resources.

      return "File Delete Successfully";
    } else {
      return "File not deleted because that is not exist";
    }
  }

  /// Read Data

//  static Future<String> readData({required String? fileName}) async {
//    try {
//      final file = await localFile(fileName: fileName);
//
//      if (file.exists() == true) {
//        final contents = await file.readAsString();
//
//        return contents;
//      } else {
//        writeData(data: "Today File", fileName: DateTime.now().day.toString())
//            .then((value) {});
//
//        final contents = await file.readAsString();
//
//        return contents;
//      }
//    } catch (e) {
//      // If encountering an error, return 0
//      return "Null";
//    }
//  }
//
  static Future<String> readFileData({required String fileName}) async {
    try {
      File file = await localFile(fileName: fileName);

      if (await file.exists() == true) {
        String contents = await file.readAsString();

        return "File Exist Data is:---------   " + contents;
      } else {
        file = await createNewFile(fileName: fileName);
        String contents = await file.readAsString();
        return "File Not Exist:---------------  " + contents;
      }
    } catch (e) {
      return "File Exception" + e.toString();
    }
  }
}
