﻿<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAudit.Master" AutoEventWireup="true" CodeBehind="AuditDashboard.aspx.cs" Inherits="HR_Grove_Web.Dashboard.AuditDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>
    <style>
        .highcharts-figure,
        .highcharts-data-table table {  
            min-width: 310px;
            max-width: 800px;
            margin: 1em auto;
        }

        #container {
            height: 400px;
        }

        .highcharts-data-table table {
            font-family: Verdana, sans-serif;
            border-collapse: collapse;
            border: 1px solid #ebebeb;
            margin: 10px auto;
            text-align: center;
            width: 100%;
            max-width: 500px;
        }

        .highcharts-data-table caption {
            padding: 1em 0;
            font-size: 1.2em;
            color: #555;
        }

        .highcharts-data-table th {
            font-weight: 600;
            padding: 0.5em;
        }

        .highcharts-data-table td,
        .highcharts-data-table th,
        .highcharts-data-table caption {
            padding: 0.5em;
        }

        .highcharts-data-table thead tr,
        .highcharts-data-table tr:nth-child(even) {
            background: #f8f8f8;
        }

        .highcharts-data-table tr:hover {
            background: #f1f7ff;
        }
        div.content-wrapper div.container-fluid::file-selector-button
        {
            display:none;
        }
    </style>
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script>
        $(document).ready(function () {
            $("a.nav-link").first().trigger("click");
            window.setTimeout(function () {
                tab_hrm();
            }, 100);
        });

        function tab_fieldforce() {
            // SELLOUT
            Highcharts.chart('containerSellout', {
                chart: { type: 'column' },
                title: { text: null },
                subtitle: { text: null },
                xAxis: {
                    categories: ['W1', 'W2', 'W3', 'W4', 'W5', 'W6', 'W7', 'W8'],
                    crosshair: true
                },
                yAxis:
                {
                    min: 0,
                    title: {
                        text: 'Tỉ VND'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:.1f} tỉ</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none',
                            formatter: function () {
                                if (this.point.y < 10) {
                                    return '<span style="color: red">' + this.y + '</span>';
                                } else {
                                    return '<span style="color: black">' + this.y + '</span>';
                                }
                            }
                        }
                    }
                },
                legend: { enabled: true },
                credits: { enabled: false },
                series: [{
                    name: 'Doanh số',
                    data: [9, 15, 16, 12, 14, 17, 18, 19]
                },
                {
                    name: 'Đổi quà (MT) / trả thưởng (GT)',
                    data: [5, 3, 4, 2, 0, 0, 1, 3],
                    color: '#FF530D',
                }
                ]
            });

            //OOS
            Highcharts.chart('containerOOS', {
                chart: { type: 'column' },
                title: { text: null },
                subtitle: { text: null },
                xAxis: {
                    categories: ['Cycle 5', 'Cycle 6', 'Cycle 7'],
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'Tỉ lệ %'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:.1f} %</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none',
                            formatter: function () {
                                if (this.point.y > 5) {
                                    return '<span style="color: red">' + this.y + ' %</span>';
                                } else {
                                    return '<span style="color: black">' + this.y + ' %</span>';
                                }
                            }
                        }
                    }
                },
                legend: { enabled: false },
                credits: { enabled: false },
                series: [{
                    name: 'OOS',
                    data: [8, 5.6, 4.3]
                }]
            });

            // SOS
            Highcharts.chart('containerSOS', {
                chart: { type: 'column' },
                title: { text: null },
                subtitle: { text: null },
                xAxis: {
                    categories: ['Cycle 5', 'Cycle 6', 'Cycle 7'],
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'Tỉ lệ %'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:.1f} %</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none',
                            formatter: function () {
                                if (this.point.y < 45) {
                                    return '<span style="color: red">' + this.y + ' %</span>';
                                } else {
                                    return '<span style="color: black">' + this.y + ' %</span>';
                                }
                            }
                        }
                    }
                },
                legend: { enabled: true },
                credits: { enabled: false },
                series: [{
                    name: 'SOS',
                    data: [45, 50, 43]
                },
                {
                    name: 'Đối thủ 1',
                    data: [30, 39, 24],
                    color: '#25D2CE'
                },
                {
                    name: 'Đối thủ 2',
                    data: [12, 12, 15],
                    color: '#D25725'
                }
                ]
            });

            // IVT
            Highcharts.chart('containerIVT', {
                chart: {
                    zoomType: 'xy'
                },
                credits: { enabled: false },
                title: { text: null },
                subtitle: { text: null, align: 'left' },
                xAxis: [{
                    categories: ['W8', 'W9', 'W10'],
                    crosshair: true
                }],
                yAxis: [{ // Primary yAxis
                    labels: {
                        format: '{value} tuần',
                        style: {
                            color: '#D26E25'
                        }
                    },
                    title: {
                        text: 'Số tuần để bán hết hàng',
                        style: {
                            color: '#D26E25'
                        }
                    },
                    opposite: true

                }, { // Secondary yAxis
                    gridLineWidth: 0,
                    title: {
                        text: 'Giá trị tồn kho ( tỉ )',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    },
                    labels: {
                        format: '{value} tỉ',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    }

                }
                ],
                tooltip: {
                    shared: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none'
                        }
                    }
                },
                series: [{
                    name: 'Giá trị tồn kho',
                    type: 'column',
                    yAxis: 1,
                    data: [89.9, 71.5, 90.4],
                    tooltip: {
                        valueSuffix: ' tỉ'
                    }

                }, {
                    name: 'Số tuần bán hàng',
                    type: 'spline',
                    yAxis: 0,
                    data: [2, 2.5, 1.5],
                    marker: {
                        enabled: false
                    },
                    tooltip: {
                        valueSuffix: ' tuần'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y} tuần'
                    }
                }
                ]
            });


            //OOL
            Highcharts.chart('containerOOL', {
                chart: { type: 'column' },
                title: { text: null },
                subtitle: { text: null },
                xAxis: {
                    categories: ['Cycle 5', 'Cycle 6', 'Cycle 7'],
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'Tỉ lệ %'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:.1f} %</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none',
                            formatter: function () {
                                if (this.point.y < 89) {
                                    return '<span style="color: red">' + this.y + ' %</span>';
                                } else {
                                    return '<span style="color: black">' + this.y + ' %</span>';
                                }
                            }
                        }
                    }
                },
                legend: { enabled: false },
                credits: { enabled: false },
                series: [{
                    name: 'OOL',
                    data: [95, 90, 89.8]
                }]
            });

            //POG
            Highcharts.chart('containerPOG', {
                chart: { type: 'column' },
                title: { text: null },
                subtitle: { text: null },
                xAxis: {
                    categories: ['Cycle 5', 'Cycle 6', 'Cycle 7'],
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'Tỉ lệ %'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:.1f} %</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none',
                            formatter: function () {
                                if (this.point.y < 90) {
                                    return '<span style="color: red">' + this.y + ' %</span>';
                                } else {
                                    return '<span style="color: black">' + this.y + ' %</span>';
                                }
                            }
                        }
                    }
                },
                legend: { enabled: false },
                credits: { enabled: false },
                series: [{
                    name: 'POG',
                    data: [95, 90, 89.8]
                }]
            });


            //WP
            Highcharts.chart('containerWP', {
                chart: {
                    zoomType: 'xy'
                },
                credits: { enabled: false },
                title: { text: null },
                subtitle: { text: null, align: 'left' },
                xAxis: [{
                    categories: ['Cycle 5', 'Cycle 6', 'Cycle 7'],
                    crosshair: true
                }],
                yAxis: [{ // Primary yAxis
                    labels: {
                        format: '{value} %',
                        style: {
                            color: '#D26E25'
                        }
                    },
                    title: {
                        text: 'Visit Rate',
                        style: {
                            color: '#D26E25'
                        }
                    },
                    opposite: true

                }, { // Secondary yAxis
                    gridLineWidth: 0,
                    title: {
                        text: 'Số lượt viếng thăm',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    },
                    labels: {
                        format: '{value}k',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    }

                }
                ],
                tooltip: {
                    shared: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none'
                        },
                        stacking: 'normal'
                    }
                },
                series: [{
                    name: 'Chỉ tiêu',
                    type: 'column',
                    yAxis: 1,
                    data: [33, 34, 33.2],
                    tooltip: {
                        valueSuffix: 'k turns'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y}k'
                    }

                },
                {
                    name: 'KTC',
                    type: 'column',
                    color: '#FF530D',
                    yAxis: 1,
                    data: [2.4, 2.1, 1],
                    tooltip: {
                        valueSuffix: 'k turns'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y}k'
                    },
                    stack: 'TC'
                },
                {
                    name: 'TC',
                    type: 'column',
                    color: '#226E40',
                    yAxis: 1,
                    data: [30, 31, 32],
                    tooltip: {
                        valueSuffix: 'k turns'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y}k'
                    },
                    stack: 'TC'
                },
                {
                    name: 'Visit Rate',
                    type: 'spline',
                    yAxis: 0,
                    data: [95, 95, 99],
                    marker: {
                        enabled: false
                    },
                    tooltip: {
                        valueSuffix: ' %'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y} %'
                    }
                }
                ]
            });

            //VISIT
            Highcharts.chart('containerSTORE', {
                chart: {
                    zoomType: 'xy'
                },
                credits: { enabled: false },
                title: { text: null },
                subtitle: { text: null, align: 'left' },
                xAxis: [{
                    categories: ['Cycle 5', 'Cycle 6', 'Cycle 7'],
                    crosshair: true
                }],
                yAxis: [{ // Primary yAxis
                    labels: {
                        format: '{value} %',
                        style: {
                            color: '#D26E25'
                        }
                    },
                    title: {
                        text: 'Tỉ lệ phủ',
                        style: {
                            color: '#D26E25'
                        }
                    },
                    opposite: true

                }, { // Secondary yAxis
                    gridLineWidth: 0,
                    title: {
                        text: 'Số lượng cửa hàng',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    },
                    labels: {
                        format: '{value}k',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    }

                }
                ],
                tooltip: {
                    shared: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none'
                        },
                        stacking: 'normal'
                    }
                },
                series: [{
                    name: 'Chỉ tiêu',
                    type: 'column',
                    yAxis: 1,
                    data: [6.2, 6.1, 6],
                    tooltip: {
                        valueSuffix: 'k CH'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y}k'
                    }

                },
                {
                    name: 'KTC',
                    type: 'column',
                    color: '#FF530D',
                    yAxis: 1,
                    data: [0.4, 0.2, 0.5],
                    tooltip: {
                        valueSuffix: 'k CH'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y}k'
                    },
                    stack: 'TC'
                },
                {
                    name: 'TC',
                    type: 'column',
                    color: '#226E40',
                    yAxis: 1,
                    data: [5.8, 5.9, 5.5],
                    tooltip: {
                        valueSuffix: 'k CH'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y}k'
                    },
                    stack: 'TC'
                },

                {
                    name: 'Độ phủ cửa hàng',
                    type: 'spline',
                    yAxis: 0,
                    data: [99, 100, 100],
                    marker: {
                        enabled: false
                    },
                    tooltip: {
                        valueSuffix: ' %'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y} %'
                    }
                }
                ]
            });
        }

        function tab_hrm() {

            // HC
            Highcharts.chart('containerEMP', {
                chart: {
                    zoomType: 'xy'
                },
                credits: { enabled: false },
                title: { text: null },
                subtitle: { text: null, align: 'left' },
                xAxis: [{
                    categories: ['Cycle 5', 'Cycle 6', 'Cycle 7'],
                    crosshair: true
                }],
                yAxis: [{ // Primary yAxis
                    labels: {
                        format: '{value} %',
                        style: {
                            color: '#D26E25'
                        }
                    },
                    title: {
                        text: 'Time attendance rate',
                        style: {
                            color: '#D26E25'
                        }
                    },
                    opposite: true

                }, { // Secondary yAxis
                    gridLineWidth: 0,
                    title: {
                        text: 'Number of visits',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    },
                    labels: {
                        format: '{value}k',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    }

                }
                ],
                tooltip: {
                    shared: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none'
                        },
                        stacking: 'normal'
                    }
                },
                series: [{
                    name: 'Target',
                    type: 'column',
                    yAxis: 1,
                    data: [33, 34, 33.2],
                    tooltip: {
                        valueSuffix: 'k turns'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y}k'
                    }

                },
                {
                    name: 'Attendance',
                    type: 'column',
                    color: '#226E40',
                    yAxis: 1,
                    data: [30, 31, 32],
                    tooltip: {
                        valueSuffix: 'k turns'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y}k'
                    },
                    stack: 'Attendance'
                },
                {
                    name: 'Time attendance rate',
                    type: 'spline',
                    yAxis: 0,
                    data: [95, 95, 99],
                    marker: {
                        enabled: false
                    },
                    tooltip: {
                        valueSuffix: ' %'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y} %'
                    }
                }
                ]
            });

            //PayRoll

            Highcharts.chart('containerHR', {
                chart: { type: 'column' },
                title: { text: null },
                subtitle: { text: null },
                xAxis: {
                    categories: ['Cycle 5', 'Cycle 6', 'Cycle 7'],
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'Time attendance rate'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:.1f} %</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none',
                            formatter: function () {
                                if (this.point.y < 95) {
                                    return '<span style="color: red">' + this.y + '%</span>';
                                } else {
                                    return '<span style="color: black">' + this.y + '%</span>';
                                }
                            }
                        }
                    }
                },
                credits: { enabled: false },
                series: [{
                    name: 'Office North',
                    data: [95, 90, 97]
                },
                {
                    name: 'Office Center',
                    data: [94, 95, 90]
                },
                {
                    name: 'Office South',
                    data: [97, 99, 89]
                }
                ]
            });

            //Training
            Highcharts.chart('containerTraining', {
                chart: { type: 'column' },
                title: { text: null },
                subtitle: { text: null },
                xAxis: {
                    categories: ['Cycle 5', 'Cycle 6', 'Cycle 7'],
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'Time attendance rate'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:.1f} %</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none',
                            formatter: function () {
                                if (this.point.y < 95) {
                                    return '<span style="color: red">' + this.y + '%</span>';
                                } else {
                                    return '<span style="color: black">' + this.y + '%</span>';
                                }
                            }
                        }
                    }
                },
                credits: { enabled: false },
                series: [{
                    name: 'Teamlead A',
                    data: [95, 90, 97]
                },
                {
                    name: 'Teamlead B',
                    data: [94, 95, 90]
                },
                {
                    name: 'Teamlead C',
                    data: [97, 99, 89]
                }
                ]
            });

            //KPI
            Highcharts.chart('containerKPI', {
                chart: {
                    zoomType: 'xy'
                },
                credits: { enabled: false },
                title: { text: null },
                subtitle: { text: null, align: 'left' },
                xAxis: [{
                    categories: ['Cycle 5', 'Cycle 6', 'Cycle 7'],
                    crosshair: true
                }],
                yAxis: [{ // Primary yAxis
                    labels: {
                        format: '{value} %',
                        style: {
                            color: '#D26E25'
                        }
                    },
                    title: {
                        text: 'Visit Rate',
                        style: {
                            color: '#D26E25'
                        }
                    },
                    opposite: true

                }, { // Secondary yAxis
                    gridLineWidth: 0,
                    title: {
                        text: 'Số giờ',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    },
                    labels: {
                        format: '{value}k',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    }

                }
                ],
                tooltip: {
                    shared: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none'
                        },
                        stacking: 'normal'
                    }
                },
                series: [{
                    name: 'Target',
                    type: 'column',
                    yAxis: 1,
                    data: [33, 34, 33.2],
                    tooltip: {
                        valueSuffix: 'k turns'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y}k'
                    }

                },
                {
                    name: 'Time off',
                    type: 'column',
                    //color: '#FF530D',
                    yAxis: 1,
                    data: [2.5, 2.7, 5.3],
                    tooltip: {
                        valueSuffix: 'k turns'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y}k'
                    },
                    stack: 'TC'
                },
                {
                    name: 'OT hours',
                    type: 'column',
                    color: '#FF530D',
                    yAxis: 1,
                    data: [2.4, 2.1, 1],
                    tooltip: {
                        valueSuffix: 'k turns'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y}k'
                    },
                    stack: 'TC'
                },
                {
                    name: 'Work time',
                    type: 'column',
                    color: '#226E40',
                    yAxis: 1,
                    data: [30, 31, 32],
                    tooltip: {
                        valueSuffix: 'k turns'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y}k'
                    },
                    stack: 'TC'
                },
                {
                    name: 'Visit Rate',
                    type: 'spline',
                    yAxis: 0,
                    data: [95, 95, 99],
                    marker: {
                        enabled: false
                    },
                    tooltip: {
                        valueSuffix: ' %'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y} %'
                    }
                }
                ]
            });

            //Laptop
            Highcharts.chart('containerLaptop', {
                chart: {
                    zoomType: 'column'
                },
                credits: { enabled: false },
                title: { text: null },
                subtitle: { text: null, align: 'left' },
                xAxis: [{
                    categories: ['Cycle 5', 'Cycle 6', 'Cycle 7'],
                    crosshair: true
                }],
                yAxis: [{ // Primary yAxis
                    labels: {
                        format: '{value} %',
                        style: {
                            color: '#D26E25'
                        }
                    },
                    title: {
                        text: '%',
                        style: {
                            color: '#D26E25'
                        }
                    },
                    opposite: true

                }, { // Secondary yAxis
                    gridLineWidth: 0,
                    title: {
                        text: '% Time',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    },
                    labels: {
                        format: '{value} %',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    }

                }
                ],
                tooltip: {
                    shared: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none'
                        }
                    }
                },
                series: [{
                    name: '% Time',
                    type: 'spline',
                    //type: 'column',
                    yAxis: 1,
                    data: [93, 94, 91],
                    tooltip: {
                        valueSuffix: ' HC'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y} %'
                    }

                }, {
                    name: '% Overtime Hours',
                    type: 'spline',
                    yAxis: 0,
                    data: [2, 4, 5],
                    marker: {
                        enabled: false
                    },
                    tooltip: {
                        valueSuffix: ' %'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y} %'
                    }
                }, {
                    name: '% Leave Hours',
                    type: 'spline',
                    yAxis: 0,
                    data: [5, 2, 3],
                    marker: {
                        enabled: false
                    },
                    tooltip: {
                        valueSuffix: ' %'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y} %'
                    }
                }
                ]
            });

            //Điện thoại
            Highcharts.chart('containerDT', {
                chart: {
                    zoomType: 'xy'
                },
                credits: { enabled: false },
                title: { text: null },
                subtitle: { text: null, align: 'left' },
                xAxis: [{
                    categories: ['Cycle 5', 'Cycle 6', 'Cycle 7'],
                    crosshair: true
                }],
                yAxis: [{ // Primary yAxis
                    labels: {
                        format: '{value} %',
                        style: {
                            color: '#D26E25'
                        }
                    },
                    title: {
                        text: '%',
                        style: {
                            color: '#D26E25'
                        }
                    },
                    opposite: true

                }, { // Secondary yAxis
                    gridLineWidth: 0,
                    title: {
                        text: '% Time',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    },
                    labels: {
                        format: '{value} %',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    }

                }
                ],
                tooltip: {
                    shared: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none'
                        }
                    }
                },
                series: [{
                    name: '% Time',
                    type: 'spline',
                    //type: 'column',
                    yAxis: 1,
                    data: [93, 94, 91],
                    tooltip: {
                        valueSuffix: ' HC'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y} %'
                    }

                }, {
                    name: '% Overtime Hours',
                    type: 'spline',
                    yAxis: 0,
                    data: [2, 4, 5],
                    marker: {
                        enabled: false
                    },
                    tooltip: {
                        valueSuffix: ' %'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y} %'
                    }
                }, {
                    name: '% Leave Hours',
                    type: 'spline',
                    yAxis: 0,
                    data: [5, 2, 3],
                    marker: {
                        enabled: false
                    },
                    tooltip: {
                        valueSuffix: ' %'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y} %'
                    }
                }
                ]
            });

            //Điện thoại
            Highcharts.chart('containerDT1', {
                chart: {
                    zoomType: 'xy'
                },
                credits: { enabled: false },
                title: { text: null },
                subtitle: { text: null, align: 'left' },
                xAxis: [{
                    categories: ['Cycle 5', 'Cycle 6', 'Cycle 7'],
                    crosshair: true
                }],
                yAxis: [{ // Primary yAxis
                    labels: {
                        format: '{value} %',
                        style: {
                            color: '#D26E25'
                        }
                    },
                    title: {
                        text: '%',
                        style: {
                            color: '#D26E25'
                        }
                    },
                    opposite: true

                }, { // Secondary yAxis
                    gridLineWidth: 0,
                    title: {
                        text: '% Time',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    },
                    labels: {
                        format: '{value} %',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    }

                }
                ],
                tooltip: {
                    shared: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none'
                        }
                    }
                },
                series: [{
                    name: '% Time',
                    type: 'spline',
                    //type: 'column',
                    yAxis: 1,
                    data: [93, 94, 91],
                    tooltip: {
                        valueSuffix: ' HC'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y} %'
                    }

                }, {
                    name: '% Overtime Hours',
                    type: 'spline',
                    yAxis: 0,
                    data: [2, 4, 5],
                    marker: {
                        enabled: false
                    },
                    tooltip: {
                        valueSuffix: ' %'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y} %'
                    }
                }, {
                    name: '% Leave Hours',
                    type: 'spline',
                    yAxis: 0,
                    data: [5, 2, 3],
                    marker: {
                        enabled: false
                    },
                    tooltip: {
                        valueSuffix: ' %'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y} %'
                    }
                }
                ]
            });
        }

        function tab_audit() {
            //Process Audit
            Highcharts.chart('containerProcessAudit', {
                chart: {
                    zoomType: 'xy',
                    height: 400
                },
                credits: { enabled: false },
                title: { text: null },
                subtitle: { text: null, align: 'left' },
                xAxis: [{
                    categories: ['Cycle 5', 'Cycle 6', 'Cycle 7'],
                    crosshair: true
                }],
                yAxis: [{ // Primary yAxis
                    labels: {
                        format: '{value} %',
                        style: {
                            color: '#D26E25'
                        }
                    },
                    title: {
                        text: 'Tỉ lệ Audit',
                        style: {
                            color: '#D26E25'
                        }
                    },
                    opposite: true

                }, { // Secondary yAxis
                    gridLineWidth: 0,
                    title: {
                        text: 'Số lượt Audit',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    },
                    labels: {
                        format: '{value}k',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    }

                }
                ],
                tooltip: {
                    shared: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none'
                        },
                        stacking: 'normal'
                    }
                },
                series: [{
                    name: 'Chỉ tiêu',
                    type: 'column',
                    yAxis: 1,
                    data: [33, 34, 32],
                    tooltip: {
                        valueSuffix: 'k turns'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y}k'
                    }

                },
                {
                    name: 'KTC',
                    type: 'column',
                    color: '#FF530D',
                    yAxis: 1,
                    data: [2.4, 2.1, 2],
                    tooltip: {
                        valueSuffix: 'k turns'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y}k'
                    },
                    stack: 'TC'
                },
                {
                    name: 'TC',
                    type: 'column',
                    color: '#226E40',
                    yAxis: 1,
                    data: [30, 31, 18],
                    tooltip: {
                        valueSuffix: 'k turns'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y}k'
                    },
                    stack: 'TC'
                },
                {
                    name: 'Tỉ lệ Audit',
                    type: 'spline',
                    yAxis: 0,
                    data: [95, 95, 75],
                    marker: {
                        enabled: false
                    },
                    tooltip: {
                        valueSuffix: ' %'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y} %'
                    }
                }
                ]
            });

            // Auditresult
            Highcharts.chart('containerAuditResult', {
                chart: { type: 'column' },
                title: { text: null },
                subtitle: { text: null },
                xAxis: {
                    categories: ['Cycle 5', 'Cycle 6', 'Cycle 7'],
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'Pass rate %'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:.1f} %</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none',
                            formatter: function () {
                                if (this.point.y <= 80) {
                                    return '<span style="color: red">' + this.y + ' %</span>';
                                } else {
                                    return '<span style="color: black">' + this.y + ' %</span>';
                                }
                            }
                        }
                    }
                },
                legend: { enabled: false },
                credits: { enabled: false },
                series: [{
                    name: 'Pass',
                    data: [80, 83, 85]
                }]
            });

            // PassKPIAudit
            Highcharts.chart('containerPassKPIAudit', {
                chart: { type: 'column' },
                title: { text: null },
                subtitle: { text: null },
                xAxis: {
                    categories: ['Cycle 5', 'Cycle 6', 'Cycle 7'],
                    crosshair: true
                },
                yAxis:
                {
                    min: 0,
                    title: {
                        text: '% Pass rate'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y} %</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none',
                            formatter: function () {
                                if (this.point.y < 80) {
                                    return '<span style="color: red">' + this.y + '</span>';
                                } else {
                                    return '<span style="color: black">' + this.y + '</span>';
                                }
                            }
                        }
                    }
                },
                legend: { enabled: true },
                credits: { enabled: false },
                series: [
                    {
                        name: 'TeamLead A',
                        data: [67, 68, 68]
                    },
                    {
                        name: 'TeamLead B',
                        data: [90, 90, 95]
                    },
                    {
                        name: 'TeamLead C',
                        data: [60, 67, 79],
                        color: '#FF530D',
                    },
                    {
                        name: 'TeamLead D',
                        data: [60, 65, 80],
                    }
                ]
            });

            // SOSAudit
            Highcharts.chart('containerSOSAudit', {
                chart: { type: 'column' },
                title: { text: null },
                subtitle: { text: null },
                xAxis: {
                    categories: ['Cycle 5', 'Cycle 6', 'Cycle 7'],
                    crosshair: true
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: '%'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:.1f} %</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none',
                            formatter: function () {
                                if (this.point.y < 45) {
                                    return '<span style="color: red">' + this.y + ' %</span>';
                                } else {
                                    return '<span style="color: black">' + this.y + ' %</span>';
                                }
                            }
                        }
                    }
                },
                legend: { enabled: true },
                credits: { enabled: false },
                series: [{
                    name: 'North',
                    data: [45, 50, 43]
                },
                {
                    name: 'Center',
                    data: [30, 39, 24],
                    color: '#25D2CE'
                },
                {
                    name: 'South',
                    data: [12, 12, 15],
                    color: '#D25725'
                }
                ]
            });
        }

        function tab_b2c() {
            //INSTALL APP
            Highcharts.chart('containerINAPP', {
                chart: {
                    zoomType: 'xy'
                },
                credits: { enabled: false },
                title: { text: null },
                subtitle: { text: null, align: 'left' },
                xAxis: [{
                    categories: ['Cycle 5', 'Cycle 6', 'Cycle 7'],
                    crosshair: true
                }],
                yAxis: [{ // Primary yAxis
                    labels: {
                        format: '{value} %',
                        style: {
                            color: '#D26E25'
                        }
                    },
                    title: {
                        text: 'Tỉ lệ mua hàng',
                        style: {
                            color: '#D26E25'
                        }
                    },
                    opposite: true

                }, { // Secondary yAxis
                    gridLineWidth: 0,
                    title: {
                        text: 'Số lượng cửa hàng',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    },
                    labels: {
                        format: '{value}k',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    }

                }
                ],
                tooltip: {
                    shared: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none'
                        },
                        stacking: 'normal'
                    }
                },
                series: [{
                    name: 'Tổng số CH',
                    type: 'column',
                    yAxis: 1,
                    data: [6.2, 6.1, 6],
                    tooltip: {
                        valueSuffix: 'k CH'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y}k'
                    }

                },
                {
                    name: 'Đã cài app + ko phát sinh đơn hàng',
                    type: 'column',
                    color: '#FF530D',
                    yAxis: 1,
                    data: [2, 2, 2],
                    tooltip: {
                        valueSuffix: 'k CH'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y}k'
                    },
                    stack: 'TC'
                },
                {
                    name: 'Đã cài app + phát sinh đơn hàng',
                    type: 'column',
                    color: '#226E40',
                    yAxis: 1,
                    data: [3, 3.4, 3.6],
                    tooltip: {
                        valueSuffix: 'k CH'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y}k'
                    },
                    stack: 'TC'
                },

                {
                    name: 'Tỉ lệ phát sinh đơn hàng',
                    type: 'spline',
                    yAxis: 0,
                    data: [50, 56, 58],
                    marker: {
                        enabled: false
                    },
                    tooltip: {
                        valueSuffix: ' %'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y} %'
                    }
                }
                ]
            });

            //SO APP B2C
            Highcharts.chart('containerAmountB2C', {
                chart: {
                    zoomType: 'xy'
                },
                credits: { enabled: false },
                title: { text: null },
                subtitle: { text: null, align: 'left' },
                xAxis: [{
                    categories: ['Cycle 5', 'Cycle 6', 'Cycle 7'],
                    crosshair: true
                }],
                yAxis: [{ // Primary yAxis
                    labels: {
                        format: '{value} đơn',
                        style: {
                            color: '#D26E25'
                        }
                    },
                    title: {
                        text: 'Số lượng đơn hàng',
                        style: {
                            color: '#D26E25'
                        }
                    },
                    opposite: true

                }, { // Secondary yAxis
                    gridLineWidth: 0,
                    title: {
                        text: 'Giá trị đơn hàng ( tỉ )',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    },
                    labels: {
                        format: '{value} tỉ',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    }

                }
                ],
                tooltip: {
                    shared: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none'
                        }
                    }
                },
                series: [{
                    name: 'Giá trị đơn hàng',
                    type: 'column',
                    color: '#FF530D',
                    yAxis: 1,
                    data: [69, 71, 90],
                    tooltip: {
                        valueSuffix: ' tỉ'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y} tỉ'
                    }
                }, {
                    name: 'Giá trị Voucher KM',
                    type: 'column',
                    color: '#5FD225',
                    yAxis: 1,
                    data: [11, 13, 16],
                    tooltip: {
                        valueSuffix: ' tỉ'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y} tỉ'
                    }
                }, {
                    name: 'Số lượng đơn hàng',
                    type: 'column',
                    yAxis: 0,
                    color: '#226E40',
                    data: [150, 250, 256],
                    marker: {
                        enabled: false
                    },
                    tooltip: {
                        valueSuffix: ' đơn'
                    },
                    dataLabels: {
                        enabled: true,
                        format: '{y} đơn'
                    }
                }
                ]
            });


            // StoreFB
            Highcharts.chart('containerStoreFB', {
                chart: { type: 'column' },
                title: { text: null },
                subtitle: { text: null },
                xAxis: {
                    categories: ['Cycle 5', 'Cycle 6', 'Cycle 7'],
                    crosshair: true
                },
                yAxis:
                {
                    min: 0,
                    title: {
                        text: 'lỗi'
                    }
                },
                tooltip: {
                    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y} lỗi</b></td></tr>',
                    footerFormat: '</table>',
                    shared: true,
                    useHTML: true
                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none',
                            formatter: function () {
                                if (this.point.y > 10) {
                                    return '<span style="color: red">' + this.y + '</span>';
                                } else {
                                    return '<span style="color: black">' + this.y + '</span>';
                                }
                            }
                        }
                    }
                },
                legend: { enabled: true },
                credits: { enabled: false },
                series: [
                    {
                        name: 'Lỗi ứng dụng',
                        data: [47, 27, 10]
                    },
                    {
                        name: 'Giao hàng chậm',
                        data: [90, 90, 95]
                    },
                    {
                        name: 'Thái độ Sales',
                        data: [60, 67, 79],
                        color: '#FF530D',
                    },
                    {
                        name: 'Trả thưởng trưng bày',
                        data: [60, 65, 80],
                    }
                ]
            });

            //Laptop
            Highcharts.chart('containerRating', {
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false,
                    type: 'pie'
                },
                title: {
                    text: null
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.y} cái</b>'
                },
                accessibility: {
                    point: {
                        valueSuffix: '%'
                    }
                },
                credits: { enabled: false },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        dataLabels: {
                            enabled: true,
                            format: '<b>{point.name}</b>: {point.y} %'
                        }
                    }
                },
                series: [{
                    name: 'Tỉ lệ',
                    colorByPoint: true,
                    data: [{
                        name: '5 sao',
                        y: 20,
                        sliced: true,
                        selected: true
                    }, {
                        name: '4 sao',
                        y: 15
                    }, {
                        name: '3 sao',
                        y: 30
                    }, {
                        name: '2 sao',
                        y: 10
                    }, {
                        name: '1 sao',
                        y: 10
                    }, {
                        name: 'Ko đánh giá',
                        y: 15
                    }]
                }]
            });
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content">
        <div class="container-fluid">
            <div class="card card-info">
                <div class="card-header">
                    <h3 class="card-title">Dashboard Summary</h3>

                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                    </div>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-2" data-select2-id="30">
                            <div class="form-group">
                                <label>Cycle:</label>
                                <asp:DropDownList runat="server" ID="ddlCycle" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">Cycle 1/2022</asp:ListItem>
                                    <asp:ListItem Value="2">Cycle 2/2022</asp:ListItem>
                                    <asp:ListItem Value="3">Cycle 3/2022</asp:ListItem>
                                    <asp:ListItem Value="4">Cycle 4/2022</asp:ListItem>
                                    <asp:ListItem Value="4">Cycle 5/2022</asp:ListItem>
                                    <asp:ListItem Value="5">Cycle 6/2022</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2" data-select2-id="30">
                            <div class="form-group">
                                <label>Area:</label>
                                <asp:DropDownList runat="server" ID="ddlArea" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">--All--</asp:ListItem>
                                    <asp:ListItem Value="2">North</asp:ListItem>
                                    <asp:ListItem Value="3">Central</asp:ListItem>
                                    <%--<asp:ListItem Value="4">Miền Đông</asp:ListItem>--%>
                                    <asp:ListItem Value="5">South</asp:ListItem>
                                    <asp:ListItem Value="6">MKD</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2" data-select2-id="30">
                            <div class="form-group">
                                <label>TeamLead:</label>
                                <asp:DropDownList runat="server" ID="ddlASM" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">--Tất cả--</asp:ListItem>
                                    <asp:ListItem Value="2">TeamLead 1</asp:ListItem>
                                    <asp:ListItem Value="3">TeamLead 2</asp:ListItem>
                                    <asp:ListItem Value="4">TeamLead 3</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <%--<div class="col-md-3" data-select2-id="30">
                            <div class="form-group">
                                <label>Supervisor:</label>
                                <asp:DropDownList runat="server" ID="ddlSUP" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="1">--Tất cả--</asp:ListItem>
                                    <asp:ListItem Value="2">Supervisor 1</asp:ListItem>
                                    <asp:ListItem Value="3">Supervisor 2</asp:ListItem>
                                    <asp:ListItem Value="4">Supervisor 3</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-3" data-select2-id="30">
                            <div class="form-group" data-select2-id="29">
                                <label>(MT) Chuỗi siêu thị</label>
                                <asp:DropDownList runat="server" ID="ddl1" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="0">-Tất cả-</asp:ListItem>
                                    <asp:ListItem Value="1">Aeon</asp:ListItem>
                                    <asp:ListItem Value="2">BHX</asp:ListItem>
                                    <asp:ListItem Value="3">BigC</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>--%>
                    </div>
                    <div class="row" style="display:none;">
                        <div class="col-md-2">
                            <div class="form-group" data-select2-id="29">
                                <label>(MT) Loại hình</label>
                                <asp:DropDownList runat="server" ID="DropDownList1" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="0">-Tất cả-</asp:ListItem>
                                    <asp:ListItem Value="1">Supermarket</asp:ListItem>
                                    <asp:ListItem Value="2">Hypermarket</asp:ListItem>
                                    <asp:ListItem Value="3">Minimart</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group" data-select2-id="29">
                                <label>(GT) Nhà phân phối</label>
                                <asp:DropDownList runat="server" ID="DropDownList2" class="form-control select2 select2-hidden-accessible" Style="width: 100%; height: 40px;">
                                    <asp:ListItem Value="0">-Tất cả-</asp:ListItem>
                                    <asp:ListItem Value="1">NPP 1</asp:ListItem>
                                    <asp:ListItem Value="2">NPP 2</asp:ListItem>
                                    <asp:ListItem Value="3">NPP 3</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <div class="row">
                        <div class="col-md-2">
                            <label class="btn btn-primary">Search</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="content">
        <div class="container-fluid">
            <div class="card card-primary card-outline card-tabs">
                <div class="card-header p-0 pt-1">
                    <ul class="nav nav-tabs" id="custom-tabs-one-tab" role="tablist">
                        <li class="nav-item" style="display:none;">
                            <a class="nav-link" id="tabfieldforce_Tab" data-toggle="pill" href="#tabfieldforce" role="tab" aria-controls="tabfieldforce" aria-selected="false">Field Force</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" id="tabhrm_Tab" data-toggle="pill" href="#tabhrm" onclick="return tab_hrm()" role="tab" aria-controls="tabhrm" aria-selected="true">HRM</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="tabhrm_Audit" data-toggle="pill" href="#tabaudit" onclick="return tab_audit()" role="tab" aria-controls="tabaudits" aria-selected="false">Recruitment</a>
                        </li>
                        <li class="nav-item" style="display:none;">>
                            <a class="nav-link" id="tabb2c_Tab" data-toggle="pill" href="#tabb2c" onclick="return tab_b2c()" role="tab" aria-controls="tabb2cs" aria-selected="false">(GT)B2C</a>
                        </li>
                    </ul>
                </div>
                <div class="card-body">
                    <div class="tab-content">
                        <div style="display:none;" class="tab-pane fade show" id="tabfieldforce" role="tabpanel" aria-labelledby="tabfieldforce">
                            <div class="row">
                                <div class="col-md-5">
                                    <div class="card">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Doanh số trong 10 tuần gần nhất ( tỉ)
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse" onclick="document.location.href='dashboardsellout'">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <!-- /.card-header -->
                                        <div class="card-body">
                                            <div id="containerSellout"></div>
                                        </div>
                                        <!-- /.card-body -->
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="card">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Tỉ lệ hết hàng
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <!-- /.card-header -->
                                        <div class="card-body">
                                            <div id="containerOOS"></div>
                                        </div>
                                        <!-- /.card-body -->
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Thị phần t/bày trong 3 Cycle gần nhất
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <!-- /.card-header -->
                                        <div class="card-body">
                                            <div id="containerSOS"></div>
                                        </div>
                                        <!-- /.card-body -->
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="card">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Inventory & WOS 3 tuần gần nhất
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <!-- /.card-header -->
                                        <div class="card-body">
                                            <div id="containerIVT"></div>
                                        </div>
                                        <!-- /.card-body -->
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="card">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Pass rate Offlocation
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <!-- /.card-header -->
                                        <div class="card-body">
                                            <div id="containerOOL"></div>
                                        </div>
                                        <!-- /.card-body -->
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="card">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Pass rate Planogram
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <!-- /.card-header -->
                                        <div class="card-body">
                                            <div id="containerPOG"></div>
                                        </div>
                                        <!-- /.card-body -->
                                    </div>
                                </div>
                            </div>
                            <div class="row">

                                <div class="col-md-6">
                                    <div class="card">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                % Tỉ lệ ghé thăm CH 3 tháng gần nhất
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <!-- /.card-header -->
                                        <div class="card-body">
                                            <div id="containerWP"></div>
                                        </div>
                                        <!-- /.card-body -->
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                % Tỉ lệ độ phủ cửa hàng 3 tháng gần nhất
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <!-- /.card-header -->
                                        <div class="card-body">
                                            <div id="containerSTORE"></div>
                                        </div>
                                        <!-- /.card-body -->
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane fade show active" id="tabhrm" role="tabpanel" aria-labelledby="tabhrm">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="card">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Work Schedule Statistics
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <!-- /.card-header -->
                                        <div class="card-body">
                                            <div id="containerEMP"></div>
                                        </div>
                                        <!-- /.card-body -->
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Work Schedule by Office
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div id="containerHR"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Work Schedule by TeamLead
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div id="containerTraining"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Statistics of Working Hours
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div id="containerKPI"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                
                                <div class="col-md-4">
                                    <div class="card">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Statistics of Working Hours ( Office North) 
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div id="containerLaptop"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Statistics of Working Hours (Office Center)
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div id="containerDT"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Statistics of Working Hours (Office Sourth)
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div id="containerDT1"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade show" id="tabaudit" role="tabpanel" aria-labelledby="tabaudit">
                            <div class="row" style="display:none;">
                                <div class="col-md-6">
                                    <div class="card" style="height: 500px;">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Tiến độ Audit
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div id="containerProcessAudit"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card" style="height: 500px;">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Thống kê số lượng KTC
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <!-- /.card-header -->
                                        <div class="card-body" style="height: 450px; overflow-y: scroll;">
                                            <table class="table table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th style="width: 10px">#</th>
                                                        <th>Lý do KTC</th>
                                                        <th style="text-align: center;">CK1</th>
                                                        <th style="text-align: center;">CK2</th>
                                                        <th style="text-align: center;">CK3</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>1.</td>
                                                        <td>Từ chối tiếp xúc ( Ncovid)</td>
                                                        <td style="text-align: center;">12
                                                        </td>
                                                        <td style="text-align: center;">14</td>
                                                        <td style="text-align: center;">15</td>
                                                    </tr>
                                                    <tr>
                                                        <td>2.</td>
                                                        <td>Không tham gia trưng bày	</td>
                                                        <td style="text-align: center;">13
                                                        </td>
                                                        <td style="text-align: center;">10</td>
                                                        <td style="text-align: center;">25</td>
                                                    </tr>
                                                    <tr>
                                                        <td>3.</td>
                                                        <td>Trùng cửa hàng</td>
                                                        <td style="text-align: center;">13
                                                        </td>
                                                        <td style="text-align: center;">10</td>
                                                        <td style="text-align: center;">25</td>
                                                    </tr>
                                                    <tr>
                                                        <td>4.</td>
                                                        <td>Thay đổi loại hình kinh doanh</td>
                                                        <td style="text-align: center;">13
                                                        </td>
                                                        <td style="text-align: center;">10</td>
                                                        <td style="text-align: center;">25</td>
                                                    </tr>
                                                    <tr>
                                                        <td>5.</td>
                                                        <td>Đóng cửa tạm thời	</td>
                                                        <td style="text-align: center;">13
                                                        </td>
                                                        <td style="text-align: center;">10</td>
                                                        <td style="text-align: center;">25</td>
                                                    </tr>
                                                    <tr>
                                                        <td>6.</td>
                                                        <td>Đóng cửa vĩnh viễn		</td>
                                                        <td style="text-align: center;">13
                                                        </td>
                                                        <td style="text-align: center;">10</td>
                                                        <td style="text-align: center;">25</td>
                                                    </tr>
                                                    <tr>
                                                        <td>7.</td>
                                                        <td>Không tìm thấy cửa hàng	</td>
                                                        <td style="text-align: center;">13
                                                        </td>
                                                        <td style="text-align: center;">10</td>
                                                        <td style="text-align: center;">25</td>
                                                    </tr>
                                                    <tr>
                                                        <td>8.</td>
                                                        <td>Lý do khác</td>
                                                        <td style="text-align: center;">13
                                                        </td>
                                                        <td style="text-align: center;">10</td>
                                                        <td style="text-align: center;">25</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                        <!-- /.card-body -->
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-3">
                                    <div class="card" style="height: 500px;">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Rate of achieving recruitment KPI
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div id="containerAuditResult"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-5">
                                    <div class="card" style="height: 500px;">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Recruiting pass rate by teamlead
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div id="containerPassKPIAudit"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card" style="height: 500px;">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Recruitment rate by office
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div id="containerSOSAudit"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>


                        </div>
                        <div class="tab-pane fade show" id="tabb2c" role="tabpanel" aria-labelledby="tabb2c">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="card" style="height: 500px;">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Thống kê tình hình sử dụng ứng dụng B2C + đơn hàng
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div id="containerINAPP"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card" style="height: 500px;">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Thống kê số lượng + giá trị đơn hàng
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div id="containerAmountB2C"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="card" style="height: 500px;">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Thống kê số lỗi điểm bán hàng phản hồi
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div id="containerStoreFB"></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="card" style="height: 500px;">
                                        <div class="card-header ui-sortable-handle" style="cursor: move; background-color: #00bcd4;">
                                            <p class="card-title" style="color: white; font-weight: bold;">
                                                Thống kê đánh giá cửa điểm bán hàng về chương trình
                                            </p>
                                            <div class="card-tools">
                                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                                    <i class="fas fa-search-plus" style="color: beige;"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div id="containerRating"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
