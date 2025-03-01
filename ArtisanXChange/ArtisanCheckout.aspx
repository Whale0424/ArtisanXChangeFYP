<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ArtisanCheckout.aspx.cs" Inherits="ArtisanXChange.ArtisanCheckout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Checkout - ArtisanXChange</title>
    <style>
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            font-family: Arial, sans-serif;
        }
        
        .checkout-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .checkout-header h1 {
            font-size: 32px;
            color: #333;
        }
        
        .checkout-steps {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
            position: relative;
        }
        
        .checkout-steps::after {
            content: "";
            position: absolute;
            top: 15px;
            left: 0;
            right: 0;
            height: 2px;
            background-color: #ddd;
            z-index: -1;
        }
        
        .step {
            background-color: #f9f8f3;
            padding: 0 15px;
            text-align: center;
            z-index: 1;
        }
        
        .step-number {
            display: inline-block;
            width: 30px;
            height: 30px;
            background-color: #122620;
            color: white;
            border-radius: 50%;
            text-align: center;
            line-height: 30px;
            margin-right: 10px;
        }
        
        .active .step-number {
            background-color: #D32F2F;
        }
        
        .checkout-form {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-bottom: 30px;
        }
        
        .form-section {
            margin-bottom: 30px;
        }
        
        .section-title {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ddd;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #666;
        }
        
        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }
        
        .form-row {
            display: flex;
            gap: 15px;
        }
        
        .form-row .form-group {
            flex: 1;
        }
        
        .payment-methods {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }
        
        .payment-method {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            width: calc(33.333% - 10px);
            text-align: center;
            cursor: pointer;
        }
        
        .payment-method.selected {
            border-color: #122620;
            background-color: rgba(18, 38, 32, 0.05);
        }
        
        .payment-method img {
            height: 40px;
            margin-bottom: 10px;
        }
        
        .order-summary {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }
        
        .summary-title {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ddd;
        }
        
        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        
        .summary-item-title {
            color: #666;
        }
        
        .summary-item-value {
            font-weight: bold;
            color: #333;
        }
        
        .summary-total {
            font-size: 18px;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #ddd;
        }
        
        .summary-total .summary-item-value {
            color: #D32F2F;
            font-size: 22px;
        }
        
        .checkout-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }
        
        .back-to-cart {
            color: #666;
            text-decoration: none;
            display: flex;
            align-items: center;
        }
        
        .back-to-cart:hover {
            color: #333;
        }
        
        .place-order-btn {
            background-color: #122620;
            color: white;
            border: none;
            padding: 12px 30px;
            font-size: 18px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .place-order-btn:hover {
            background-color: #D32F2F;
        }
        
        .message {
            margin-top: 15px;
            padding: 10px;
            border-radius: 5px;
            font-weight: bold;
        }
        
        .success {
            background-color: #d4edda;
            color: #155724;
        }
        
        .error {
            background-color: #f8d7da;
            color: #721c24;
        }
        
        .shipping-info {
            padding: 10px 15px;
            background-color: #f8f9fa;
            border-radius: 5px;
            margin-bottom: 15px;
            border-left: 4px solid #122620;
        }
        
        .text-success {
            color: #28a745;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="checkout-header">
            <h1>Checkout</h1>
        </div>
        
        <div class="checkout-steps">
            <div class="step">
                <span class="step-number">1</span>
                <span>Shopping Cart</span>
            </div>
            <div class="step active">
                <span class="step-number">2</span>
                <span>Checkout</span>
            </div>
            <div class="step">
                <span class="step-number">3</span>
                <span>Confirmation</span>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-8">
                <div class="checkout-form">
                    <div class="shipping-info">
                        <h4>Shipping to <asp:Label ID="lblShippingRegion" runat="server"></asp:Label></h4>
                        <asp:Label ID="lblShippingNote" runat="server"></asp:Label>
                        <p><small>RM 8 for West Malaysia, RM 15 for East Malaysia. Free shipping for purchase from RM100 and above across Malaysia.</small></p>
                    </div>
                    
                    <div class="form-section">
                        <h3 class="section-title">Shipping Information</h3>
                        <div class="form-group">
                            <label for="txtFullName">Full Name</label>
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" required></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtAddress">Address</label>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" required></asp:TextBox>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="txtCity">City</label>
                                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" required></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="txtState">State</label>
                                <asp:TextBox ID="txtState" runat="server" CssClass="form-control" required></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="txtPostcode">Postcode</label>
                                <asp:TextBox ID="txtPostcode" runat="server" CssClass="form-control" required></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="txtPhone">Phone Number</label>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" required></asp:TextBox>
                        </div>
                    </div>
                    
                    <div class="form-section">
                        <h3 class="section-title">Payment Method</h3>
                        <asp:RadioButtonList ID="rblPaymentMethod" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Value="Credit" Selected="True">Credit Card</asp:ListItem>
                            <asp:ListItem Value="Debit">Debit Card</asp:ListItem>
                            <asp:ListItem Value="Online">Online Banking</asp:ListItem>
                        </asp:RadioButtonList>
                        
                        <div class="form-group" id="cardDetailsSection">
                            <div class="form-group">
                                <label for="txtCardNumber">Card Number</label>
                                <asp:TextBox ID="txtCardNumber" runat="server" CssClass="form-control" placeholder="XXXX XXXX XXXX XXXX"></asp:TextBox>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="txtExpiry">Expiry Date</label>
                                    <asp:TextBox ID="txtExpiry" runat="server" CssClass="form-control" placeholder="MM/YY"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="txtCVV">CVV</label>
                                    <asp:TextBox ID="txtCVV" runat="server" CssClass="form-control" placeholder="XXX"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="order-summary">
                    <h3 class="summary-title">Order Summary</h3>
                    
                    <asp:Repeater ID="rptCartItems" runat="server">
                        <ItemTemplate>
                            <div class="summary-item">
                                <div class="summary-item-title">
                                    <%# Eval("ProductName") %> x <%# Eval("Quantity") %>
                                </div>
                                <div class="summary-item-value">
                                    RM <%# (Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity"))).ToString("0.00") %>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    
                    <div class="summary-item">
                        <div class="summary-item-title">Subtotal</div>
                        <div class="summary-item-value">RM <asp:Label ID="lblSubtotal" runat="server"></asp:Label></div>
                    </div>
                    
                    <div class="summary-item">
                        <div class="summary-item-title">Shipping</div>
                        <div class="summary-item-value">RM <asp:Label ID="lblShipping" runat="server"></asp:Label></div>
                    </div>
                    
                    <div class="summary-item summary-total">
                        <div class="summary-item-title">Total</div>
                        <div class="summary-item-value">RM <asp:Label ID="lblTotal" runat="server"></asp:Label></div>
                    </div>
                </div>
                
                <div class="checkout-actions">
                    <a href="ArtisanCart.aspx" class="back-to-cart">← Back to Cart</a>
                    <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" CssClass="place-order-btn" OnClick="btnPlaceOrder_Click" />
                </div>
                
                <asp:Label ID="lblMessage" runat="server" CssClass="message" Visible="false"></asp:Label>
            </div>
        </div>
    </div>
</asp:Content>