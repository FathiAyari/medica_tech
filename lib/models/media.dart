class MediaObject {
   String endTime;
   String mediaLink;
   int screenId;
   String startTime;

  MediaObject.fromJson(Map<String, dynamic> json) {
    endTime = json['end_time'];
    mediaLink = json['media_link'];
    screenId = json['screen_id'];
    startTime = json['start_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['end_time'] = this.endTime;
    data['media_link'] = this.mediaLink;
    data['screen_id'] = this.screenId;
    data['start_time'] = this.startTime;
    return data;
  }
}
