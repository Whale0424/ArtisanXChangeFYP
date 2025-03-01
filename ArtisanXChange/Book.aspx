<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Book.aspx.cs" Inherits="ArtisanXChange.Book" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Stickers - ArtisanXChange</title>
        <style>
        html, body {
            margin: 0;
            padding: 0;
            background-color: #F9F8F3;
            font-family: Arial, sans-serif;
        }

        .product-container {
            position: relative;
            text-align: center;
            margin-bottom: 30px;
        }

        .product-container img {
            width: 100%;
            max-height: 300px;
            object-fit: cover;
        }

        .product-container h1 {
            position: absolute;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            color: white;
            font-size: 45px;
            background: rgba(0, 0, 0, 0.6);
            padding: 10px 20px;
            border-radius: 8px;
        }

        .repeater-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            padding: 20px;
        }

        .repeater-item {
            background: white;
            width: 280px;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.2s;
        }

        .repeater-item:hover {
            transform: translateY(-5px);
        }

        .product-image img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
        }

        .product-details h3 {
            font-size: 18px;
            margin: 10px 0 5px;
            color: #333;
        }

        .product-details p {
            font-size: 14px;
            color: #666;
        }

        .price {
            font-weight: bold;
            color: #D32F2F;
        }

        .link {
            text-decoration: none;
            color: black;
        }

        .link:hover {
            border: 1px solid grey;
        }

        .view-details-btn {
            display: inline-block;
            margin-top: 10px;
            background-color: #122620;
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .view-details-btn:hover {
            background-color: #D32F2F;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="product-container">
        <img src="Image/ImageBook.jpg" alt="Book"/>
        <h1>Books</h1>
    </div>

                <div class="repeater-container">
                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                    <ItemTemplate>
                        <div class="repeater-item">
                            
                                <div class="product-image">
                                    <asp:Image ID="ProductImage" runat="server" ImageUrl='<%# Eval("LocalProdImageURL") %>' CssClass="small-image" />
                                </div>
                                <div class="product-details">
                        <h3><%# Eval("LocalProdName") %></h3>
                        <p><%# Eval("LocalProdDesc") %></p>
                        <p class="price">RM <%# Eval("LocalProdPrice") %></p>
                        <a href="ArtisanProductDetails.aspx?LocalProdID=<%# Eval("LocalProdID") %>" class="view-details-btn">View Details</a>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionStringLocal %>" 
        SelectCommand="SELECT LocalProdID, LocalProdName, LocalProdDesc, LocalProdPrice, LocalProdImageURL 
                       FROM LocalProducts WHERE LocalCatID = 1001">
    </asp:SqlDataSource>
</asp:Content>