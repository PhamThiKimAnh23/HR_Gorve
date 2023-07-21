using BLL.Attendants;
using BLL.WorkResults;
using HR_Grove_Web.App_Code;
using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Threading;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace HR_Grove_Web.Report
{
    public partial class WorkResult : PagePermisstion
    {
        private string _title = "Report Attendance";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ((SiteAuditMaster)Master).SetFormTitle(_title);
                Pf.bindCycleDropDown_Customer(Employee.EmployeeId.Value, DateTime.Now.Year, DateTime.Now.Month, ref ddlCycle);
                txtToDate.Text = txtFromDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtFromDate.Text = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).ToString("dd/MM/yyyy");
                bindOption();
            }
            ScriptManager script = ScriptManager.GetCurrent(Page);
            script.Dispose();
            script.RegisterPostBackControl(btnExport);
        }

        void bindOption()
        {
            ddlAuditor.Items.Insert(0, new ListItem("-Tất cả-", "-1"));

            Pf.bindEmployeeDropDown(2, null, null, ref ddlSup);
            if (Employee.TypeId == 2)
            {
                ddlSup.SelectedValue = Employee.EmployeeId.ToString();
                ddlSup.Enabled = false;
            }
            Pf.bindEmployeeDropDown(4, null, null, ref ddlMDO);
            Pf.bindEmployeeDropDown(3, null, Employee.TypeId == 2 ? Employee.EmployeeId : null, ref ddlAuditor);
            Thread.Sleep(1000);
            Pf.bindMasterDropDown("AUDITRESULT", ref ddlAuditResults);

            Pf.bindAreaDropDown(Employee.EmployeeId.Value, ref ddlArea);
            //ddlProvince.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
            Pf.bindAddressDropDown(Employee.EmployeeId.Value, -1, null, null, null, "ProvinceId", "ProvinceName", ref ddlProvince);
            ddlDistrict.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
            ddlTown.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
            ViewState["PageNumber"] = 1;
        }

        protected void ddlSup_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlAuditor.Items.Clear();
            string selected = ddlSup.SelectedValue;
            if (!string.IsNullOrEmpty(selected) && selected != "-1")
                Pf.bindEmployeeDropDown(null, null, Convert.ToInt32(selected), ref ddlAuditor);
            else
                ddlAuditor.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            Filter();
        }
        void Filter(int PageNumber = 1)
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
                int AuditResult = Convert.ToInt32(ddlAuditResults.SelectedValue);

                //Thêm mới 20220521
                int AreaId = Convert.ToInt32(ddlArea.SelectedValue);
                int ProvinceId = Convert.ToInt32(ddlProvince.SelectedValue);
                int DistrictId = Convert.ToInt32(ddlDistrict.SelectedValue);
                int TownId = Convert.ToInt32(ddlTown.SelectedValue);
                int MVOId = Convert.ToInt32(ddlMDO.SelectedValue);
                int POGId = Convert.ToInt32(ddlPNG.SelectedValue);

                //Thêm mới 20220607
                int QCStatus = Convert.ToInt32(ddlQC.SelectedValue);

                //Thêm mới 20220613
                string LWorkId = null;
                if (!string.IsNullOrEmpty(txtWorkId.Text))
                {
                    LWorkId = txtWorkId.Text;
                }

                using (DataTable data = new WorkResultController().WorkResultGetList(Employee.EmployeeId.Value, FromDate, ToDate, SupId, AuditorId, AuditResult, txtShopCode.Text,
                    AreaId, ProvinceId, DistrictId, TownId, MVOId, POGId, QCStatus, LWorkId,
                    PageNumber, 20))
                {
                    if (data != null && data.Rows.Count > 0)
                    {
                        workresult.Visible = true;
                        plPaging.Visible = true;
                        rpWorkResult.DataSource = data;
                        rpWorkResult.DataBind();

                        LoadPaging(data, PageNumber);


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

                    }
                    else
                    {
                        plPaging.Visible = true;
                        workresult.Visible = false;
                        rpWorkResult.DataSource = new DataTable();
                        rpWorkResult.DataBind();
                        Toastr.WarningToast("Không có dữ liệu.");
                        return;
                    }
                }
            }
            catch (Exception ex)
            {
                Toastr.ErrorToast(ex.Message);
            }
        }
        protected void btnExport_Click(object sender, EventArgs e)
        {
            ExportRawData();
        }

        protected void img_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton image = sender as ImageButton;
            RepeaterItem rpt = (RepeaterItem)image.NamingContainer;
            /*Literal ltrImage = gr.FindControl("ltrImage") as Literal;
            Repeater rptDetails = gr.FindControl("rptDetails") as Repeater;*/
            Panel pnGrid = rpt.FindControl("pnGrid") as Panel;
            PlaceHolder pndetail = rpt.FindControl("pndetail") as PlaceHolder;
            Label lblWorkId = (Label)rpt.FindControl("lblWorkId");
            //Label lbIsNewShop = (Label)rpt.FindControl("lbIsNewShop");
            Panel plATT = rpt.FindControl("plATT") as Panel;
            //Panel plCREATESHOP = rpt.FindControl("plCREATESHOP") as Panel;
            Panel pnAudio = rpt.FindControl("plAudio") as Panel;
            int WorkId = Convert.ToInt32(lblWorkId.Text.Trim());

            if (image.CommandName == "Show")
            {
                image.ImageUrl = "~/images/minus.png";
                pnGrid.Visible = pndetail.Visible = true;
                image.CommandName = "Hide";

                ///* Check Hide/Unhide tab */
                //CheckVisibleTabByWorkId(WorkId, rpt);

                ///* Bind List Audio*/
                //BindAudio(rpt, pnAudio);

                ///* Bind Tab Attendant*/
                //Thread.Sleep(500);

                try
                {
                    LinkButton lbKPI = rpt.FindControl("lbATT") as LinkButton;
                    BindTabAttendant(rpt, plATT);
                    //if (lbIsNewShop.Text == "0")
                    //{
                    //    //BindTabAttendant(rpt, plATT);
                    //    lbKPI_Click(lbKPI, EventArgs.Empty);
                    //}
                    //else
                    //{
                    //    lbKPI = rpt.FindControl("lbCREATESHOP") as LinkButton;
                    //    lbKPI_Click(lbKPI, EventArgs.Empty);
                    //    //BindTabCreateShop(rpt, plCREATESHOP);
                    //}

                    /*TextBox txtQCComment = rpt.FindControl("txtQCComment") as TextBox;
                    DropDownList ddlQC = rpt.FindControl("ddlQC") as DropDownList;

                    txtQCComment.Text = "";
                    ddlQC.SelectedIndex = 0;

                    using (DataTable dt = new WorkResultController().WorkResultUpdateQC(Employee.EmployeeId.Value,
                        Convert.ToInt32(lblWorkId.Text), -100, 0, null, 1
                        ))
                    {
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            txtQCComment.Text = dt.Rows[0]["QCComment"].ToString();
                            ddlQC.SelectedValue = !string.IsNullOrWhiteSpace(Convert.ToString(dt.Rows[0]["QCStatus"])) || Convert.ToString(dt.Rows[0]["QCStatus"]) != "" ? Convert.ToString(dt.Rows[0]["QCStatus"]) : "0";
                        }
                    }*/
                }
                catch (Exception ex)
                {
                    Toastr.ErrorToast(ex.Message);
                }

            }
            else if (image.CommandName == "Hide")
            {
                image.CommandName = "Show";
                pnGrid.Visible = pndetail.Visible = false;
                image.ImageUrl = "~/images/plus.png";
            }

        }
        protected void lbKPI_Click(object sender, EventArgs e)
        {
            LinkButton lk = (LinkButton)sender;
            RepeaterItem item = lk.NamingContainer as RepeaterItem;
            Panel pnGrid = (Panel)item.FindControl("pnGrid");

            LinkButton lbATT = item.FindControl("lbATT") as LinkButton;
           /* LinkButton lbSURVEYNUMOFEMP = item.FindControl("lbSURVEYNUMOFEMP") as LinkButton;
            LinkButton lbSURVEYFISTGIFT = item.FindControl("lbSURVEYFISTGIFT") as LinkButton;
            LinkButton lbSURVEYLASTGIFT = item.FindControl("lbSURVEYLASTGIFT") as LinkButton;*/
            //LinkButton lbSTOREIMAGE = item.FindControl("lbSTOREIMAGE") as LinkButton;

            string CommandName = lk.CommandName;

            List<LinkButton> linkButtons = new List<LinkButton>()
            {
                lbATT//,, lbSURVEYNUMOFEMP, lbSURVEYFISTGIFT, lbSURVEYLASTGIFTlbSTOREIMAGE
            };
            int KPIId = 0;
            foreach (var itemlbtn in linkButtons)
            {
                itemlbtn.CssClass = itemlbtn.CommandName == lk.CommandName ? "nav-link active" : "nav-link";
                KPIId = KPIId == 0 ? (itemlbtn.CommandName == lk.CommandName ? Convert.ToInt32(itemlbtn.CommandArgument) : 0) : KPIId;
            }
            foreach (Control c in pnGrid.Controls)
            {
                if (c is Panel)
                {
                    Panel pbb = c as Panel;
                    string pnlTabId = $"pl{CommandName}";
                    if (c.ID.ToLower() != "plaudio")
                    {
                        if (pbb.ID == pnlTabId)
                        {
                            pbb.Visible = true;
                            LoadDataByTab(item, pnlTabId, pbb, CommandName, KPIId);
                        }
                        else
                            pbb.Visible = false;
                    }
                }
            }
        }

        private void LoadDataByTab(RepeaterItem item, string pnlTabId, Panel pbb, string CommandName = "", int KPIId = 0)
        {
            string IDRepeater = $"rpt{CommandName}";
            switch (pnlTabId)
            {
                case "plATT":
                    BindTabAttendant(item, pbb); break;
                /*case "plPlanogram":
                    BindTabOSA(item, pbb); break;
                case "plHotzone":
                    BindTabKPISurvey(item, pbb, IDRepeater, KPIId); break;
                case "plPRO":
                    BindTabKPISurvey(item, pbb, IDRepeater, KPIId); break;
                case "plSURVEY_POSM":
                    BindTabKPISurvey(item, pbb, IDRepeater, KPIId); break;
                case "plSURVEYALL":
                    BindTabKPISurvey(item, pbb, IDRepeater, KPIId); break;
                case "plPOSM":
                    BindTabPOSM(item, pbb); break;
                case "plCTEATESHOP":
                    BindTabCreateShop(item, pbb); break;

                case "plSURVEYNUMOFEMP":
                    BindTabKPISurvey(item, pbb, IDRepeater, KPIId); break;
                case "plSURVEYFISTGIFT":
                    BindTabKPISurvey(item, pbb, IDRepeater, KPIId); break;
                case "plSURVEYLASTGIFT":
                    BindTabKPISurvey(item, pbb, IDRepeater, KPIId); break;*/
                //case "plSTOREIMAGE":
                //    BindTabKPISurvey(item, pbb, IDRepeater, KPIId); break;
                default:
                    break;
            }
        }

        protected void Bind_QC_KPI(RepeaterItem item, int KPIID)
        {
            try
            {

                Label lblWorkId = (Label)item.FindControl("lblWorkId");
                Label lbqckpi = item.FindControl("lbqckpi") as Label;
                Label lbqckpiid = item.FindControl("lbqckpiid") as Label;
                Label lbqckpiname = item.FindControl("lbqckpiname") as Label;


                TextBox txtQCKPIComment = item.FindControl("txtQCKPIComment") as TextBox;
                DropDownList ddlQCKPI = item.FindControl("ddlQCKPI") as DropDownList;


                txtQCKPIComment.Text = "";
                ddlQCKPI.SelectedIndex = 0;

                lbqckpi.Text = "Kết quả KPI chấm công";
                lbqckpiname.Text = "lbATT";
                if (KPIID == 1)
                {
                    lbqckpi.Text = "Kết quả KPI Hotzone";
                    lbqckpiname.Text = "lbHotzone";
                }
                if (KPIID == 2)
                {
                    lbqckpi.Text = "Kết quả KPI Trưng bày";
                    lbqckpiname.Text = "lbPlanogram";
                }
                if (KPIID == 3)
                {
                    lbqckpi.Text = "Kết quả KPI POSM";
                    lbqckpiname.Text = "lbPOSM";
                }
                if (KPIID == 4)
                {
                    lbqckpi.Text = "Kết quả KPI Phiếu xác nhận";
                    lbqckpiname.Text = "lbPRO";
                }
                if (KPIID == 5)
                {
                    lbqckpi.Text = "Kết quả KPI Khảo sát khác";
                    lbqckpiname.Text = "lbSURVEYALL";
                }
                if (KPIID == 6)
                {
                    lbqckpi.Text = "Kết quả KPI Tạo mới CH";
                    lbqckpiname.Text = "lbCREATESHOP";
                }



                lbqckpiid.Text = KPIID.ToString();
                using (DataTable dt = new WorkResultController().WorkResultUpdateQC(Employee.EmployeeId.Value,
                    Convert.ToInt32(lblWorkId.Text), KPIID, 0, null, 1
                    ))
                {
                    txtQCKPIComment.Text = dt.Rows[0]["QCComment"].ToString();
                    ddlQCKPI.SelectedValue = dt.Rows[0]["QCStatus"].ToString();
                }
            }
            catch (Exception ex)
            {
                Toastr.ErrorToast(ex.Message);
            }
        }

        private void BindTabAttendant(RepeaterItem item, Panel pbb)
        {
            //Bind_QC_KPI(item, 0);
            try
            {
                Repeater rptAttendant = item.FindControl("rptAttendant") as Repeater;
                Label lblAuditDate = (Label)item.FindControl("lblAuditDate");
                Label lblShopId = (Label)item.FindControl("lblShopId");
                Label lblEmployeeId = (Label)item.FindControl("lblEmployeeId");

                Label lblWorkId = (Label)item.FindControl("lblWorkId");

               /* Button btn = (Button)item.FindControl("btnChangeImage");
                btn.OnClientClick = $"popWindow_Custom('/Popups/ImportImageAdmin.aspx?WorkId=" + lblWorkId.Text + "&KPIId=0', 700, 520); return false;";*/

                int EmployeeId = Convert.ToInt32(lblEmployeeId.Text.Trim());
                int ShopId = Convert.ToInt32(lblShopId.Text.Trim());
                int AuditDate = Convert.ToInt32(lblAuditDate.Text.Trim());
                DataTable data = new AttendantController().AttendantGetList(EmployeeId, ShopId, AuditDate);
                if (data != null && data.Rows.Count > 0)
                {
                    pbb.Visible = true;
                    rptAttendant.DataSource = data;
                    rptAttendant.DataBind();
                }
                else
                    pbb.Visible = false;
            }
            catch (Exception ex)
            {
                pbb.Visible = false;
                Toastr.ErrorToast(ex.Message);
            }
        }
        private void BindTabCreateShop(RepeaterItem item, Panel pbb)
        {
            Bind_QC_KPI(item, 6);
            try
            {
                pbb.Visible = true;
                Repeater rpt_cshop = item.FindControl("rpt_cshop") as Repeater;
                Label lblWorkId = (Label)item.FindControl("lblWorkId");

                DataTable data = new AttendantController().CreateShopGetList(Convert.ToInt32(lblWorkId.Text));
                if (data != null && data.Rows.Count > 0)
                {
                    rpt_cshop.DataSource = data;
                    rpt_cshop.DataBind();
                }
                else
                    pbb.Visible = false;
            }
            catch (Exception ex)
            {
                pbb.Visible = false;
                Toastr.ErrorToast(ex.Message);
            }
        }

        public string load_image_create_Shop(string photo)
        {
            string html = "";
            if (!string.IsNullOrEmpty(photo))
            {
                string[] l_photo = photo.Split(';');
                foreach (string item in l_photo)
                {
                    html += $"<img src='" + item + "' style=\"width: 200px;padding-left:5px; \" />";
                }
            }
            return html;
        }

        private void BindTabOSA(RepeaterItem item, Panel pbb)
        {
            Bind_QC_KPI(item, 2);
            try
            {
                Repeater rptOSA = item.FindControl("rptOSA") as Repeater;
                CheckBox cbAllOSA = item.FindControl("cbAllOSA") as CheckBox;
                Repeater rpt_calculator = item.FindControl("rpt_calculator") as Repeater;
                Label lblWorkId = (Label)item.FindControl("lblWorkId");
                Label lbIsLockReport = (Label)item.FindControl("lbIsLockReport");
                Label lbQCStatus = (Label)item.FindControl("lbQCStatus");

                Button btn = (Button)item.FindControl("btnChangeImage");
                btn.OnClientClick = $"popWindow_Custom('/Popups/ImportImageAdmin.aspx?WorkId=" + lblWorkId.Text + "&KPIId=2', 700, 520); return false;";

                long WorkId = Convert.ToInt32(lblWorkId.Text.Trim());
                using (DataTable data = new WorkResultController().WorkResultGetKPIOSA(WorkId))
                {
                    if (data != null && data.Rows.Count > 0)
                    {
                        System.Data.DataColumn newColumn = new System.Data.DataColumn("IsLockReport", typeof(System.String));
                        newColumn.DefaultValue = lbIsLockReport.Text;
                        data.Columns.Add(newColumn);

                        System.Data.DataColumn newColumn1 = new System.Data.DataColumn("QCStatus", typeof(System.String));
                        newColumn1.DefaultValue = lbQCStatus.Text;
                        data.Columns.Add(newColumn1);

                        rptOSA.DataSource = data;
                        rptOSA.DataBind();
                    }
                    else
                        pbb.Visible = false;
                }
                using (DataTable data = new WorkResultController().WorkResultGetKPICalculator(WorkId))
                {
                    if (data != null && data.Rows.Count > 0)
                    {
                        rpt_calculator.DataSource = data;
                        rpt_calculator.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                pbb.Visible = false;
                Toastr.ErrorToast(ex.Message.Replace("'", ""));
            }
        }
        private void BindTabPOSM(RepeaterItem item, Panel pbb)
        {
            Bind_QC_KPI(item, 3);
            try
            {
                Repeater rptPOSM = item.FindControl("rptPOSM") as Repeater;
                Label lblWorkId = (Label)item.FindControl("lblWorkId");
                Label lbIsLockReport = (Label)item.FindControl("lbIsLockReport");
                Label lbQCStatus = (Label)item.FindControl("lbQCStatus");

                Button btn = (Button)item.FindControl("btnChangeImage");
                btn.OnClientClick = $"popWindow_Custom('/Popups/ImportImageAdmin.aspx?WorkId=" + lblWorkId.Text + "&KPIId=3', 700, 520); return false;";

                long WorkId = Convert.ToInt32(lblWorkId.Text.Trim());
                DataTable data = new WorkResultController().WorkResultGetKPIPOSM(WorkId);
                if (data != null && data.Rows.Count > 0)
                {
                    System.Data.DataColumn newColumn = new System.Data.DataColumn("IsLockReport", typeof(System.String));
                    newColumn.DefaultValue = lbIsLockReport.Text;
                    data.Columns.Add(newColumn);

                    System.Data.DataColumn newColumn1 = new System.Data.DataColumn("QCStatus", typeof(System.String));
                    newColumn1.DefaultValue = lbQCStatus.Text;
                    data.Columns.Add(newColumn1);

                    rptPOSM.DataSource = data;
                    rptPOSM.DataBind();
                }
                else
                    pbb.Visible = false;
            }
            catch (Exception ex)
            {
                pbb.Visible = false;
                Toastr.ErrorToast(ex.Message);
            }
        }
        private void BindTabKPISurvey(RepeaterItem item, Panel pbb, string IdRepeater, int KPIId)
        {
            Bind_QC_KPI(item, KPIId);
            try
            {
                Repeater rptSurvey = item.FindControl(IdRepeater) as Repeater;
                Label lblWorkId = (Label)item.FindControl("lblWorkId");
                Label lbIsLockReport = (Label)item.FindControl("lbIsLockReport");
                Label lbQCStatus = (Label)item.FindControl("lbQCStatus");

                Button btn = (Button)item.FindControl("btnChangeImage");
                //if (KPIId == 4)
                btn.OnClientClick = $"popWindow_Custom('/Popups/ImportImageAdmin.aspx?WorkId=" + lblWorkId.Text + "&KPIId=" + KPIId + "', 700, 520); return false;";
                //else
                //    btn.OnClientClick = "";
                long WorkId = Convert.ToInt32(lblWorkId.Text.Trim());
                DataTable data = new WorkResultController().WorkResultGetKPISurvey(WorkId, KPIId);
                if (data != null && data.Rows.Count > 0)
                {
                    System.Data.DataColumn newColumn = new System.Data.DataColumn("IsLockReport", typeof(System.String));
                    newColumn.DefaultValue = lbIsLockReport.Text;
                    data.Columns.Add(newColumn);

                    System.Data.DataColumn newColumn1 = new System.Data.DataColumn("QCStatus", typeof(System.String));
                    newColumn1.DefaultValue = lbQCStatus.Text;
                    data.Columns.Add(newColumn1);

                    rptSurvey.DataSource = data;
                    rptSurvey.DataBind();
                }
                else
                    pbb.Visible = false;
            }
            catch (Exception ex)
            {
                pbb.Visible = false;
                Toastr.ErrorToast(ex.Message);
            }
        }
        private void BindAudio(RepeaterItem item, Panel pbb)
        {
            try
            {
                Repeater rptAudio = item.FindControl("rptAudio") as Repeater;
                Label lblWorkId = (Label)item.FindControl("lblWorkId");

                long WorkId = Convert.ToInt32(lblWorkId.Text.Trim());
                DataTable data = new WorkResultController().WorkResultGetAudio(WorkId);
                if (data != null && data.Rows.Count > 0)
                {
                    pbb.Visible = true;
                    rptAudio.DataSource = data;
                    rptAudio.DataBind();
                }
                else
                    pbb.Visible = false;
            }
            catch (Exception ex)
            {
                pbb.Visible = false;
                Toastr.ErrorToast(ex.Message);
            }
        }
        private void CheckVisibleTabByWorkId(int WorkId, RepeaterItem item)
        {
            HtmlGenericControl li_att = item.FindControl("li_att") as HtmlGenericControl;
            HtmlGenericControl li_surveynumofemp = item.FindControl("li_surveynumofemp") as HtmlGenericControl;
            HtmlGenericControl li_surveyfistgift = item.FindControl("li_surveyfistgift") as HtmlGenericControl;
            HtmlGenericControl li_surveylastgift = item.FindControl("li_surveylastgift") as HtmlGenericControl;
            //HtmlGenericControl li_storeimage = item.FindControl("li_storeimage") as HtmlGenericControl;

            LinkButton lbATT = item.FindControl("lbATT") as LinkButton;
            LinkButton lbSURVEYNUMOFEMP = item.FindControl("lbSURVEYNUMOFEMP") as LinkButton;
            LinkButton lbSURVEYFISTGIFT = item.FindControl("lbSURVEYFISTGIFT") as LinkButton;
            LinkButton lbSURVEYLASTGIFT = item.FindControl("lbSURVEYLASTGIFT") as LinkButton;
            //LinkButton lbSTOREIMAGE = item.FindControl("lbSTOREIMAGE") as LinkButton;

            DataTable data = new WorkResultController().WorkResultGetTabByWorkId(WorkId);
            if (data == null || data.Rows.Count == 0)
            {
                Toastr.WarningToast("Không có dữ liệu KPI trong báo cáo này");
                return;
            }
            lbATT.CommandArgument = "0";
            li_surveynumofemp.Visible = li_surveyfistgift.Visible = li_surveylastgift.Visible = false;// li_storeimage.Visible =  false;
            if (data != null && data.Rows.Count > 0)
            {
                foreach (DataRow dr in data.Rows)
                {
                    switch (Convert.ToInt32(dr["KPIId"]))
                    {
                        case (int)KPI.SURVEYNUMOFEMP: li_surveynumofemp.Visible = true; lbSURVEYNUMOFEMP.Text = Convert.ToString(dr["KPIName"]); lbSURVEYNUMOFEMP.CommandArgument = Convert.ToString(dr["KPIId"]); break;
                        case (int)KPI.SURVEYFISTGIFT: li_surveyfistgift.Visible = true; lbSURVEYFISTGIFT.Text = Convert.ToString(dr["KPIName"]); lbSURVEYFISTGIFT.CommandArgument = Convert.ToString(dr["KPIId"]); break;
                        case (int)KPI.SURVEYLASTGIFT: li_surveylastgift.Visible = true; lbSURVEYLASTGIFT.Text = Convert.ToString(dr["KPIName"]); lbSURVEYLASTGIFT.CommandArgument = Convert.ToString(dr["KPIId"]); break;
                        //case (int)KPI.STOREIMAGE: li_storeimage.Visible = true; lbSTOREIMAGE.Text = Convert.ToString(dr["KPIName"]); lbSTOREIMAGE.CommandArgument = Convert.ToString(dr["KPIId"]); break;
                        default: break;
                    }
                }
            }
        }
        private void ExportRawData()
        {
            int KPIId = Convert.ToInt32(ddlTypeReport.SelectedValue.Trim());
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
                int AuditResult = Convert.ToInt32(ddlAuditResults.SelectedValue);

                //Thêm mới 20220521
                int AreaId = Convert.ToInt32(ddlArea.SelectedValue);
                int ProvinceId = Convert.ToInt32(ddlProvince.SelectedValue);
                int DistrictId = Convert.ToInt32(ddlDistrict.SelectedValue);
                int TownId = Convert.ToInt32(ddlTown.SelectedValue);
                int MVOId = Convert.ToInt32(ddlMDO.SelectedValue);
                int POGId = Convert.ToInt32(ddlPNG.SelectedValue);

                //Thêm mới 20220607
                int QCStatus = Convert.ToInt32(ddlQC.SelectedValue);

                //Thêm mới 20220613
                string LWorkId = null;
                if (!string.IsNullOrEmpty(txtWorkId.Text))
                    LWorkId = txtWorkId.Text;

                List<int> lst_kpi = new List<int>() { 1000, 8, 9, 7 };
                if (lst_kpi.Any(k => k.Equals(KPIId)))
                {
                    using (DataTable data = new WorkResultController().WorkResultExportRawData(Employee.EmployeeId.Value, FromDate, ToDate, KPIId, SupId, AuditorId, AuditResult, txtShopCode.Text))
                    {
                        if (data != null && data.Rows.Count > 0)
                        {
                            string Filename = $"Rawdata_{ddlTypeReport.SelectedItem.Text}";
                            Pf.Excel(data, Filename);
                        }
                    }
                }
                else if (KPIId == 6)
                {
                    using (DataSet data = new WorkResultController().WorkResult_BCCT(Employee.EmployeeId.Value, FromDate, ToDate, SupId, AuditorId, AuditResult, txtShopCode.Text,
                    AreaId, ProvinceId, DistrictId, TownId, MVOId, POGId, QCStatus, LWorkId,
                    1, 20000000))
                    {
                        if (data != null)
                        {
                            string fileName = "Ket qua chi tiet " + string.Format("{0:yyyyMMddHHmmss}", DateTime.Now);
                            FileInfo fileInfo = new FileInfo(Server.MapPath("~\\Template\\Template_BaoCaoChiTiet.xlsx"));
                            /*string fileExport = Server.MapPath("~\\upload\\export\\" + fileName);
                            FileInfo fileCopy = fileInfo.CopyTo(fileExport);*/
                            using (var xls = new ExcelPackage(fileInfo))
                            {
                                for (int i = 0; i < data.Tables.Count; i++)
                                {
                                    ExcelWorksheet ws = xls.Workbook.Worksheets[i];
                                    try
                                    {
                                        ws.Cells[2, 2].LoadFromDataTable(data.Tables[i], true);
                                    }
                                    catch (Exception)
                                    {
                                    }
                                }
                                Pf.ExcelByExcelPackage(xls, fileName);

                                //btnExport.OnClientClick = "this.value='Xuất báo cáo'; this.disabled='false'";

                                //Response.Clear();
                                //Response.Expires = 1000;
                                //Response.Buffer = true;
                                //Response.Charset = "";
                                //Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                                //Response.AddHeader("content-disposition", "attachment;filename=" + fileName);
                                //using (MemoryStream MyMemoryStream = new MemoryStream())
                                //{
                                //    xls.SaveAs(MyMemoryStream);
                                //    MyMemoryStream.WriteTo(Response.OutputStream);

                                //    Response.Flush();
                                //    Response.End();
                                //}
                            }
                        }
                        else
                        {
                            Toastr.ErrorToast("Không có dữ liệu");
                        }
                    }
                }

                else if (KPIId == 1001)
                {
                    using (DataSet data = new WorkResultController().ReportAttendance(Employee.EmployeeId.Value, FromDate, ToDate))
                    {
                        if (data != null)
                        {
                            string fileName = "Report Attendance " + string.Format("{0:yyyyMMddHHmmss}", DateTime.Now);
                            FileInfo fileInfo = new FileInfo(Server.MapPath("~\\Template\\template_reportattendance.xlsx"));
                            /*string fileExport = Server.MapPath("~\\upload\\export\\" + fileName);
                            FileInfo fileCopy = fileInfo.CopyTo(fileExport);*/
                            using (var xls = new ExcelPackage(fileInfo))
                            {
                                for (int i = 0; i < data.Tables.Count; i++)
                                {
                                    ExcelWorksheet ws = xls.Workbook.Worksheets[i];
                                    try
                                    {
                                        ws.Cells[2, 2].LoadFromDataTable(data.Tables[i], true);
                                    }
                                    catch (Exception)
                                    {
                                    }
                                }
                                Pf.ExcelByExcelPackage(xls, fileName);

                                //btnExport.OnClientClick = "this.value='Xuất báo cáo'; this.disabled='false'";

                                //Response.Clear();
                                //Response.Expires = 1000;
                                //Response.Buffer = true;
                                //Response.Charset = "";
                                //Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                                //Response.AddHeader("content-disposition", "attachment;filename=" + fileName);
                                //using (MemoryStream MyMemoryStream = new MemoryStream())
                                //{
                                //    xls.SaveAs(MyMemoryStream);
                                //    MyMemoryStream.WriteTo(Response.OutputStream);

                                //    Response.Flush();
                                //    Response.End();
                                //}
                            }
                        }
                        else
                        {
                            Toastr.ErrorToast("Không có dữ liệu");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Toastr.ErrorToast(ex.Message);
            }
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

        protected void ddlProvince_SelectedIndexChanged(object sender, EventArgs e)
        {
            int ProvinceId = Convert.ToInt32(ddlProvince.SelectedValue);
            if (ProvinceId < 0)
            {
                ddlDistrict.Items.Clear();
                ddlTown.Items.Clear();
                ddlDistrict.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
                ddlTown.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
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
                ddlProvince.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
                ddlDistrict.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
                ddlTown.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
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
                ddlTown.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
            }
            else
                Pf.bindAddressDropDown(Employee.EmployeeId.Value, null, null, DistrictId, null, "TownId", "TownName", ref ddlTown);
        }

        protected void ddlCycle_SelectedIndexChanged(object sender, EventArgs e)
        {
            rpWorkResult.DataSource = null;
            rpWorkResult.DataBind();
            txtFromDate.Text = txtToDate.Text = "";
            if (ddlCycle.SelectedIndex > 0)
            {
                string value = ddlCycle.SelectedValue;
                string[] arg = value.Split('_');
                txtFromDate.Text = Pf.DateIntToString(Convert.ToInt32(arg[3]), "dd/MM/yyyy");
                txtToDate.Text = Pf.DateIntToString(Convert.ToInt32(arg[4]), "dd/MM/yyyy");
            }
        }

        protected void btnQCKPI_Click(object sender, EventArgs e)
        {
            try
            {
                Button image = sender as Button;
                RepeaterItem rpt = (RepeaterItem)image.NamingContainer;
                Label lblWorkId = rpt.FindControl("lblWorkId") as Label;
                Label lbqckpiid = rpt.FindControl("lbqckpiid") as Label;
                TextBox txtQCKPIComment = rpt.FindControl("txtQCKPIComment") as TextBox;
                DropDownList ddlQCKPI = rpt.FindControl("ddlQCKPI") as DropDownList;
                if (ddlQCKPI.SelectedIndex <= 0)
                {
                    Toastr.ErrorToast("Vui lòng chọn trạng thái QC");
                    return;
                }
                if (string.IsNullOrEmpty(txtQCKPIComment.Text))
                {
                    Toastr.ErrorToast("Vui lòng ghi chú");
                    return;
                }

                using (DataTable dt = new WorkResultController().WorkResultUpdateQC(Employee.EmployeeId.Value,
                        Convert.ToInt32(lblWorkId.Text), Convert.ToInt32(lbqckpiid.Text), Convert.ToInt32(ddlQCKPI.SelectedIndex),
                        txtQCKPIComment.Text, 2
                        ))
                {
                    Toastr.SucessToast("Lưu thành công");
                }
            }
            catch (Exception ex)
            {
                Toastr.ErrorToast("Lỗi:" + ex.Message);
            }

        }

        protected void btnLockWr_Click(object sender, EventArgs e)
        {
            try
            {
                Button image = sender as Button;
                int action_code = Convert.ToInt32(image.CommandArgument);
                RepeaterItem rpt = (RepeaterItem)image.NamingContainer;
                Label lblWorkId = rpt.FindControl("lblWorkId") as Label;
                Label lbqckpiid = rpt.FindControl("lbqckpiid") as Label;
                Label lbqckpiname = rpt.FindControl("lbqckpiname") as Label;
                TextBox txtQCComment = rpt.FindControl("txtQCComment") as TextBox;
                DropDownList ddlQC = rpt.FindControl("ddlQC") as DropDownList;
                LinkButton lbKPI = rpt.FindControl(lbqckpiname.Text) as LinkButton;

                TextBox txtKey = rpt.FindControl("txtKey") as TextBox;
                Label lbPassKey = rpt.FindControl("lbPassKey") as Label;

                if (string.IsNullOrEmpty(txtKey.Text))
                {
                    Toastr.ErrorToast("Vui lòng mật khẩu");
                    return;
                }
                if (!txtKey.Text.Equals(lbPassKey.Text))
                {
                    Toastr.ErrorToast("Sai mật khẩu. Vui lòng nhập lại.");
                    return;
                }

                Button btnQCKPI = rpt.FindControl("btnQCKPI") as Button;

                Label lbIsLockReport = rpt.FindControl("lbIsLockReport") as Label;

                if (ddlQC.SelectedIndex <= 0 && action_code == -100)
                {
                    Toastr.ErrorToast("Vui lòng chọn trạng thái QC");
                    return;
                }
                if (string.IsNullOrEmpty(txtQCComment.Text) && action_code == -100)
                {
                    Toastr.ErrorToast("Vui lòng ghi chú");
                    return;
                }

                using (DataTable dt = new WorkResultController().WorkResultUpdateQC(Employee.EmployeeId.Value,
                        Convert.ToInt32(lblWorkId.Text), action_code, Convert.ToInt32(ddlQC.SelectedIndex),
                        txtQCComment.Text, 2
                        ))
                {
                    if (dt.Rows[0]["status_code"].ToString() == "200")
                    {
                        if (action_code == -100)
                            lbIsLockReport.Text = "1";
                        lbKPI_Click(lbKPI, EventArgs.Empty);
                        Toastr.SucessToast("Lưu thành công");
                        btnQCKPI.Visible = false;
                        image.Visible = false;
                    }
                    else
                        Toastr.ErrorToast(dt.Rows[0]["comment"].ToString());
                }
            }
            catch (Exception ex)
            {
                Toastr.ErrorToast("Lỗi:" + ex.Message);
            }
        }

        //protected void cbAllOSA_CheckedChanged(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        CheckBox image = sender as CheckBox;
        //        RepeaterItem item = (RepeaterItem)image.NamingContainer;

        //        Repeater rptOSA = item.FindControl("rptOSA") as Repeater;
        //        CheckBox cbAllOSA = item.FindControl("cbAllOSA") as CheckBox;
        //        Repeater rpt_calculator = item.FindControl("rpt_calculator") as Repeater;
        //        Label lblWorkId = (Label)item.FindControl("lblWorkId");
        //        Label lbIsLockReport = (Label)item.FindControl("lbIsLockReport");
        //        Label lbQCStatus = (Label)item.FindControl("lbQCStatus");
        //        rptOSA.DataSource = null;
        //        rptOSA.DataBind();

        //        long WorkId = Convert.ToInt32(lblWorkId.Text.Trim());
        //        using (DataTable data = new WorkResultController().WorkResultGetKPIOSA(WorkId, cbAllOSA.Checked == true ? 1 : 0))
        //        {
        //            if (data != null && data.Rows.Count > 0)
        //            {
        //                System.Data.DataColumn newColumn = new System.Data.DataColumn("IsLockReport", typeof(System.String));
        //                newColumn.DefaultValue = lbIsLockReport.Text;
        //                data.Columns.Add(newColumn);

        //                System.Data.DataColumn newColumn1 = new System.Data.DataColumn("QCStatus", typeof(System.String));
        //                newColumn1.DefaultValue = lbQCStatus.Text;
        //                data.Columns.Add(newColumn1);

        //                rptOSA.DataSource = data;
        //                rptOSA.DataBind();
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Toastr.ErrorToast(ex.Message);
        //    }
        //}

        protected void btnDoneQc_Click(object sender, EventArgs e)
        {
            try
            {
                Button image = sender as Button;
                RepeaterItem rpt = (RepeaterItem)image.NamingContainer;
                Label lblWorkId = rpt.FindControl("lblWorkId") as Label;
                Label lbqckpiid = rpt.FindControl("lbqckpiid") as Label;
                Label lbqckpiname = rpt.FindControl("lbqckpiname") as Label;
                TextBox txtQCComment = rpt.FindControl("txtQCComment") as TextBox;
                DropDownList ddlQC = rpt.FindControl("ddlQC") as DropDownList;
                LinkButton lbKPI = rpt.FindControl(lbqckpiname.Text) as LinkButton;

                Button btnQCKPI = rpt.FindControl("btnQCKPI") as Button;

                using (DataTable dt = new WorkResultController().WorkResultUpdateQC(Employee.EmployeeId.Value,
                        Convert.ToInt32(lblWorkId.Text), -10, Convert.ToInt32(ddlQC.SelectedIndex),
                        txtQCComment.Text, 2
                        ))
                {
                    if (dt.Rows[0]["status_code"].ToString() == "200")
                    {
                        lbKPI_Click(lbKPI, EventArgs.Empty);
                        Toastr.SucessToast("Lưu thành công");
                        btnQCKPI.Visible = false;
                        image.Visible = false;
                    }
                    else
                        Toastr.ErrorToast(dt.Rows[0]["comment"].ToString());
                }
            }
            catch (Exception ex)
            {
                Toastr.ErrorToast("Lỗi:" + ex.Message);
            }
        }

        protected void cbAllPosm_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                CheckBox image = sender as CheckBox;
                RepeaterItem item = (RepeaterItem)image.NamingContainer;

                Repeater rptPOSM = item.FindControl("rptPOSM") as Repeater;
                CheckBox cbAllPosm = item.FindControl("cbAllPosm") as CheckBox;
                Repeater rpt_calculator = item.FindControl("rpt_calculator") as Repeater;
                Label lblWorkId = (Label)item.FindControl("lblWorkId");
                Label lbIsLockReport = (Label)item.FindControl("lbIsLockReport");
                Label lbQCStatus = (Label)item.FindControl("lbQCStatus");
                rptPOSM.DataSource = null;
                rptPOSM.DataBind();

                long WorkId = Convert.ToInt32(lblWorkId.Text.Trim());
                using (DataTable data = new WorkResultController().WorkResultGetKPIPOSM(WorkId, cbAllPosm.Checked == true ? 1 : 0))
                {
                    if (data != null && data.Rows.Count > 0)
                    {
                        System.Data.DataColumn newColumn = new System.Data.DataColumn("IsLockReport", typeof(System.String));
                        newColumn.DefaultValue = lbIsLockReport.Text;
                        data.Columns.Add(newColumn);

                        System.Data.DataColumn newColumn1 = new System.Data.DataColumn("QCStatus", typeof(System.String));
                        newColumn1.DefaultValue = lbQCStatus.Text;
                        data.Columns.Add(newColumn1);

                        rptPOSM.DataSource = data;
                        rptPOSM.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Toastr.ErrorToast(ex.Message);
            }
        }
    }
}