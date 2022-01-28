enum NotificationType { AGENDAMENTO, MESSAGE }

extension NotificationTypeString on NotificationType {
  String get getName {
    return '${this}'.split('.').last;
  }
}
