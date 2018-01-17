<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="NTUGTLoveCarrier.Default" %>

<!DOCTYPE HTML>
<html prefix='og: http://ogp.me/ns#'>

<head>
    <meta property="og:title" content="【台大吉他社103級 民歌傳情-琴不自禁】" />
    <meta property="og:type" content="Website" />
    <meta property="og:url" content="http://love.ntuguitar.com/" />
    <meta property="og:image" content="http://love.ntuguitar.com/images/meta-img.jpg" />
    <meta property="og:description" content="【傳情週：5/02 - 5/06， 網路點歌：4/17 - 4/28】說不出口的話好多，既然巧克力、琉璃、棉花糖都可以用來傳情，這一次就讓我們用一首歌曲傳達你的心意！" />
    <meta property="og:site_name" content="台大吉他社103級 民歌傳情" />
    <meta property='article:author' content='https://www.facebook.com/ntuguitarlove' />

    <title>NTUGuitar - Music Delivery</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="/images/icon.jpg" rel="SHORTCUT ICON" />
    <!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
    <link rel="stylesheet" href="/Content/font-awesome/css/font-awesome.min.css" />
    <link rel="stylesheet" href="/CSS/mainpage.css" />
    <link rel="stylesheet" href="/CSS/swipebox.min.css" />
    <!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
    <!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
    <!-- Scripts -->
    <script src="/Scripts/jquery-2.2.1.min.js"></script>
    <script src="/Scripts/jquery.dropotron.min.js"></script>
    <script src="/Scripts/jquery.scrolly.min.js"></script>
    <script src="/Scripts/jquery.scrollgress.min.js"></script>
    <script src="/Scripts/skel.min.js"></script>
    <script src="/Scripts/util.js"></script>
    <script src="/Scripts/jquery.swipebox.min.js"></script>
    <!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
    <script src="/Scripts/Custom/HomeScript.js"></script>

    <script>
        $(document).ready(function () {
            if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
                var h = $('#banner').height();
                $('#banner').height(h);
            }

            $('.swipebox-video').swipebox();

            //alert('民歌傳情選歌正式結束，5/2-5/6為傳情週，讓我們把你妳的心意唱給他她聽!\n\n2016台大吉他社民歌傳情 琴不自禁');
        });

        $(window).resize(function () {
            setIframeHeight(document.getElementById('VideoClipIframe'));
        });
        $(window).load(function () {
            setIframeHeight(document.getElementById('VideoClipIframe'));
        });

        function setIframeHeight(iframe) {
            if (iframe) {
                var iframeWin = iframe.contentWindow || iframe.contentDocument.parentWindow;
                if (iframeWin.document.body) {
                    iframe.height = iframeWin.document.documentElement.scrollHeight || iframeWin.document.body.scrollHeight;
                }
            }
        };
    </script>
</head>

