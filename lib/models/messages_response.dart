import 'dart:convert';

MessagesResponse mesagesResponseFromJson(String str) => MessagesResponse.fromJson(json.decode(str));

String mesagesResponseToJson(MessagesResponse data) => json.encode(data.toJson());

class MessagesResponse {
    MessagesResponse({
        this.ok,
        this.messages,
    });

    bool ok;
    List<Message> messages;

    factory MessagesResponse.fromJson(Map<String, dynamic> json) => MessagesResponse(
        ok: json["ok"],
        messages: List<Message>.from(json["mensajes"].map((x) => Message.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "mensajes": List<dynamic>.from(messages.map((x) => x.toJson())),
    };
}

class Message {
    Message({
        this.from,
        this.to,
        this.message,
        this.createdAt,
        this.updatedAt,
    });

    String from;
    String to;
    String message;
    DateTime createdAt;
    DateTime updatedAt;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        from: json["de"],
        to: json["para"],
        message: json["Message"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "de": from,
        "para": to,
        "Message": message,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
