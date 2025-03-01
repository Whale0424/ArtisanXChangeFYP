<%@ Page Title="Product Details" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ArtisanProductDetails.aspx.cs" Inherits="ArtisanXChange.ArtisanProductDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Product Details - ArtisanXChange</title>
    <style>
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            font-family: Arial, sans-serif;
        }
        
        .product-details {
            padding: 20px;
        }
        
        .quantity-section {
            margin: 20px 0;
        }
        
        .quantity-selector {
            display: flex;
            align-items: center;
        }

        
        .quantity-btn {
            width: 40px;
            height: 40px;
            background-color: #ddd;
            border: 1px solid #ccc;
            cursor: pointer;
            font-size: 18px;
            font-weight: bold;
            border-radius: 5px;
        }
        
        .quantity-input {
            width: 60px;
            height: 40px;
            text-align: center;
            margin: 0 5px;
            border: 1px solid #ccc;
            font-size: 18px;
            font-weight: bold;
        }
        
        .stock-info {
            font-weight: bold;
            color: green;
        }
        
        .out-of-stock {
            color: red;
        }
        
        .message {
            font-weight: bold;
            color: darkred;
        }
        
        .add-to-cart-btn {
            background-color: #FF0066;
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            border: none;
        }
        
        .add-to-cart-btn:disabled {
            background-color: gray;
            cursor: not-allowed;
        }

        .product-image {
            max-width: 100%;
            height: auto;
            border-radius: 5px;
        }

        .product-title {
            font-size: 24px;
            margin-bottom: 10px;
        }

        .product-price {
            font-size: 22px;
            color: #D32F2F;
            margin-bottom: 15px;
        }

        .product-description {
            margin-bottom: 20px;
            line-height: 1.6;
        }
    </style>
    <script>
        function validateQuantity(input) {
            if (input.value < 1) { input.value = 1; }
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <asp:Image ID="imgProduct" runat="server" CssClass="product-image img-fluid" />
            </div>
            <div class="col-md-6">
                <div class="product-details">
                    <h1 class="product-title"><asp:Label ID="lblLocalProdName" runat="server"></asp:Label></h1>
                    <h4 class="product-price"><asp:Label ID="lblProductPrice" runat="server"></asp:Label></h4>
                    <p class="product-description"><asp:Label ID="lblProductDescription" runat="server"></asp:Label></p>
                    <p><asp:Label ID="lblStock" runat="server" CssClass="stock-info"></asp:Label></p>
                    
                    <div class="quantity-section">
                        <h5>Quantity:</h5>
                        <div class="quantity-selector">
                            <asp:Button ID="btnDecrease" runat="server" Text="−" OnClick="btnDecrease_Click" CssClass="quantity-btn" />
                            <asp:TextBox ID="txtQuantity" runat="server" Text="1" CssClass="quantity-input" TextMode="Number" min="1" oninput="validateQuantity(this)"></asp:TextBox>
                            <asp:Button ID="btnIncrease" runat="server" Text="+" OnClick="btnIncrease_Click" CssClass="quantity-btn" />
                        </div>
                    </div>
                    
                    <div class="mt-3">
                        <asp:Button ID="AddToCartButton" runat="server" Text="Add to Cart" OnClick="AddToCartButton_Click" CssClass="add-to-cart-btn" />
                    </div>
                    
                    <div class="mt-3">
                        <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>