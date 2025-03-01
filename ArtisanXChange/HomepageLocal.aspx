<%@ Page Title="" Language="C#" EnableViewState="True"  MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="HomepageLocal.aspx.cs" Inherits="ArtisanXChange.HomepageLocal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>ArtisanXChange</title>

    <style>
        .content h1 {
            font-size: 70px;
            margin-top: 0px;
        }

        h1 {
            display: block;
            font-size: 2em;
            margin-block-start: 0.67em;
            margin-block-end: 0.67em;
            margin-inline-start: 0px;
            margin-inline-end: 0px;
            font-weight: bold;
            unicode-bidi: isolate;
        }

        .content p {
            margin-bottom: 30px;
            font-size: 21px;
            font-weight: 100;
            line-height: 25px;
        }

        p {
            display: block;
            margin-block-start: 1em;
            margin-block-end: 1em;
            margin-inline-start: 0px;
            margin-inline-end: 0px;
            unicode-bidi: isolate;
        }

        .content {
            width: 100%;
            position: relative;
            top: 45%;
            transform: translateY(-50%);
            text-align: center;
            color: white;
        }

        .banner {
            width: 100%;
            height: 85vh;
            background-image: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)), url('image/background.jpg');
            background-size: cover;
            background-position: center;
            position: relative;
            overflow: hidden; /* Ensure no overflow */
        }

        .adImg{
            margin-top:-5%;
        }

        .homepagebutton:hover {
            background-color: #FF0066;
        }

        .button_container ul {
            display: flex;
            flex-flow: row;
            justify-content:center;
        }

        .homepagebutton {
            width: 200px;
            padding: 15px 50px;
            text-align: center;
            margin: 20px 10px;
            border-radius: 25px;
            font-size: 20px;
            font-weight: bold;
            border: 2px solid black;
            background: transparent;
            color: white;
            cursor: pointer;
            overflow: hidden;
            display: block;
            text-decoration: none;
        }

        .video-container {
            width: 100%;
            height: 100vh;
            position: relative;
            overflow: hidden;
        }

        video {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .gap {
            margin-bottom:100px;
        }
        /* Style for navigation buttons */
        .prev, .next {
            cursor: pointer;
            position: absolute;
            top: 50%;
            width: auto;
            padding: 16px;
            margin-top: -22px;
            color: white;
            font-weight: bold;
            font-size: 18px;
            transition: 0.6s ease;
            border-radius: 0 3px 3px 0;
            user-select: none;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .prev {
            left: 0;
            border-radius: 3px 0 0 3px;
        }

        .next {
            right: 0;
            border-radius: 3px 0 0 3px;
        }

        .prev:hover, .next:hover {
            background-color: rgba(0,0,0,0.8);
        }

        /* Style for navigation dots */
        .dot {
            cursor: pointer;
            height: 15px;
            width: 15px;
            margin: 0 2px;
            background-color: #bbb;
            border-radius: 50%;
            display: inline-block;
            transition: background-color 0.6s ease;
        }

        .active, .dot:hover {
            background-color: #717171;
        }
        /* Style for slides */
        .slide {
            display: none; /* Hide slides by default */
        }

        .fade {
            animation: fade 0.5s ease-in-out;
        }

        @keyframes fade {
            from {opacity: 0.4}
            to {opacity: 1}
        }
    .auto-style1 {
        width: 100%;
    }
   </style>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            let slideIndex = 1;
            showSlides(slideIndex);
            setInterval(() => plusSlides(1), 5000); // Change slide every 2 seconds

            function plusSlides(n) {
                showSlides(slideIndex += n);
            }

            function currentSlide(n) {
                showSlides(slideIndex = n);
            }

            function showSlides(n) {
                let i;
                let slides = document.getElementsByClassName("slide");
                let dots = document.getElementsByClassName("dot");
                if (n > slides.length) { slideIndex = 1 }
                if (n < 1) { slideIndex = slides.length }
                for (i = 0; i < slides.length; i++) {
                    slides[i].style.display = "none";
                }
                for (i = 0; i < dots.length; i++) {
                    dots[i].className = dots[i].className.replace(" active", "");
                }
                slides[slideIndex - 1].style.display = "block";
                dots[slideIndex - 1].className += " active";
            }

            window.plusSlides = plusSlides;
            window.currentSlide = currentSlide;
        });


    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="banner">
        <div class="content">
            <div class="auto-style1">
                <div class="slide fade">
                    <div class="numbertext">1 / 3</div>
                        <asp:HyperLink ID="Link1" runat="server" NavigateUrl="~/Book.aspx">
                            <asp:Image ID="ImageBook" runat="server" ImageUrl="~/Image/ImageBook.jpg" Width="100%"/>
                         </asp:HyperLink>
                    <div class="text">Caption Text</div>
                </div>

                <div class="slide fade">
                    <div class="numbertext">2 / 3</div>
                        <asp:HyperLink ID="Link2" runat="server" NavigateUrl="~/Sticker.aspx">                        
                            <asp:Image ID="ImageSticker" CssClass="adImg" runat="server" Width="100%" />
                        </asp:HyperLink>
                    <div class="text">Caption Two</div>
                </div>

                <div class="slide fade">
                    <div class="numbertext">3 / 3</div>
                        <asp:HyperLink ID="Link3" runat="server" NavigateUrl="~/Postcard.aspx">
                            <asp:Image ID="ImagePostcard" CssClass="adImg" runat="server" Width="100%" />
                        </asp:HyperLink>
                    <div class="text">Caption Three</div>
                </div>

                 <div class="slide fade">
                    <div class="numbertext">3 / 3</div>
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Others.aspx">
                            <asp:Image ID="ImageOthers" CssClass="adImg" runat="server" Width="100%" />
                        </asp:HyperLink>
                    <div class="text">Caption Three</div>
                </div>

                <!-- Navigation Buttons -->
                <a class="prev" onclick="plusSlides(-1)">❮</a>
                <a class="next" onclick="plusSlides(1)">❯</a>
            </div>

            <!-- Navigation Dots -->
            <div style="text-align:center">
                <asp:Button ID="btnVisit" runat="server" OnClick="btnVisit_Click" PostBackUrl="~/Cart.aspx" Text="Visit Page" />
                <span class="dot" onclick="currentSlide(1)"></span>
                <span class="dot" onclick="currentSlide(2)"></span>
                <span class="dot" onclick="currentSlide(3)"></span>
                <span class="dot" onclick="currentSlide(4)"></span>
              </div>

            <br>

        </div>
    </div>
    <div class="video-container">
        <video autoplay muted loop>
            <source src="Video/video.mp4" type="video/mp4">
            Your browser does not support the video tag.
        </video>
    </div>
</asp:Content>