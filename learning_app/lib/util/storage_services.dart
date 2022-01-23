import 'dart:io' as io;
import 'package:collection/collection.dart';
import 'package:learning_app/constants/storage_constants.dart';
import 'package:path/path.dart';

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
