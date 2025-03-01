<%@ Page Language="C#" MasterPageFile="~/LocalSite2.Master" AutoEventWireup="true" CodeBehind="LocalProdInv.aspx.cs" Inherits="ArtisanXChange.LocalProdInv" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Admin - ArtisanXChange</title>
    <style>
    .main-content {
        padding: 20px;
        box-sizing: border-box;
        width: 100%;
    }

    .container-large {
        border: 1px solid #ccc;
        padding: 20px;
        margin: 5px 10px;
        border-radius: 5px;
        box-sizing: border-box;
        width: 98%;
        display: inline-block;
        vertical-align: top;
    }

    .grid-column-1 { width: 100px; text-align: center; }
    .grid-column-2 { width: 100px; text-align: center; }
    .grid-column-3 { width: 700px; text-align: left; }
    .grid-column-4 { width: 50px; text-align: center; }
    .grid-column-5 { width: 100px; text-align: left; }
    .grid-column-6 { width: 50px; text-align: center; }
    .grid-column-7 { width: 250px; text-align: left; }

    table {
        width: 98.7%;
        text-align: center;
        border: 2px solid lightgrey;
        margin-top: 10px;
        margin-left: 10px;
        margin-right: 20px;
        padding: 20px;
        border-collapse: collapse;
    }

    th, td {
        padding: 10px;
        border: 2px solid #000;
    }

    th {
        font-weight: bold;
        text-align: center;
        background-color: darkgrey;
    }

    .bold-text {
        font-weight: bold;
    }

    .no-color {
        color: inherit;
        text-decoration: none;
    }

    /* Style for GridView paging controls */
    .gridview-paging a {
        color: inherit; /* Inherit the text color */
        text-decoration: none; /* Remove underline */
    }

    .gridview-paging a:hover {
        text-decoration: underline; /* Optional: underline on hover */
    }

    /* Optional: Add space between paging links */
    .gridview-paging a {
        margin: 0 5px;
    }
</style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="main-content">
            <div class="container-large">
                <h2>Product Inventory Management</h2>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" AllowPaging="True" PageSize="9" DataKeyNames="LocalProdID">
                    <Columns>
                        <asp:BoundField DataField="LocalProdID" HeaderText="Product ID" InsertVisible="False" ReadOnly="True" SortExpression="LocalProdID">
                        </asp:BoundField>

                        <asp:BoundField DataField="LocalCatID" HeaderText="Category ID" SortExpression="LocalCatID">
                        </asp:BoundField>

                        <asp:BoundField DataField="LocalProdName" HeaderText="Product Name" SortExpression="LocalProdName">
                        </asp:BoundField>

                        <asp:BoundField DataField="LocalProdDesc" HeaderText="Description" SortExpression="LocalProdDesc">
                        </asp:BoundField>

                        <asp:BoundField DataField="LocalProdPrice" HeaderText="Price" SortExpression="LocalProdPrice">
                        </asp:BoundField>

                        <asp:BoundField DataField="LocalProdQuantity" HeaderText="Quantity" SortExpression="LocalProdQuantity">
                        </asp:BoundField>

                        <asp:BoundField DataField="LocalProdImageURL" HeaderText="Image URL" SortExpression="LocalProdImageURL">
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringLocal %>" SelectCommand="SELECT * FROM [LocalProducts] ORDER BY [LocalProdID]"></asp:SqlDataSource>
                       <div>
                            <table>
                                <tr>
                                    <td>
                                        <p class="bold-text">
                                            <asp:HyperLink runat="server" NavigateUrl="~/LocalCreate.aspx" CssClass="no-color">Create</asp:HyperLink>
                                        </p>
                                    <td>
                                        <p class="bold-text">
                                            <asp:HyperLink runat="server" NavigateUrl="~/LocalUpdate.aspx" CssClass="no-color">Update</asp:HyperLink>
                                        </p>
                                    </td>
                                    <td>
                                        <p class="bold-text">
                                            <asp:HyperLink runat="server" NavigateUrl="~/LocalDelete.aspx" CssClass="no-color">Delete</asp:HyperLink>
                                        </p>
                                    </td>
                                </tr>
                            </table>
                    </div>
            </div>
        </div>
</asp:Content>