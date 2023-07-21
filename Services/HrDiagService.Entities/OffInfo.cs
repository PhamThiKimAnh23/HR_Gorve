using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HrDiagService.Entities
{
    public class OffInfo
    {
        [Column]
        public int Id { get; set; }
        [Column]
        public string EmployeeName { get; set; }
        [Column]
        public string OFFDate { get; set; }
        [Column]
        public int OffType { get; set; }
        [Column]
        public string OFFTypeName { get; set; }
        [Column]
        public decimal OffValue { get; set; }
        [Column]
        public int Status { get; set; }
        [Column]
        public string StatusName { get; set; }
        [Column]
        public string EmployeeComment { get; set; }
        [Column]
        public string UserConfirmComment { get; set; }
        [Column]
        public string CreatedTime { get; set; }
        [Column]
        public string ConfirmTime { get; set; }
        [Column]
        public string TotalDayOffUsed { get; set; }
        [Column]
        public string TotalStockDayOff { get; set; }
    }
}
