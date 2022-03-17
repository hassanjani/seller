// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

NotificationModel notificationModelFromMap(String str) =>
    NotificationModel.fromMap(json.decode(str));

String notificationModelToMap(NotificationModel data) =>
    json.encode(data.toMap());

class NotificationModel {
  NotificationModel({
    @required this.id,
    @required this.type,
    @required this.notifiableType,
    @required this.notifiableId,
    @required this.data,
    @required this.readAt,
    @required this.createdAt,
    @required this.updatedAt,
  });

  String id;
  String type;
  String notifiableType;
  String notifiableId;
  Data data;
  dynamic readAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory NotificationModel.fromMap(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        type: json["type"],
        notifiableType: json["notifiable_type"],
        notifiableId: json["notifiable_id"],
        data: Data.fromMap(json["data"]),
        readAt: json["read_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "notifiable_type": notifiableType,
        "notifiable_id": notifiableId,
        "data": data.toMap(),
        "read_at": readAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Data {
  Data({
    @required this.letters,
  });

  Letters letters;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        letters: Letters.fromMap(json["letters"]),
      );

  Map<String, dynamic> toMap() => {
        "letters": letters.toMap(),
      };
}

class Letters {
  Letters({
    @required this.message,
    @required this.orderId,
  });

  String message;
  String orderId;

  factory Letters.fromMap(Map<String, dynamic> json) => Letters(
        message: json["message"],
        orderId: json["order_id"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "order_id": orderId,
      };
}
