import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:file_manager/extention.dart';
import 'package:file_manager/file_manager_2.dart';
import 'package:flutter/material.dart';

class AppLifeCycleManager extends StatefulWidget {
  AppLifeCycleManager({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _AppLifeCycleManagerState createState() => _AppLifeCycleManagerState();
}

class _AppLifeCycleManagerState extends State<AppLifeCycleManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    late encrypt.Encrypted encrypted;
    super.didChangeAppLifecycleState(state);
    print('AppLifecycleState: $state');

    if (AppLifecycleState.detached == state) {
      debugPrint("App Life Cycle State detached" + state.toString());
    }
    if (AppLifecycleState.inactive == state) {
      debugPrint("App Life Cycle State Inactive" + state.toString());
    }

    if (AppLifecycleState.paused == state) {
      debugPrint("App Life Cycle State Pause" + state.toString());

     // encrypted = await encryptData(data: FileManager2.logFileData);

    //  debugPrint(
     //     "Base 16 encrypted:=-----------------" + encrypted.base16.toString());

    //  FileManager2.appendDataInFile(
    //      data: encrypted.base16, fileName: DateTime.now().day.toString());
    }
    if (AppLifecycleState.resumed == state) {
    //  FileManager2.logFileData = await FileManager2.readFileData(
    //      fileName: DateTime.now().day.toString());
//
    //  FileManager2.logFileData =
    //      decryptData(encrypted: FileManager2.logFileData.toString());
//
    //  debugPrint(
    //      "decrypted:=-----------------" + FileManager2.logFileData.toString());

      debugPrint("App Life Cycle State resume" + state.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
