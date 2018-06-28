<%@ Page Language="C#" Title="Accueil" AutoEventWireup="true" CodeFile="Default1.aspx.cs" Inherits="Default1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Default</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />

    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <link href="css/weather-icons.min.css" rel="stylesheet" />

    <link href="css/dibaw.min.css" rel="stylesheet" />
    <link href="css/dem.min.css" rel="stylesheet" />
    <link href="css/typicons.min.css" rel="stylesheet" />
    <link href="css/animate.min.css" rel="stylesheet" />

    <script type="text/javascript" src="js/skins.min.js"></script>

</head>
<body>
    <form runat="server">
        <div class="loading-container">
            <div class="loader"></div>
        </div>
        <div class="navbar">
            <div class="navbar-inner">
                <div class="navbar-container">
                    <div class="navbar-header pull-left">
                        <a href="Default.aspx" class="navbar-brand">
                            <small>
                                <img src="img/logo.png" alt="" />
                            </small>
                        </a>
                    </div>
                    <div class="sidebar-collapse" id="sidebar-collapse">
                        <i class="collapse-icon fa fa-bars"></i>
                    </div>
                    <div class="navbar-header pull-right">
                        <div class="navbar-account">
                            <ul class="account-area">
                                <li>
                                    <a class="dropdown-toggle" title="Logout" onclick="bootbox.confirm({ message: 'Voulez-vous vraiment quitter votre session ?' , callback: function (result) { if (result) { __doPostBack('Disconnect'); } }, title: app_name})">
                                        <i class="icon fa fa-sign-out" style="font-size: 27px; cursor: pointer"></i>
                                    </a>


                                </li>


                                <li>
                                    <a class="login-area dropdown-toggle" data-toggle="dropdown">
                                        <div class="iconfa" title="View my data">
                                            <i class="icon fa fa-user"></i>
                                        </div>

                                        <section>
                                            <h2><span class="profile"><span><%= _userProfile %> </span></span></h2>
                                        </section>
                                    </a>
                                    <ul class="pull-right dropdown-menu dropdown-arrow dropdown-messages">

                                        <li>
                                            <a href="#">
                                                <i class="icon fa fa-user message-avatar" style="font-size: 27px;"></i>
                                                <div class="message">
                                                    <span class="message-sender">
                                                        <%= _userFullName %> 
                                                    </span>
                                                </div>
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                            <div class="setting">
                                <a id="btn-setting" title="Settings" href="#">
                                    <i class="icon glyphicon glyphicon-cog"></i>
                                </a>
                            </div>
                            <div class="setting-container">
                                <label>
                                    <input type="checkbox" id="checkbox_fixednavbar">
                                    <span class="text">Fixed Navbar</span>
                                </label>
                                <label>
                                    <input type="checkbox" id="checkbox_fixedsidebar">
                                    <span class="text">Fixed SideBar</span>
                                </label>
                                <label>
                                    <input type="checkbox" id="checkbox_fixedbreadcrumbs">
                                    <span class="text">Fixed BreadCrumbs</span>
                                </label>
                                <label>
                                    <input type="checkbox" id="checkbox_fixedheader">
                                    <span class="text">Fixed Header</span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="main-container container-fluid">
            <div class="page-container">
                <div class="page-sidebar" id="sidebar">
                    <div class="sidebar-header-wrapper">
                        <input type="text" class="searchinput" />
                        <i class="searchicon fa fa-search" onclick="javascript: alert('module de recherche à mettre en place'); return false;"></i>
                        <div class="searchhelper">Rechercher des projets...</div>
                    </div>
                    <ul class='nav sidebar-menu'>
                        <li><a href="Dashboard.aspx" class='menu-dropdown'><i class="menu-icon glyphicon glyphicon-dashboard"></i><span class="menu-text">DASHBOARD</span></a></li>
                        <li><a href="#" class='menu-dropdown'><i class="menu-icon fa fa-table"></i><span class="menu-text">PROJETS</span><i class="menu-expand"></i></a>
                            <ul class='submenu'>
                                <li><a href="projets.aspx"><i class="menu-icon glyphicon glyphicon-plus-sign"></i><span class="menu-text">Ajout de projets</span></a></li>
                                <li><a href="projets-liste.aspx"><i class="menu-icon glyphicon glyphicon-list"></i><span class="menu-text">Liste</span></a></li>
                            </ul>
                        </li>
                        <li><a href="#" class='menu-dropdown'><i class="menu-icon fa fa-book"></i><span class="menu-text">RAPPORTS</span><i class="menu-expand"></i></a>
                            <ul class='submenu'>
                                <li><a href="#" class='menu-dropdown'><i class="menu-icon glyphicon glyphicon-stats"></i><span class="menu-text">Rapport 1</span><i class="menu-expand"></i></a>
                                    <ul class='submenu'>
                                        <li><a href="#.aspx"><i class="menu-icon glyphicon glyphicon-stats"></i><span class="menu-text">Sous-Rapport 1</span></a></li>
                                        <li><a href="#.aspx"><i class="menu-icon glyphicon glyphicon-stats"></i><span class="menu-text">Sous-Rapport 2</span></a></li>
                                    </ul>
                                </li>
                                <li><a href="#" class='menu-dropdown'><i class="menu-icon glyphicon glyphicon-stats"></i><span class="menu-text">Rapport 2 </span><i class="menu-expand"></i></a>
                                    <ul class='submenu'>
                                        <li><a href="#.aspx"><i class="menu-icon glyphicon glyphicon-stats"></i><span class="menu-text">Sous-Rapport 2</span></a></li>
                                        <li><a href="#.aspx"><i class="menu-icon glyphicon glyphicon-stats"></i><span class="menu-text">Sous-Rapport 2</span></a></li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <li><a href="#" class='menu-dropdown'><i class="menu-icon fa fa-map-marker"></i><span class="menu-text">CARTOGRAPHIE</span><i class="menu-expand"></i></a>
                            <ul class='submenu'>
                                <li><a href="#" class='menu-dropdown'><i class="menu-icon glyphicon glyphicon-stats"></i><span class="menu-text">Cartes</span><i class="menu-expand"></i></a>
                                    <ul class='submenu'>
                                        <li><a href="#.aspx"><i class="menu-icon glyphicon glyphicon-stats"></i><span class="menu-text">Carte 1</span></a></li>
                                        <li><a href="#.aspx"><i class="menu-icon glyphicon glyphicon-stats"></i><span class="menu-text">Carte 2</span></a></li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <li><a href="#" class='menu-dropdown'><i class="menu-icon fa fa-gears"></i><span class="menu-text">PARAMETRAGE</span><i class="menu-expand"></i></a>
                            <ul class='submenu'>
                                <li><a href="devises.aspx"><i class="menu-icon glyphicon glyphicon-euro"></i><span class="menu-text">Devise</span></a></li>
                                <li><a href="#" class='menu-dropdown'><i class="menu-icon fa fa-database"></i><span class="menu-text">Financement</span><i class="menu-expand"></i></a>
                                    <ul class='submenu'>
                                        <li><a href="sources.aspx"><i class="menu-icon glyphicon glyphicon-stats"></i><span class="menu-text">Sources</span></a></li>
                                        <li><a href="instruments.aspx"><i class="menu-icon glyphicon glyphicon-stats"></i><span class="menu-text">Instruments</span></a></li>
                                    </ul>
                                </li>
                                <li><a href="#" class='menu-dropdown'><i class="menu-icon fa fa-table"></i><span class="menu-text">Intervention</span><i class="menu-expand"></i></a>
                                    <ul class='submenu'>
                                        <li><a href="secteurs.aspx"><i class="menu-icon glyphicon glyphicon-stats"></i><span class="menu-text">Secteurs</span></a></li>
                                        <li><a href="soussecteurs.aspx"><i class="menu-icon glyphicon glyphicon-stats"></i><span class="menu-text">Sous-Secteurs</span></a></li>
                                    </ul>
                                </li>
                                <li><a href="#" class='menu-dropdown'><i class="menu-icon fa fa-map-marker"></i><span class="menu-text">Localités</span><i class="menu-expand"></i></a>
                                    <ul class='submenu'>
                                        <li><a href="regions.aspx"><i class="menu-icon glyphicon glyphicon-map-marker"></i><span class="menu-text">Région</span></a></li>
                                        <li><a href="cercles.aspx"><i class="menu-icon glyphicon glyphicon-map-marker"></i><span class="menu-text">Cercle</span></a></li>
                                        <li><a href="communes.aspx"><i class="menu-icon glyphicon glyphicon-map-marker"></i><span class="menu-text">Commune</span></a></li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <li><a href="#" class='menu-dropdown'><i class="menu-icon fa fa-table"></i><span class="menu-text">ADMINISTRATION</span><i class="menu-expand"></i></a>
                            <ul class='submenu'>
                                <li><a href="#" class='menu-dropdown'><i class="menu-icon glyphicon glyphicon-edit"></i><span class="menu-text">Profil</span><i class="menu-expand"></i></a>
                                    <ul class='submenu'>
                                        <li><a href="ajout-profil.aspx"><i class="menu-icon fa fa-plus"></i><span class="menu-text">Ajout</span></a></li>
                                        <li><a href="liste-profil.aspx"><i class="menu-icon fa fa-list"></i><span class="menu-text">Liste</span></a></li>
                                    </ul>
                                </li>
                                <li><a href="#" class='menu-dropdown'><i class="menu-icon glyphicon glyphicon-tasks"></i><span class="menu-text">Accès</span><i class="menu-expand"></i></a>
                                    <ul class='submenu'>
                                        <li><a href="ajout-acces.aspx"><i class="menu-icon fa fa-plus"></i><span class="menu-text">Ajout</span></a></li>
                                        <li><a href="liste-acces.aspx"><i class="menu-icon fa fa-list"></i><span class="menu-text">Liste</span></a></li>
                                    </ul>
                                </li>

                                <li><a href="#" class='menu-dropdown'><i class="menu-icon glyphicon glyphicon-user"></i><span class="menu-text">utilisateur</span><i class="menu-expand"></i></a>
                                    <ul class='submenu'>
                                        <li><a href="ajout-user.aspx"><i class="menu-icon fa fa-plus"></i><span class="menu-text">Ajout</span></a></li>
                                        <li><a href="liste-user.aspx"><i class="menu-icon fa fa-list"></i><span class="menu-text">Liste</span></a></li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <li><a href="#" class='menu-dropdown'><i class="menu-icon fa fa-image"></i><span class="menu-text">MEDIA</span></a></li>
                        <li><a href="#" class='menu-dropdown'><i class="menu-icon fa fa-calendar-o"></i><span class="menu-text">CALENDRIER</span></a></li>
                    </ul>
                </div>
                <div class="page-content">
                    <div class="page-breadcrumbs">
                        <ul class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-home"></i>
                                <a href="Default.aspx">Welcome</a>
                            </li>

                        </ul>
                    </div>
                    <div class="page-header position-relative">
                        <div class="header-title">
                            <h1>ContactHub in Lebanon
                            </h1>
                        </div>
                        <div class="header-buttons">
                            <a class="sidebar-toggler" title="Hide the left sidebar" href="#">
                                <i class="fa fa-arrows-h"></i>
                            </a>
                            <a class="refresh" id="refresh-toggler" title="Refresh the page" href="">
                                <i class="glyphicon glyphicon-refresh"></i>
                            </a>
                            <a class="fullscreen" id="fullscreen-toggler" title="Full screen" href="#">
                                <i class="glyphicon glyphicon-fullscreen"></i>
                            </a>
                        </div>
                    </div>
                    <div class="page-body">
                        <div class="row">
                            <div class="col-lg-12 col-sm-12 col-xs-12">
                                <div class="row">
                                    <div class="col-lg-12 col-sm-12 col-xs-12">
                                        <h3><b><%= _userFullName %>  </b>, Welcome to your session</h3>
                                        <h6>Today  <%= StrToday %>  </h6>
                                        <div class="well bordered-left bordered-themeprimary" style="opacity: 0.9; margin-top: 25px">
                                            <p>
                                                <b>HAB</b> ContactHub is designed to be a support in the management of the  
                                                address used for the Humanitarian activies and action in Lebnon. 
                                            </p>

                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" id="homeback"></div>
                    </div>
                </div>

            </div>
        </div>

        <script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/slimscroll/jquery.slimscroll.min.js"></script>

        <script type="text/javascript" src="js/dibaw.js"></script>
        <script type="text/javascript" src="js/bootbox.js"></script>
        <script type="text/javascript" src="js/doAppmin.js"></script>

        <script type="text/javascript" src="js/charts/sparkline/jquery.sparkline.js"></script>
        <script type="text/javascript" src="js/charts/sparkline/sparkline-init.js"></script>

        <script type="text/javascript" src="js/charts/easypiechart/jquery.easypiechart.js"></script>
        <script type="text/javascript" src="js/charts/easypiechart/easypiechart-init.js"></script>

        <script type="text/javascript" src="js/charts/chartjs/Chart.js"></script>
        <script type="text/javascript" src="js/charts/chartjs/chartjs-init.js"></script>
    </form>
</body>
</html>

