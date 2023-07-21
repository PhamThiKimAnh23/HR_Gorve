using HrDiagService.Data;
using HrDiagService.Entities;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace HrDiagService.BLL
{
    public static class WorkController
    {
        public static List<WorkPlanInfo> getWorkPlan(string EmployeeCode)
        {
            List<WorkPlanInfo> list = null;
            using (WorkPlanContext context = new WorkPlanContext())
            {
                var _list = context.ListWorkPlan(EmployeeCode);
                if (_list != null)
                    list = _list.ToList();
            }
            return list;
        }

        public static int SaveWorkPlan(string EmployeeCode, string WorkingDate, string WorkingNote, string Reason)
        {
            using (var context = new WorkPlanContext())
            {
                return context.SaveWorkPlan(EmployeeCode, WorkingDate, WorkingNote, Reason);
            }
        }

		public static int WorkResultAction(int EmployeeId,int ShopId,int AuditResult,string ShopType,int WorkDate, string WorkTime,string Comment,int? ReasonResult, int CustomerDisplay, string CustomerComment, DataTable dtosa, DataTable dt_sos, DataTable dt_sos_compe, DataTable dt_pro, DataTable dt_pro_compe, DataTable dt_posm, DataTable dt_survey, DataTable dt_surveydetail, DataTable dt_audio, DataTable dt_photo, DataTable dt_att)
		{
			using (var context = new WorkPlanContext())
			{
				return context.WorkResultAction(EmployeeId,  ShopId,  AuditResult,  ShopType, WorkDate,  WorkTime,  Comment, ReasonResult, CustomerDisplay,  CustomerComment,  dtosa, dt_sos, dt_sos_compe, dt_pro, dt_pro_compe, dt_posm, dt_survey, dt_surveydetail, dt_audio, dt_photo, dt_att);
			}
		}

        public static int WorkResultActionV2(int EmployeeId, int ShopId, int AuditResult, string ShopType, int WorkDate, string WorkTime, string Comment, int? ReasonResult, int CustomerDisplay, string CustomerComment, DataTable dtosa, DataTable dt_sos, DataTable dt_sos_compe, DataTable dt_pro, DataTable dt_pro_compe, DataTable dt_posm, DataTable dt_survey, DataTable dt_surveydetail, DataTable dt_audio, DataTable dt_photo, DataTable dt_att)
        {
            using (var context = new WorkPlanContext())
            {
                return context.WorkResultActionV2(EmployeeId, ShopId, AuditResult, ShopType, WorkDate, WorkTime, Comment, ReasonResult, CustomerDisplay, CustomerComment, dtosa, dt_sos, dt_sos_compe, dt_pro, dt_pro_compe, dt_posm, dt_survey, dt_surveydetail, dt_audio, dt_photo, dt_att);
            }
        }

        public static int WorkResultActionMT(int EmployeeId, int ShopId, int AuditResult, string ShopType, int WorkDate, string WorkTime, string Comment, int? ReasonResult, int CustomerDisplay, string CustomerComment, DataTable dtosa, DataTable dt_sos, DataTable dt_sos_compe, DataTable dt_pro, DataTable dt_pro_compe, DataTable dt_posm, DataTable dt_survey, DataTable dt_surveydetail, DataTable dt_audio, DataTable dt_photo, DataTable dt_att,DataTable dt_ool,DataTable dt_ool_detail)
        {
            using (var context = new WorkPlanContext())
            {
                return context.WorkResultActionMT(EmployeeId, ShopId, AuditResult, ShopType, WorkDate, WorkTime, Comment, ReasonResult, CustomerDisplay, CustomerComment, dtosa, dt_sos, dt_sos_compe, dt_pro, dt_pro_compe, dt_posm, dt_survey, dt_surveydetail, dt_audio, dt_photo, dt_att, dt_ool, dt_ool_detail);
            }
        }

        public static int WorkResultActionMTV2(int EmployeeId, int ShopId, int AuditResult, string ShopType, int WorkDate, string WorkTime, string Comment, int? ReasonResult, int CustomerDisplay, string CustomerComment, DataTable dtosa, DataTable dt_sos, DataTable dt_sos_compe, DataTable dt_pro, DataTable dt_pro_compe, DataTable dt_posm, DataTable dt_survey, DataTable dt_surveydetail, DataTable dt_audio, DataTable dt_photo, DataTable dt_att, DataTable dt_ool, DataTable dt_ool_detail)
        {
            using (var context = new WorkPlanContext())
            {
                return context.WorkResultActionMTV2(EmployeeId, ShopId, AuditResult, ShopType, WorkDate, WorkTime, Comment, ReasonResult, CustomerDisplay, CustomerComment, dtosa, dt_sos, dt_sos_compe, dt_pro, dt_pro_compe, dt_posm, dt_survey, dt_surveydetail, dt_audio, dt_photo, dt_att, dt_ool, dt_ool_detail);
            }
        }
        public static DataSet Attendance_Apple_Action(int EmployeeId, int ShopId,int AttendanceType, double? latitude, double? longitude, double? accuracy, string Address, string LinkPhoto,int WorkDate, string WorkTime, int ActionType)
        {
            using (var context = new WorkPlanContext())
            {
                return context.Attendance_Apple_Action(EmployeeId, ShopId, AttendanceType,latitude, longitude, accuracy, Address, LinkPhoto, WorkDate, WorkTime, ActionType);
            }
        }
        public static List<AttendanceNewInfo> Attendance_Apple_ActionV3(int EmployeeId, int ShopId, int AttendanceType, double? latitude, double? longitude, double? accuracy, string Address, string LinkPhoto, int WorkDate, string WorkTime, int ActionType)
        {
            List<AttendanceNewInfo> list = null;
            using (WorkPlanContext context = new WorkPlanContext())
            {
                var _list = context.Attendance_Apple_ActionV3(EmployeeId, ShopId, AttendanceType, latitude, longitude, accuracy, Address, LinkPhoto, WorkDate, WorkTime, ActionType);
                if (_list != null)
                    list = _list.ToList();
            }
            return list;
            //using (var context = new WorkPlanContext())
            //{
            //    return context.Attendance_Apple_Action(EmployeeId, ShopId, AttendanceType, latitude, longitude, accuracy, Address, LinkPhoto, WorkDate, WorkTime, ActionType);
            //}
        }
        public static List<AttendanceNewInfo> Attendance_Apple_GetListV3(int EmployeeId, int ShopId,int WorkDate)
        {
            List<AttendanceNewInfo> list = null;
            using (WorkPlanContext context = new WorkPlanContext())
            {
                var _list = context.Attendance_Apple_GetListV3(EmployeeId, ShopId, WorkDate);
                if (_list != null)
                    list = _list.ToList();
            }
            return list;
        }
        public static DataSet Attendance_Apple_GetList(int EmployeeId, int ShopId, int AttendanceType, double? latitude, double? longitude, double? accuracy, string Address, string LinkPhoto, int WorkDate, string WorkTime, int ActionType)
        {
            using (var context = new WorkPlanContext())
            {
                return context.Attendance_Apple_GetList(EmployeeId, ShopId, AttendanceType, latitude, longitude, accuracy, Address, LinkPhoto, WorkDate, WorkTime, ActionType);
            }
        }
        public static DataSet Employee_Apple_Action(string Email, string PassWord, string OTP,int ActionType)
        {
            using (var context = new WorkPlanContext())
            {
                return context.Employee_Apple_Action(Email, PassWord, OTP, ActionType);
            }
        }
        public static DataSet CreateBill(int? ShopId, int EmployeeId, int BillDate, string CusName, int? CusSex, string CusAddress, string CusMobile, int? MiniGame, string MiniGameComment, int? ProductId, string PayMethod, string ImageBill, string ImageCusReGift, int? LuckyDraw, string LuckyDrawCode, string BillSeri, double? Amount)
        {
            using (var context = new WorkPlanContext())
            {
                return context.CreateBill(ShopId, EmployeeId, BillDate, CusName, CusSex, CusAddress, CusMobile, MiniGame, MiniGameComment, ProductId, PayMethod, ImageBill, ImageCusReGift, LuckyDraw, LuckyDrawCode, BillSeri, Amount);
            }
        }
    }
}
