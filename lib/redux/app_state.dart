import 'package:meta/meta.dart';
import 'package:toffin_app/redux/modules/main_state.dart';

@immutable
class AppState {
  AppState({this.mainState});

  final MainState mainState;

  factory AppState.initial() {
    return AppState(
      mainState: MainState.initial(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          mainState == other.mainState;

  @override
  int get hashCode => mainState.hashCode;
}
