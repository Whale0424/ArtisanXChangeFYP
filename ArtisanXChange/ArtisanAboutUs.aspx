<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ArtisanAboutUs.aspx.cs" Inherits="ArtisanXChange.ArtisanAboutUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>About Us - ArtisanXChange</title>

    <style>

         body {
             background-color: #F9F8F3;
         }

        .container {
            min-height: 100vh;
            width: 80%;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding-top: 1rem;
            line-height: 1.6;
            font-size: 1.4rem;
        }

        .title {
            font-size: 3rem;
            margin: 0;
        }

        .content {
            text-align: justify;
            padding: 50px;
        }

        .image {
            border-radius: 10px;
            cursor: pointer;
            transition: 0.3s;
            display: block;
            margin: 20px auto;
            height: 300px;
            width: 500px;
        }

        .image:hover {
            opacity: 0.7;
        }

        .abtus-container img {
            width: 100%;
            height: auto; /* Maintains aspect ratio */
            display: block; /* Removes extra space below the image */
        }


        .container {
    min-height: auto; /* Remove the large height */
    padding-top: 0; /* Remove extra padding */
    margin-bottom: 10px; /* Adjust as needed */
}



        .box-container { 
            display: flex; /* Align boxes horizontally */
            justify-content: center; /* Center them */
            gap: 40px; /* Adds space between the boxes */
            margin-top: 10px; /* Adds spacing */
        }

        .box {
            width: 500px; /* Adjust width as needed */
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            text-s
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .box p {
            font-size: 15px; /* Adjust the size as needed */
        }

        h2 {
            font-weight: bold;
            text-align: center;
        }

        p {
            text-align: center; 
        }

        .auto-style1 {
            border-radius: 10px;
            cursor: pointer;
            transition: 0.3s;
            display: block;
            margin: 20px auto;
            height: 453px;
            width: 391px;
        }

        .auto-style2 {
            border-radius: 10px;
            cursor: pointer;
            transition: 0.3s;
            display: block;
            margin: 20px auto;
            height: 351px;
            width: 481px;
        }
        .auto-style3 {
            border-radius: 10px;
            cursor: pointer;
            transition: 0.3s;
            display: block;
            margin: 20px auto;
            height: 370px;
            width: 500px;
        }

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="abtus-container">
        <img src="Image/ArtisanAbtUs.jpg" alt="Sticker"/>
    </div>



    <div class="container">
        <h1 class="title">About Us</h1>
        </div>

        
        <img class="auto-style1" src="image/ArtisanAbtUs2.jpg" alt="ArtisanXChange About Image">
        <div class="content">
            <p>ArtisanXChange is a distinguished cultural brand establised in Malaysia in 2025.</p>
            <br />
            <p>Our philosophy is to provide Malaysian artist with a dedicated marketplace where they can showcase their products, connect with a wider audience and sustain their passion. </p>
            

        </div>

        <img class="auto-style3" src="image/ArtisanAbtUs3.jpg" alt="ArtisanXChange About Image 2">
        <div class="content">
            <p>We are more than just an e-commerce platform - we are thriving community dedicated to celebrate craftmanship, culture and creativity.</p>
            <br />
            <p>ArtisanXChange is committed to supporting local talent by offering a platform that values authenticity, creativity, 
               and cultural heritage, ensuring that every handmade piece tells a unique story.</p>
        </div>

        <img class="auto-style2" src="image/ArtisanAbtUs4.jpg" alt="ArtisanXChange About Image 3">
        <div class="content">
            <h2>Our Goals</h2>
        </div>

        <div class="box-container">
            <div class="box">
                <h3>Increase Visiblity of Local Artisans</h3>
                <p>To provide Malaysian Artists a dedicated platform that allows them to showcase and retail their unique creations.</p>
            </div>

            <div class="box">
                <h3>Cultural Preservations and Education</h3>
                <p>Promote understanding and appreciation of Malaysian culture. Encouraqge the public to  respect the span of local handicrafts and showcasing Malaysia's culture to the world. </p>
            </div>
        </div>

    
<div class="content">
    
</div>

</asp:Content>
