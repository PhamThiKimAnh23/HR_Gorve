class ShowKPIModel {
  int? showOT;
  int? showLeave;

  ShowKPIModel({this.showOT, this.showLeave});

  ShowKPIModel.fromJson(Map<String, dynamic> json) {
    showOT = json['ShowOT'];
    showLeave = json['ShowLeave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ShowOT'] = this.showOT;
    data['ShowLeave'] = this.showLeave;
    return data;
  }
}