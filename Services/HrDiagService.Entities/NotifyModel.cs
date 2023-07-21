using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Web;

namespace HrDiagService.Models
{
    public class NotifyModel
    {
        [Column]
        public int StatusCode { set; get; }
        [Column]
        public string Content { set; get; }
        [Column]
        public string SenderId { set; get; }
        [Column]
        public string NotifyContent { set; get; }
    }
}