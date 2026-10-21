import 'dart:io';
import 'dart:ui';

import 'package:app_failure/app_failure.dart';
import 'package:archive/archive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../domain/services/i_app_log_share_service.dart';
import '../domain/services/i_app_logger_service.dart';

class AppLogShareService implements IAppLogShareService {
  final IAppLoggerService _logger;
  final String _archivePassword;

  const AppLogShareService(this._logger, {required String archivePassword})
      : _archivePassword = archivePassword;

  @override
  Future<AppResult<void>> shareLog() async {
    try {
      if (_archivePassword.isEmpty) {
        throw StateError('Apollo log archive password is empty.');
      }
      final snapshot = (await _logger.snapshotLog()).fold(
        (content) => content,
        (failure) => throw failure,
      );
      final temporaryDirectory = await getTemporaryDirectory();
      final exportDirectory = Directory('${temporaryDirectory.path}/log_share');
      await exportDirectory.create(recursive: true);
      final exportFile = File(
        '${exportDirectory.path}/session_log_${DateTime.now().millisecondsSinceEpoch}.zip',
      );
      final archive = Archive()
        ..add(ArchiveFile.string('session_log.txt', snapshot));
      final bytes = ZipEncoder(password: _archivePassword).encode(archive);
      await exportFile.writeAsBytes(bytes, flush: true);

      final view = PlatformDispatcher.instance.implicitView!;
      final size = view.physicalSize / view.devicePixelRatio;
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(exportFile.path, mimeType: 'application/zip')],
          sharePositionOrigin: Rect.fromLTWH(0, 0, size.width, size.height),
        ),
      );
      return const AppResult<void>.success(null);
    } catch (error, stackTrace) {
      return AppResult.failure(
        AppFailure.unhandledFailure(
          logMessage: 'Apollo log archive sharing failed',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
