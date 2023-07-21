using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HrDiagService.Entities
{
    public class OTInfo
    {
        [Column]
        public int Id { set; get; }
        [Column]
        public string OTDate { set; get; }
        [Column]
        public string OTValue { set; get; }
        [Column]
        public int Status { set; get; }
        [Column]
        public string StatusName { set; get; }
        [Column]
        public string EmployeeComment { set; get; }
        [Column]
        public string UserConfirmComment { set; get; }
        [Column]
        public string CreatedTime { set; get; }
        [Column]
        public string ConfirmTime { set; get; }
        [Column]
        public string EmployeeName { set; get; }
        [Column]
        public string OTTargetName { set; get; }
    }
}
