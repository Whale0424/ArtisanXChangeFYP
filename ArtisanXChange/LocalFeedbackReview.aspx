<%@ Page Language="C#" MasterPageFile="~/LocalAdminSite3.Master" AutoEventWireup="true" CodeBehind="LocalFeedbackReview.aspx.cs" Inherits="ArtisanXChange.LocalFeedbackReview" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Customer Feedback Review - ArtisanXChange Admin</title>
    <style>
        .main-container {
            padding: 20px;
            box-sizing: border-box;
            width: 100%;
        }

        .panel-container {
            border: 1px solid #ddd;
            padding: 20px;
            margin: 5px 0;
            border-radius: 5px;
            box-sizing: border-box;
            width: 100%;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .panel-heading {
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #2c3e50;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .panel-heading h2 {
            color: #2c3e50;
            margin: 0;
        }

        .feedback-filters {
            margin-bottom: 20px;
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            min-width: 200px;
        }

        .filter-group label {
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }

        .feedback-filters select, .feedback-filters input {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        .filter-btn {
            padding: 8px 15px;
            background-color: #2c3e50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            align-self: flex-end;
            margin-top: 23px;
            transition: background-color 0.2s;
        }

        .filter-btn:hover {
            background-color: #3a506b;
        }

        .feedback-grid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        .feedback-grid th {
            background-color: #2c3e50;
            color: white;
            padding: 12px 10px;
            text-align: left;
            font-weight: normal;
        }

        .feedback-grid th, .feedback-grid td {
            padding: 12px 10px;
            border: 1px solid #ddd;
        }

        .feedback-grid tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .feedback-grid tr:hover {
            background-color: #f1f1f1;
        }

        .feedback-text {
            max-width: 300px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .pager {
            margin-top: 15px;
            display: flex;
            justify-content: center;
        }

        .pager a, .pager span {
            padding: 6px 12px;
            margin: 0 3px;
            border: 1px solid #ddd;
            color: #2c3e50;
            text-decoration: none;
            border-radius: 3px;
        }

        .pager a:hover, .pager span {
            background-color: #2c3e50;
            color: white;
        }

        .no-data {
            padding: 30px;
            text-align: center;
            color: #666;
            font-style: italic;
            background-color: #f9f9f9;
            border: 1px dashed #ddd;
            margin: 20px 0;
            border-radius: 4px;
        }

        .detail-view {
            margin-top: 30px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
            display: none;
        }

        .detail-view h3 {
            margin-top: 0;
            color: #2c3e50;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        .detail-row {
            display: flex;
            margin-bottom: 15px;
        }

        .detail-label {
            font-weight: bold;
            width: 150px;
            color: #555;
        }

        .detail-value {
            flex: 1;
        }

        .feedback-message {
            white-space: pre-wrap;
            padding: 15px;
            background-color: white;
            border: 1px solid #eee;
            border-radius: 4px;
            margin-top: 5px;
            min-height: 100px;
            line-height: 1.5;
        }

        .action-buttons {
            margin-top: 20px;
            display: flex;
            gap: 15px;
        }

        .action-btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.2s;
        }

        .reply-btn {
            background-color: #2c3e50;
            color: white;
        }

        .reply-btn:hover {
            background-color: #3a506b;
        }

        .delete-btn {
            background-color: #e74c3c;
            color: white;
        }

        .delete-btn:hover {
            background-color: #c0392b;
        }

        .action-link {
            color: #2c3e50;
            text-decoration: none;
            display: inline-block;
            padding: 3px 10px;
            border-radius: 3px;
            transition: background-color 0.2s;
        }

        .action-link:hover {
            background-color: #eee;
            text-decoration: underline;
        }

        .message-panel {
            padding: 10px 15px;
            margin: 15px 0;
            border-radius: 4px;
            display: none;
        }

        .message-success {
            background-color: #d1e7dd;
            color: #0f5132;
            border: 1px solid #badbcc;
        }

        .message-error {
            background-color: #f8d7da;
            color: #842029;
            border: 1px solid #f5c2c7;
        }

        .counter-badge {
            display: inline-block;
            min-width: 18px;
            height: 18px;
            line-height: 18px;
            border-radius: 9px;
            background-color: #e74c3c;
            color: white;
            text-align: center;
            font-size: 11px;
            font-weight: bold;
            margin-left: 8px;
        }

        .counter-container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .counter-box {
            flex: 1;
            margin: 0 10px;
            padding: 15px;
            border-radius: 5px;
            background-color: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            text-align: center;
        }

        .counter-box:first-child {
            margin-left: 0;
        }

        .counter-box:last-child {
            margin-right: 0;
        }

        .counter-title {
            font-size: 14px;
            color: #555;
            margin-bottom: 10px;
        }

        .counter-value {
            font-size: 24px;
            font-weight: bold;
            color: #2c3e50;
        }

        .counter-box.today {
            border-top: 3px solid #3498db;
        }

        .counter-box.week {
            border-top: 3px solid #2ecc71;
        }

        .counter-box.month {
            border-top: 3px solid #f39c12;
        }

        .counter-box.total {
            border-top: 3px solid #9b59b6;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main-container">
        <div class="panel-container">
            <div class="panel-heading">
                <h2>Customer Feedback Management</h2>
            </div>
            
            <!-- Feedback Statistics -->
            <div class="counter-container">
                <div class="counter-box today">
                    <div class="counter-title">Today</div>
                    <div class="counter-value">
                        <asp:Label ID="lblTodayCount" runat="server">0</asp:Label>
                    </div>
                </div>
                <div class="counter-box week">
                    <div class="counter-title">This Week</div>
                    <div class="counter-value">
                        <asp:Label ID="lblWeekCount" runat="server">0</asp:Label>
                    </div>
                </div>
                <div class="counter-box month">
                    <div class="counter-title">This Month</div>
                    <div class="counter-value">
                        <asp:Label ID="lblMonthCount" runat="server">0</asp:Label>
                    </div>
                </div>
                <div class="counter-box total">
                    <div class="counter-title">Total Feedback</div>
                    <div class="counter-value">
                        <asp:Label ID="lblTotalCount" runat="server">0</asp:Label>
                    </div>
                </div>
            </div>
            
            <!-- Filters -->
            <div class="feedback-filters">
                <div class="filter-group">
                    <asp:Label ID="lblDateRange" runat="server" Text="Filter by Date:" AssociatedControlID="ddlDateFilter"></asp:Label>
                    <asp:DropDownList ID="ddlDateFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlDateFilter_SelectedIndexChanged">
                        <asp:ListItem Value="all" Selected="True">All Time</asp:ListItem>
                        <asp:ListItem Value="today">Today</asp:ListItem>
                        <asp:ListItem Value="week">This Week</asp:ListItem>
                        <asp:ListItem Value="month">This Month</asp:ListItem>
                    </asp:DropDownList>
                </div>
                
                <div class="filter-group">
                    <asp:Label ID="lblSearch" runat="server" Text="Search:" AssociatedControlID="txtSearch"></asp:Label>
                    <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by name or email"></asp:TextBox>
                </div>
                
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="filter-btn" OnClick="btnSearch_Click" />
                <asp:Button ID="btnClear" runat="server" Text="Clear Filters" CssClass="filter-btn" OnClick="btnClear_Click" />
            </div>
            
            <!-- Messages Panel -->
            <asp:Panel ID="pnlMessage" runat="server" CssClass="message-panel" Visible="false">
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </asp:Panel>
            
            <!-- Feedback Grid -->
            <asp:GridView ID="gvFeedback" runat="server" AutoGenerateColumns="False" 
                CssClass="feedback-grid" AllowPaging="True" PageSize="10" 
                OnPageIndexChanging="gvFeedback_PageIndexChanging"
                OnRowCommand="gvFeedback_RowCommand" DataKeyNames="LocalFeedbackID">
                <Columns>
                    <asp:BoundField DataField="LocalFeedbackID" HeaderText="ID" />
                    <asp:BoundField DataField="LocalCustomerName" HeaderText="Name" />
                    <asp:BoundField DataField="LocalContactEmail" HeaderText="Email" />
                    <asp:BoundField DataField="LocalContactNumber" HeaderText="Contact" />
                    <asp:TemplateField HeaderText="Feedback">
                        <ItemTemplate>
                            <div class="feedback-text">
                                <%# Eval("LocalFeedbackText").ToString().Length > 100 ? 
                                    Eval("LocalFeedbackText").ToString().Substring(0, 100) + "..." : 
                                    Eval("LocalFeedbackText") %>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="LocalFeedbackDate" HeaderText="Date Submitted" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkViewDetails" runat="server" Text="View Details" 
                                CommandName="ViewDetails" CommandArgument='<%# Eval("LocalFeedbackID") %>'
                                CssClass="action-link"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="no-data">No feedback records found.</div>
                </EmptyDataTemplate>
                <PagerStyle CssClass="pager" />
            </asp:GridView>
        </div>
        
        <!-- Feedback Details Panel -->
        <asp:Panel ID="pnlFeedbackDetails" runat="server" CssClass="detail-view panel-container">
            <h3>Feedback Details</h3>
            
            <div class="detail-row">
                <div class="detail-label">Customer Name:</div>
                <div class="detail-value">
                    <asp:Label ID="lblDetailName" runat="server"></asp:Label>
                </div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Email:</div>
                <div class="detail-value">
                    <asp:Label ID="lblDetailEmail" runat="server"></asp:Label>
                </div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Contact Number:</div>
                <div class="detail-value">
                    <asp:Label ID="lblDetailContact" runat="server"></asp:Label>
                </div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Date Submitted:</div>
                <div class="detail-value">
                    <asp:Label ID="lblDetailDate" runat="server"></asp:Label>
                </div>
            </div>
            
            <div class="detail-row">
                <div class="detail-label">Feedback:</div>
            </div>
            <div class="feedback-message">
                <asp:Label ID="lblDetailMessage" runat="server"></asp:Label>
            </div>
            
            <div class="action-buttons">
                <asp:Button ID="btnReply" runat="server" Text="Reply via Email" CssClass="action-btn reply-btn" OnClick="btnReply_Click" />
                <asp:Button ID="btnDelete" runat="server" Text="Delete Feedback" CssClass="action-btn delete-btn" OnClick="btnDelete_Click" OnClientClick="return confirm('Are you sure you want to delete this feedback?');" />
                <asp:HiddenField ID="hdnSelectedFeedbackID" runat="server" />
            </div>
        </asp:Panel>
    </div>
</asp:Content>