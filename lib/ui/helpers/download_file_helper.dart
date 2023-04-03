import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sosty/infraestructure/helpers/api_client/api_client.dart';
import 'package:sosty/infraestructure/helpers/api_client/exception/api_exception.dart';
import 'package:uuid/uuid.dart';

class DownloadFileHelper {
  late String _localPath;
  late bool _permissionReady;
  late TargetPlatform? _platform;
  late ApiClient _apiClient;

  static const _downloadFilerError = "Error al descargar el archivo";

  DownloadFileHelper() {
    _apiClient = ApiClient();
    if (Platform.isAndroid) {
      _platform = TargetPlatform.android;
    } else {
      _platform = TargetPlatform.iOS;
    }
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _showMessage(
      BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  Future<bool> _checkStoragePermission() async {
    final status = await Permission.storage.request();
    switch (status) {
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        return false;
    }
  }

  Future<String?> _findLocalPath() async {
    if (_platform == TargetPlatform.android) {
      // /storage/emulated/0/Download
      return "/sdcard/download";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return '${directory.path}${Platform.pathSeparator}Download';
    }
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;

    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Map<String, String> _getFileNameAndExtension(String fileName) {
    final fileSplit = fileName.split('.');
    final fileExtension = fileSplit.last;
    fileSplit.removeLast();
    return {
      'name': fileSplit.join(),
      'extension': fileExtension,
    };
  }

  void downloadFile({
    required BuildContext context,
    required String url,
    Map<String, String?>? params,
    String? fileName,
  }) async {
    _permissionReady = await _checkStoragePermission();
    if (_permissionReady) {
      try {
        await _prepareSaveDir();
        final response = await _apiClient.get(url, params: params);
        if (response.status == HttpStatus.ok) {
          const uuid = Uuid();
          final fName = fileName ?? url.split('/').last;
          final fileMap = _getFileNameAndExtension(fName);

          File("$_localPath/${fileMap['name']}_${uuid.v4()}.${fileMap['extension']}")
              .writeAsBytes(response.bodyBytes);
          if (context.mounted) {
            _showMessage(context, "Archivo descargado correctamente");
          }
        } else {
          if (context.mounted) _showMessage(context, _downloadFilerError);
        }
      } on ApiException catch (e) {
        if (kDebugMode) {
          print("DOWNLOAD_FILE_FAILED => ${e.toString()}");
        }
        if (context.mounted) _showMessage(context, _downloadFilerError);
      }
    }
  }
}
