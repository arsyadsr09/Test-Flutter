import 'package:meta/meta.dart';

@immutable
class MainState {
  MainState({this.users});

  final List users;

  factory MainState.initial() {
    return MainState(
      users: [],
    );
  }

  MainState copyWith({List users}) {
    return MainState(
      users: users ?? this.users,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainState &&
          runtimeType == other.runtimeType &&
          users == other.users;

  @override
  int get hashCode => users.hashCode;
}
