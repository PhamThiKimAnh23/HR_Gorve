using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Linq;
using System.Data.Linq.Mapping;
using System.Reflection;
using System.Data;
using System.Data.SqlClient;
using HrDiagService.Entities;
using DAL.Base;
using HrDiagService.Models;

namespace HrDiagService.Data
{
    public class EmployeeContext : BaseDataContext
    {

        public Table<MobileSupportEntity> MobileSupport { get { return GetTable<MobileSupportEntity>(); } }
        [Function(Name = "[dbo].[Mobile.Employee.byCode]")]
        public IEnumerable<EmployeeInfo> byCode(
            [Parameter(Name = "@EmployeeCode", DbType = "NVARCHAR(100)")] String EmployeeCode)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeCode);
            return (IEnumerable<EmployeeInfo>)result.ReturnValue;
        }
        [Function(Name = "[dbo].[Mobile.Employee.byUsername]")]
        public IEnumerable<EmployeeInfo> byUsername(
            [Parameter(Name = "@Username", DbType = "NVARCHAR(100)")] String Username,
            [Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId
            )
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), Username, EmployeeId);
            return (IEnumerable<EmployeeInfo>)result.ReturnValue;
        }
        [Function(Name = "[dbo]. [Mobile.CheckChangePass]")]
        public IEnumerable<EmployeeInfo> byCheckChangePass(
            [Parameter(Name = "@username", DbType = "NVARCHAR(32)")] String username,
            [Parameter(Name = "@oldpass", DbType = "NVARCHAR(32)")] String oldpass)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), username, oldpass);
            return (IEnumerable<EmployeeInfo>)result.ReturnValue;
        }
        [Function(Name = "[dbo]. [Mobile.Employee.ChangePass]")]
        public IEnumerable<EmployeeInfo> Changepass(
            [Parameter(Name = "@username", DbType = "NVARCHAR(32)")] String username,
            [Parameter(Name = "@newpass", DbType = "NVARCHAR(32)")] String newpass)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), username, newpass);
            return (IEnumerable<EmployeeInfo>)result.ReturnValue;
        }


        [Function(Name = "[dbo].[Mobile.Employee.GetEmployee]")]
        public IEnumerable<EmployeeInfo> GetEmployee(
            [Parameter(Name = "@EmployeeCode", DbType = "NVARCHAR(100)")] String EmployeeCode = null,
            [Parameter(Name = "@Username", DbType = "NVARCHAR(100)")] String Username = null,
            [Parameter(Name = "@Email", DbType = "NVARCHAR(100)")] String Email = null,
            [Parameter(Name = "@Mobile", DbType = "NVARCHAR(50)")] String Mobile = null)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeCode, Username, Email, Mobile);
            return (IEnumerable<EmployeeInfo>)result.ReturnValue;
        }


        #region "OTP TOOL"

        [Function(Name = "[dbo].[Mobile.CreateOTP]")]
        public int OTPCreate(
            [Parameter(Name = "@EmployeeCode", DbType = "VARCHAR(50)")] String EmployeeCode,
            [Parameter(Name = "@OTP", DbType = "VARCHAR(6)")] String OTP)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeCode, OTP);
            return (int)result.ReturnValue;
        }
        [Function(Name = "[dbo].[Mobile.CheckingOTP]")]
        public IEnumerable<OTPInfo> OTPChecking(
            [Parameter(Name = "@EmployeeCode", DbType = "VARCHAR(50)")] string EmployeeCode,
            [Parameter(Name = "@OTP", DbType = "VARCHAR(6)")] string OTP)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeCode, OTP);
            return (IEnumerable<OTPInfo>)result.ReturnValue;
        }
        #endregion
        [Function(Name = "[dbo].[Mobile.DBSqlite.Save]")]
        public int SaveDBMobile(
           [Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId,
           [Parameter(Name = "@FilePath", DbType = "VARCHAR(512)")] string FilePath)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId, FilePath);
            return (int)result.ReturnValue;
        }

        [Function(Name = "[dbo].[Mobile.Employee.saveOrUpdateFcmToken]")]
        public DataTable saveOrUpdateFcmToken(
          [Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId,
          [Parameter(Name = "@Fcm_Token", DbType = "VARCHAR(512)")] string Fcm_Token,
          [Parameter(Name = "@Platform", DbType = "VARCHAR(32)")] string Platform)
        {
            return this.ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId, Fcm_Token, Platform);
        }

        [Function(Name = "[dbo].[Mobile.EmployeeOT.Insert]")]
        public IEnumerable<NotifyModel> insertEmployeeOT(
         [Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId,
         [Parameter(Name = "@OTDate", DbType = "INT")] int? OTDate,
         [Parameter(Name = "@OTValue", DbType = "Decimal(18,1)")] double? OTValue,
         [Parameter(Name = "@OTTarget", DbType = "INT")] double? OTTarget,
         [Parameter(Name = "@EmployeeComment", DbType = "NVARCHAR(512)")] string EmployeeComment
        )
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId, OTDate, OTValue, OTTarget, EmployeeComment);
            return (IEnumerable<NotifyModel>)result.ReturnValue;
        }

        [Function(Name = "[dbo].[Mobile.EmployeeOff.Insert]")]
        public IEnumerable<NotifyModel> insertEmployeeOff(
           [Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId,
           [Parameter(Name = "@OffDate", DbType = "INT")] int? OffDate,
           [Parameter(Name = "@OffValue", DbType = "Decimal(18,1)")] double? OffValue,
           [Parameter(Name = "@OffType", DbType = "INT")] int? OffType,
           [Parameter(Name = "@EmployeeComment", DbType = "NVARCHAR(512)")] string EmployeeComment
        )
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId, OffDate, OffValue, OffType, EmployeeComment);
            return (IEnumerable<NotifyModel>)result.ReturnValue;
        }



        [Function(Name = "[dbo].[Mobile.EmployeeOT.confirm]")]
        public IEnumerable<NotifyModel> confirmOT(
         [Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId,
         [Parameter(Name = "@Id", DbType = "INT")] int Id,
         [Parameter(Name = "@Status", DbType = "INT")] int Status,
         [Parameter(Name = "@Comment", DbType = "NVARCHAR(512)")] string Comment
        )
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId, Id, Status, Comment);
            return (IEnumerable<NotifyModel>)result.ReturnValue;
        }

        [Function(Name = "[dbo].[Mobile.EmployeeOff.confirm]")]
        public IEnumerable<NotifyModel> confirmOFF(
         [Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId,
         [Parameter(Name = "@Id", DbType = "INT")] int Id,
         [Parameter(Name = "@Status", DbType = "INT")] int Status,
         [Parameter(Name = "@Comment", DbType = "NVARCHAR(512)")] string Comment
        )
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId, Id, Status, Comment);
            return (IEnumerable<NotifyModel>)result.ReturnValue;
        }

        [Function(Name = "[dbo].[Mobile.EmployeeOT.getList]")]
        public IEnumerable<OTInfo> getListOT(
        [Parameter(Name = "@LoginId", DbType = "INT")] int LoginId,
        [Parameter(Name = "@Month", DbType = "INT")] int? Month,
        [Parameter(Name = "@Year", DbType = "INT")] int? Year,
        [Parameter(Name = "@EmployeeId", DbType = "INT")] int? EmployeeId,
        [Parameter(Name = "@Status", DbType = "INT")] int? Status
        )
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), LoginId, Month, Year, EmployeeId, Status);
            return (IEnumerable<OTInfo>)result.ReturnValue;
        }

        [Function(Name = "[dbo].[Mobile.EmployeeOff.getList]")]
        public IEnumerable<OffInfo> getListOff(
        [Parameter(Name = "@LoginId", DbType = "INT")] int LoginId,
        [Parameter(Name = "@Month", DbType = "INT")] int? Month,
        [Parameter(Name = "@Year", DbType = "INT")] int? Year,
        [Parameter(Name = "@EmployeeId", DbType = "INT")] int? EmployeeId,
        [Parameter(Name = "@Status", DbType = "INT")] int? Status
        )
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), LoginId, Month, Year, EmployeeId, Status);
            return (IEnumerable<OffInfo>)result.ReturnValue;
        }

        [Function(Name = "[dbo].[Employee.getEmployeeChild]")]
        public IEnumerable<EmployeeInfo> getEmployeeList(
        [Parameter(Name = "@EmployeeId", DbType = "INT")] int LoginId
        )
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), LoginId);
            return (IEnumerable<EmployeeInfo>)result.ReturnValue;
        }


    }
}
