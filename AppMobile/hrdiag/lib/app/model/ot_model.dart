class OTModel {
  int? id;
  String? oTDate;
  int? oTTarget;
  String? oTValue;
  int? status;
  String? statusName;
  String? employeeComment;
  String? userConfirmComment;
  String? createdTime;
  String? confirmTime;
  String? employeeName;
  String? oTTargetName;

  OTModel(
      {this.id,
        this.oTDate,
        this.oTTarget,
        this.oTValue,
        this.status,
        this.statusName,
        this.employeeComment,
        this.userConfirmComment,
        this.createdTime,
        this.oTTargetName,
        this.confirmTime});

  OTModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    oTDate = json['OTDate'];
    oTTarget = json['OTTarget'];
    oTValue = json['OTValue'];
    status = json['Status'];
    statusName = json['StatusName'];
    employeeComment = json['EmployeeComment'];
    userConfirmComment = json['UserConfirmComment'];
    createdTime = json['CreatedTime'];
    confirmTime = json['ConfirmTime'];
    employeeName = json['EmployeeName'];
    oTTargetName = json['OTTargetName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['OTDate'] = this.oTDate;
    data['OTTarget'] = this.oTTarget;
    data['OTValue'] = this.oTValue;
    data['Status'] = this.status;
    data['StatusName'] = this.statusName;
    data['EmployeeComment'] = this.employeeComment;
    data['UserConfirmComment'] = this.userConfirmComment;
    data['CreatedTime'] = this.createdTime;
    data['ConfirmTime'] = this.confirmTime;
    data['OTTargetName'] = this.oTTargetName;
    return data;
  }
}

