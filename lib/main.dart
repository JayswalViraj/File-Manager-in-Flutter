import 'package:file_manager/app_life_cycle_manager.dart';
import 'package:file_manager/extention.dart';
import 'package:file_manager/file_manager_2.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(AppLifeCycleManager(child: MaterialApp(home: MyApp())));

  // getDeviceInfo().then((deviceInfo) {
  //    deviceInformation = deviceInfo.toString();
//
  //     FileManager2.readData(fileName: DateTime.now().day.toString()).then((value) {
  //        debugPrint("Data:------------------" + value.toString());
  //      });
//
////Call
  //  });

  deviceInformation = await getDeviceInfo();
  FileManager2.localAppPath = await FileManager2.localPath;

  FileManager2.logFileData =
      await FileManager2.readFileData(fileName: DateTime.now().day.toString())
          as String;

  debugPrint(FileManager2.logFileData.toString());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();

    /*   getDeviceInfo().then((deviceInfo) {
      deviceInformation = deviceInfo.toString();

   FileManager2.writeData(data: "Today File\n", fileName: DateTime.now().day.toString())
          .then((value) {
        FileManager2.readData(fileName: DateTime.now().day.toString()).then((value) {
          debugPrint("Data:------------------" + value.toString());
        });
      });//Call
    });
    */
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                FileManager2.appendDataInFile(
                    data: "This is data\n",
                    fileName: DateTime.now().day.toString());
              },
              child: Text("File Manager")),
        ],
      ),
    );
  }
}
