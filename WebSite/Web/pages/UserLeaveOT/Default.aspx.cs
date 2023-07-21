using BLL.Employees;
using HR_Grove_Web.App_Code;
using OfficeOpenXml;
using System;
using System.Data;
using System.IO;
using System.Threading;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HR_Grove_Web.pages.UserLeaveOT
{
    public partial class Default : PagePermisstion
    {
        private string _title = "Report Leave, OverTime";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["CurrentTabReport"] = 1;
                ((SiteAuditMaster)Master).SetFormTitle(_title);
                BindOption();
            }
            ScriptManager script = ScriptManager.GetCurrent(Page);
            script.Dispose();
            script.RegisterPostBackControl(btnExport);
        }
        void BindOption()
        {
            //Pf.bindCycleDropDown_Customer(Employee.EmployeeId.Value, DateTime.Now.Year, DateTime.Now.Month, ref ddlCycle);
            //Thread.Sleep(500);
            txtFromDate.Text = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).ToString("dd/MM/yyyy");
            txtToDate.Text = DateTime.Now.ToString("dd/MM/yyyy");

            Pf.bindEmployeeDropDown(null, null, null, ref ddlAuditor);
            Thread.Sleep(500);
            Pf.bindEmployeeDropDown(2, null, null, ref ddlSup);

            if (Employee.TypeId == 2)
            {
                ddlSup.SelectedValue = Employee.EmployeeId.ToString();
                ddlSup.Enabled = false;
            }
            //Thread.Sleep(500);
            //Pf.bindAreaDropDown(Employee.EmployeeId.Value, ref ddlArea);
            //Thread.Sleep(500);
            //Pf.bindAddressDropDown(Employee.EmployeeId.Value, -1, null, null, null, "ProvinceId", "ProvinceName", ref ddlProvince);
            //Thread.Sleep(500);
            //Pf.bindOfficeDropDown(Employee.EmployeeId.Value, null, null, null, null, "ShopId", "ShopName", ref ddlOffice);

            //ddlDistrict.Items.Insert(0, new ListItem("-All-", "-1"));
            //ddlTown.Items.Insert(0, new ListItem("-All-", "-1"));
            ddlAuditor.Items.Insert(0, new ListItem("-All-", "-1"));
        }
        protected void lbKPI_Click(object sender, EventArgs e)
        {
            LinkButton lk = (LinkButton)sender;
            string CommandName = lk.CommandName;

            foreach (Control c in pnGrid.Controls)
            {
                if (c is LinkButton)
                {
                    LinkButton lbb = c as LinkButton;
                    if (lbb.ID == "lb" + CommandName)
                        lbb.CssClass = "nav-link active";
                    else
                        lbb.CssClass = "nav-link";
                }
                if (c is Panel)
                {
                    Panel pbb = c as Panel;
                    if (pbb.ID == "pl" + CommandName)
                        pbb.Visible = true;
                    else
                        pbb.Visible = false;
                }
            }

            switch (CommandName)
            {
                case "UserLeave": BindUserLeave_OT(1, 1); ViewState["CurrentTabReport"] = 1; break;
                case "OT": BindUserLeave_OT(1, 2); ViewState["CurrentTabReport"] = 2; break;

            }
        }
        public string GetIconConfirm(int Status)
        {
            string url_image;
            switch (Status)
            {
                case 0: url_image = "../Images/icons8-cancel.svg"; break;
                case 1: url_image = "../Images/icons8-ok.svg"; break;
                default: url_image = "../Images/icons8-hourglass-48.png"; break;
            }
            return url_image;
        }
        protected void btnFilter_Click(object sender, EventArgs e)
        {
            Filter();
        }
        void Filter(int PageNumber = 1)
        {
            int TypeReport = ViewState["CurrentTabReport"] != null ? Convert.ToInt32(ViewState["CurrentTabReport"]) : 1;
            BindUserLeave_OT(PageNumber, TypeReport);
        }
        protected void btnExport_Click(object sender, EventArgs e)
        {
            string fileName = "UserLeave_OT_" + string.Format("{0:yyyyMMddHHmmss}", DateTime.Now);
            FileInfo fileInfo = new FileInfo(Server.MapPath("~\\Template\\template_userleave_ot.xlsx"));
            string root = Server.MapPath("~\\Template\\Upload\\export\\");
            if (!Directory.Exists(root))
                Directory.CreateDirectory(root);


            if (!DateTime.TryParseExact(txtFromDate.Text.Trim(), "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out DateTime FromDate))
            {
                Toastr.ErrorToast("Từ ngày không đúng định dạng dd/MM/yyyy");
                return;
            }
            if (!DateTime.TryParseExact(txtToDate.Text.Trim(), "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out DateTime ToDate))
            {
                Toastr.ErrorToast("Đến ngày không đúng định dạng dd/MM/yyyy");
                return;
            }
            int SupId = Convert.ToInt32(ddlSup.SelectedValue);
            int AuditorId = Convert.ToInt32(ddlAuditor.SelectedValue);

            /*int AreaId = Convert.ToInt32(ddlArea.SelectedValue);
            int ProvinceId = Convert.ToInt32(ddlProvince.SelectedValue);
            int DistrictId = Convert.ToInt32(ddlDistrict.SelectedValue);
            int TownId = Convert.ToInt32(ddlTown.SelectedValue);*/
            int Status = Convert.ToInt32(ddlStatus.SelectedValue);

            DataTable data_leave = new EmployeesController().UserLeaveGetList(Employee.EmployeeId.Value, FromDate, ToDate, SupId, AuditorId, Status, 1, 20000000);
            Thread.Sleep(1000);
            DataTable data_ot = new EmployeesController().UserOTGetList(Employee.EmployeeId.Value, FromDate, ToDate, SupId, AuditorId, Status, 1, 20000000);

            if (data_leave.Rows.Count == 0 && data_ot.Rows.Count == 0)
            {
                Toastr.WarningToast("Không có data nghỉ phép và tăng ca");
                return;
            }

            using (var xls = new ExcelPackage(fileInfo))
            {
                ExcelWorksheet excel_leave = xls.Workbook.Worksheets["UserLeave"];
                ExcelWorksheet excel_ot = xls.Workbook.Worksheets["UserOT"];

                if (excel_leave != null && data_leave != null && data_leave.Rows.Count > 0)
                {
                    excel_leave.Cells[1, 1].LoadFromDataTable(data_leave, true);
                    Pf.border(excel_leave, 1, data_leave.Rows.Count + 1, 1, data_leave.Columns.Count, "", "");
                    excel_leave.Cells[1, 1].AutoFitColumns();
                }

                if (excel_ot != null && data_ot != null && data_ot.Rows.Count > 0)
                {
                    excel_ot.Cells[1, 1].LoadFromDataTable(data_ot, true);
                    Pf.border(excel_ot, 1, data_ot.Rows.Count + 1, 1, data_ot.Columns.Count, "", "");
                    excel_ot.Cells[1, 1].AutoFitColumns();
                }
                Pf.ExcelByExcelPackage(xls, fileName);
            }
        }
        //protected void ddlCycle_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    txtFromDate.Text = txtToDate.Text = "";
        //    if (ddlCycle.SelectedIndex > 0)
        //    {
        //        string value = ddlCycle.SelectedValue;
        //        string[] arg = value.Split('_');
        //        txtFromDate.Text = Pf.DateIntToString(Convert.ToInt32(arg[3]), "dd/MM/yyyy");
        //        txtToDate.Text = Pf.DateIntToString(Convert.ToInt32(arg[4]), "dd/MM/yyyy");
        //    }
        //}
        protected void ddlSup_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlAuditor.Items.Clear();
            string selected = ddlSup.SelectedValue;
            if (!string.IsNullOrEmpty(selected) && selected != "-1")
                Pf.bindEmployeeDropDown(null, null, Convert.ToInt32(selected), ref ddlAuditor);
            else
                ddlAuditor.Items.Insert(0, new ListItem(Pf.OptionChooseEN, "-1"));
        }
        protected void ddlProvince_SelectedIndexChanged(object sender, EventArgs e)
        {
            int ProvinceId = Convert.ToInt32(ddlProvince.SelectedValue);
            if (ProvinceId < 0)
            {
                ddlDistrict.Items.Clear();
                ddlTown.Items.Clear();
                ddlDistrict.Items.Insert(0, new ListItem(Pf.OptionChooseEN, "-1"));
                ddlTown.Items.Insert(0, new ListItem(Pf.OptionChooseEN, "-1"));
            }
            else
                Pf.bindAddressDropDown(Employee.EmployeeId.Value, null, ProvinceId, null, null, "DistrictId", "DistrictName", ref ddlDistrict);
        }
        protected void ddlArea_SelectedIndexChanged(object sender, EventArgs e)
        {
            int AreaId = Convert.ToInt32(ddlArea.SelectedValue);
            if (AreaId < 0)
            {
                ddlProvince.Items.Clear();
                ddlDistrict.Items.Clear();
                ddlTown.Items.Clear();
                ddlProvince.Items.Insert(0, new ListItem(Pf.OptionChooseEN, "-1"));
                ddlDistrict.Items.Insert(0, new ListItem(Pf.OptionChooseEN, "-1"));
                ddlTown.Items.Insert(0, new ListItem(Pf.OptionChooseEN, "-1"));
            }
            else
                Pf.bindAddressDropDown(Employee.EmployeeId.Value, AreaId, null, null, null, "ProvinceId", "ProvinceName", ref ddlProvince);
        }
        protected void ddlDistrict_SelectedIndexChanged(object sender, EventArgs e)
        {
            int DistrictId = Convert.ToInt32(ddlDistrict.SelectedValue);
            if (DistrictId < 0)
            {
                ddlTown.Items.Clear();
                ddlTown.Items.Insert(0, new ListItem(Pf.OptionChooseEN, "-1"));
            }
            else
                Pf.bindAddressDropDown(Employee.EmployeeId.Value, null, null, DistrictId, null, "TownId", "TownName", ref ddlTown);
        }
        private void LoadPaging(DataTable data, int PageNumber = 1, int RowNumber = 20)
        {
            ViewState["PageNumber"] = PageNumber;
            DataTable data_pag = new DataTable();
            data_pag.Columns.Add("PageNumber", typeof(int));
            data_pag.Columns.Add("Active", typeof(string));

            int TotalRows = Convert.ToInt32(data.Rows[0]["TotalRows"]);
            lblFrom.Text = (((PageNumber - 1) * RowNumber) + 1).ToString();
            lblTo.Text = TotalRows > RowNumber ? (PageNumber * RowNumber).ToString() : (RowNumber - (RowNumber - TotalRows)).ToString();
            if (Convert.ToInt32(lblTo.Text) > TotalRows)
                lblTo.Text = TotalRows.ToString();
            lblTotalRows.Text = TotalRows.ToString();

            if (TotalRows > RowNumber)
            {
                int TotalPages = Convert.ToInt32(TotalRows / RowNumber) + 1;
                ViewState["TotalPages"] = TotalPages;
                for (int i = 1; i <= TotalPages; i++)
                {
                    if (i == PageNumber)
                        _ = data_pag.Rows.Add(i, "paginate_button page-item active");
                    else
                        data_pag.Rows.Add(i, "paginate_button page-item");
                }
            }
            else
                _ = data_pag.Rows.Add(1, "paginate_button page-item active");


            if (data.Rows.Count > 0)
            {
                int totalItem = (int)data.Rows[0]["TotalRows"];
                int totalPage = (int)Math.Ceiling((decimal)totalItem / 20);
                //lblTotalRow.Text = totalItem.ToString();
                ViewState["TotalPage"] = totalPage;
                DataTable dtPage = new DataTable();
                dtPage.Columns.Add("Page", typeof(int));
                dtPage.Columns.Add("Class", typeof(string));

                rpt_pagination.Visible = true;
                int currentPage = ViewState["PageNumber"] == null ? 1 : Int16.Parse(ViewState["PageNumber"].ToString());
                int start = ((int)Math.Ceiling((decimal)currentPage / 20) - 1) * 10 + 1;
                int end = start + (20 - 1);
                end = end > totalPage ? totalPage : end;
                for (int i = start; i <= end; i++)
                {
                    DataRow dr = dtPage.NewRow();
                    dr["Page"] = i;
                    dr["Class"] = i == PageNumber ? "paginate_button page-item active" : "paginate_button page-item";
                    dtPage.Rows.Add(dr);
                }
                rpt_pagination.DataSource = dtPage;
                rpt_pagination.DataBind();
            }
            else
            {
                rpt_pagination.Visible = false;
            }


            ViewState["DataPaging"] = data_pag;
            rptPaging.DataSource = data_pag;
            rptPaging.DataBind();

        }
        protected void lnkPage_Click(object sender, EventArgs e)
        {
            LinkButton lnk = sender as LinkButton;
            RepeaterItem item = lnk.NamingContainer as RepeaterItem;
            LinkButton lnkPage = item.FindControl("lnkPage") as LinkButton;

            int PageNumber = Convert.ToInt32(lnkPage.Text.Trim());
            int TotalPages = (int)ViewState["TotalPages"];
            DataTable data_pag = ViewState["DataPaging"] as DataTable;
            ViewState["PageNumber"] = PageNumber;
            lnkPrevious.Enabled = lnkNext.Enabled = true;
            if (PageNumber == 1)
                lnkPrevious.Enabled = !lnkPrevious.Enabled;
            else if (PageNumber == TotalPages)
                lnkNext.Enabled = !lnkNext.Enabled;

            Filter(PageNumber);
            //LoadPaging(data_pag, PageNumber);
        }
        protected void lnkPrevious_Click(object sender, EventArgs e)
        {
            int PageNumber = (int)ViewState["PageNumber"];
            int Previous = PageNumber == 1 ? 1 : PageNumber - 1;
            lnkPrevious.Enabled = lnkNext.Enabled = true;
            DataTable data_pag = ViewState["DataPaging"] as DataTable;
            if (PageNumber == 1)
                lnkPrevious.Enabled = false;
            Filter(Previous);
            //LoadPaging(data_pag, Previous);
        }
        protected void lnkNext_Click(object sender, EventArgs e)
        {
            int TotalPages = (int)ViewState["TotalPages"];
            int PageNumber = (int)ViewState["PageNumber"];
            int Next = PageNumber == TotalPages ? TotalPages : PageNumber + 1;
            lnkPrevious.Enabled = lnkNext.Enabled = true;
            DataTable data_pag = ViewState["DataPaging"] as DataTable;
            if (PageNumber == TotalPages)
                lnkNext.Enabled = false;
            Filter(Next);
            //LoadPaging(data_pag, Next);
        }
        protected void rpt_pagination_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            ViewState["PageNumber"] = Convert.ToInt32(e.CommandArgument);
            Filter(Convert.ToInt32(e.CommandArgument));
        }
        protected void lbn_next_Click(object sender, EventArgs e)
        {
            int? pageNumber = Int16.Parse(ViewState["PageNumber"].ToString());
            int? totalPage = Int16.Parse(ViewState["TotalPage"].ToString());
            if (pageNumber < totalPage)
            {
                pageNumber++;
                ViewState["PageNumber"] = pageNumber;
                Filter(pageNumber.Value);
            }
        }
        protected void lbn_prev_Click(object sender, EventArgs e)
        {
            int? pageNumber = Int16.Parse(ViewState["PageNumber"].ToString());
            if (pageNumber > 1)
            {
                pageNumber--;
                ViewState["PageNumber"] = pageNumber;
                Filter(pageNumber.Value);
            }

        }
        protected void lbn_first_Click(object sender, EventArgs e)
        {
            ViewState["PageNumber"] = 1;
            Filter(1);
        }
        protected void lbn_end_Click(object sender, EventArgs e)
        {
            ViewState["PageNumber"] = ViewState["TotalPage"];
            Filter(Convert.ToInt32(ViewState["TotalPage"]));
        }
        private void BindUserLeave_OT(int PageNumber = 1, int TypeReport = 1)
        {
            try
            {
                if (!DateTime.TryParseExact(txtFromDate.Text.Trim(), "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out DateTime FromDate))
                {
                    Toastr.ErrorToast("Từ ngày không đúng định dạng dd/MM/yyyy");
                    return;
                }
                if (!DateTime.TryParseExact(txtToDate.Text.Trim(), "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out DateTime ToDate))
                {
                    Toastr.ErrorToast("Đến ngày không đúng định dạng dd/MM/yyyy");
                    return;
                }

                //string value = ddlCycle.SelectedValue;
                //string[] arg = value.Split('_');
                //DateTime _from_cycle = Pf.DateIntToDate(Convert.ToInt32(arg[3]));
                //DateTime _to_cycle = Pf.DateIntToDate(Convert.ToInt32(arg[4]));

                //if (FromDate.Date < _from_cycle.Date || FromDate.Date > _to_cycle.Date)
                //{
                //    Toastr.ErrorToast("Từ ngày không nằm trong chu kỳ");
                //    return;
                //}
                //if (ToDate.Date < _from_cycle.Date || ToDate.Date > _to_cycle.Date)
                //{
                //    Toastr.ErrorToast("Đến ngày không nằm trong chu kỳ");
                //    return;
                //}

                int SupId = Convert.ToInt32(ddlSup.SelectedValue);
                int AuditorId = Convert.ToInt32(ddlAuditor.SelectedValue);
                int Status = Convert.ToInt32(ddlStatus.SelectedValue);

                /*int AreaId = Convert.ToInt32(ddlArea.SelectedValue);
                int ProvinceId = Convert.ToInt32(ddlProvince.SelectedValue);
                int DistrictId = Convert.ToInt32(ddlDistrict.SelectedValue);
                int TownId = Convert.ToInt32(ddlTown.SelectedValue);*/
                DataTable data = new DataTable();
                if (TypeReport == 1)
                    data = new EmployeesController().UserLeaveGetList(Employee.EmployeeId.Value, FromDate, ToDate, SupId, AuditorId, Status, PageNumber, 20);
                else if (TypeReport == 2)
                    data = new EmployeesController().UserOTGetList(Employee.EmployeeId.Value, FromDate, ToDate, SupId, AuditorId, Status, PageNumber, 20);

                if (data != null && data.Rows.Count > 0)
                {
                    plPaging.Visible = true;
                    plNoData.Visible = false;
                    if (TypeReport == 1)
                    {
                        plUserLeave.Visible = true;
                        rptLeave.DataSource = data;
                        rptLeave.DataBind();
                    }
                    else
                    {
                        plOT.Visible = true;
                        rptOT.DataSource = data;
                        rptOT.DataBind();
                    }
                    LoadPaging(data, PageNumber);
                }
                else
                {
                    plPaging.Visible = false;
                    plNoData.Visible = true;
                    if (TypeReport == 1)
                    {
                        plUserLeave.Visible = false;
                        rptLeave.DataSource = new DataTable();
                        rptLeave.DataBind();
                    }
                    else
                    {
                        plOT.Visible = false;
                        rptOT.DataSource = new DataTable();
                        rptOT.DataBind();
                    }
                    Toastr.WarningToast($"Không có dữ liệu {(TypeReport == 1 ? "nghỉ phép" : "OT")}.");
                    return;
                }
            }
            catch (Exception ex)
            {
                plPaging.Visible = plNoData.Visible = false;
                Toastr.ErrorToast(ex.Message);
            }
        }
        public DateTime DateIntToDate(int date)
        {
            DateTime _value = new DateTime();
            try
            {
                _value = DateTime.ParseExact(date + "", "yyyyMMdd", null);
            }
            catch (Exception)
            {
            }
            return _value;
        }
    }
}