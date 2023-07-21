using System;

namespace HR_Grove_Web.Dashboard
{
    public partial class AuditDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                //txtFromDate.Text = "01/03/2022";
                //txtToDate.Text = "22/03/2022";
                ddlCycle.SelectedValue = "3";
                ((SiteAuditMaster)Master).SetHideHeader();
            }    
        }
    }
}