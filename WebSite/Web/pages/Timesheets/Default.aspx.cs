using HR_Grove_Web.App_Code;
using OfficeOpenXml;
using System;
using System.IO;
using System.Threading;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HR_Grove_Web.pages.Timesheets
{
    public partial class Default : System.Web.UI.Page
    {
        private string _title = "Báo cáo Time Sheet";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ((SiteAuditMaster)Master).SetFormTitle(_title);
                BindOption();
            }
            ScriptManager script = ScriptManager.GetCurrent(Page);
            script.Dispose();
            script.RegisterPostBackControl(btnExport);
        }
        void BindOption()
        {
            ddlYear.SelectedValue = DateTime.Now.Year.ToString();
            ddlMonth.SelectedValue = DateTime.Now.Month.ToString();
            ddlAuditor.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
            Pf.bindEmployeeDropDown(null, null, null, ref ddlAuditor);
            Thread.Sleep(500);
            Pf.bindEmployeeTypeDropDown(ref ddlType);
        }
        protected void btnExport_Click(object sender, EventArgs e)
        {
            string fileName = "TimeSheets_" + string.Format("{0:yyyyMMddHHmmss}", DateTime.Now);
            FileInfo fileInfo = new FileInfo(Server.MapPath("~\\Template\\template_timesheet.xlsx"));
            string root = Server.MapPath("~\\Template\\Upload\\export\\");
            string fileExport = root + fileName;
            if (!Directory.Exists(root))
                Directory.CreateDirectory(root);

            FileInfo fileCopy = fileInfo.CopyTo(fileExport);
            using (var xls = new ExcelPackage(fileCopy))
            {
                Pf.ExcelByExcelPackage(xls, fileName);
            }
        }
    }
}