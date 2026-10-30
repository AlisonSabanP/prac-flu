import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Escribe archivos generados en el almacenamiento de la app y los comparte.
///
/// El almacenamiento interno de la app no requiere permisos en Android.
class FileExporter {
  const FileExporter();

  Future<File> writeTextFile({
    required String fileName,
    required String contents,
  }) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final Directory exports = Directory('${directory.path}/exportaciones');
    if (!await exports.exists()) {
      await exports.create(recursive: true);
    }
    final File file = File('${exports.path}/$fileName');
    await file.writeAsString(contents, flush: true);
    return file;
  }

  Future<File> writeBytes({
    required String fileName,
    required List<int> bytes,
  }) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final Directory exports = Directory('${directory.path}/exportaciones');
    if (!await exports.exists()) {
      await exports.create(recursive: true);
    }
    final File file = File('${exports.path}/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  Future<void> shareFile(File file, {String? text}) async {
    await Share.shareXFiles(<XFile>[XFile(file.path)], text: text);
  }
}
