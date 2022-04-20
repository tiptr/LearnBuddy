import 'dart:convert';
import 'dart:io' as io;
import 'package:archive/archive_io.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:learning_app/constants/storage_constants.dart';
import 'package:learning_app/shared/shared_preferences_data.dart';
import 'package:learning_app/util/formatting_comparison/date_time_extensions.dart';
import 'package:path/path.dart';
import 'logger.dart';

/// Provides the subfolder of the protected app storage directory
/// used to store user data (database, pictures...)
io.Directory get appStorageDirectory {
  final customLocation = SharedPreferencesData.storageLocation;
  return io.Directory.fromRawPath(const Utf8Encoder().convert(customLocation));
}

/// Exports the user data as zip archive to a user-defined directory
Future<bool> exportStorage() async {
  final directory = appStorageDirectory;
  final encoder = ZipFileEncoder();

  String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

  if (selectedDirectory == null) {
    // User canceled the picker
    logger.d('Folder selection canceled by the user');
    return false;
  }

  final exportFileName =
      exportFileNameBase + DateTime.now().formatAlphabeticSorting() + '.zip';

  final exportFilePath = join(selectedDirectory, exportFileName);

  encoder.create(exportFilePath, modified: DateTime.now());
  for (final file in directory.listSync()) {
    if (file is io.File) {
      encoder.addFile(file);
    } else if (file is io.Directory) {
      encoder.addDirectory(file);
    }
  }
  encoder.close();

  return true;
}

/// Imports a zip archive with user data into the protected app directory
Future<bool> importStorage() async {
  final directory = appStorageDirectory;
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result == null || result.files.single.path == null) {
    // No file selected
    return false;
  }

  // Delete the current app directory
  directory.deleteSync(recursive: true);

  final io.File file = io.File(result.files.single.path as String);
  final bytes = file.readAsBytesSync();
  final archive = ZipDecoder().decodeBytes(bytes);

  // TODO: validate the decoded data
  // TODO: check the version of the imported data
  // TODO: -> migrate older versions accordingly

  // Decode and save the loaded zip
  for (final file in archive) {
    final filename = file.name;
    final filePath = join(directory.path, filename);
    if (file.isFile) {
      final data = file.content as List<int>;
      io.File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(data);
    } else {
      io.Directory(filePath).create(recursive: true);
    }
  }

  return true;
}

// The rest of this file contains currently unused storage service functions
// that could come become relevant again at a later point

bool isFolderEmpty(String path) {
  final folder = io.Directory(path);

  if (folder.existsSync()) {
    final children = folder.listSync();
    return children.isEmpty;
  } else {
    return true;
  }
}

bool doesContainDatabase(String path) {
  final folder = io.Directory(path);

  if (folder.existsSync()) {
    final children = folder.listSync();
    final found = children
        .firstWhereOrNull((entity) => basename(entity.path) == databaseName);
    return found != null;
  } else {
    return false;
  }
}

void deleteDirectoryContent(String path) {
  final folder = io.Directory(path);

  if (folder.existsSync()) {
    for (var child in folder.listSync()) {
      child.delete(recursive: true);
    }
  }
}

void moveContentToNewDirectory(
    {required String oldPath, required String newPath}) {
  final oldFolder = io.Directory(oldPath);

  if (oldFolder.existsSync()) {
    for (var child in oldFolder.listSync()) {
      if (child is io.File) {
        final fileName = basename(child.path);
        final newFilePath = join(newPath, fileName);
        moveFile(child, newFilePath);
      } else if (child is io.Directory) {
        // recursively move the contents of the subdirectory
        final subDirName = basename(child.path);
        final newSubPath = join(newPath, subDirName);
        moveContentToNewDirectory(oldPath: child.path, newPath: newSubPath);
      }
    }
  }
}

io.File moveFile(io.File sourceFile, String newPath) {
  try {
    // prefer using rename as it is probably faster
    return sourceFile.renameSync(newPath);
  } on io.FileSystemException {
    // if rename fails, copy the source file and then delete it
    final newFile = sourceFile.copySync(newPath);
    sourceFile.deleteSync();
    return newFile;
  }
}
