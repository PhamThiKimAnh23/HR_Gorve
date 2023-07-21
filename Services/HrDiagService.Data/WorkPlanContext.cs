using DAL.Base;
using HrDiagService.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Linq.Mapping;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace HrDiagService.Data
{
    public class WorkPlanContext : BaseDataContext
    {
        [Function(Name = "[dbo].[Mobile.WorkingPlan.GetList]")]
        public IEnumerable<WorkPlanInfo> ListWorkPlan(
            [Parameter(Name = "@EmployeeCode", DbType = "NVARCHAR(100)")]String EmployeeCode)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeCode);
            return (IEnumerable<WorkPlanInfo>)result.ReturnValue;
        }

        [Function(Name = "[dbo].[Mobile.WorkingPlan.Save]")]
        public int SaveWorkPlan(
           [Parameter(Name = "@EmployeeCode", DbType = "VARCHAR(100)")]string EmployeeCode,
           [Parameter(Name = "@WorkingDate", DbType = "VARCHAR(50)")]string WorkingDate,
           [Parameter(Name = "@WorkingNote", DbType = "VARCHAR(MAX)")]string WorkingNote,
           [Parameter(Name = "@Reason", DbType = "NVARcHAR(256)")]string Reason
           )
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeCode, WorkingDate, WorkingNote, Reason);
            return 1;
        }

        public int WorkResultAction(int EmployeeId, int ShopId, int AuditResult, string ShopType, int WorkDate, string WorkTime, string Comment, int? ReasonResult, int CustomerDisplay, string CustomerComment, DataTable dtosa, DataTable dt_sos, DataTable dt_sos_compe, DataTable dt_pro, DataTable dt_pro_compe, DataTable dt_posm, DataTable dt_survey, DataTable dt_surveydetail, DataTable dt_audio, DataTable dt_photo, DataTable dt_att)
        {
            SqlCommand command = new SqlCommand();
            command.Parameters.Add(new SqlParameter("@EmployeeId", EmployeeId));
            command.Parameters.Add(new SqlParameter("@ShopId", ShopId));
            command.Parameters.Add(new SqlParameter("@AuditResult", AuditResult));
            command.Parameters.Add(new SqlParameter("@ShopType", ShopType));
            command.Parameters.Add(new SqlParameter("@WorkDate", WorkDate));
            command.Parameters.Add(new SqlParameter("@WorkTime", WorkTime));
            command.Parameters.Add(new SqlParameter("@Comment", Comment));
            //int? ReasonResult, int CustomerDisplay, string CustomerComment
            command.Parameters.Add(new SqlParameter("@ReasonResult", ReasonResult));
            command.Parameters.Add(new SqlParameter("@CustomerDisplay", CustomerDisplay));
            command.Parameters.Add(new SqlParameter("@CustomerComment", CustomerComment));
            command.Parameters.Add(new SqlParameter("@dtosa", dtosa));
            command.Parameters.Add(new SqlParameter("@dtsos", dt_sos));
            command.Parameters.Add(new SqlParameter("@dtsoscompe", dt_sos_compe));
            command.Parameters.Add(new SqlParameter("@dtpro", dt_pro));
            command.Parameters.Add(new SqlParameter("@dtprocompe", dt_pro_compe));
            command.Parameters.Add(new SqlParameter("@dtposm", dt_posm));
            command.Parameters.Add(new SqlParameter("@dtsurvey", dt_survey));
            command.Parameters.Add(new SqlParameter("@dtsurveydetail", dt_surveydetail));
            command.Parameters.Add(new SqlParameter("@dtaudio", dt_audio));
            command.Parameters.Add(new SqlParameter("@dtphoto", dt_photo));
            command.Parameters.Add(new SqlParameter("@dtatt", dt_att));
            return DAUltility.Helpers.SqlHelper.excuteSqlCommnd(command, "[dbo].[Mobile.WorkResultAction]");
            //return 1
        }

        public int WorkResultActionV2(int EmployeeId, int ShopId, int AuditResult, string ShopType, int WorkDate, string WorkTime, string Comment, int? ReasonResult, int CustomerDisplay, string CustomerComment, DataTable dtosa, DataTable dt_sos, DataTable dt_sos_compe, DataTable dt_pro, DataTable dt_pro_compe, DataTable dt_posm, DataTable dt_survey, DataTable dt_surveydetail, DataTable dt_audio, DataTable dt_photo, DataTable dt_att)
        {
            SqlCommand command = new SqlCommand();
            command.Parameters.Add(new SqlParameter("@EmployeeId", EmployeeId));
            command.Parameters.Add(new SqlParameter("@ShopId", ShopId));
            command.Parameters.Add(new SqlParameter("@AuditResult", AuditResult));
            command.Parameters.Add(new SqlParameter("@ShopType", ShopType));
            command.Parameters.Add(new SqlParameter("@WorkDate", WorkDate));
            command.Parameters.Add(new SqlParameter("@WorkTime", WorkTime));
            command.Parameters.Add(new SqlParameter("@Comment", Comment));
            //int? ReasonResult, int CustomerDisplay, string CustomerComment
            command.Parameters.Add(new SqlParameter("@ReasonResult", ReasonResult));
            command.Parameters.Add(new SqlParameter("@CustomerDisplay", CustomerDisplay));
            command.Parameters.Add(new SqlParameter("@CustomerComment", CustomerComment));
            command.Parameters.Add(new SqlParameter("@dtosa", dtosa));
            command.Parameters.Add(new SqlParameter("@dtsos", dt_sos));
            command.Parameters.Add(new SqlParameter("@dtsoscompe", dt_sos_compe));
            command.Parameters.Add(new SqlParameter("@dtpro", dt_pro));
            command.Parameters.Add(new SqlParameter("@dtprocompe", dt_pro_compe));
            command.Parameters.Add(new SqlParameter("@dtposm", dt_posm));
            command.Parameters.Add(new SqlParameter("@dtsurvey", dt_survey));
            command.Parameters.Add(new SqlParameter("@dtsurveydetail", dt_surveydetail));
            command.Parameters.Add(new SqlParameter("@dtaudio", dt_audio));
            command.Parameters.Add(new SqlParameter("@dtphoto", dt_photo));
            command.Parameters.Add(new SqlParameter("@dtatt", dt_att));
            return DAUltility.Helpers.SqlHelper.excuteSqlCommnd(command, "[dbo].[Mobile.WorkResultActionV2]");
            //return 1
        }

        public int WorkResultActionMT(int EmployeeId, int ShopId, int AuditResult, string ShopType, int WorkDate, string WorkTime, string Comment, int? ReasonResult, int CustomerDisplay, string CustomerComment, DataTable dtosa, DataTable dt_sos, DataTable dt_sos_compe, DataTable dt_pro, DataTable dt_pro_compe, DataTable dt_posm, DataTable dt_survey, DataTable dt_surveydetail, DataTable dt_audio, DataTable dt_photo, DataTable dt_att, DataTable dt_ool, DataTable dt_ool_detail)
        {
            SqlCommand command = new SqlCommand();
            command.Parameters.Add(new SqlParameter("@EmployeeId", EmployeeId));
            command.Parameters.Add(new SqlParameter("@ShopId", ShopId));
            command.Parameters.Add(new SqlParameter("@AuditResult", AuditResult));
            command.Parameters.Add(new SqlParameter("@ShopType", ShopType));
            command.Parameters.Add(new SqlParameter("@WorkDate", WorkDate));
            command.Parameters.Add(new SqlParameter("@WorkTime", WorkTime));
            command.Parameters.Add(new SqlParameter("@Comment", Comment));
            //int? ReasonResult, int CustomerDisplay, string CustomerComment
            command.Parameters.Add(new SqlParameter("@ReasonResult", ReasonResult));
            command.Parameters.Add(new SqlParameter("@CustomerDisplay", CustomerDisplay));
            command.Parameters.Add(new SqlParameter("@CustomerComment", CustomerComment));
            command.Parameters.Add(new SqlParameter("@dtosa", dtosa));
            command.Parameters.Add(new SqlParameter("@dtsos", dt_sos));
            command.Parameters.Add(new SqlParameter("@dtsoscompe", dt_sos_compe));
            command.Parameters.Add(new SqlParameter("@dtpro", dt_pro));
            command.Parameters.Add(new SqlParameter("@dtprocompe", dt_pro_compe));
            command.Parameters.Add(new SqlParameter("@dtposm", dt_posm));
            command.Parameters.Add(new SqlParameter("@dtsurvey", dt_survey));
            command.Parameters.Add(new SqlParameter("@dtsurveydetail", dt_surveydetail));
            command.Parameters.Add(new SqlParameter("@dtaudio", dt_audio));
            command.Parameters.Add(new SqlParameter("@dtphoto", dt_photo));
            command.Parameters.Add(new SqlParameter("@dtatt", dt_att));//dt_ool
            command.Parameters.Add(new SqlParameter("@dt_ool", dt_ool));
            command.Parameters.Add(new SqlParameter("@dt_ool_detail", dt_ool_detail));
            return DAUltility.Helpers.SqlHelper.excuteSqlCommnd(command, "[dbo].[Mobile.WorkResultActionMT]");
            //return 1
        }

        public int WorkResultActionMTV2(int EmployeeId, int ShopId, int AuditResult, string ShopType, int WorkDate, string WorkTime, string Comment, int? ReasonResult, int CustomerDisplay, string CustomerComment, DataTable dtosa, DataTable dt_sos, DataTable dt_sos_compe, DataTable dt_pro, DataTable dt_pro_compe, DataTable dt_posm, DataTable dt_survey, DataTable dt_surveydetail, DataTable dt_audio, DataTable dt_photo, DataTable dt_att, DataTable dt_ool, DataTable dt_ool_detail)
        {
            SqlCommand command = new SqlCommand();
            command.Parameters.Add(new SqlParameter("@EmployeeId", EmployeeId));
            command.Parameters.Add(new SqlParameter("@ShopId", ShopId));
            command.Parameters.Add(new SqlParameter("@AuditResult", AuditResult));
            command.Parameters.Add(new SqlParameter("@ShopType", ShopType));
            command.Parameters.Add(new SqlParameter("@WorkDate", WorkDate));
            command.Parameters.Add(new SqlParameter("@WorkTime", WorkTime));
            command.Parameters.Add(new SqlParameter("@Comment", Comment));
            //int? ReasonResult, int CustomerDisplay, string CustomerComment
            command.Parameters.Add(new SqlParameter("@ReasonResult", ReasonResult));
            command.Parameters.Add(new SqlParameter("@CustomerDisplay", CustomerDisplay));
            command.Parameters.Add(new SqlParameter("@CustomerComment", CustomerComment));
            command.Parameters.Add(new SqlParameter("@dtosa", dtosa));
            command.Parameters.Add(new SqlParameter("@dtsos", dt_sos));
            command.Parameters.Add(new SqlParameter("@dtsoscompe", dt_sos_compe));
            command.Parameters.Add(new SqlParameter("@dtpro", dt_pro));
            command.Parameters.Add(new SqlParameter("@dtprocompe", dt_pro_compe));
            command.Parameters.Add(new SqlParameter("@dtposm", dt_posm));
            command.Parameters.Add(new SqlParameter("@dtsurvey", dt_survey));
            command.Parameters.Add(new SqlParameter("@dtsurveydetail", dt_surveydetail));
            command.Parameters.Add(new SqlParameter("@dtaudio", dt_audio));
            command.Parameters.Add(new SqlParameter("@dtphoto", dt_photo));
            command.Parameters.Add(new SqlParameter("@dtatt", dt_att));//dt_ool
            command.Parameters.Add(new SqlParameter("@dt_ool", dt_ool));
            command.Parameters.Add(new SqlParameter("@dt_ool_detail", dt_ool_detail));
            return DAUltility.Helpers.SqlHelper.excuteSqlCommnd(command, "[dbo].[Mobile.WorkResultActionMTV2]");
            //return 1
        }

        public DataSet Attendance_Apple_Action(int EmployeeId, int ShopId,int AttendanceType, double? latitude, double? longitude, double? accuracy, string Address, string LinkPhoto, int WorkDate, string WorkTime, int ActionType)
        {
            return DAUltility.Helpers.SqlHelper.ExecuteDataset("[dbo].[Mobile.AtendanceAction]", EmployeeId, ShopId, AttendanceType, latitude, longitude, accuracy, Address, LinkPhoto, WorkDate, WorkTime, ActionType);
        }
        [Function(Name = "[dbo].[Mobile.AtendanceActionV3]")]
        public IEnumerable<AttendanceNewInfo> Attendance_Apple_ActionV3(
            [Parameter(Name = "@EmployeeId", DbType = "int")] int EmployeeId,
            [Parameter(Name = "@ShopId", DbType = "int")] int ShopId,
            [Parameter(Name = "@AttendanceType", DbType = "int")] int AttendanceType,
            [Parameter(Name = "@latitude", DbType = "FLOAT")] double? latitude,
            [Parameter(Name = "@longitude", DbType = "FLOAT")] double? longitude,
            [Parameter(Name = "@accuracy", DbType = "FLOAT")] double? accuracy,
            [Parameter(Name = "@Address", DbType = "NVARCHAR(2056)")] string Address,
            [Parameter(Name = "@LinkPhoto", DbType = "VARCHAR(128)")] string LinkPhoto,

            [Parameter(Name = "@WorkDate", DbType = "int")] int WorkDate,
            [Parameter(Name = "@WorkTime", DbType = "VARCHAR(52)")] string WorkTime,
            [Parameter(Name = "@ActionType", DbType = "int")] int ActionType
            )
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId, ShopId, AttendanceType, latitude, longitude, accuracy, Address, LinkPhoto, WorkDate, WorkTime, ActionType);
            return (IEnumerable<AttendanceNewInfo>)result.ReturnValue;
        }

        public DataSet Attendance_Apple_GetList(int EmployeeId, int ShopId, int AttendanceType, double? latitude, double? longitude, double? accuracy, string Address, string LinkPhoto, int WorkDate, string WorkTime, int ActionType)
        {
            return DAUltility.Helpers.SqlHelper.ExecuteDataset("[dbo].[Mobile.AtendanceGetListV2]", EmployeeId, ShopId, AttendanceType, latitude, longitude, accuracy, Address, LinkPhoto, WorkDate, WorkTime, ActionType);
        }
        [Function(Name = "[dbo].[Mobile.AtendanceGetListV3]")]
        public IEnumerable<AttendanceNewInfo> Attendance_Apple_GetListV3(
            [Parameter(Name = "@EmployeeId", DbType = "int")] int EmployeeId,
            [Parameter(Name = "@ShopId", DbType = "int")] int ShopId,
            [Parameter(Name = "@WorkDate", DbType = "int")] int WorkDate
            )
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId,ShopId,WorkDate);
            return (IEnumerable<AttendanceNewInfo>)result.ReturnValue;
        }
        public DataSet Attendance_Apple_ActionV2(int EmployeeId, int ShopId, int AttendanceType, double? latitude, double? longitude, double? accuracy, string Address, string LinkPhoto, int WorkDate, string WorkTime, int ActionType)
        {
            return DAUltility.Helpers.SqlHelper.ExecuteDataset("[dbo].[Mobile.AtendanceActionV2]", EmployeeId, ShopId, AttendanceType, latitude, longitude, accuracy, Address, LinkPhoto, WorkDate, WorkTime, ActionType);
        }
        public DataSet Employee_Apple_Action(string Email, string PassWord, string OTP, int ActionType)
        {
            //SqlCommand command = new SqlCommand();
            //command.Parameters.Add(new SqlParameter("@Email", Email));
            //command.Parameters.Add(new SqlParameter("@PassWord", PassWord));
            //command.Parameters.Add(new SqlParameter("@OTP", OTP));
            //command.Parameters.Add(new SqlParameter("@ActionType", ActionType));
            //return DAUltility.Helpers.SqlHelper.ExecuteDataset(command, "[dbo].[Apple.EmployeeAction]");
            //return 1
            return DAUltility.Helpers.SqlHelper.ExecuteDataset("[dbo].[Apple.EmployeeAction]", Email, PassWord, OTP, ActionType);
        }
        public DataSet CreateBill(int? ShopId,int EmployeeId,int BillDate,string CusName, int? CusSex,string CusAddress,string CusMobile,int? MiniGame,string MiniGameComment,int? ProductId,string PayMethod,string ImageBill,string ImageCusReGift,int? LuckyDraw,string LuckyDrawCode,string BillSeri,double? Amount)
        {
            SqlCommand command = new SqlCommand();
            command.Parameters.Add(new SqlParameter("@ShopId", ShopId));
            command.Parameters.Add(new SqlParameter("@EmployeeId", EmployeeId));
            command.Parameters.Add(new SqlParameter("@BillDate", BillDate));
            command.Parameters.Add(new SqlParameter("@CusName", CusName));
            command.Parameters.Add(new SqlParameter("@CusSex", CusSex));
            command.Parameters.Add(new SqlParameter("@CusAddress", CusAddress));
            command.Parameters.Add(new SqlParameter("@CusMobile", CusMobile));
            command.Parameters.Add(new SqlParameter("@MiniGame", MiniGame));
            command.Parameters.Add(new SqlParameter("@MiniGameComment", MiniGameComment));
            command.Parameters.Add(new SqlParameter("@ProductId", ProductId));
            command.Parameters.Add(new SqlParameter("@PayMethod", PayMethod));
            command.Parameters.Add(new SqlParameter("@ImageBill", ImageBill));
            command.Parameters.Add(new SqlParameter("@ImageCusReGift", ImageCusReGift));
            command.Parameters.Add(new SqlParameter("@LuckyDraw", LuckyDraw));
            command.Parameters.Add(new SqlParameter("@LuckyDrawCode", LuckyDrawCode));
            command.Parameters.Add(new SqlParameter("@BillSeri", BillSeri));
            command.Parameters.Add(new SqlParameter("@Amount", Amount));
            return DAUltility.Helpers.SqlHelper.ExecuteDataset("[dbo].[Mobile.Bill.CreateBill]", ShopId,  EmployeeId,  BillDate,  CusName,   CusSex,  CusAddress,  CusMobile,   MiniGame,  MiniGameComment,   ProductId,  PayMethod,  ImageBill,  ImageCusReGift,  LuckyDraw, LuckyDrawCode, BillSeri, Amount);
        }
    }
}
