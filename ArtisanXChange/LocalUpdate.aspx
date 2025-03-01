<%@ Page Title="Update Product" Language="C#" MasterPageFile="~/LocalSite2.Master" AutoEventWireup="true" CodeBehind="LocalUpdate.aspx.cs" Inherits="ArtisanXChange.LocalUpdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Update Product</title>
    <style>
        .container {
            display: flex;
            align-items: flex-start;
            margin: 20px;
        }
        .back-button {
            height: 30px;
            width: 30px;
            margin-left: 110px;
            margin-right: 20px;
        }
        .form-container {
            padding: 20px;
            border: 1px solid #ccc;
            margin-left: 270px;
            border-radius: 5px;
            width: 100%;
            max-width: 600px;
            background-color: #f9f9f9;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .auto-style1 {
            margin-left: 110px;
            margin-right: 20px;
        }
        .id-container {
            display: flex;
            gap: 10px;
        }
        .load-button {
            flex-shrink: 0;
            width: auto !important;
        }
        .success-message {
            color: green;
            font-weight: bold;
            margin-top: 10px;
            display: block;
        }
        .error-message {
            color: red;
            font-weight: bold;
            margin-top: 10px;
            display: block;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <asp:ImageButton runat="server" PostBackUrl="~/LocalProdInv.aspx" CssClass="auto-style1" ImageUrl="~/Image/LocalBack.png" Width="30px"></asp:ImageButton>
        <div class="form-container">
            <h2>Update Product</h2>
           <div class="form-group">
                <label for="ProductID">Product ID:</label>
                <div class="id-container">
                    <asp:TextBox ID="ProductID" runat="server"></asp:TextBox>
                    <asp:Button ID="LoadButton" runat="server" Text="Load Product" OnClick="LoadButton_Click" CssClass="load-button" />
                </div>
            </div>
            <div class="form-group">
                <label for="LocalCatID">Category:</label>
                <asp:DropDownList ID="LocalCatID" runat="server" DataSourceID="SqlDataSource1" DataTextField="LocalCatName" DataValueField="LocalCatID"></asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringLocal %>" SelectCommand="SELECT [LocalCatID], [LocalCatName] FROM [LocalCategory]"></asp:SqlDataSource>
            </div>
            <div class="form-group">
                <label for="LocalProdName">Name:</label>
                <asp:TextBox ID="LocalProdName" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="LocalProdDesc">Description:</label>
                <asp:TextBox ID="LocalProdDesc" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="LocalProdPrice">Price:</label>
                <asp:TextBox ID="LocalProdPrice" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="LocalProdQuantity">Quantity:</label>
                <asp:TextBox ID="LocalProdQuantity" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="LocalProdImageURL">Image URL:</label>
                <asp:TextBox ID="LocalProdImageURL" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Button ID="UpdateButton" runat="server" Text="Update Product" OnClick="UpdateButton_Click" />
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </div>
        </div>
    </div>
</asp:Content>