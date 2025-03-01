<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ArtisanFeedback.aspx.cs" Inherits="ArtisanXChange.ArtisanFeedback" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Feedback - ArtisanXchange</title>

    <style>
         .page_container {
            height: auto;
            display: flex;
            justify-content: space-between;
            padding: 40px;
        }

        .left_container {
            width: 45%;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: rgba(99, 99, 99, 0.2) 0px 2px 8px;
        }

        .right_container {
            width: 50%;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: rgba(99, 99, 99, 0.2) 0px 2px 8px;
        }

        .form_group {
            margin-bottom: 20px;
        }

        .form_group label {
            font-size: 1.2rem;
            display: block;
            margin-bottom: 5px;
        }

        .input_field {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1rem;
        }

        .btnSubmit {
            width: 100%;
            padding: 10px;
            border: none;
            background-color: #122620;
            color: #F9F8F3;
            font-size: 1.2rem;
            border-radius: 5px;
            cursor: pointer;
        }

        .message {
            margin-top: 10px;
            font-size: 1.1rem;


        }

        input::placeholder, textarea::placeholder {
            font-family: inherit;
            font-size: 1rem;
            color: #888; /* Adjust color to match other placeholders */
            opacity: 1; /* Ensure it's fully visible */
        }


    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page_container">
        <div class="left_container">
            <h2>Contact Us</h2>
            <br />
            <p>If you have any inquiries, feel free to reach out to us.</p>
            <br/>
            <p><strong>Email:</strong> theartisanxchangeart@gmail.com</p>
            <br/>
            <p><strong>Phone:</strong> 017-9919231</p>
            <br/>
            <p><strong>Address:</strong> Second floor SK24, Central Market, Lot 4.04-4.06, Jalan Hang Kasturi,
                City Centre, 50050 Kuala Lumpur, 
                Wilayah Persekutuan Kuala Lumpur</p>
        </div>

        <div class="right_container">
            <h2>Customer Feedback Form</h2>
            
            <div class="form_group">
                <label for="txtLocalCustName">Name</label>
                <asp:TextBox ID="txtName" CssClass="input_field" runat="server" placeholder="Enter your name"></asp:TextBox>
            </div>

            <div class="form_group">
                <label for="txtLocalCustContactNumber">Contact Number</label>
                <asp:TextBox ID="txtContactNumber" CssClass="input_field" runat="server" placeholder="Enter your contact number"></asp:TextBox>
            </div>

            <div class="form_group">
                <label for="txtLocalCustEmail">Email</label>
                <asp:TextBox ID="txtEmail" CssClass="input_field" runat="server" TextMode="Email" placeholder="Enter your email"></asp:TextBox>
            </div>

            <div class="form_group">
                <label for="txtLocalCustFeedback">Leave us a message</label>
                <asp:TextBox ID="txtFeedback" CssClass="input_field" runat="server" TextMode="MultiLine" placeholder="Write your message here"></asp:TextBox>
            </div>

            <asp:Button ID="btnLocalFormSubmit" CssClass="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" Width="710px" />
            <asp:Label ID="lblMessage" runat="server" CssClass="message" ></asp:Label>
        </div>
    </div>
</asp:Content>