<body class="index">
    <div id="page-wrapper">
        <!-- Header -->
        <header id="header" class="alt">
            <h2 id="logo">
                <a href="/">2016 Music Delivery</a><a>&nbsp;|&nbsp;</a><a href="https://www.facebook.com/ntuguitar/" target="_parent"><span>NTU Guitar 2016</span></a>
            </h2>
            <nav id="nav">
                <ul>

                    <li class="submenu">
                        <a>Menu</a>
                        <ul>
                            <%--<li class="submenu">
                                <a><span class="icon fa-music"></span>&nbsp;開始選歌&nbsp<i class="fa fa-angle-right"></i></a>
                                <ul>
                                    <li><a href="/time"><span class="icon fa-clock-o"></span>&nbsp;&nbsp;時段選歌</a></li>
                                    <li><a href="/category"><span class="icon fa-sitemap"></span>&nbsp;分類選歌</a></li>
                                    <li><a href="/team"><span class="icon fa-user"></span>&nbsp;&nbsp;歌手選歌</a></li>
                                </ul>
                            </li>--%>
                            <li><a href="/time"><span class="icon fa-clock-o"></span>&nbsp;Time</a></li>
                            <li><a href="/category"><span class="icon fa-sitemap"></span>&nbsp;Catetory</a></li>
                            <li><a href="/team"><span class="icon fa-user"></span>&nbsp;Guitarist</a></li>
                            <li><a href="query"><span class="icon fa-book"></span>&nbsp;Query</a></li>
                            <%--<li><a href="#"><span class="icon fa-microphone"></span>&nbsp;&nbsp;歌手專區(未開放)</a></li>--%>
                        </ul>
                    </li>
                    <li class="current"><a href="/">Home</a></li>
                    <li class="current"><a href="https://www.facebook.com/ntuguitarlove/" target="_parent">Facebook <span class="icon fa-facebook-square" /></a></li>
                    <!-- <li><a href="#" class="special">Sign Up</a></li> -->
                </ul>
            </nav>
        </header>
        <!-- Banner -->
        <section id="banner">
            <!--
                        ".inner" is set up as an inline-block so it automatically expands
                        in both directions to fit whatever's inside it. This means it won't
                        automatically wrap lines, so be sure to use line breaks where
                        appropriate (<br />).
                    -->
            <div class="inner">
                <!-- <header>
                                    <h2>NTU GUITAR</h2>
                </header> -->
                <img src="/images/Title.png" style="max-width: 70%; margin-bottom: -1em;">
                <h3>Order: 4/17 - 4/28 | Deviver: 5/2 - 5/6</h3>
                <footer>
                    <ul class="buttons">
                        <li><a href="#guide" class="button scrolly" style="background-color: rgba(0,0,0,0.3);"><span class="icon fa-envelope"></span>&nbsp;Procedure</a></li>
                        <li><a href="#choose" class="button scrolly" style="background-color: rgba(0,0,0,0.3);"><span class="icon fa-music"></span>&nbsp;Order</a></li>
                        <li><a href="#lookup" class="button scrolly" style="background-color: rgba(0,0,0,0.3);"><span class="icon fa-book"></span>&nbsp;Query</a></li>
                    </ul>
                </footer>
            </div>
        </section>
        <!-- Main -->
        <article id="guide">
            <!-- One -->
            <section class="wrapper style2 special-alt">
                <div class="row 50%">
                    <div class="12u 12u(narrower) important(narrower)">
                        <header class="major">
                            <h1><span class="icon fa-envelope">Procedure</span></h1>
                        </header>
                        <a class="image featured">
                            <img src="/images/flow.png" style="max-width: 1250px; display: block; margin: auto;" alt="" /></a>
                        <footer>
                            <ul class="buttons">
                                <li><a href="#choose" class="button scrolly" style="background-color: rgba(0,0,0,0.15);"><span class="icon fa-music"></span>&nbsp;Start ordering</a></li>
                            </ul>
                        </footer>
                    </div>
                    <!--<div class="1u 12u(narrower)"></div>
                    <div class="2u 12u(narrower) icons">
                        <ul class="featured-icons">
                            <li>
                                <span class="icon fa-clock-o"></span>
                                <h3 style="margin: -1em 0 0 0;"> 時段選歌</h3>
                            </li>
                            <li>
                                <span class="icon fa-sitemap"></span>
                                <h3 style="margin: -1em 0 0 0;"> 分類選歌</h3>
                            </li>
                            <li>
                                <span class="icon fa-user"></span>
                                <h3 style="margin: -1em 0 0 0;"> 歌手選歌</h3>
                            </li>
                        </ul>
                    </div>-->
                </div>
            </section>
        </article>
        <article id="choose">
            <section class="wrapper style1 container special">
                <header class="major">
                    <h1><span class="icon fa-music"></span>&nbsp;Choose a song<br style="display: none" />(three options)</h1>
                </header>
                <div class="row">
                    <div class="4u 12u(narrower)">
                        <section>
                            <span class="icon featured fa-clock-o"></span>
                            <header>
                                <h2>Time</h2>
                            </header>
                        </section>
                        <p>
                            5/2(Mon.) - 5/6(Fri.)
                        </p>
                        <a href="/time" class="button"><span class="icon fa-clock-o"></span>&nbsp;time</a>
                    </div>
                    <div class="4u 12u(narrower)">
                        <section>
                            <span class="icon featured fa-sitemap"></span>
                            <header>
                                <h2 style="position: relative">Category
                                    <small style="position: absolute; top: 10px; font-size: 15px; letter-spacing: 0; font-weight: 700; color: #FF2255; /* border: 1px solid; */">(New!)</small>
                                </h2>
                            </header>
                            <p>Friend / Lover / Prank / Teacher / Other</p>
                            <a href="/category" class="button"><span class="icon fa-sitemap"></span>&nbsp;category</a>
                        </section>
                    </div>
                    <div class="4u 12u(narrower)">
                        <section>
                            <span class="icon featured fa-user"></span>
                            <header>
                                <h2 style="position: relative">Guitarist
                                <small style="position: absolute; top: 10px; font-size: 15px; letter-spacing: 0; font-weight: 700; color: #6759F9; /* border: 1px solid; */">(Cool!)</small>
                                </h2>
                            </header>
                            <p>65 Guitarists</p>
                            <a href="/team" class="button"><span class="icon fa-user"></span>&nbsp;guitarist</a>
                        </section>
                    </div>
                </div>
            </section>
            <header class="special container">
                <h2>We deliver messages from our <strong>hands</strong> to your <strong>hearts</strong></h2>
                <span class="icon fa-music"></span>
                <!-- <p></p> -->
            </header>
        </article>
        <article id="clips">
            <section class="container wrapper style3 special" style="overflow: auto;">
                <header class="major">
                    <h1><span class="icon fa-play-circle-o"></span>
                        <br style="display: none" />
                        Clips</h1>
                </header>

                <%--<ul class="pgwSlider">
                    <li>
                        <img src="/Images/VideoRecords/1.jpg" alt="友情" data-description="Eiffel Tower and Champ de Mars"></li>
                    <li>
                        <img src="/Images/VideoRecords/2.jpg" alt="愛情" data-description="Eiffel Tower and Champ de Mars"></li>
                    <li>
                        <img src="/Images/VideoRecords/3.jpg" alt="銃康" data-description="Eiffel Tower and Champ de Mars"></li>
                    <li>
                        <img src="/Images/VideoRecords/4.jpg" alt="師長" data-description="Eiffel Tower and Champ de Mars"></li>
                    <li>
                        <img src="/Images/VideoRecords/5.jpg" alt="另類" data-description="Eiffel Tower and Champ de Mars">
                    </li>
                    <li>
                        <a href="#">
                            <img src="/Images/VideoRecords/5.jpg">
                            <span>New York, NY, USA</span>
                        </a>
                    </li>
                </ul>--%>
                <iframe id="VideoClipIframe" src="/VideoClip.html" frameborder="no" scrolling="no" width="100%"></iframe>
                <div style="display: none">
                    <a class="swipebox-video type0" rel="youtube" href="https://www.youtube.com/watch?v=bGjSnenJ0ms"></a>
                    <a class="swipebox-video type1" rel="youtube" href="https://www.youtube.com/watch?v=NcsVUFr3c_Y"></a>
                    <a class="swipebox-video type2" rel="youtube" href="https://www.youtube.com/watch?v=VwcOBoFwSqM"></a>
                    <a class="swipebox-video type3" rel="youtube" href="https://www.youtube.com/watch?v=qP5FYxl8ZK0"></a>
                    <a class="swipebox-video type4" rel="youtube" href="https://www.youtube.com/watch?v=1VWF7bT3fwg"></a>
                    <a class="swipebox-video type5" rel="youtube" href="https://www.youtube.com/watch?v=oVqAVEZHaZQ"></a>
                    <a class="swipebox-video type6" rel="youtube" href="https://www.youtube.com/watch?v=tQcXNqfNjRM"></a>
                    <a class="swipebox-video type7" rel="youtube" href="https://www.youtube.com/watch?v=l9FuQlpJAjQ"></a>
                    <a class="swipebox-video type8" rel="youtube" href="https://www.youtube.com/watch?v=AB0viiHpcmY"></a>
                    <a class="swipebox-video type9" rel="youtube" href="https://www.youtube.com/watch?v=kw0qERw02mg"></a>
                </div>
            </section>
        </article>
        <section id="lookup">
            <header>
                <h1><strong>Already ordered?</strong></h1>
                <!-- <p>查詢歌手</p> -->
            </header>
            <footer>
                <ul class="buttons">
                    <li><a href="/query" class="button"><span class="icon fa-check"></span>Yes, Query</a></li>
                    <li><a href="#choose" class="button scrolly"><span class="icon fa-close"></span>No, Choose a song</a></li>
                </ul>
            </footer>
        </section>
        <!-- Footer -->
        <footer id="footer">
            <ul class="icons">

                <li><a href="https://www.facebook.com/ntuguitarlove/" target="_parent" class="icon circle fa-heart"><span class="label"></span></a>
                    <p style="display: inline-block; margin-left: 5px;">NTU Guitar Love(Fanpage)</p>
                </li>
                <li><a href="https://www.facebook.com/ntuguitar/" target="_parent" class="icon circle fa-facebook"><span class="label"></span></a>
                    <p style="display: inline-block; margin-left: 5px;">NTU Guitar 2016</p>
                </li>
                <!--<li><a href="#" class="icon circle fa-google-plus"><span class="label">Google+</span></a></li>
                <li><a href="#" class="icon circle fa-github"><span class="label">Github</span></a></li>
                <li><a href="#" class="icon circle fa-dribbble"><span class="label">Dribbble</span></a></li>-->
            </ul>
            <ul class="copyright">
                <li>NTUGUITAR 2016</li>
                <li>Design：康廷宇 Ting-Yu Kang</li>
            </ul>
        </footer>
    </div>
</body>

</html>