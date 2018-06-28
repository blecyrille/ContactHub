using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using System.Collections.Specialized;
using System.Reflection;
using IMDLL;
using System.Web.Services;
using AjaxControlToolkit;
using System.Diagnostics;
using System.Data.OleDb;
using System.IO;

public partial class ContactList : System.Web.UI.Page
{
    private DataTable d = new DataTable();
    Profile objProfile = new Profile();
    Users objUsers = new Users();
    protected static int l;
    protected static string SectorArea;
    SectorInterest objSectorInterest = new SectorInterest();
    AreaInterest objAreaInterest = new AreaInterest();
      DataTable detail_dt = new DataTable("");
      DataTable dtEmailList = new DataTable("");
    string Strsearch = "";

    Subscriber objSubscriber = new Subscriber();
    Interest objInterest = new Interest();

    protected void Page_Load(object sender, EventArgs e)
    {
        PagesAccess objPagesAccess = new PagesAccess();
        if (objPagesAccess.CheckAccess(Path.GetFileNameWithoutExtension(Page.AppRelativeVirtualPath), Session[RunningCache.UserProfile].ToString()) == true)
        {
            try
            {
                Stopwatch stopWatch = new Stopwatch();
                stopWatch.Start();
                Session[RunningCache.SectorInterestID] = "0";
                Session[RunningCache.AreaInterestID] = "0";

                if (!IsPostBack)
                {
                    if (HttpContext.Current.Session["AlertOn"] != null)
                    {
                        if ((Boolean)HttpContext.Current.Session["AlertOn"] == true)
                        {
                            if (this.global_error.Visible) this.global_error.Visible = false;
                            this.global_success.Visible = true;
                            this.global_success_msg.Text = Mains.Constant.SUCCESS_INSERT;
                        }
                        HttpContext.Current.Session["AlertOn"] = null;
                    }

                    bindgrid(Session[RunningCache.SectorInterestID].ToString(), Session[RunningCache.AreaInterestID].ToString());
                    bindSectorInterest();
                    bindAreaInterest();

                }

                if (this.Edit_global.Visible) this.Edit_global.Visible = false;
               // bindgrid(Session[RunningCache.SectorInterestID].ToString(), Session[RunningCache.AreaInterestID].ToString());
                stopWatch.Stop();
                TimeSpan ts = stopWatch.Elapsed;
                execTimeLit.Text = String.Format("{0:00} minute(s), {1:00} seconde(s), {2:00} milliseconde(s)", ts.Minutes, ts.Seconds, ts.Milliseconds / 10);

            }
            catch (Exception ex)
            {
                if (this.global_success.Visible) this.global_success.Visible = false;
                this.global_error.Visible = true;
                this.global_error_msg.Text = Mains.Constant.GENERAL_ERR;
            }
        }

    }

