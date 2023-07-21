class OffModel {
  int? id;
  String? employeeName;
  String? oFFDate;
  int? offType;
  String? oFFTypeName;
  double? offValue;
  int? status;
  String? statusName;
  String? employeeComment;
  String? userConfirmComment;
  String? createdTime;
  String?confirmTime;
  String? totalDayOffUsed;
  String? totalStockDayOff;

  OffModel(
      {this.id,
        this.employeeName,
        this.oFFDate,
        this.offType,
        this.oFFTypeName,
        this.offValue,
        this.status,
        this.statusName,
        this.employeeComment,
        this.userConfirmComment,
        this.createdTime,
        this.confirmTime});

  OffModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    employeeName = json['EmployeeName'];
    oFFDate = json['OFFDate'];
    offType = json['OffType'];
    oFFTypeName = json['OFFTypeName'];
    offValue = json['OffValue'];
    status = json['Status'];
    statusName = json['StatusName'];
    employeeComment = json['EmployeeComment'];
    userConfirmComment = json['UserConfirmComment'];
    createdTime = json['CreatedTime'];
    confirmTime = json['ConfirmTime'];

    totalDayOffUsed = json['TotalDayOffUsed'];
    totalStockDayOff = json['TotalStockDayOff'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['EmployeeName'] = this.employeeName;
    data['OFFDate'] = this.oFFDate;
    data['OffType'] = this.offType;
    data['OFFTypeName'] = this.oFFTypeName;
    data['OffValue'] = this.offValue;
    data['Status'] = this.status;
    data['StatusName'] = this.statusName;
    data['EmployeeComment'] = this.employeeComment;
    data['UserConfirmComment'] = this.userConfirmComment;
    data['CreatedTime'] = this.createdTime;
    data['ConfirmTime'] = this.confirmTime;
    data['TotalDayOffUsed'] = this.totalDayOffUsed;
    data['TotalStockDayOff'] = this.totalStockDayOff;
    return data;
  }
}

