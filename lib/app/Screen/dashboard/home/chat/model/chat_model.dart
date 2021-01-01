class Chat {
  final String body;
  final String senderUID;
  final String time;

  Chat({
    this.body,
    this.senderUID,
    this.time,
  });
  factory Chat.fromMap(Map<dynamic, dynamic> value) {
    return Chat(
        body: value['body'],
        senderUID: value['senderUID'],
        time: value['time']);
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'body': body,
      'senderUID': senderUID,
      'time': time
    };
  }
}
