<%@ Page Language="C#" MasterPageFile="~/LocalSite2.Master" AutoEventWireup="true" CodeBehind="LocalDelete.aspx.cs" Inherits="ArtisanXChange.LocalDelete" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Delete Product</title>
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
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .form-group input[type="submit"] {
            background-color: #f44336; /* Red background for delete */
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        .form-group input[type="submit"]:hover {
            background-color: #d32f2f; /* Darker red on hover */
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
            margin-left: 130px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ImageButton runat="server" PostBackUrl="~/LocalProdInv.aspx" CssClass="back-button" ImageUrl="~/Image/LocalBack.png"></asp:ImageButton>
    <div class="form-container">
        <h2>Delete Product</h2>

        <div class="form-group">
            <label for="ProductID">Product ID:</label>
            <asp:TextBox ID="LocalProdID" runat="server"></asp:TextBox>
        </div>

        <div class="form-group">
            <asp:Button ID="DeleteButton" runat="server" Text="Delete Product" OnClick="DeleteButton_Click" />
            <asp:Label ID="lblMessage" runat="server" CssClass="success-message"></asp:Label>
        </div>
    </div>
</asp:Content>
