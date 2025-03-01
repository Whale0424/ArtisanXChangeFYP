<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="LocalSearch.aspx.cs" Inherits="ArtisanXChange.LocalSearch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Local Search - ArtisanXChange</title>
    <style>
        html, body {
            padding: 0;
            height: 100%;
            width: 100%;
        }
        .search_container {
            padding: 0 30px;
            margin-top: 20px;
        }
        .search_container p {
            font-size: 20px;
            color: dimgrey;
        }
        .lblResult {
            font-size: 40px;
        }
        .search_container hr {
            border: 1px;
            border-bottom: 1px solid lightgrey;
            margin: 5px auto;
        }
        .repeater-container {
            padding-left: 30px;
            padding-right: 30px;
            display: flex;
            flex-wrap: wrap;
            justify-content: flex-start;
            gap: 10px;
        }
        .repeater-item {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            width: calc(25% - 10px);
            box-sizing: border-box;
            margin-bottom: 20px;
        }
        .product-image {
            width: 100%;
            display: flex;
            justify-content: center;
            margin-bottom: 10px;
        }
        .small-image {
            width: 100%;
            height: auto;
            max-width: 360px;
            max-height: 360px;
            object-fit: cover;
        }
        .product-details {
            text-align: left;
        }
        .gap {
            margin-bottom: 100px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="search_container">
        <p>Your Search Results for:</p>
        <asp:Label ID="lblSearchResult" CssClass="lblResult" runat="server"></asp:Label>
        <hr />
    </div>
    <div class="repeater-container">
    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
        <ItemTemplate>
            <div class="repeater-item">
                <div class="product-image">
                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("LocalProdImageURL") %>' CssClass="small-image" />
                </div>
                <div class="product-details">
                    <%# Eval("LocalProdName") %> <br />
                    <%# Eval("LocalProdPrice", "{0:C}") %> <!-- Formats as currency -->
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>

     
    <div class="gap">&nbsp;</div>
   <asp:SqlDataSource ID="SqlDataSource1" runat="server"
    ConnectionString="<%$ ConnectionStrings:ConnectionStringLocal %>"
    SelectCommand="SELECT DISTINCT LocalProdName, LocalProdDesc, LocalProdPrice, LocalProdImageURL 
                   FROM LocalProducts 
                   WHERE LocalProdName LIKE '%' + @SearchQuery + '%' 
                   OR LocalProdDesc LIKE '%' + @SearchQuery + '%'">
    <SelectParameters>
        <asp:Parameter Name="SearchQuery" Type="String" DefaultValue="" />
    </SelectParameters>
</asp:SqlDataSource>

</asp:Content>
