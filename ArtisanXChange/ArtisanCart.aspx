<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ArtisanCart.aspx.cs" Inherits="ArtisanXChange.ArtisanCart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Shopping Cart - ArtisanXChange</title>
    <style>
        .cart-container {
            padding: 20px;
        }
        .cart-table {
            width: 100%;
            border-collapse: collapse;
        }
        .cart-table th, .cart-table td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        .cart-table th {
            background-color: #f8f9fa;
            text-align: left;
        }
        .quantity-selector {
            display: flex;
            align-items: center;
        }
        .quantity-btn {
            width: 25px;
            height: 25px;
            background-color: #f0f0f0;
            border: 1px solid #ddd;
            cursor: pointer;
        }
        .quantity-input {
            width: 40px;
            height: 25px;
            text-align: center;
            margin: 0 5px;
            border: 1px solid #ddd;
        }
        .product-image {
            max-width: 100px;
            max-height: 100px;
        }
        .cart-summary {
            margin-top: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }
        .empty-cart {
            text-align: center;
            padding: 50px 0;
        }
        .empty-cart-message {
            font-size: 18px;
            color: #6c757d;
            margin-bottom: 20px;
        }
        .checkout-btn {
            background-color: #FF0066;
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }
        .checkout-btn:hover {
            background-color: #d30051;
        }
        .continue-shopping-btn {
            background-color: #6c757d;
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            margin-right: 10px;
        }
        .continue-shopping-btn:hover {
            background-color: #5a6268;
        }
        .action-buttons {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }
        .remove-btn {
            color: #dc3545;
            text-decoration: none;
            cursor: pointer;
        }
        .remove-btn:hover {
            text-decoration: underline;
        }
        .shipping-options {
            margin-top: 15px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 5px;
            border: 1px solid #dee2e6;
        }
        .shipping-options label {
            font-weight: bold;
            margin-bottom: 8px;
            display: block;
        }
        .shipping-options select {
            padding: 8px;
            width: 100%;
            max-width: 300px;
            border-radius: 4px;
            border: 1px solid #ced4da;
        }
        .shipping-message {
            margin-top: 10px;
            font-size: 14px;
        }
        .text-success {
            color: #28a745;
        }
        .text-info {
            color: #17a2b8;
        }
        .font-weight-bold {
            font-weight: bold;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="cart-container">
            <h2>Your Shopping Cart</h2>
            
            <asp:Panel ID="pnlEmptyCart" runat="server" Visible="false" CssClass="empty-cart">
                <div class="empty-cart-message">Your cart is empty</div>
                <asp:Button ID="btnContinueShopping" runat="server" Text="Continue Shopping" 
                    OnClick="btnContinueShopping_Click" CssClass="continue-shopping-btn" />
            </asp:Panel>
            
            <asp:Panel ID="pnlCart" runat="server">
                <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="false" 
                    CssClass="cart-table" OnRowCommand="gvCart_RowCommand"
                    OnRowDataBound="gvCart_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="Product">
                            <ItemTemplate>
                                <div class="d-flex align-items-center">
                                    <asp:Image ID="imgProduct" runat="server" CssClass="product-image mr-3" 
                                        ImageUrl='<%# Eval("ProductImage") %>' />
                                    <div>
                                        <h5><%# Eval("ProductName") %></h5>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Price">
                            <ItemTemplate>
                                RM <%# Eval("Price", "{0:F2}") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Quantity">
                            <ItemTemplate>
                                <div class="quantity-selector">
                                    <asp:Button ID="btnDecrease" runat="server" Text="-" 
                                        CommandName="DecreaseQty" CommandArgument='<%# Eval("ProductId") %>' 
                                        CssClass="quantity-btn" />
                                    <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Eval("Quantity") %>' 
                                        CssClass="quantity-input" ReadOnly="true"></asp:TextBox>
                                    <asp:Button ID="btnIncrease" runat="server" Text="+" 
                                        CommandName="IncreaseQty" CommandArgument='<%# Eval("ProductId") %>' 
                                        CssClass="quantity-btn" />
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Subtotal">
                            <ItemTemplate>
                                RM <%# String.Format("{0:F2}", Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity"))) %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkRemove" runat="server" Text="Remove" 
                                    CommandName="RemoveItem" CommandArgument='<%# Eval("ProductId") %>'
                                    CssClass="remove-btn" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="empty-cart-message">Your cart is empty</div>
                    </EmptyDataTemplate>
                </asp:GridView>
                
                <!-- Shipping Options -->
                <div class="shipping-options">
                    <label for="ddlShippingRegion">Shipping Location:</label>
                    <asp:DropDownList ID="ddlShippingRegion" runat="server" AutoPostBack="true" 
                                     OnSelectedIndexChanged="ddlShippingRegion_SelectedIndexChanged">
                        <asp:ListItem Value="West" Text="West Malaysia (RM 8.00)" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="East" Text="East Malaysia (RM 15.00)"></asp:ListItem>
                    </asp:DropDownList>
                    <div class="shipping-message">
                        <asp:Label ID="lblShippingMessage" runat="server"></asp:Label>
                    </div>
                    <div class="shipping-note">
                        <small>Free shipping for purchases of RM100 and above across Malaysia</small>
                    </div>
                </div>
                
                <div class="cart-summary">
                    <div class="row">
                        <div class="col-md-6 offset-md-6">
                            <table class="table">
                                <tr>
                                    <td>Subtotal:</td>
                                    <td class="text-right">RM <asp:Label ID="lblSubtotal" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>Shipping:</td>
                                    <td class="text-right">RM <asp:Label ID="lblShipping" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td><strong>Total:</strong></td>
                                    <td class="text-right"><strong>RM <asp:Label ID="lblTotal" runat="server"></asp:Label></strong></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                
                <div class="action-buttons">
                    <div>
                        <asp:Button ID="btnContinueShoppingFilled" runat="server" Text="Continue Shopping" 
                            OnClick="btnContinueShopping_Click" CssClass="continue-shopping-btn" />
                    </div>
                    <div>
                        <asp:Button ID="btnProceedCheckout" runat="server" Text="Proceed to Checkout" 
                            OnClick="btnProceedCheckout_Click" CssClass="checkout-btn" />
                    </div>
                </div>
            </asp:Panel>
            
            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mt-3"></asp:Label>
        </div>
    </div>
</asp:Content>