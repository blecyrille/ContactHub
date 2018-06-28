using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
//using System.Web.Mail;
using System.IO;

using System.Net.Mime;

using System.Configuration;
using System.Net.Mail;
using System.Net;
using System.Text;

/// <summary>
/// Summary description for clsEmail
/// </summary>
public class clsEmail
{
	public clsEmail()
	{
		//
		// TODO: Add constructor logic here
		//
	}


    //public Boolean EmailConfig(string template, MailMessage oMail, string strEmailFrom)
    //{
    //    oMail.IsBodyHtml = true;
    //    //    msg.Body = template;

    //    oMail.Priority = MailPriority.High;	// enumeration
    //    oMail.Body = template;

    //    oMail.From = new MailAddress(strEmailFrom, "");
    //    SmtpClient ss = new SmtpClient();

    //    ss.Host = "smtp.sendgrid.net";
    //    ss.EnableSsl = true;
    //    ss.Port = 465;
    //    ss.Timeout = 50000;
    //    ss.DeliveryMethod = SmtpDeliveryMethod.Network;
    //    ss.UseDefaultCredentials = false;
    //    ss.Credentials = new NetworkCredential(strEmailFrom, "");

    //    oMail.DeliveryNotificationOptions = DeliveryNotificationOptions.OnFailure;
    //    ss.Send(oMail);

    //    return true;

    //}

    public Boolean EmailConfig(string template, MailMessage msg)
    {
        msg.IsBodyHtml = true;
        msg.Priority = MailPriority.High;
        msg.Body = template;

        msg.From = new MailAddress("lebbeia@unhcr.org", "Inter-Agency Coordination Lebanon");
        SmtpClient smtpClient = new SmtpClient("smtp.sendgrid.net", Convert.ToInt32(587));
        smtpClient.EnableSsl = true;
        smtpClient.UseDefaultCredentials = false;
        smtpClient.Timeout = 10000;
        smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
        System.Net.NetworkCredential credentials = new System.Net.NetworkCredential("apikey", "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");
        smtpClient.Credentials = credentials;

        smtpClient.Send(msg);
        return true;

    }


}