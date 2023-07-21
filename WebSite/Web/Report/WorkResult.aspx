<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAudit.Master" AutoEventWireup="true" CodeBehind="WorkResult.aspx.cs" Inherits="HR_Grove_Web.Report.WorkResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* .nav-link.active {
            background-color: goldenrod !important;
        }
*/
        .img-fluid {
            width: 100%;
            height: auto;
        }
    </style>
    <script type="text/javascript">
        function openNewImage(file, WorkId, KPIId) {
            popWindow_ImageAudit("../Popups/ImagesAuditDetail.aspx?src1=" + file + "&WorkId=" + WorkId + "&KPIId=" + KPIId, 820, 635);
        }
        function popWindow_ImageAudit(link, width, height) {
            var w = width, h = height;
            var left = (screen.width / 2) - (w / 2);
            var top = 10;
            window.open(link, 'popup', 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
            return false;
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content">
        <div class="container-fluid">
            <div class="card card-info">
                <%--<div class="card-header">
                    <h3 class="card-title">Báo cáo viếng thăm cửa hàng (Audit - Mer)</h3>
                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                    </div>
                </div>--%>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-2" runat="server" visible="false">
                            <div class="form-group">
                                <label>Cycle:</label>
                                <asp:DropDownList runat="server" ID="ddlCycle" OnSelectedIndexChanged="ddlCycle_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>StartDate :</label>
                                <div class="input-group date" id="reservationdate" data-target-input="nearest">
                                    <%--<input type="text" class="form-control datetimepicker-input" data-target="#reservationdate" />--%>
                                    <asp:TextBox runat="server" ID="txtFromDate" CssClass="form-control datetimepicker-input" data-target="#reservationdate"></asp:TextBox>
                                    <div class="input-group-append" data-target="#reservationdate" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>EndDate :</label>
                                <div class="input-group date" id="reservationdate1" data-target-input="nearest">
                                    <%--<input type="text" class="form-control datetimepicker-input" data-target="#reservationdate" />--%>
                                    <asp:TextBox runat="server" ID="txtToDate" CssClass="form-control datetimepicker-input" data-target="#reservationdate1"></asp:TextBox>
                                    <div class="input-group-append" data-target="#reservationdate1" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Area:</label>
                                <asp:DropDownList runat="server" ID="ddlArea" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlArea_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Province:</label>
                                <asp:DropDownList runat="server" ID="ddlProvince" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;" AutoPostBack="true" OnSelectedIndexChanged="ddlProvince_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>District:</label>
                                <asp:DropDownList runat="server" ID="ddlDistrict" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Town:</label>
                                <asp:DropDownList runat="server" ID="ddlTown" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="col-md-2" runat="server" visible="false">
                            <div class="form-group">
                                <label>MDO:</label>
                                <asp:DropDownList runat="server" ID="ddlMDO" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2" runat="server" visible="false">
                            <div class="form-group">
                                <label>Gói TB:</label>
                                <asp:DropDownList runat="server" ID="ddlPNG" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="-1">-Tất cả-</asp:ListItem>
                                    <asp:ListItem Value="1">DIAMOND</asp:ListItem>
                                    <asp:ListItem Value="2">GOLD</asp:ListItem>
                                    <asp:ListItem Value="3">TITAN</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>TeamLead:</label>
                                <asp:DropDownList runat="server" ID="ddlSup" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;" AutoPostBack="true" OnSelectedIndexChanged="ddlSup_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>PG:</label>
                                <asp:DropDownList runat="server" ID="ddlAuditor" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Store Results:</label>
                                <asp:DropDownList runat="server" ID="ddlAuditResults" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2" runat="server" visible="false">
                            <div class="form-group">
                                <label>Kết quả QC Cửa hàng:</label>
                                <asp:DropDownList runat="server" ID="ddlQC" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="-1">-Tất cả-</asp:ListItem>
                                    <asp:ListItem Value="0">Chưa QC</asp:ListItem>
                                    <asp:ListItem Value="4">Đang QC</asp:ListItem>
                                    <asp:ListItem Value="5">Done QC</asp:ListItem>
                                    <asp:ListItem Value="1">Pass</asp:ListItem>
                                    <asp:ListItem Value="2">Reject</asp:ListItem>
                                    <asp:ListItem Value="3">Review</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>ID store:</label>
                                <asp:TextBox runat="server" ID="txtShopCode" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>WorkId:</label>
                                <asp:TextBox runat="server" ID="txtWorkId" CssClass="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Button runat="server" class="btn btn-primary" Text="Tìm kiếm" ID="btnFilter" OnClick="btnFilter_Click" />

                            <asp:Button runat="server" class="btn btn-primary" Text="Xuất báo cáo" ID="btnExport" OnClick="btnExport_Click" UseSubmitBehavior="false" Style="float: right;" OnClientClick="this.value='Đang xuất file...'; this.disabled='true'" />
                            <asp:DropDownList runat="server" ID="ddlTypeReport" Style="width: 150px; height: 37px; float: right; margin-right: 20px;">
                                <asp:ListItem Text="ATTENDANT" Value="1000" />
                                <asp:ListItem Text="Report Attendance" Value="1001" />
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>
    <section class="content" id="workresult" runat="server" visible="false">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Kết quả làm việc</h3>

                        </div>
                        <div class="card-body" style="padding: 0 !important;">
                            <div id="example2_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <table class="table table-bordered table-responsive">
                                            <thead>
                                                <tr>
                                                    <th></th>
                                                    <th>#</th>
                                                    <th>WorkId</th>
                                                    <th>Cửa hàng</th>
                                                    <th>Địa chỉ</th>
                                                   <%-- <th>Gói TB</th>--%>
                                                    <th>Nhân viên</th>
                                                    <th>Ngày viếng thăm</th>
                                                    <th>KQ Làm việc</th>
                                                    <%--<th>Điểm TB</th>--%>
                                                    <%--<th>% Trả thưởng</th>--%>
                                                    <%-- <th>KQ QC</th>--%>
                                                    <%--<th>Ghi chú</th>--%>
                                                    <th>Ngày App</th>
                                                    <th>Ngày hệ thống</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater runat="server" ID="rpWorkResult">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td>
                                                                <asp:ImageButton ID="img" ImageUrl="~/images/plus.png" runat="server" OnClick="img_Click" CommandName="Show" Width="13" />
                                                            </td>
                                                            <td><%# Eval("RN") %></td>
                                                            <td>
                                                                <asp:Label Text='<%# Eval("WorkId") %>' runat="server" ID="lblWorkId" />
                                                                <asp:Label Text='<%# Eval("IsLockReport") %>' Visible="false" runat="server" ID="lbIsLockReport" />
                                                                <asp:Label Text='<%# Eval("QCStatus") %>' Visible="false" runat="server" ID="lbQCStatus" />
                                                                <asp:Label Text='<%# Eval("IsNewShop") %>' Visible="false" runat="server" ID="lbIsNewShop" />
                                                            </td>
                                                            <td><%# Eval("ShopId") %> - <%# Eval("ShopName") %></td>
                                                            <td><%# Eval("AddressLine") %></td>
                                                            <%--<td><%# Eval("PNG") %>
                                                                <asp:Label runat="server" ID="Label11111" CssClass='<%# Eval("PNG_BCOLOR") %>' Text='<%# Eval("PNG") %>'></asp:Label>
                                                            </td>--%>
                                                            <td><%# Eval("EmployeeId") %> - <%# Eval("EmployeeName") %></td>
                                                            <td>
                                                                <asp:Label Text='<%# Eval("AuditDate") %>' runat="server" ID="lblAuditDate" />
                                                                <asp:Label Text='<%# Eval("ShopId") %>' runat="server" ID="lblShopId" Visible="false" />
                                                                <asp:Label Text='<%# Eval("EmployeeId") %>' runat="server" ID="lblEmployeeId" Visible="false" />
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="lbVisitResult" CssClass='<%# Eval("AuditResult").ToString().Contains("KTC")?"badge bg-danger":"" %>' Text='<%# Eval("AuditResult") %>'></asp:Label>
                                                                <%#(Eval("Comment") != null && Eval("Comment").ToString() != "")?
                                                                                                                        "<i style='margin-left:6px;' title='"+Eval("Comment")+"' class='far fa-comments'></i>"
                                                                                                                        :"" %>
                                                            </td>
                                                           <%-- <td><%# Eval("StoreCard") %></td>
                                                            <td><%# Eval("PaymentPercent") %></td>
                                                            <td><%# Eval("QCStatusName") + "-" + Eval("QCActual") + "/" + Eval("QCTarget") %> </td>--%>
                                                            <td><%# String.Format("{0:yyyy-MM-dd HH:mm:ss}", Eval("CreateDateApp")) %></td>
                                                            <td><%# String.Format("{0:yyyy-MM-dd HH:mm:ss}", Eval("CreateDateSys")) %></td>
                                                        </tr>
                                                        <asp:PlaceHolder ID="pndetail" Visible="false" runat="server">
                                                            <tr style="height: 40%">
                                                                <td colspan="100%" style="padding: 0px !important;">
                                                                    <%-- Tabs --%>
                                                                    <div class="card card-primary card-outline card-tabs">
                                                                        <div class="card-header p-0 pt-1 border-bottom-0">
                                                                            <ul class="nav nav-tabs" id="custom-tabs-three-tab" role="tablist">
                                                                                <li class="nav-item" runat="server" id="li_att">
                                                                                    <asp:LinkButton runat="server" class="nav-link active" CommandArgument="0" CommandName="ATT" ID="lbATT" OnClick="lbKPI_Click">Chấm công </asp:LinkButton>
                                                                                </li>
                                                                            </ul>
                                                                        </div>
                                                                    </div>
                                                                    <asp:Panel runat="server" ID="pnGrid" Visible="false">
                                                                        <%-- Audio --%>
                                                                        <asp:Panel runat="server" ID="plAudio" Visible="false">
                                                                            <div class="row">
                                                                                <div class="col-sm-12">
                                                                                    <table width="100%">
                                                                                        <asp:Repeater runat="server" ID="rptAudio">
                                                                                            <ItemTemplate>
                                                                                                <audio controls="controls" style="width: 400px">
                                                                                                    <source src='<%# Eval("AudioPath") %>'>
                                                                                                </audio>
                                                                                            </ItemTemplate>
                                                                                        </asp:Repeater>
                                                                                    </table>
                                                                                </div>
                                                                            </div>
                                                                        </asp:Panel>

                                                                        <%-- Tab Attendant --%>
                                                                        <asp:Panel runat="server" ID="plATT" Visible="false">
                                                                            <div class="col-sm-11" style="height: 480px; overflow-y: scroll;">
                                                                                <table class="table table-bordered table-responsive">
                                                                                    <tr style="text-align: left; vertical-align: top">
                                                                                        <thead>
                                                                                            <tr>
                                                                                                <th class="text-center">Check In</th>
                                                                                                <th class="text-center">Check Out</th>
                                                                                                <th class="text-center">Thời gian tại cửa hàng</th>
                                                                                                <th class="text-center">Overview</th>
                                                                                            </tr>
                                                                                        </thead>
                                                                                        <tbody>
                                                                                            <asp:Repeater runat="server" ID="rptAttendant">
                                                                                                <ItemTemplate>
                                                                                                    <tr style="text-align: center;">
                                                                                                        <td>
                                                                                                            <%-- <asp:Label runat="server" ID="lblInTime" Text='<%# Eval("InTime") %>' />--%>
                                                                                                            <%# Eval("InTime") %>
                                                                                                            <br />
                                                                                                            Tọa độ: <%# Convert.ToString(Eval("LatitudeIn")) + " - "+ Convert.ToString(Eval("LongitudeIn")) %>
                                                                                                            <%-- <asp:Label runat="server" ID="lblLatLongIn" Text='<%# Convert.ToString(Eval("LatitudeIn")) + " - "+ Convert.ToString(Eval("LongitudeIn")) %>' />--%>
                                                                                                            <%--13.1984159 108.6861718--%>
                                                                                                            <br />
                                                                                                            Sai số(mét):<%# Eval("AccuracyIn") %>
                                                                                                            <%--<asp:Label runat="server" ID="lblAccurancyIn" Text='<%# Eval("AccuracyIn") %>' />--%>
                                                                                                            <br />
                                                                                                            <a onclick="return openNewImage('<%# Eval("Image_CheckIn") %>','<%# Eval("ShopId") %>', '0')">
                                                                                                                <img src='<%# Eval("Image_CheckIn") %>' style="width: 235px; height: 300px;" /></a>
                                                                                                            <%--<asp:ImageButton  ImageUrl='<%# Eval("Image_CheckIn") %>' runat="server" Width="235" Height="300" ID="imgInTime1" />--%>    
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <%# Eval("OutTime") %>
                                                                                                            <%--<asp:Label runat="server" ID="lblOutTime" Text='<%# Eval("OutTime") %>' />--%>
                                                                                                            <br />
                                                                                                            Tọa độ: 
                                                                                                           
                                                                                                            <%# Convert.ToString(Eval("LatitudeOut")) + " - "+ Convert.ToString(Eval("LongitudeOut")) %>
                                                                                                            <%--<asp:Label runat="server" ID="lblLatLongOut" Text='<%# Convert.ToString(Eval("LatitudeOut")) + " - "+ Convert.ToString(Eval("LongitudeOut")) %>' />--%>
                                                                                                            <br />
                                                                                                            Sai số(mét): 
                                                                                                           
                                                                                                            <%# Eval("AccuracyOut") %>
                                                                                                            <%--<asp:Label runat="server" ID="lblAccurancyOut" Text='<%# Eval("AccuracyOut") %>' />--%>
                                                                                                            <br />
                                                                                                            <a onclick="return openNewImage('<%# Eval("Image_CheckOut") %>','<%# Eval("ShopId") %>', '0')">
                                                                                                                <img src='<%# Eval("Image_CheckOut") %>' style="width: 235px; height: 300px;" /></a>
                                                                                                            <%--<asp:Image ImageUrl='<%# Eval("Image_CheckOut") %>' runat="server" Width="235" Height="300" ID="imgOutTime" />--%>
                                                                                                        </td>
                                                                                                        <td style="vertical-align: bottom;"><%# Eval("TotalHours") %>
                                                                                                            <br />
                                                                                                            <a title="Xem bản đồ" style="cursor: pointer" onclick="popWindow('<%# "https://www.google.com/maps/search/" + Convert.ToString(Eval("LatitudeOverview")) + "+" + Convert.ToString(Eval("LongitudeOverview")) %>', 820, 635)">
                                                                                                                <img style="border: 1px solid red; height: 300px" src='<%# "https://maps.googleapis.com/maps/api/staticmap?center=" + Convert.ToString(Eval("LatitudeOverview")) + "," + Convert.ToString(Eval("LongitudeOverview")) +"&zoom=15&size=300x300&maptype=roadmap&markers=color:red%7Clabel:Shop%7C" + Convert.ToString(Eval("LatitudeOverview")) + "," + Convert.ToString(Eval("LongitudeOverview")) +"&key=AIzaSyAa8HeLH2lQMbPeOiMlM9D1VxZ7pbGQq8o" %>' />
                                                                                                            </a>
                                                                                                        </td>
                                                                                                        <td><%# Eval("OverviewTime") %>
                                                                                                            <%--<asp:Label runat="server" ID="lblTimeOverview" Text='<%# Eval("OverviewTime") %>' />--%>
                                                                                                            <br />
                                                                                                            Tọa độ:<%# Convert.ToString(Eval("LatitudeOverview")) + " - "+ Convert.ToString(Eval("LongitudeOverview")) %>
                                                                                                            <%--<asp:Label runat="server" ID="lblLatLongStore" Text='<%# Convert.ToString(Eval("LatitudeOverview")) + " - "+ Convert.ToString(Eval("LongitudeOverview")) %>' />--%>
                                                                                                            <br />
                                                                                                            Sai số(mét): <%# Eval("AccuracyOverview") %>

                                                                                                            <%--<asp:Label runat="server" ID="lblAccurancyOverview" Text='<%# Eval("AccuracyOverview") %>' />--%>
                                                                                                            <br />
                                                                                                            <a onclick="return openNewImage('<%# Eval("Image_Overview") %>','<%# Eval("ShopId") %>', '0')">
                                                                                                                <img src='<%# Eval("Image_Overview") %>' style="width: 235px; height: 300px;" /></a>
                                                                                                            <%--<asp:Image runat="server" Width="235" Height="300" ID="imgOverview" ImageUrl='<%# Eval("Image_Overview") %>' />--%>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </ItemTemplate>
                                                                                            </asp:Repeater>
                                                                                        </tbody>
                                                                                    </tr>
                                                                                </table>
                                                                            </div>
                                                                        </asp:Panel>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                        </asp:PlaceHolder>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                        </table>
                                        <asp:Panel runat="server" ID="plPaging" Visible="false">
                                            <div class="row">
                                                <div class="col-sm-12 col-md-5">
                                                    <div class="dataTables_info" id="example2_info" role="status" aria-live="polite">
                                                        Hiển thị
                                                        <asp:Label ID="lblFrom" runat="server" />
                                                        đến
                                                        <asp:Label ID="lblTo" runat="server" />
                                                        của 
                                                        <asp:Label ID="lblTotalRows" runat="server" />
                                                        dữ liệu
                                                    </div>
                                                </div>
                                                <div class="col-sm-12 col-md-7" style="display: none;">
                                                    <div class="dataTables_paginate paging_simple_numbers" id="example2_paginate">
                                                        <ul class="pagination">
                                                            <li class="paginate_button page-item previous" id="example2_previous">
                                                                <asp:LinkButton Text="Previous" runat="server" CssClass="page-link" ID="lnkPrevious" CommandName="Previous" OnClick="lnkPrevious_Click" />
                                                            </li>
                                                            <asp:Repeater runat="server" ID="rptPaging">
                                                                <ItemTemplate>
                                                                    <li class='<%# Eval("Active") %>'>
                                                                        <asp:LinkButton ID="lnkPage" Text='<%# Eval("PageNumber") %>' CommandName="Page" runat="server" CssClass="page-link" OnClick="lnkPage_Click" />
                                                                    </li>
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                            <%--<li class="paginate_button page-item active"><a href="#" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link">1</a></li>
                                                            <li class="paginate_button page-item "><a href="#" aria-controls="example2" data-dt-idx="2" tabindex="0" class="page-link">2</a></li>
                                                            <li class="paginate_button page-item "><a href="#" aria-controls="example2" data-dt-idx="3" tabindex="0" class="page-link">3</a></li>
                                                            <li class="paginate_button page-item "><a href="#" aria-controls="example2" data-dt-idx="4" tabindex="0" class="page-link">4</a></li>
                                                            <li class="paginate_button page-item "><a href="#" aria-controls="example2" data-dt-idx="5" tabindex="0" class="page-link">5</a></li>
                                                            <li class="paginate_button page-item "><a href="#" aria-controls="example2" data-dt-idx="6" tabindex="0" class="page-link">6</a></li>--%>
                                                            <li class="paginate_button page-item next" id="example2_next">
                                                                <asp:LinkButton Text="Next" runat="server" CssClass="page-link" ID="lnkNext" CommandName="Next" OnClick="lnkNext_Click" />
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <div class="col-sm-12 col-md-7">
                                                    <div class="dataTables_paginate paging_simple_numbers">
                                                        <ul class="pagination">
                                                            <li class="paginate_button page-item previous">
                                                                <asp:LinkButton
                                                                    CssClass="page-link" runat="server" ID="lbn_first" OnClick="lbn_first_Click"><i class="fa fa-angle-double-left"></i>
                                                                </asp:LinkButton>
                                                            </li>
                                                            <li class="paginate_button page-item previous" id="prv_button">
                                                                <asp:LinkButton
                                                                    CssClass="page-link" runat="server" ID="lbn_prev" OnClick="lbn_prev_Click"><i class="fa fa-angle-left"></i>
                                                                </asp:LinkButton>
                                                            </li>
                                                            <asp:Repeater ID="rpt_pagination" runat="server" OnItemCommand="rpt_pagination_ItemCommand">
                                                                <ItemTemplate>
                                                                    <li class='<%#Eval("Class")%>'>
                                                                        <asp:LinkButton
                                                                            CssClass="page-link" CommandName="Page" CommandArgument='<%#Eval("Page")%>' runat="server" Font-Bold="True"><%#Eval("Page")%>  
                                                                        </asp:LinkButton>
                                                                    </li>
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                            <li class="paginate_button page-item next">
                                                                <asp:LinkButton
                                                                    CssClass="page-link" runat="server" ID="lbn_next" OnClick="lbn_next_Click"><i class="fa fa-angle-right"></i>
                                                                </asp:LinkButton>
                                                            </li>
                                                            <li class="paginate_button page-item previous">
                                                                <asp:LinkButton
                                                                    CssClass="page-link" runat="server" ID="lbn_end" OnClick="lbn_end_Click"><i class="fa fa-angle-double-right"></i>
                                                                </asp:LinkButton>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </asp:Panel>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script type="text/javascript">
        var requestManager = Sys.WebForms.PageRequestManager.getInstance();
        requestManager.add_endRequest(function () {
            //Loading();
        });
        requestManager.add_endRequest(function () {
            //EndLoading();
            edit_textbox();
        });
    </script>
    <script>
        function popWindow(link, width, height) {
            var w = width, h = height;
            var left = (screen.width / 2) - (w / 2);
            var top = 10;
            window.open(link, 'popup', 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
            return false;
        }
        function edit_textbox() {
            $('.edit_textbox').change(function () {
                var tx = $(this);
                var _workid = $(this).attr("data-workid");//tx.context.attributes["data-workid"].value;
                var _kpiid = $(this).attr("data-kpiid");//tx.context.attributes["data-kpiid"].value;
                var _itemid = $(this).attr("data-itemid");//tx.context.attributes["data-itemid"].value;
                var _valueold = $(this).attr("data-valueold");
                var _value = $(this).val();
                $.ajax({
                    type: "POST",
                    url: "api/updatedatakpi?WorkId=" + _workid + "&KPIId=" + _kpiid + "&ItemId=" + _itemid + "&Value=" + _value,
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        if (data.StatusCode == 200) {
                            toastr.success(data.Content);
                            $('#' + _workid + "_" + _kpiid + "_" + _itemid).attr("data-valueold", _value);;
                            $('#lb_' + _workid + "_" + _kpiid + "_" + _itemid).text(_value);
                        }
                        else {
                            toastr.error(data.Content);
                            $('#' + _workid + "_" + _kpiid + "_" + _itemid).val(_valueold);
                        }
                    }
                });
            });
        }
    </script>
</asp:Content>
