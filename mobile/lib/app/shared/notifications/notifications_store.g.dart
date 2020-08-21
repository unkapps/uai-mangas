// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotificationsStore on _NotificationsStoreBase, Store {
  final _$notificationAtom = Atom(name: '_NotificationsStoreBase.notification');

  @override
  NotificationModel get notification {
    _$notificationAtom.reportRead();
    return super.notification;
  }

  @override
  set notification(NotificationModel value) {
    _$notificationAtom.reportWrite(value, super.notification, () {
      super.notification = value;
    });
  }

  final _$_NotificationsStoreBaseActionController =
      ActionController(name: '_NotificationsStoreBase');

  @override
  void newMessage(NotificationModel notification) {
    final _$actionInfo = _$_NotificationsStoreBaseActionController.startAction(
        name: '_NotificationsStoreBase.newMessage');
    try {
      return super.newMessage(notification);
    } finally {
      _$_NotificationsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
notification: ${notification}
    ''';
  }
}
