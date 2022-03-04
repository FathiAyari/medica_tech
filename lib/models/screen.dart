class Screen {
   String endTime;
   int id;
   String name;
   String startTime;
   bool enabled;

  Screen.fromJson(Map<String, dynamic> json) {
    endTime = json['end_time'];
    id = json['id'];
    name = json['name'];
    startTime = json['start_time'];
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['end_time'] = this.endTime;
    data['id'] = this.id;
    data['name'] = this.name;
    data['start_time'] = this.startTime;
    data['enabled'] = this.enabled;
    return data;
  }
}
