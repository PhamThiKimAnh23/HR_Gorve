<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAudit.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="HR_Grove_Web.pages.UserLeaveOT.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        th {
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content">
        <div class="container-fluid">
            <div class="card card-info">
                <div class="card-body">
                    <div class="row">
                        <%--<div class="col-md-2">
                            <div class="form-group">
                                <label>Cycle:</label>
                                <asp:DropDownList runat="server" ID="ddlCycle" OnSelectedIndexChanged="ddlCycle_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                </asp:DropDownList>
                            </div>
                        </div>--%>
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
                        <div class="col-md-2" runat="server" visible="false">
                            <div class="form-group">
                                <label>Office :</label>
                                <asp:DropDownList runat="server" ID="ddlOffice" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="col-md-2" runat="server" visible="false">
                            <div class="form-group">
                                <label>Khu vực:</label>
                                <asp:DropDownList runat="server" ID="ddlArea" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlArea_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2" runat="server" visible="false">
                            <div class="form-group">
                                <label>Tỉnh/Thành phố:</label>
                                <asp:DropDownList runat="server" ID="ddlProvince" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;" AutoPostBack="true" OnSelectedIndexChanged="ddlProvince_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2" runat="server" visible="false">
                            <div class="form-group">
                                <label>Quận/Huyện:</label>
                                <asp:DropDownList runat="server" ID="ddlDistrict" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlDistrict_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2" runat="server" visible="false">
                            <div class="form-group">
                                <label>Phường/Xã:</label>
                                <asp:DropDownList runat="server" ID="ddlTown" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
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
                                <label>Status :</label>
                                <asp:DropDownList runat="server" ID="ddlStatus" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="-1">-All-</asp:ListItem>
                                    <asp:ListItem Value="1">Agree</asp:ListItem>
                                    <asp:ListItem Value="0">Disagree</asp:ListItem>
                                    <asp:ListItem Value="2">Wait</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <div class="row">
                        <div class="col-md-12">
                            <asp:Button runat="server" class="btn btn-primary" Text="Filter" ID="btnFilter" OnClick="btnFilter_Click" />
                           <asp:Button runat="server" class="btn btn-danger" Text="Export overtime, leave report" ID="btnExport" OnClick="btnExport_Click" UseSubmitBehavior="false" OnClientClick="this.value='Đang xuất file...'; this.disabled='true'" />
                           <%-- <a href="../../Template/template_userleave_ot.xlsx" class="btn btn-danger">Export overtime leave report</a>--%>
                            <%--<a href="../../Template/template_timesheet.xlsx" class="btn btn-primary">Export timesheet report</a>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>
    <section id="listemployee_userleave_ot" runat="server">
        <asp:Panel runat="server" ID="pnGrid">
            <div class="card card-primary card-outline card-tabs">
                <div class="card-header p-0 pt-1 border-bottom-0">
                    <ul class="nav nav-tabs" id="custom-tabs-three-tab" role="tablist">
                        <li class="nav-item">
                            <asp:LinkButton runat="server" class="nav-link active" CommandName="UserLeave" ID="lbUserLeave" OnClick="lbKPI_Click">Leave</asp:LinkButton>
                        </li>
                        <li class="nav-item">
                            <asp:LinkButton runat="server" class="nav-link" CommandName="OT" ID="lbOT" OnClick="lbKPI_Click">OverTime
                            </asp:LinkButton>
                        </li>
                    </ul>
                </div>
            </div>

            <%-- User Leave --%>
            <asp:Panel runat="server" ID="plUserLeave" Style="padding: 10px;" Visible="false">
                <section class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h3 class="card-title">Danh sách nhân viên nghỉ phép</h3>
                                    </div>
                                    <div class="card-body">
                                        <div id="example2_wrapper" class="dataTables_wrapper dt-bootstrap4">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <table class="table table-bordered table-hover dataTable dtr-inline">
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>EmployeeName</th>
                                                                <th>Date</th>
                                                                <th>Value</th>
                                                                <th>Reason</th>
                                                                <th>Comment</th>
                                                                <th>CreateDate</th>
                                                                <th>Confirmation date</th>
                                                                <th>Teamlead</th>
                                                                <th>Teamlead Comment</th>
                                                                <th>Status</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <asp:Repeater runat="server" ID="rptLeave">
                                                                <ItemTemplate>
                                                                    <tr>
                                                                        <td><%# Eval("RN") %></td>
                                                                        <td><%# Eval("EmployeeName") %> </td>
                                                                        <td><%# Eval("OffDate") %></td>
                                                                        <td><%# Eval("OffValue") %></td>
                                                                        <td><%# Eval("OffName") %></td>
                                                                        <td><%# Eval("EmployeeComment") %></td>
                                                                        <td><%# Eval("CreatedTime") %></td>
                                                                        <td><%# Eval("ConfirmTime") %></td>
                                                                        <td><%# Eval("SupName") %></td>
                                                                        <td><%# Eval("UserConfirmComment") %></td>
                                                                        <td style="text-align: center;">
                                                                            <img src='<%# Eval("IconStatus")  %>'
                                                                                style='width: 30px;' />

                                                                        </td>
                                                                    </tr>
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                        </tbody>
                                                    </table>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </asp:Panel>

            <%-- User OT --%>
            <asp:Panel runat="server" ID="plOT" Visible="false" Style="padding: 10px;">
                <section class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h3 class="card-title">Danh sách nhân viên tăng ca</h3>
                                    </div>
                                    <div class="card-body">
                                        <div id="example2_wrapper_ot" class="dataTables_wrapper dt-bootstrap4">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <table class="table table-bordered table-hover dataTable dtr-inline">
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>EmployeeName</th>
                                                                <th>Date</th>
                                                                <th>Value</th>
                                                                <th>OT Type</th>
                                                                <th>Comment</th>
                                                                <th>CreateDate</th>
                                                                <th>Confirmation date</th>
                                                                <th>Teamlead</th>
                                                                <th>Teamlead Comment</th>
                                                                <th>Status</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <asp:Repeater runat="server" ID="rptOT">
                                                                <ItemTemplate>
                                                                    <tr>
                                                                        <td><%# Eval("RN") %></td>
                                                                        <td><%# Eval("EmployeeName") %> </td>
                                                                        <td><%# Eval("OTDate") %></td>
                                                                        <td><%# Eval("OTValue") %></td>
                                                                        <td><%# Eval("StatusName") %></td>
                                                                        <td><%# Eval("EmployeeComment") %></td>
                                                                        <td><%# Eval("CreatedTime") %></td>
                                                                        <td><%# Eval("ConfirmTime") %></td>
                                                                        <td><%# Eval("SupName") %></td>
                                                                        <td><%# Eval("UserConfirmComment") %></td>
                                                                        <td style="text-align: center;">
                                                                            <img src='<%# Eval("IconStatus")  %>'
                                                                                style='width: 30px;' />

                                                                        </td>
                                                                    </tr>
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                        </tbody>
                                                    </table>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </asp:Panel>

            <asp:Panel runat="server" ID="plNoData">
                <div class="row" style="text-align: center">
                    <div class="col-sm-12">
                        <h5 style="color: red">Không có dữ liệu !</h5>
                    </div>
                </div>
            </asp:Panel>

            <%-- Paging --%>
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
        </asp:Panel>
    </section>
    
</asp:Content>
