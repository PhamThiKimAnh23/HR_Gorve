using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HrDiagService.Entities
{
    public class ShowKPI
    {
        [Column]
        public int ShowOT { set; get; }
        [Column]
        public int ShowLeave { set; get; }
    }
}
