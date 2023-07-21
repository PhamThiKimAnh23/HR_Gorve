using System;
using System.Web;
using Newtonsoft.Json;
using HrDiagService.Entities;
using HrDiagService.BLL;

namespace HrDiagService.Core
{
    public class TimeHandler : BaseHandler
    {
        public override object ProcessRequest()
        {
            return DateTime.Now.ToString("yyyyMMddHHmmss");
        }
    }
}
