// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

List<NotificationModel> notificationModelFromMap(String str) =>
    List<NotificationModel>.from(
        json.decode(str).map((x) => NotificationModel.fromMap(x)));

String notificationModelToMap(List<NotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

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
  NotificationModelData data;
  dynamic readAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory NotificationModel.fromMap(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        type: json["type"],
        notifiableType: json["notifiable_type"],
        notifiableId: json["notifiable_id"],
        data: NotificationModelData.fromMap(json["data"]),
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

class NotificationModelData {
  NotificationModelData({
    @required this.data,
  });

  DataData data;

  factory NotificationModelData.fromMap(Map<String, dynamic> json) =>
      NotificationModelData(
        data: DataData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
      };
}

class DataData {
  DataData({
    @required this.message,
    @required this.confirmationLink,
    @required this.orderId,
    @required this.rejectionLink,
  });

  String message;
  String confirmationLink;
  String orderId;
  String rejectionLink;

  factory DataData.fromMap(Map<String, dynamic> json) => DataData(
        message: json["message"],
        confirmationLink: json["confirmation_link"],
        orderId: json["order_id"].toString(),
        rejectionLink: json["rejection_link"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "confirmation_link": confirmationLink,
        "order_id": orderId,
        "rejection_link": rejectionLink,
      };
}

// // To parse this JSON data, do
// //
// //     final welcome = welcomeFromJson(jsonString);
//
// import 'dart:convert';
//
// List<NotificationModel> welcomeFromJson(String str) =>
//     List<NotificationModel>.from(
//         json.decode(str).map((x) => NotificationModel.fromJson(x)));
//
// String welcomeToJson(List<NotificationModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class NotificationModel {
//   NotificationModel({
//     this.id,
//     this.type,
//     this.notifiableType,
//     this.notifiableId,
//     this.data,
//     this.readAt,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   String id;
//   String type;
//   String notifiableType;
//   String notifiableId;
//   Data data;
//   dynamic readAt;
//   DateTime createdAt;
//   DateTime updatedAt;
//
//   factory NotificationModel.fromJson(Map<String, dynamic> json) =>
//       NotificationModel(
//         id: json["id"],
//         type: json["type"],
//         notifiableType: json["notifiable_type"],
//         notifiableId: json["notifiable_id"],
//         data: Data.fromJson(json["data"]),
//         readAt: json["read_at"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "type": type,
//         "notifiable_type": notifiableType,
//         "notifiable_id": notifiableId,
//         "data": data.toJson(),
//         "read_at": readAt,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }
//
// class Data {
//   Data({
//     this.letter,
//   });
//
//   Letter letter;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         letter: Letter.fromJson(json["letter"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "letter": letter.toJson(),
//       };
// }
//
// class Letter {
//   Letter({
//     this.message,
//     this.orderId,
//   });
//
//   String message;
//   String orderId;
//
//   factory Letter.fromJson(Map<String, dynamic> json) => Letter(
//         message: json["message"],
//         orderId: json["order_id"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "order_id": orderId,
//       };
// }
