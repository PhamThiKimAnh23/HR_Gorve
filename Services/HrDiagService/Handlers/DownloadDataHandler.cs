using HrDiagService.BLL;
using HrDiagService.Core;
using HrDiagService.Entities;
using HrDiagService.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace HrDiagService.Handlers
{
    public class DownloadDataHandler : AuthorizationHandler
    {

        public override HttpResponseMessage AuthorizationRequest()
        {
            String FUNCTION = new FieldRequest("FUNCTION");
            try
            {
                int? version = new FieldRequest("version");
                int appversion_current = Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings["appversion"]);

                if (version != null && version < appversion_current)
                {
                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "Đã có phiên bản phần mềm "+ appversion_current + " mới, vui lòng cập nhật trước phần mềm trước khi làm việc.");
                }
                else
                {
                    if ("MASTERDATA".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                    {
                        string ListCode = new FieldRequest("ListCode");
                        List<MasterInfo> data = AuditController.MasterGetList(Employee.EmployeeId, ListCode);
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, data, data.Count);
                    }
                    else if ("EVALUATEKPI".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                    {
                        List<EvaluateResultInfo> data = AuditController.getLastEvaluateResult(Employee.EmployeeId);
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, data, data.Count);
                    }
                    else if ("COINCOLLECT".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                    {
                        List<CoinCollectInfo> data = AuditController.getCoinCollect(Employee.EmployeeId);
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, data, data.Count);
                    }
                    else if ("SUPPORT".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                    {
                        List<MobileSupportInfo> data = AuditController.GetSupport(Employee.EmployeeId);
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, data, data.Count);
                    }
                    else if ("SHOPS".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                    {
                        AuditController.SaveOrUpdateEmployeeDownload(Employee.EmployeeId, 0, version);
                        List<ShopInfo> data = ShopsController.byEmployee(Employee.EmployeeId);
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, data, data.Count);
                    }
                    else if ("KPIOSA".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, AuditController.KPIMTOSAGetList(Employee.EmployeeId));
                    }
                    else if ("KPISURVEY".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, AuditController.KPISurveyGetList(Employee.EmployeeId));
                    }
                    else if ("KPISURVEYDETAIL".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, AuditController.KPISurveyDetailGetList(Employee.EmployeeId));
                    }
                    else if ("KPISURVEYANSWER".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, AuditController.KPISurveyAnswerGetList(Employee.EmployeeId));
                    }
                    else if ("PRODUCTS".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, AuditController.ProductsGetList(Employee.EmployeeId));
                    }
                    else if ("KPIPOSM".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, AuditController.KPIPosmGetList(Employee.EmployeeId));
                    }
                    else if ("EXPORTDB".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                    {
                        try
                        {
                            if (Context.Request.Files.Count > 0)
                            {
                                var file = Context.Request.Files[0];
                                if (file != null)
                                {
                                    if (File.Exists(Context.Server.MapPath("~/Database/" + Employee.EmployeeId + "_" + DateTime.Now.ToString("yyyyMMdd") + ".db")))
                                        File.Delete(Context.Server.MapPath("~/Database/" + Employee.EmployeeId + "_" + DateTime.Now.ToString("yyyyMMdd") + ".db"));
                                    file.SaveAs(Context.Server.MapPath("~/Database/" + Employee.EmployeeId + "_" + DateTime.Now.ToString("yyyyMMdd") + ".db"));
                                    string filePath = "http://syngenta.e-technology.vn:4070/Database/" + Employee.EmployeeId + "_" + DateTime.Now.ToString("yyyyMMdd") + ".db";
                                    EmployeeController.SaveDBMobile(Employee.EmployeeId, filePath);
                                }
                            }
                            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, "Upload DBFile Success !");
                        }
                        catch (Exception ex)
                        {
                            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, ex.Message);
                        }
                    }
                    else if ("IMPORTDB".Equals(FUNCTION, StringComparison.OrdinalIgnoreCase))
                    {
                        int IsPermistion = EmployeeController.check_emp_mobilesupport(Employee.EmployeeId);
                        if (IsPermistion == 0)
                        {
                            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "Bạn chưa được cấp quyền Donwload DB ngày: " + DateTime.Now.ToString("yyyy-MM-dd"));
                        }
                        else
                        {
                            Context.Response.Clear();
                            Context.Response.AddHeader("content-disposition", "attachment; filename=" + Employee.EmployeeId + ".db");
                            Context.Response.TransmitFile(Context.Server.MapPath("~/Database/" + Employee.EmployeeId + "_" + DateTime.Now.ToString("yyyyMMdd") + ".db"));
                            Context.Response.Flush();
                            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, "Download DB thành công, vui lòng tắt ứng dụng rồi mở lại !");
                        }
                    }
                    else if ("DEVICE".Equals(FUNCTION, StringComparison.OrdinalIgnoreCase))
                    {
                        string Model = new FieldRequest("Model");
                        string Release = new FieldRequest("Release");
                        string IMEI = new FieldRequest("IMEI");
                        string Platform = new FieldRequest("Platform");
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, AuditController.InserDevice(Employee.EmployeeId, Model, Release, IMEI, version, Platform));
                    }
                    else if ("PROVINCE".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, AuditController.ProvinceGetList(Employee.EmployeeId));
                    }
                    else if ("DISTRICT".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                    {
                        int? ProvinceId = new FieldRequest("ProvinceId");
                        if (ProvinceId == null) ProvinceId = 0;
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, AuditController.DistrictGetList(Employee.EmployeeId, ProvinceId.Value));
                    }
                    else if ("TOWN".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                    {
                        int? districtid = new FieldRequest("districtid");
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, AuditController.TownGetList(Employee.EmployeeId, districtid.Value));
                    }
                    else if ("KPIPROMOTION".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, AuditController.KPIPromotionGetList(Employee.EmployeeId));
                    }
                    else if ("GETBILL".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                    {
                        int? ShopId = new FieldRequest("ShopId");
                        string CusName = new FieldRequest("CusName");
                        string BillSeri = new FieldRequest("BillSeri");
                        int? FromDate = new FieldRequest("FromDate");
                        int? ToDate = new FieldRequest("ToDate");

                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, AuditController.GetBill(Employee.EmployeeId,ShopId,CusName,BillSeri,FromDate,ToDate));
                    }
                    else if ("USERLOCATION".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                    {
                        string Latitude = new FieldRequest("Latitude");
                        string Longitude = new FieldRequest("Longitude");
                        string Accuracy = new FieldRequest("Accuracy");
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, AuditController.InsertLocation(Employee.EmployeeId, Latitude, Longitude, Accuracy));
                    }
                    else if ("SHOWKPI".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
                    {
                        int? WorkDate = new FieldRequest("WorkDate");
                        List<ShowKPI> lst = new List<ShowKPI>();

                        ShowKPI show = new ShowKPI();
                        show.ShowOT = Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings["SHOW_OT"]);
                        show.ShowLeave = Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings["SHOW_LEAVE"]); ;
                        lst.Add(show);

                        //if (WorkDate != null && (WorkDate >= 20230309 && WorkDate < 20230331))
                        //{
                        //    ShowKPI show = new ShowKPI();
                        //    show.ShowOT = 1;
                        //    show.ShowLeave = 0;
                        //    lst.Add(show);
                        //}
                        //else if (WorkDate != null && WorkDate >= 20230331)
                        //{
                        //    ShowKPI show = new ShowKPI();
                        //    show.ShowOT = 1;
                        //    show.ShowLeave = 1;
                        //    lst.Add(show);
                        //}
                        //else
                        //{
                        //    ShowKPI show = new ShowKPI();
                        //    show.ShowOT = 0;
                        //    show.ShowLeave = 0;
                        //    lst.Add(show);
                        //}
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, lst);
                    }
                    else
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "Không tìm thấy Function");
                    }
                }
            }
            catch (Exception ex)
            {
                Logs.w(Employee.EmployeeId.ToString(), ex.Message, "DOWNLOAD-" + FUNCTION, 590);
                return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, ex.Message);
            }
        }
    }
}