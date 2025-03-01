<%@ Page Title="Add New Product" Language="C#" MasterPageFile="~/LocalSite2.Master" AutoEventWireup="true" CodeBehind="LocalCreate.aspx.cs" Inherits="ArtisanXChange.LocalCreate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Add New Product</title>
    <style>
        .form-container {
            padding: 20px;
            margin: 20px auto;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 50%;
            background-color: #f9f9f9;
        }

        .form-container h2 {
            margin-bottom: 20px;
            text-align: center;
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

        .form-group input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        .form-group input[type="submit"]:hover {
            background-color: #45a049;
        }

        .error-message {
            color: red;
        }

        .success-message {
            color: green;
        }

        .back-button {
            height: 30px;
            width: 30px;
            margin-top: 20px;
            margin-right: 100px;
        }



       .auto-style1 {
    height: 40px;
    width: 40px;
    display: inline-block;
    position: relative;
    z-index: 100;
    margin: 10px;
    margin-left: 120px; /* Increase this value to move it more to the right */
}



    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ImageButton runat="server" PostBackUrl="~/LocalProdInv.aspx" CssClass="auto-style1" ImageUrl="~/Image/LocalBack.png"></asp:ImageButton>
    
    <div class="form-container">
        <h2>Add New Product</h2>

        <div class="form-group">
            <label for="LocalCatID">Category:</label>
           <asp:DropDownList ID="LocalCatID" runat="server" DataSourceID="SqlDataSource1" DataTextField="LocalCatName" DataValueField="LocalCatID">
        </asp:DropDownList>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringLocal %>" 
            SelectCommand="SELECT LocalCatID, LocalCatName FROM LocalCategory">
        </asp:SqlDataSource>

        </div>

        <div class="form-group">
            <label for="ProductName">Name:</label>
            <asp:TextBox ID="ProductName" runat="server"></asp:TextBox>
        </div>

        <div class="form-group">
            <label for="ProductDesc">Description:</label>
            <asp:TextBox ID="ProductDesc" runat="server"></asp:TextBox>
        </div>

        <div class="form-group">
            <label for="ProductPrice">Price:</label>
            <asp:TextBox ID="ProductPrice" runat="server" TextMode="Number"></asp:TextBox>
        </div>

        <div class="form-group">
            <label for="ProductQuantity">Quantity:</label>
            <asp:TextBox ID="ProductQuantity" runat="server" TextMode="Number"></asp:TextBox>
        </div>

        <div class="form-group">
            <label for="ProductURL">Image URL:</label>
            <asp:TextBox ID="ProductURL" runat="server"></asp:TextBox>
        </div>

        <div class="form-group">
            <asp:Button ID="SubmitButton" runat="server" Text="Add Product" OnClick="SubmitButton_Click" />
            <asp:Label ID="lblMessage" runat="server"></asp:Label>
        </div>
    </div>
</asp:Content>
