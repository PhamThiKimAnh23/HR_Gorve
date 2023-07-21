using HrDiagService.BLL;
using HrDiagService.Core;
using HrDiagService.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace HrDiagService.Handlers
{
    public class EmployeeRequestHandler : AuthorizationHandler
    {
        public override HttpResponseMessage AuthorizationRequest()
        {
            string FUNCTION = new FieldRequest("FUNCTION");
            try
            {
                if ("REGISOT".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                {
                    int? OTDate = new FieldRequest("OTDate");
                    double? OTValue = new FieldRequest("OTValue");
                    int? OTTarget = new FieldRequest("OTTarget");
                    string EmployeeComment = new FieldRequest("EmployeeComment");

                    List<NotifyModel> data = EmployeeController.insertEmployeeOT(Employee.EmployeeId, OTDate, OTValue, OTTarget, EmployeeComment);
                    if (data != null && data.Count > 0)
                    {
                        int StatusCode = data[0].StatusCode;
                        if (StatusCode == 200)
                        {
                            for (int i = 0; i < data.Count; i++)
                            {

                                if (!string.IsNullOrWhiteSpace(data[i].SenderId))
                                {
                                    FirebaseCore.SendNotification(data[i].SenderId, "Yêu cầu OT", data[i].NotifyContent, null);
                                }

                            }
                            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, "Bạn đã đăng ký OT thành công !");
                        }
                        else
                        {
                            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, data[0].Content);
                        }
                    }
                    else
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "Not Respone !");
                    }

                }
                else if ("CONFRIMOT".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                {

                    int? Id = new FieldRequest("Id");
                    int? Status = new FieldRequest("Status");
                    string Commnet = new FieldRequest("Comment");
                    if (Status == 0 && string.IsNullOrWhiteSpace(Commnet))
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "Vui lòng nhập lý do không đồng ý !");

                    }
                    List<NotifyModel> data = EmployeeController.confirmOT(Employee.EmployeeId, Id.Value, Status.Value, Commnet);
                    if (data != null && data.Count > 0)
                    {
                        for (int i = 0; i < data.Count; i++)
                        {

                            if (!string.IsNullOrWhiteSpace(data[i].SenderId))
                            {
                                FirebaseCore.SendNotification(data[i].SenderId, "Duyệt OT", data[i].NotifyContent, null);
                            }

                        }
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, "Xác nhận thành công !");
                    }
                    else {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "Không tìm thấy thông tin !");
                    }

                }
                else if ("GETLISTOT".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                {
                    int? Month = new FieldRequest("Month");
                    int? Year = new FieldRequest("Year");
                    int? EmployeeId = new FieldRequest("EmployeeId");
                    int? Status = new FieldRequest("Status");
                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, EmployeeController.getListOT(Employee.EmployeeId, Month, Year, EmployeeId, Status));
                }
                else if ("REGISOFF".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                {
                    int? OffDate = new FieldRequest("OffDate");
                    double? OffValue = new FieldRequest("OffValue");
                    int? OffType = new FieldRequest("OffType");
                    string EmployeeComment = new FieldRequest("EmployeeComment");

                    List<NotifyModel> data = EmployeeController.insertEmployeeOff(Employee.EmployeeId, OffDate, OffValue, OffType, EmployeeComment);
                    if (data != null && data.Count > 0)
                    {
                        int StatusCode = data[0].StatusCode;
                        if (StatusCode == 200)
                        {
                            for (int i = 0; i < data.Count; i++)
                            {

                                if (!string.IsNullOrWhiteSpace(data[i].SenderId))
                                {
                                    FirebaseCore.SendNotification(data[i].SenderId, "Yêu cầu nghỉ phép", data[i].NotifyContent, null);
                                }

                            }
                            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, "Bạn đã đăng ký nghỉ phép thành công !");
                        }
                        else
                        {
                            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, data[0].Content);
                        }
                    }
                    else
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "Not Respone !");
                    }

                }
                else if ("CONFRIMOFF".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                {

                    int? Id = new FieldRequest("Id");
                    int? Status = new FieldRequest("Status");
                    string Commnet = new FieldRequest("Commnet");

                    List<NotifyModel> data = EmployeeController.confirmOFF(Employee.EmployeeId, Id.Value, Status.Value, Commnet);
                    if (data != null && data.Count > 0)
                    {
                        for (int i = 0; i < data.Count; i++)
                        {

                            if (!string.IsNullOrWhiteSpace(data[i].SenderId))
                            {
                                FirebaseCore.SendNotification(data[i].SenderId, "Duyệt nghỉ phép", data[i].NotifyContent, null);
                            }

                        }
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, "Xác nhận thành công !");
                    }
                    else
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "Không tìm thấy thông tin !");
                    }

                }
                else if ("GETLISTOFF".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                {
                    int? Month = new FieldRequest("Month");
                    int? Year = new FieldRequest("Year");
                    int? EmployeeId = new FieldRequest("EmployeeId");
                    int? Status = new FieldRequest("Status");
                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, EmployeeController.getListOff(Employee.EmployeeId, Month, Year, EmployeeId, Status));

                }
                else if ("GETEMPLOYEELIST".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                {

                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, EmployeeController.getEmployeeList(Employee.EmployeeId));
                }
                else
                {
                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, FUNCTION + ": " + "Chức năng này chưa được định nghĩa !");
                }

            }
            catch (Exception ex)
            {
                Logs.w(Employee.EmployeeId.ToString(), ex.Message, "EmployeeRequest: " + FUNCTION, 501);
                return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, FUNCTION + ": " + ex.Message);

            }

        }
    }
}