    protected void bindgrid(string SectorID, string AreaID)
    {
        try
        {
            if (string.IsNullOrEmpty(Strsearch) == false)
            {
                if (SectorID == "0" && AreaID == "0")
                {
                    dtEmailList = objSubscriber.GetSubscriber(" WHERE InterestStatus=1 AND InterestSector IN (SELECT FocalPointsSector FROM GetFocalPoints WHERE "
                                     + " FocalPointsUser=" + Session[RunningCache.UserID] + ") AND InterestArea IN (SELECT FocalPointsArea FROM GetFocalPoints WHERE FocalPointsUser=" + Session[RunningCache.UserID] + ") AND " + Strsearch);
                }
                else if (SectorID != "0" && AreaID == "0")
                {
                    dtEmailList = objSubscriber.GetSubscriber(" WHERE InterestStatus=1 AND InterestSector IN (SELECT FocalPointsSector FROM GetFocalPoints WHERE "
                                     + " FocalPointsSector= " + SectorID + " AND FocalPointsUser=" + Session[RunningCache.UserID] + ") AND InterestArea IN (SELECT FocalPointsArea FROM GetFocalPoints WHERE FocalPointsUser=" + Session[RunningCache.UserID] + ") AND " + Strsearch);

                }
                else if (SectorID == "0" && AreaID != "0")
                {
                    dtEmailList = objSubscriber.GetSubscriber(" WHERE InterestStatus=1 AND InterestSector IN (SELECT FocalPointsSector FROM GetFocalPoints WHERE "
                                     + " FocalPointsUser=" + Session[RunningCache.UserID] + ") AND InterestArea IN (SELECT FocalPointsArea FROM GetFocalPoints WHERE FocalPointsArea=" + AreaID + " AND FocalPointsUser=" + Session[RunningCache.UserID] + ") AND " + Strsearch);

                }
                else if (SectorID != "0" && AreaID != "0")
                {
                    dtEmailList = objSubscriber.GetSubscriber(" WHERE InterestStatus=1 AND InterestSector IN (SELECT FocalPointsSector FROM GetFocalPoints WHERE "
                                     + " FocalPointsSector= " + SectorID + " AND FocalPointsUser=" + Session[RunningCache.UserID] + ") AND InterestArea IN (SELECT FocalPointsArea FROM GetFocalPoints WHERE FocalPointsArea=" + AreaID + " AND FocalPointsUser=" + Session[RunningCache.UserID] + ") AND " + Strsearch);

                }

                Strsearch = "";
                if (dtEmailList == null || dtEmailList.Rows.Count == 0)
                {
                    no_data.Visible = true;
                    l = dtEmailList.Rows.Count;
                    NoDatalbl.Text = "No data found";
                    d.Columns.Clear();
                    d.Rows.Clear();
                    EntGridView.DataSource = d;
                    EntGridView.DataBind();
                    return;
                }

            }
            else
            {
                if (SectorID == "0" && AreaID == "0")
                {
                    dtEmailList = objSubscriber.GetSubscriber(" WHERE InterestStatus=1 AND InterestSector IN (SELECT FocalPointsSector FROM GetFocalPoints WHERE "
                                     + " FocalPointsUser=" + Session[RunningCache.UserID] + ") AND InterestArea IN (SELECT FocalPointsArea FROM GetFocalPoints WHERE FocalPointsUser=" + Session[RunningCache.UserID] + ")");
                }
                else if (SectorID != "0" && AreaID == "0")
                {
                    dtEmailList = objSubscriber.GetSubscriber(" WHERE InterestStatus=1 AND InterestSector IN (SELECT FocalPointsSector FROM GetFocalPoints WHERE "
                                     + " FocalPointsSector= " + SectorID + " AND FocalPointsUser=" + Session[RunningCache.UserID] + ") AND InterestArea IN (SELECT FocalPointsArea FROM GetFocalPoints WHERE FocalPointsUser=" + Session[RunningCache.UserID] + ")");

                }
                else if (SectorID == "0" && AreaID != "0")
                {
                    dtEmailList = objSubscriber.GetSubscriber(" WHERE InterestStatus=1 AND InterestSector IN (SELECT FocalPointsSector FROM GetFocalPoints WHERE "
                                     + " FocalPointsUser=" + Session[RunningCache.UserID] + ") AND InterestArea IN (SELECT FocalPointsArea FROM GetFocalPoints WHERE FocalPointsArea=" + AreaID + " AND FocalPointsUser=" + Session[RunningCache.UserID] + ")");

                }
                else if (SectorID != "0" && AreaID != "0")
                {
                    dtEmailList = objSubscriber.GetSubscriber(" WHERE InterestStatus=1 AND InterestSector IN (SELECT FocalPointsSector FROM GetFocalPoints WHERE "
                                     + " FocalPointsSector= " + SectorID + " AND FocalPointsUser=" + Session[RunningCache.UserID] + ") AND InterestArea IN (SELECT FocalPointsArea FROM GetFocalPoints WHERE FocalPointsArea=" + AreaID + " AND FocalPointsUser=" + Session[RunningCache.UserID] + ")");

                }
            }

            l = dtEmailList.Rows.Count;
            EntGridView.DataSource = dtEmailList;
            Session[RunningCache.dtEmailList] = dtEmailList;
            EntGridView.DataBind();
            EntGridView.Visible = true;
            no_data.Visible = false;
            upCrudGrid.Update();

        }
        catch (Exception ex)
        {
            if (this.global_success.Visible) this.global_success.Visible = false;
            this.global_error.Visible = true;
            this.global_error_msg.Text = Mains.Constant.GENERAL_ERR;
        }
    }
    
