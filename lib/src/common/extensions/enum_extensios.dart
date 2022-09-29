import 'package:quiz_ui/src/features/home/repositories/home_repository.dart';

extension CompitionStatusExt on CompitionStatus {
  bool get isNone => this == CompitionStatus.none;
  bool get isActive => this == CompitionStatus.active;
  bool get isCountingDown => this == CompitionStatus.timerStarted;
  bool get isCompleted => this == CompitionStatus.completed;
}
