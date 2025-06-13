import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';

import '../../core/models/api/api_model.dart';

final class PackageServices {
  late final AndroidDeviceInfo androidInfo;
  late final IosDeviceInfo iosInfo;

  Future<void> getDeviceInfo() async {
    try {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) androidInfo = await deviceInfo.androidInfo;
      if (Platform.isIOS) iosInfo = await deviceInfo.iosInfo;
    } catch (e) {
      debugPrint("$e");
    }
  }

  Future<String> getDeviceId() async {
    String deviceId = "";
    if (Platform.isAndroid) deviceId = androidInfo.id;
    if (Platform.isIOS) deviceId = iosInfo.identifierForVendor ?? '';
    return deviceId;
  }

  Future<FileInfo?> pickFile({
    required final List<String> allowedFileExt,
  }) async {
    try {
      final pickedFile = await FilePicker.platform.pickFiles(
        allowedExtensions: allowedFileExt,
        type: FileType.custom,
      );
      if (pickedFile == null || pickedFile.files.isEmpty) return null;
      final tempFile = pickedFile.files.first;
      if (tempFile.path != null &&
          tempFile.extension != null &&
          tempFile.path!.isNotEmpty &&
          tempFile.extension!.isNotEmpty) {
        return FileInfo(
          path: tempFile.path!,
          name: tempFile.name,
          ext: tempFile.extension!,
        );
      }
    } catch (e) {
      debugPrint("pickFile Error : $e");
      return null;
    }
    return null;
  }

  Future<List<FileInfo>> pickFiles({
    required final List<String> allowedFilesExt,
    final FileType fileType = FileType.custom,
  }) async {
    final List<FileInfo> files = [];
    try {
      final pickedFile = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        allowedExtensions: allowedFilesExt,
        type: fileType,
      );
      if (pickedFile == null || pickedFile.files.isEmpty) return files;
      for (final file in pickedFile.files) {
        if (file.path != null &&
            file.extension != null &&
            file.path!.isNotEmpty &&
            file.extension!.isNotEmpty) {
          files.add(
            FileInfo(path: file.path!, name: file.name, ext: file.extension!),
          );
        }
      }
      return files;
    } catch (e) {
      debugPrint("pickFiles Error : $e");
      return files;
    }
  }
}
