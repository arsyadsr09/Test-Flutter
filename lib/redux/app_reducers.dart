
import 'package:toffin_app/redux/app_state.dart';
import 'package:toffin_app/redux/reducers/main_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
      mainState: mainReducer(state.mainState, action));
}
