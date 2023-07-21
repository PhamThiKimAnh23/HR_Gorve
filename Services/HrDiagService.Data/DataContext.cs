using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using HrDiagService.Entities;
using System.Data.Linq.Mapping;
using System.Data;
using System.Reflection;
using System.Data.Linq;
using DAL.Base;

namespace HrDiagService.Data
{
    public class DataContext : BaseDataContext
    {

        public Table<LogInfo> Logs { get { return this.GetTable<LogInfo>(); } }
        public Table<EmployeeInfo> Employees { get { return this.GetTable<EmployeeInfo>(); } }
        public Table<ShopInfo> Shops { get { return this.GetTable<ShopInfo>(); } }
        public Table<ProductInfo> Products { get { return this.GetTable<ProductInfo>(); } }
        public Table<AttendanceInfo> Attendances { get { return this.GetTable<AttendanceInfo>(); } }
    }
}