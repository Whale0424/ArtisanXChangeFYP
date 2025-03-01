<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ArtisanFAQ.aspx.cs" Inherits="ArtisanXChange.ArtisanFAQ" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>FAQ - ArtisanXChange</title>

    <style>

        body {
            background-color: #F9F8F3;
        }

        .container {
            padding: 20px;
            width: 50%;
            margin: auto;
            margin-bottom: 50px;
            display: flex;
            flex-direction: column;
            text-align: justify;
            align-items: center;
        }

        .title {
            font-size: 3rem;
            margin-bottom: 20px;
        }

        .wrapper {
            width: 100%;
            margin-bottom: 10px;
        }

        .question {
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
            background-color: #122620;
            color: white;
            padding: 15px;
            font-size: 18px;
            border-radius: 5px;
        }

        .answer {
            display: none;
            background-color: #122620;
            color: white;
            padding: 15px;
            margin-top: 5px;
            border-radius: 5px;
        }

        .dropDownIcon {
            width: 20px;
            height: 20px;
            transition: transform 0.3s ease;
        }

        .active .dropDownIcon {
            transform: rotate(180deg);
        }

        .active + .answer {
            display: block;
        }
    </style>
    <script>
        function toggleAnswer(element) {
            element.classList.toggle("active");
        }
    </script>
    </asp:Content>
    <asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
         <div class="container">
            <h1 class="title">FAQs</h1>

                <h2>Shipping</h2>

                <br/>

                <div class="wrapper">
                    <div class="question" onclick="toggleAnswer(this)">
                        <h3>How much does the delivery cost?</h3>
                        <img src="image/dropdownArt.png" alt="drop down button" class="dropDownIcon">
                    </div>
                    <div class="answer">
                        <p>RM 8 for West Malaysia, RM 15 for East Malaysia. Free shipping for purchase from RM100 and Above across Malaysia</p>
                    </div>
                </div>

                <div class="wrapper">
                     <div class="question" onclick="toggleAnswer(this)">
                         <h3>How long does it takes to ship the items? </h3>
                         <img src="image/dropdownArt.png" alt="drop down button" class="dropDownIcon">
                     </div>
                     <div class="answer">
                         <p>ArtisanXChange will process your order within 24 hours and will ship within the next 24 hours.
                            Item will be delivered to yout doorstep the next 3-5 days (Malaysia) 
                             / within 7 working days (International). </p>
                     </div>
                 </div>

                <h2>Return / Exchange</h2>

                <br />

                <div class="wrapper">
                    <div class="question" onclick="toggleAnswer(this)">
                        <h3>What is your return policy?</h3>
                        <img src="image/dropdownArt.png" alt="drop down button" class="dropDownIcon">
                    </div>
                    <div class="answer">
                        <p>To be eligible for a return, your item must be in the same condition as when you received it—unworn, unused, with tags, and in its original packaging. 
                           A receipt or proof of purchase is also required.</p>
                    </div>
                </div>

                <div class="wrapper">
                    <div class="question" onclick="toggleAnswer(this)">
                        <h3>What should I do if I receive a damaged item?</h3>
                        <img src="image/dropdownArt.png" alt="drop down button" class="dropDownIcon">
                    </div>
                    <div class="answer">
                        <p>If your product arrives damaged to the extent that it is unusable, 
                           please provide us with photos for inspection. 
                            We give utmost attention to our products and packaging to ensure they arrive safely.</p>
                    </div>
                </div>

                <div class="wrapper">
                    <div class="question" onclick="toggleAnswer(this)">
                        <h3>Do you offers refund?</h3>
                        <img src="image/dropdownArt.png" alt="drop down button" class="dropDownIcon">
                    </div>
                    <div class="answer">
                        <p>No refunds are provided. All sales are final. Exchanges are only available for damaged items. </p>
                    </div>
                </div>

                <div class="wrapper">
                    <div class="question" onclick="toggleAnswer(this)">
                        <h3>Can I exchange an item?</h3>
                        <img src="image/dropdownArt.png" alt="drop down button" class="dropDownIcon">
                    </div>
                    <div class="answer">
                        <p>Exchange are available under certain conditions:</p>
                        <p> - The item must be unused and in original packaging.</p>
                        <p> - A receipt or a history of purchase is required.</p>    
                    </div>
                </div>

                 <h2>Contact Us?</h2>
        
                 <br />

                 <div class="wrapper">
                     <div class="question" onclick="toggleAnswer(this)">
                         <h3>How to contact us?</h3>
                         <img src="image/dropdownArt.png" alt="drop down button" class="dropDownIcon">
                     </div>
                     <div class="answer">
                         <p>You can contatc us via:</p>
                         <p>- Tel: 017-9919231</p>
                         <p>- theartisanxchangeart@gmail.com</p>
             </div>
         </div>
    </div>
</asp:Content>
