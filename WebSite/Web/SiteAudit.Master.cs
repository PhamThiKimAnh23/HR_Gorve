using Model;
using System;
using System.Web;
using System.Web.UI;

namespace HR_Grove_Web
{
    public partial class SiteAuditMaster : MasterPage
    {
        public string _path;
        protected void Page_Load(object sender, EventArgs e)
        {
            _path = HttpContext.Current.Request.Url.AbsolutePath;
            EmployeesInfo Employee = ICookiesMaster.GetCookie<EmployeesInfo>(ICookiesMaster.EINFO);
            if (Employee == null || Employee.EmployeeId == null)
                Response.Redirect("~/Default.aspx");
            hdfUserType.Value = Convert.ToString(Employee.TypeId);
        }
        public void SetFormTitle(string s)
        {
            Title.Text = s;
        }
        public void SetHideHeader()
        {
            divheader.Visible = false;
        }
        public string path
        {
            get
            {
                return _path;
            }
            set
            {
                this._path = value;
            }
        }
    }
}