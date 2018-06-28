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
using IMDLL;

public partial class Login : System.Web.UI.Page
{
    ModulePageAccess objModulePageAccess = new ModulePageAccess();
    Users objUsers = new Users();
    IMDLL.Profile objProfile = new Profile();
    clsEmail objEmail = new clsEmail();
    clsVariables objVariables = new clsVariables();

    protected void Page_Load(object sender, EventArgs e)
    {

    }


    protected void BtnLogin_Click(object sender, EventArgs e)
    {

        if (string.IsNullOrEmpty(txtUsername.Text) == true || string.IsNullOrEmpty(txtPassword.Text) == true)
        {

            errorSummaryLiteral.Text = "Kindly login with your username and password";
            errorSummaryBox.Visible = true;
        }

        else
        {
            DataTable Dt = objUsers.GetUsers(" where  Username ='" + txtUsername.Text + "'  and  UserPassword ='" + txtPassword.Text + "' AND UserActif=1");
            if (Dt.Rows.Count > 0)
            {
                Session[RunningCache.UserID] = Dt.Rows[0]["UserID"].ToString();
                Session[RunningCache.UserFullName] = Dt.Rows[0]["UserFullName"].ToString();
                Session[RunningCache.UserLogin] = Dt.Rows[0]["UserName"].ToString();
                Session[RunningCache.UserProfile] = Dt.Rows[0]["UserProfile"].ToString();

                //Get the profile of the user
                DataTable dtProfile = objProfile.GetProfile(" where  ProfileID =" + Session[RunningCache.UserProfile].ToString());
                if (dtProfile.Rows.Count > 0)
                {

                    Session[RunningCache.ProfileName] = dtProfile.Rows[0]["ProfileName"].ToString();

                    //string strProfileID = Session[RunningCache.ProfileID].ToString();
                    DataTable DtModulePageAccess = objModulePageAccess.GetModulePageAccess(" where ProfileID=" + Session[RunningCache.UserProfile].ToString());
                    if (DtModulePageAccess.Rows.Count > 0)
                    {
                        Session[RunningCache.DtModulePageAccess] = DtModulePageAccess;
                        Response.Redirect("default.aspx", false);
                    }
                    else
                    {
                        errorSummaryLiteral.Text = "You don't have the profile to access this page, please contact your administrator";
                        errorSummaryBox.Visible = true;
                        Response.Redirect("Register.aspx", false);
                    }
                }
                else
                {
                    errorSummaryLiteral.Text = "You don't have any profile. Please contact your administrator";
                    errorSummaryBox.Visible = true;
                }




            }
            else
            {
                errorSummaryLiteral.Text = "Your username or password is not correct";
                errorSummaryBox.Visible = true;
            }
        }
    }

    //protected void BtnChangePwd_Click(object sender, EventArgs e)
    //{
    //    string strmsg = "";


    //    DataTable DtEmail = objUsers.GetUsers("  where UserMail='" + txtEmail.Value.Trim() + "'");
    //    if (DtEmail.Rows.Count > 0)
    //    {
    //        string Newpwd = GetUniqueKey(6);
    //        objUsers.CustomUpdateUsers("  UserPwd='" + Newpwd + "' where UserMail= '" + txtEmail.Value.Trim() + "'");

    //        SendEmail(txtEmail.Value.Trim(), "MINUSMA Tombouctou Data   Login Details", objUsers.UserIdentifiant, Newpwd);
    //        SendEmail("ble1@un.org", "MINUSMA-Tombouctou Data Login Details", objUsers.UserIdentifiant, Newpwd);

    //        trmsg.Visible = true;
    //        lbmsg.Text = "New Password sent to " + txtEmail.Value.Trim();
    //        txtEmail.Value = "";
    //    }
    //    else
    //    {
    //        trmsgErr.Visible = true;
    //        lbmsgErr.Text = " The Email does not exist in the system";
    //    }
    //}

    //protected void SendEmail(string emailAddress, String Title, string username, string pwd)
    //{
    //    SmtpClient smtp = new SmtpClient();

    //    string MailTemplate = Server.MapPath("~/EmailTemplates/logo.htm");

    //    string template = string.Empty;
    //    if (File.Exists(MailTemplate))
    //    {
    //        template = File.ReadAllText(MailTemplate);
    //    }

    //    template = template.Replace("<%Strename%>", username);
    //    template = template.Replace("<%StrUsername%>", username);
    //    template = template.Replace("<%StrPassword%>", pwd);


    //    //template = template.Replace("<%Overdue%>", paymentDate);

    //    System.Net.Mail.MailMessage msg = new System.Net.Mail.MailMessage();

    //    msg.From = new MailAddress("MINUSMA-DIGITAL-SOLUTIONS@un.org");


    //    msg.To.Add(emailAddress);
    //    msg.Subject = Title;



    //    String logo = Server.MapPath("~/EmailTemplates/logo.png");
    //    System.Net.Mail.AlternateView htmlView = AlternateView.CreateAlternateViewFromString(template, null, "text/html");
    //    LinkedResource pic1 = new LinkedResource(logo, MediaTypeNames.Image.Jpeg);
    //    pic1.ContentId = "logo";
    //    htmlView.LinkedResources.Add(pic1);
    //    msg.AlternateViews.Add(htmlView);
    //    obj_Email.EmailConfig(template, msg, "MINUSMA-BUSINESS-SOLUTIONS@un.org");

    //}

    //public static string GetUniqueKey(int maxSize)
    //{
    //    char[] chars = new char[62];
    //    // chars ="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890".ToCharArray();
    //    chars = "abcdefghijklmnopqrstuvwxyz1234567890".ToCharArray();
    //    byte[] data = new byte[1];
    //    RNGCryptoServiceProvider crypto = new RNGCryptoServiceProvider();
    //    crypto.GetNonZeroBytes(data);
    //    data = new byte[maxSize];
    //    crypto.GetNonZeroBytes(data);
    //    StringBuilder result = new StringBuilder(maxSize);
    //    foreach (byte b in data)
    //    {
    //        result.Append(chars[b % (chars.Length)]);
    //    }
    //    return result.ToString();
    //}

    protected void BtnSubscribe_Click(object sender, EventArgs e)
    {
        Response.Redirect("Subscription.aspx", false);
    }

    protected void BtnForgottenPwd_Click(object sender, EventArgs e)
    {
        Response.Redirect("Subscription.aspx", false);
    }

}