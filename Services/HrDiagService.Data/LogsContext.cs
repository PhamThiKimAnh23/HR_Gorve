using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using System.Data.Linq;
using System.Data.Linq.Mapping;
using HrDiagService.Entities;
using DAL.Base;

namespace HrDiagService.Data
{
    public class LogsContext : BaseDataContext
    {
        public Table<LogInfo> Logs { get { return this.GetTable<LogInfo>(); } }
    }
}
