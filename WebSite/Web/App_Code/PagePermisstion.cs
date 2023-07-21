using HR_Grove_Web.App_Code;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


public class PagePermisstion : System.Web.UI.Page
{
    public EmployeesInfo Employee { get; set; }
    protected override void OnInit(EventArgs e)
    {
        try
        {
            Employee = ICookiesMaster.GetCookie<EmployeesInfo>(ICookiesMaster.EINFO);
            if (Employee == null || Employee.EmployeeId == null)
                Response.Redirect("~/Default.aspx");
        }
        catch (Exception)
        {
            Response.Redirect("~/Default.aspx");
        }
       
    }

    public string CheckStatusEmployee(int Status)
    {
        string StatusName = "";
        switch (Status)
        {
            case (int)STATUS_EMPLOYEE.ACTIVE: StatusName ="Đang hoạt đồng"; break;
            case (int)STATUS_EMPLOYEE.DEACTIVE: StatusName = "Không hoạt đồng"; break;
            default:
                break;
        }
        return StatusName;
    }
}
