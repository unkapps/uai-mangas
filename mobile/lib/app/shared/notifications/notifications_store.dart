import 'package:mobx/mobx.dart';
import 'package:leitor_manga/app/shared/notifications/notification_model.dart';

part 'notifications_store.g.dart';

class NotificationsStore = _NotificationsStoreBase with _$NotificationsStore;

abstract class _NotificationsStoreBase with Store {
  @observable
  NotificationModel notification;

  @action
  void newMessage(
    NotificationModel notification,
  ) {
    this.notification = notification;
  }
}
