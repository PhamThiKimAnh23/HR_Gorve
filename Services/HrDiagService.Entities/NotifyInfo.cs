﻿using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;

namespace HrDiagService.Entities
{
    [Serializable]
    public class NotifyInfo
    {
        [Column(IsPrimaryKey = true, CanBeNull = false)]
        public long NotifyId { set; get; }
        [Column]
        public string Notification { set; get; }
        [Column]
        public string NotificationDesc { set; get; }
    }
}
