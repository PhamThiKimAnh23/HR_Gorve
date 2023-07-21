using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using HrDiagService.Entities;
using HrDiagService.Data;
using System.Data;
using HrDiagService.Models;

namespace HrDiagService.BLL
{
    public class EmployeeController
    {
        public static EmployeeInfo GetEmployee(string EmployeeCode = null, string Username = null, string Email = null, String Mobile = null)
        {
            EmployeeInfo info = null;
            using (EmployeeContext context = new EmployeeContext())
            {
                info = context.GetEmployee(EmployeeCode, Username, Email, Mobile).FirstOrDefault();
            }
            return info;
        }
        public static EmployeeInfo byCode(string EmployeeCode)
        {
            EmployeeInfo info = null;
            using (EmployeeContext context = new EmployeeContext())
            {
                info = context.byCode(EmployeeCode).FirstOrDefault();
            }
            return info;
        }
        public static EmployeeInfo byUsername(string Username, int EmployeeId)
        {
            EmployeeInfo info = null;
            using (EmployeeContext context = new EmployeeContext())
            {
                info = context.byUsername(Username, EmployeeId).FirstOrDefault();
            }
            return info;
        }
        public static EmployeeInfo byCheckChangePass(string username, string oldpass)
        {
            EmployeeInfo info = null;
            using (EmployeeContext context = new EmployeeContext())
            {
                info = context.byCheckChangePass(username, oldpass).FirstOrDefault();
            }
            return info;
        }
        public static EmployeeInfo ChangePass(string username, string newpass)
        {
            EmployeeInfo info = null;
            using (EmployeeContext context = new EmployeeContext())
            {
                info = context.Changepass(username, newpass).FirstOrDefault();
            }
            return info;
        }
        public static int OTPCreate(string EmployeeCode, string OTP)
        {
            using (EmployeeContext context = new EmployeeContext())
            {
                return context.OTPCreate(EmployeeCode, OTP);
            }
        }
        public static List<OTPInfo> OTPChecking(string EmployeeCode, string OTP)
        {
            List<OTPInfo> _tmp = null;
            using (EmployeeContext context = new EmployeeContext())
            {
                var tmp = context.OTPChecking(EmployeeCode, OTP);
                if (tmp != null)
                    _tmp = tmp.ToList();
            }
            return _tmp;
        }
        public static int check_emp_mobilesupport(int EmployeeId)
        {
            int value = 0;
            using (EmployeeContext ec = new EmployeeContext())
            {
                int dt_now = Convert.ToInt32(DateTime.Today.ToString("yyyyMMdd"));
                MobileSupportEntity ms = (from p in ec.MobileSupport where p.EmployeeId == EmployeeId && p.WorkDate == dt_now select p).FirstOrDefault();
                if (ms != null)
                    value = 1;
            }
            return value;
        }
        public static int SaveDBMobile(int EmployeeId, string FilePath)
        {
            using (EmployeeContext context = new EmployeeContext())
            {
                return context.SaveDBMobile(EmployeeId, FilePath);
            }
        }
        public static DataTable saveOrUpdateFcmToken(int EmployeeId, string FcmToken, string Platform)
        {
            using (EmployeeContext context = new EmployeeContext())
            {
                return context.saveOrUpdateFcmToken(EmployeeId, FcmToken, Platform);
            }
        }
        public static List<NotifyModel> insertEmployeeOT(int EmployeeId, int? OTDate, double? OTValue, double? OTTarget, string EmployeeComment)
        {
            List<NotifyModel> _lst = null;
            using (EmployeeContext context = new EmployeeContext())
            {
                var value = context.insertEmployeeOT(EmployeeId, OTDate, OTValue, OTTarget, EmployeeComment);
                if (value != null)
                    _lst = value.ToList();
            }
            return _lst;
        }
        public static List<NotifyModel> insertEmployeeOff(int EmployeeId, int? OffDate, double? OffValue, int? OffType, string EmployeeComment)
        {
            List<NotifyModel> _lst = null;
            using (EmployeeContext context = new EmployeeContext())
            {
                var value = context.insertEmployeeOff(EmployeeId, OffDate, OffValue, OffType, EmployeeComment);
                if (value != null)
                    _lst = value.ToList();
            }
            return _lst;
        }
        public static List<NotifyModel> confirmOT(int EmployeeId, int Id, int Status, string Comment)
        {
            List<NotifyModel> _lst = null;
            using (EmployeeContext context = new EmployeeContext())
            {
                var value = context.confirmOT(EmployeeId, Id, Status, Comment);
                if (value != null)
                    _lst = value.ToList();
            }
            return _lst;
        }
        public static List<NotifyModel> confirmOFF(int EmployeeId, int Id, int Status, string Comment)
        {
            List<NotifyModel> _lst = null;
            using (EmployeeContext context = new EmployeeContext())
            {
                var value = context.confirmOFF(EmployeeId, Id, Status, Comment);
                if (value != null)
                    _lst = value.ToList();
            }
            return _lst;
        }

        public static List<OTInfo> getListOT(int LoginId, int? Month, int? Year, int? EmployeeId, int? Status)
        {
            List<OTInfo> _lst = null;
            using (EmployeeContext context = new EmployeeContext())
            {
                var value = context.getListOT(LoginId, Month, Year, EmployeeId, Status);
                if (value != null)
                    _lst = value.ToList();
            }
            return _lst;

        }
        public static List<OffInfo> getListOff(int LoginId, int? Month, int? Year, int? EmployeeId, int? Status)
        {
            List<OffInfo> _lst = null;
            using (EmployeeContext context = new EmployeeContext())
            {
                var value = context.getListOff(LoginId, Month, Year, EmployeeId, Status);
                if (value != null)
                    _lst = value.ToList();
            }
            return _lst;
        }
        public static List<EmployeeInfo> getEmployeeList(int LoginId)
        {
            List<EmployeeInfo> _lst = null;
            using (EmployeeContext context = new EmployeeContext())
            {
                var value = context.getEmployeeList(LoginId);
                if (value != null)
                    _lst = value.ToList();
            }
            return _lst;
        }

    }
}