    protected void EntGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        // Retrieve row
        GridViewRow row = e.Row;
    }

    protected void EntGridView_PreRender(object sender, EventArgs e)
    {
        try
        {
            EntGridView.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
        catch (Exception ex)
        {
        }
    }

    protected void EntGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            bindgrid(Session[RunningCache.SectorInterestID].ToString(), Session[RunningCache.AreaInterestID].ToString());
            EntGridView.PageIndex = e.NewPageIndex;
            EntGridView.DataBind();
            upCrudGrid.Update();

        }
        catch (Exception ex)
        {
            EntGridView.Controls.Add(new LiteralControl("An error occured; please try again, " + ex));
        }
    }

    protected void EntGridView_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        try
        {
            int index = Convert.ToInt32(e.CommandArgument) % EntGridView.PageSize;
            string HDnID = ((HiddenField)EntGridView.Rows[index].FindControl("SubscriberID")).Value;
            string HDnIntID = ((HiddenField)EntGridView.Rows[index].FindControl("InterestID")).Value;
            string SubscriberFullName = ((Label)EntGridView.Rows[index].FindControl("SubscriberFullName")).Text;
            string SubscriberEmail = ((Label)EntGridView.Rows[index].FindControl("SubscriberEmail")).Text;
            string SubscriberTitle = ((Label)EntGridView.Rows[index].FindControl("SubscriberTitle")).Text;
            string SubscriberOrganization = ((Label)EntGridView.Rows[index].FindControl("SubscriberOrganization")).Text;
            string SubscriberContact = ((Label)EntGridView.Rows[index].FindControl("SubscriberContact")).Text;
            string SubscriberAddress = ((Label)EntGridView.Rows[index].FindControl("SubscriberAddress")).Text;
            string SectorInterestName = ((Label)EntGridView.Rows[index].FindControl("SectorInterestName")).Text;
            string AreaInterestName = ((Label)EntGridView.Rows[index].FindControl("AreaInterestName")).Text;

            Session[RunningCache.SubscriberID] = HDnID;
            Session[RunningCache.InterestID] = HDnIntID;

            if (e.CommandName.Equals("view"))
            {
                try
                {
                    txtSectorInterestName.Text = SectorInterestName;
                    txtAreaInterestName.Text = AreaInterestName;
                    txtSubscriberFullName.Text = SubscriberFullName;
                    txtSubscriberEmail.Text = SubscriberEmail;
                    txtSubscriberTitle.Text = SubscriberTitle;
                    txtSubscriberOrganization.Text = SubscriberOrganization;
                    txtSubscriberContact.Text = SubscriberContact;
                    txtSubscriberAddress.Text = SubscriberAddress;
                    txtSubscriberFullName.Text = SectorInterestName;
                    

                    System.Text.StringBuilder sb = new System.Text.StringBuilder();
                    sb.Append(@"<script type='text/javascript'>");
                    sb.Append("$('#addEdiModal').modal('show');");
                    sb.Append(@"</script>");
                    ToolkitScriptManager.RegisterClientScriptBlock(this, this.GetType(), "addEdiModalScript", sb.ToString(), false);
                    upEdit.Update();
                }
                catch (Exception ex)
                {

                }
            }

            if (e.CommandName.Equals("deleting"))
            {
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("$('#deleteModal').modal('show');");
                sb.Append(@"</script>");
                ToolkitScriptManager.RegisterClientScriptBlock(this, this.GetType(), "DeleteModalScript", sb.ToString(), false);
                upDel.Update();
            }

        }
        catch (Exception ex)
        {

        }
    }

       protected void BtnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            string search_value = ClsTools.Text_Validator(txtSearch.Text.Trim());

            Session[RunningCache.AreaInterestID] = ddlAreaInterest.SelectedValue.ToString();
            Session[RunningCache.SectorInterestID] = ddlSectorInterest.SelectedValue.ToString();

            if (string.IsNullOrEmpty(Session[RunningCache.SectorInterestID].ToString())) Session[RunningCache.SectorInterestID] = "0";
            if (string.IsNullOrEmpty(Session[RunningCache.AreaInterestID].ToString())) Session[RunningCache.AreaInterestID] = "0";

            Strsearch = " (SubscriberAddress LIKE '%" + txtSearch.Text.Trim() + "%' OR SubscriberTitle LIKE '%" + txtSearch.Text.Trim() + "%' OR SubscriberOrganization LIKE '%" + txtSearch.Text.Trim() + "%' OR SubscriberFullName LIKE '%" + txtSearch.Text.Trim() + "%' OR SubscriberEmail LIKE '%" + txtSearch.Text.Trim() + "%' OR AreaInterestName LIKE '%" + txtSearch.Text.Trim() + "%' OR SectorInterestName LIKE '%" + txtSearch.Text.Trim() + "%' )";
            bindgrid(Session[RunningCache.SectorInterestID].ToString(), Session[RunningCache.AreaInterestID].ToString());
        }

        catch (Exception ex)
        {
        }

    }

    protected void bindSectorInterest()
    {
        DataTable dt = objSectorInterest.GetSectorInterest("  where SectorInterestID IN (SELECT FocalPointsSector FROM GetFocalPoints WHERE FocalPointsUser=" + Session[RunningCache.UserID] + ") order by SectorInterestName ");

        DataRow dr = dt.NewRow();
        dr[1] = "All";
        dt.Rows.InsertAt(dr, 0);
        dt.AcceptChanges();

        ddlSectorInterest.DataSource = dt;
        ddlSectorInterest.DataTextField = "SectorInterestName";
        ddlSectorInterest.DataValueField = "SectorInterestID";
        ddlSectorInterest.DataBind();

    }

    protected void bindAreaInterest()
    {
        DataTable dt = objAreaInterest.GetAreaInterest("  where AreaInterestID IN (SELECT FocalPointsArea FROM GetFocalPoints WHERE FocalPointsUser=" + Session[RunningCache.UserID] + ")  order by AreaInterestName ");

        DataRow dr = dt.NewRow();
        dr[1] = "All";
        dt.Rows.InsertAt(dr, 0);
        dt.AcceptChanges();

        ddlAreaInterest.DataSource = dt;
        ddlAreaInterest.DataTextField = "AreaInterestName";
        ddlAreaInterest.DataValueField = "AreaInterestID";
        ddlAreaInterest.DataBind();

    }
    protected void ddlSectorInterest_Changed(object sender, EventArgs e)
    {
        Session[RunningCache.SectorInterestID] = ddlSectorInterest.SelectedValue.ToString();
        Session[RunningCache.AreaInterestID] = ddlAreaInterest.SelectedValue.ToString();

        if (string.IsNullOrEmpty(Session[RunningCache.SectorInterestID].ToString())) Session[RunningCache.SectorInterestID] = "0";
        if (string.IsNullOrEmpty(Session[RunningCache.AreaInterestID].ToString())) Session[RunningCache.AreaInterestID] = "0";
        bindgrid(Session[RunningCache.SectorInterestID].ToString(), Session[RunningCache.AreaInterestID].ToString());
    }

    protected void ddlAreaInterest_Changed(object sender, EventArgs e)
    {
        Session[RunningCache.AreaInterestID] = ddlAreaInterest.SelectedValue.ToString();
        Session[RunningCache.SectorInterestID] = ddlSectorInterest.SelectedValue.ToString();

        if (string.IsNullOrEmpty(Session[RunningCache.SectorInterestID].ToString())) Session[RunningCache.SectorInterestID] = "0";
        if (string.IsNullOrEmpty(Session[RunningCache.AreaInterestID].ToString())) Session[RunningCache.AreaInterestID] = "0";
        bindgrid(Session[RunningCache.SectorInterestID].ToString(), Session[RunningCache.AreaInterestID].ToString());
    }


    protected void BtnCopyEmail_Click(object sender, EventArgs e)
    {
        CKEmail.Text = string.Empty;
        string EmailList = string.Empty;
        DataTable dtEmail = new DataTable();
        DataTable Dt =  HttpContext.Current.Session[RunningCache.dtEmailList] as DataTable  ;
        dtEmail = Dt.DefaultView.ToTable(true, "SubscriberEmail");

        if (dtEmail.Rows.Count > 0)
        {
            foreach (DataRow row in dtEmail.Rows)
            {
                EmailList = EmailList + row["SubscriberEmail"].ToString().Trim() + ";";
            }

        }
        CKEmail.Text = EmailList;
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append(@"<script type='text/javascript'>");
        sb.Append("$('#copyEmailModal').modal('show');");
        sb.Append(@"</script>");
        ToolkitScriptManager.RegisterClientScriptBlock(this, this.GetType(), "copyEmailModalScript", sb.ToString(), false);
        upEmail.Update();
    }

    protected void BtnDelete_Click(object sender, EventArgs e)
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        try
        {

            if (!(objInterest.DeleteInterest(Session[RunningCache.InterestID].ToString())))
            {
                if (this.global_success.Visible) this.global_success.Visible = false;
                this.global_error.Visible = true;
                this.global_error_msg.Text = Mains.Constant.FAIL_CRUD;
                UpdatePanel.Update();
                upCrudGrid.Update();
                upDel.Update();
                bindgrid(Session[RunningCache.SectorInterestID].ToString(), Session[RunningCache.AreaInterestID].ToString());
                sb.Append(@"<script type='text/javascript'>");
                sb.Append("$('#deleteModal').modal('hide');");
                sb.Append(@"</script>");
                ToolkitScriptManager.RegisterClientScriptBlock(this, this.GetType(), "delHideModalScript", sb.ToString(), false);
                return;
            }
            else
            {
                if (this.global_error.Visible) this.global_error.Visible = false;
                this.global_success.Visible = true;
                this.global_success_msg.Text = Mains.Constant.SUCCESS_DELETE;
                UpdatePanel.Update();
                upDel.Update();
                upCrudGrid.Update();
                bindgrid(Session[RunningCache.SectorInterestID].ToString(), Session[RunningCache.AreaInterestID].ToString());

            }

        }

        catch (Exception ex)
        {
        }

        sb.Append(@"<script type='text/javascript'>");

        sb.Append("$('#deleteModal').modal('hide');");

        sb.Append(@"</script>");

        ToolkitScriptManager.RegisterClientScriptBlock(this, this.GetType(), "delHideModalScript", sb.ToString(), false);

    }
}