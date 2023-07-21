using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HrDiagService.Entities
{
    public class WorkPlanInfo
    {
        [Column]
        public String EmployeeCode { get; set; }
        [Column]
        public String WorkingDate { get; set; }
        [Column]
        public String WorkingNote { get; set; }
        [Column]
        public String Reason { get; set; }

    }

    public class AttendanceNewInfo
    {
        [Column]
        public int AttendantType { get; set; }
        [Column]
        public String PhotoServer { get; set; }
    }
}
