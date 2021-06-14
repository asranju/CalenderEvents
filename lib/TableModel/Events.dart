class Events {
  String eventName = "";
  String eventDate = "";
  String eventTime = "";
  String eventType = "";
  String eventRepeat = "";
  String eventDescription = "";
  String eventEndDate = "";

  Events(this.eventName, this.eventDate, this.eventTime, this.eventType,
      this.eventRepeat, this.eventDescription, this.eventEndDate);

  Events.fromMap(Map<String, dynamic> res)
      : eventName = res['eventName'],
        eventDate = res['eventDate'],
        eventTime = res['eventTime'],
        eventType = res['eventType'],
        eventRepeat = res['eventRepeat'],
        eventDescription = res['eventDescription'],
        eventEndDate = res['eventEndDate'];

  Map<String, Object?> toMap() {
    return {
      'eventName': eventName,
      'eventDate': eventDate,
      'eventTime': eventTime,
      'eventType': eventType,
      'eventRepeat': eventRepeat,
      'eventDescription': eventDescription,
      'eventEndDate': eventEndDate
    };
  }
}
