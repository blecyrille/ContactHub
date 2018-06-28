using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Threading;
using System.Web.Mail;
using System.Net.Mime;
using System.Security.Cryptography;
using System.Text;
using System.Net.Mail;
using System.Data.SqlClient;
using System.Data.OleDb;
using System.Data.Common;
using System.Globalization;
using System.Net;
using System.Drawing;
using System.Configuration;
using System.Data.Odbc;
using System.Web.Security;
using IMDLL;

public partial class Default1 : System.Web.UI.Page
{
    public string _userFullName = string.Empty,
                 _userProfile = string.Empty,
                 _userLastLogin = string.Empty, 
                StrToday = string.Empty,
                StrMonth = string.Empty;

    private static string usr;

    protected void Page_Load(object sender, EventArgs e)
    {
        CultureInfo ci = new CultureInfo("en-GB");

        var format = "dd, MMMM  yyyy";

        ClientScript.GetPostBackEventReference(this, string.Empty);

        if (Request.Form["__EVENTTARGET"] == "Disconnect")
        { 
            Disconnect();
        }

        if (Session[RunningCache.UserLogin] == null)
        {
            Disconnect();
        }

        if (!IsPostBack)
        {
            var ss = Session[RunningCache.UserLogin]; 
            if(ss!=null)
            {
                if (!string.IsNullOrEmpty(Session[RunningCache.UserLogin].ToString()))
                {
                    usr = Session[RunningCache.UserLogin].ToString();
                    _userFullName = Session[RunningCache.UserFullName].ToString();
                    _userProfile = Session[RunningCache.ProfileName].ToString();
                    StrMonth = DateTime.Now.ToString("MMMM yyyy",ci).ToUpper();
                    StrToday = DateTime.Now.ToString(format, ci).ToUpper();
                } 
            }
            else
            {
                Disconnect();
            }
            
        }
         
    }
    private void Disconnect()
    {
        try
        {
            FormsAuthentication.SignOut();
            usr = string.Empty;
            Session[RunningCache.UserLogin] = null;
            HttpContext.Current.Response.Redirect("login.aspx", false);

        }
        catch (Exception ex)
        { 
        }


    }
 
}