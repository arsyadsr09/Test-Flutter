import 'package:toffin_app/redux/actions/main_action.dart';
import 'package:toffin_app/redux/modules/main_state.dart';
import 'package:redux/redux.dart';

final mainReducer = combineReducers<MainState>([
  TypedReducer<MainState, SetUsers>(_setMainState),
]);

MainState _setMainState(MainState state, SetUsers payload) {
  return state.copyWith(users: payload.users);
}

