part of 'about_apollo_cubit.dart';

enum AboutApolloStatus { initialize, ready }

enum AboutApolloErrorType { unhandledError }

enum AboutApolloSheetResult { none, confirmed, cancelled }

enum AboutApolloLogShareStatus { idle, sharing }

@immutable
class AboutApolloState extends Equatable {
  final AboutApolloStatus status;
  final String version;
  final String buildNumber;
  final Map<AboutApolloErrorType, AppFailure> errors;
  final AboutApolloSheetResult sheetResult;
  final int versionTapCount;
  final AboutApolloLogShareStatus logShareStatus;

  const AboutApolloState({
    required this.status,
    required this.version,
    required this.buildNumber,
    this.errors = const {},
    this.sheetResult = AboutApolloSheetResult.none,
    this.versionTapCount = 0,
    this.logShareStatus = AboutApolloLogShareStatus.idle,
  });

  factory AboutApolloState.initial({
    required String version,
    required String buildNumber,
  }) => AboutApolloState(
    status: AboutApolloStatus.initialize,
    version: version,
    buildNumber: buildNumber,
  );

  AboutApolloState copyWith({
    AboutApolloStatus? status,
    Map<AboutApolloErrorType, AppFailure>? errors,
    AboutApolloSheetResult? sheetResult,
    int? versionTapCount,
    AboutApolloLogShareStatus? logShareStatus,
  }) {
    return AboutApolloState(
      status: status ?? this.status,
      version: version,
      buildNumber: buildNumber,
      errors: errors ?? this.errors,
      sheetResult: sheetResult ?? this.sheetResult,
      versionTapCount: versionTapCount ?? this.versionTapCount,
      logShareStatus: logShareStatus ?? this.logShareStatus,
    );
  }

  @override
  List<Object?> get props => [errors, status, version, buildNumber, sheetResult,
    versionTapCount, logShareStatus];
}
