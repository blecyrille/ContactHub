<%@ Page Title="" Language="C#" MasterPageFile="~/immain.Master" AutoEventWireup="true" CodeFile="ContactList - Copy.aspx.cs" Inherits="ContactList" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageHeadPlaceHolder" runat="server">
    <script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
    <title>Contact List </title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="PageHeaderTitlePlaceHolder" runat="server">
    <div class="header-title">
        <h1>Management of Contact List
        </h1>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageBodyPlaceHolder" runat="server">

    <div class="row">
        <div class="col-lg-6 col-sm-6 col-xs-12">
            <asp:UpdatePanel ID="UpdatePanel"
                UpdateMode="Conditional"
                runat="server">
                <ContentTemplate>
                    <div class="alert alert-success fade in" id="global_success" runat="server" visible="false">
                        <button class="close" title="Close the alert" data-dismiss="alert">
                            ×
                        </button>
                        <i class="fa-fw fa fa-check"></i>
                        <strong>
                            <asp:Literal ID="global_success_msg" runat="server"></asp:Literal></strong>
                    </div>

                    <div class="alert alert-danger fade in" id="global_error" runat="server" visible="false">
                        <button class="close" title="Close the alert" data-dismiss="alert">
                            ×
                        </button>
                        <i class="fa-fw fa fa-times"></i>
                        <strong>Error ! </strong>
                        <asp:Literal ID="global_error_msg" runat="server"></asp:Literal>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12 col-sm-12 col-xs-12">
            <div class="form-group " style="float: right">
                <asp:UpdatePanel ID="UpCopy" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="BtnCopyEmail" EventName="Click" />
                    </Triggers>
                    <ContentTemplate>
                        <asp:LinkButton ID="BtnCopyEmail" runat="server" OnClick="BtnCopyEmail_Click" CssClass="btn btn-blue-eu"> <i class="fa fa-print"></i> Copy Email </asp:LinkButton>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12 col-sm-12 col-xs-12">
            <div class="widget">
                <div class="widget-header ">
                    <span class="widget-caption this-search-widget-caption">Search</span>
                </div>
                <asp:UpdatePanel ID="upSearch" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="BtnSearch" EventName="Click" />
                    </Triggers>
                    <ContentTemplate>
                        <div class="widget-body">
                            <div>
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="form-group ">
                                            <asp:TextBox ID="txtSearch" runat="server" type="text"
                                                class="form-control" placeholder="">
                                            </asp:TextBox>
                                        </div>
                                    </div>

                                    <div class="col-sm-2">
                                        <asp:Button ID="BtnSearch" CssClass="btn btn-default" UseSubmitBehavior="false" runat="server" OnClick="BtnSearch_Click" Text="Search" />
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group ">

                                            <div class="input-group date">
                                                <div class="input-group-addon">
                                                    <i class="fa fa-map-marker" style="color: #3c8dbc"></i>
                                                </div>
                                                <asp:DropDownList runat="server" ID="ddlSectorInterest" class="form-control select2"
                                                    OnSelectedIndexChanged="ddlSectorInterest_Changed"
                                                    AutoPostBack="true"
                                                    data-bv-regexp="true">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-sm-3">
                                        <div class="form-group ">

                                            <div class="input-group date">
                                                <div class="input-group-addon">
                                                    <i class="fa fa-map-marker" style="color: #3c8dbc"></i>
                                                </div>
                                                <asp:DropDownList runat="server" ID="ddlAreaInterest" class="form-control select2"
                                                    OnSelectedIndexChanged="ddlAreaInterest_Changed"
                                                    AutoPostBack="true"
                                                    data-bv-regexp="true">
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>


    <div class="row">
        <div class="col-lg-12 col-sm-12 col-xs-12">
            <div class="well with-header with-footer">
                <asp:UpdatePanel ID="upCrudGrid" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div class="header bordered-blueberry this-search-widget-caption">
                            <div style="float: left">List of Contacts</div>
                            <div style="float: right">Total : <span style="color: red"><%=l%> </span>Contacts </div>
                        </div>
                        <div runat="server" id="no_data">
                            <asp:Label ID="NoDatalbl" class="h3" runat="server"></asp:Label>
                        </div>
                        <asp:GridView
                            ID="EntGridView"
                            runat="server"
                            AutoGenerateColumns="False"
                            OnRowCommand="EntGridView_RowCommand"
                            AllowPaging="true"
                            OnRowDataBound="EntGridView_RowDataBound"
                            DataKeysName="ModuleID"
                            PageSize="10"
                            Style="font-size: 14px"
                            OnPreRender="EntGridView_PreRender"
                            OnPageIndexChanging="EntGridView_PageIndexChanging"
                            CssClass="table table-striped table-bordered table-hover  ">

                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Left"
                                    HeaderText="Sector">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="SubscriberID" Value='<%# Bind("SubscriberID") %>' runat="server" />
                                        <asp:HiddenField ID="InterestID" Value='<%# Bind("InterestID") %>' runat="server" />
                                        <asp:Label ID="SectorInterestName" runat="server" Text='<%# Bind("SectorInterestName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Left"
                                    HeaderText="Area">
                                    <ItemTemplate>
                                        <asp:Label ID="AreaInterestName" runat="server" Text='<%# Bind("AreaInterestName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Left"
                                    HeaderText="Full Name">
                                    <ItemTemplate>
                                        <asp:Label ID="SubscriberFullName" runat="server" Text='<%# Bind("SubscriberFullName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Left"
                                    HeaderText="Email">
                                    <ItemTemplate>
                                        <asp:Label ID="SubscriberEmail" runat="server" Text='<%# Bind("SubscriberEmail") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Left"
                                    HeaderText="Title">
                                    <ItemTemplate>
                                        <asp:Label ID="SubscriberTitle" runat="server" Text='<%# Bind("SubscriberTitle") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="Left"
                                    HeaderText="Organization">
                                    <ItemTemplate>
                                        <asp:Label ID="SubscriberOrganization" runat="server" Text='<%# Bind("SubscriberOrganization") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Left"
                                    HeaderText="Contact">
                                    <ItemTemplate>
                                        <asp:Label ID="SubscriberContact" runat="server" Text='<%# Bind("SubscriberContact") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Left"
                                    HeaderText="Address">
                                    <ItemTemplate>
                                        <asp:Label ID="SubscriberAddress" runat="server" Text='<%# Bind("SubscriberAddress") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="ACTIONS" HeaderStyle-Width="12%">
                                    <ItemTemplate>
                                        <div class="row-command-preview" style="text-align: center">
                                            <asp:LinkButton ID="BtnEdit" runat="server" CommandArgument="<%# Container.DataItemIndex %>" CssClass="btn btn-default btn-xs purple" CommandName="view" Text="Update"><i class="fa fa-edit"></i>  View</asp:LinkButton>
                                            <asp:LinkButton ID="BtnDelete" runat="server" CommandArgument="<%# Container.DataItemIndex %>" CssClass="btn btn-default btn-xs red" CommandName="deleting" Text="Delete"><i class="fa fa-trash-o"></i>  Remove</asp:LinkButton>

                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>


                            </Columns>

                            <PagerStyle HorizontalAlign="Center" CssClass="pagination-ys" />
                            <PagerSettings Position="Bottom"
                                Mode="Numeric"
                                FirstPageText="First"
                                LastPageText="Last"
                                NextPageText="Next"
                                PreviousPageText="Prev" />

                        </asp:GridView>
                    </ContentTemplate>
                    <Triggers></Triggers>
                </asp:UpdatePanel>

                <div class="footer">
                    Execution time :
                    <asp:Literal ID="execTimeLit" runat="server"></asp:Literal>
                </div>

                <div id="addEdiModal" class="bootbox modal fade modal-silver in" tabindex="-1" role="dialog" style="display: none;" aria-hidden="true">
                    <asp:UpdatePanel ID="upEdit" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                        <%--<Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="EntGridView" EventName="RowCommand" />
                        </Triggers>--%>
                        <ContentTemplate>
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                        <h4 class="modal-title">ContactHub</h4>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="col-lg-12 col-sm-12 col-xs-12">

                                                <div class="alert alert-danger fade in" id="Edit_global" runat="server" visible="false">
                                                    <button class="close" title="Close the alert" data-dismiss="alert">
                                                        ×
                                                    </button>
                                                    <i class="fa-fw fa fa-check"></i>
                                                    <strong>
                                                        <asp:Literal ID="Edit_global_alert_msg" runat="server"></asp:Literal></strong>
                                                </div>

                                            </div>
                                        </div>
                                        <span class="alert-header darker">View Contact Information</span>
                                        <div>
                                            <div class="row">
                                                <div class="col-lg-6 col-sm-12 col-xs-12">
                                                    <div class="form-group">
                                                        <label for="txtSectorInterestName">
                                                            Sector
                                                        </label>
                                                        <div class="form-group">
                                                            <asp:TextBox ID="txtSectorInterestName" runat="server" type="text"
                                                                class="form-control" ReadOnly="true">
                                                            </asp:TextBox>

                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-lg-6 col-sm-12 col-xs-12">
                                                    <div class="form-group">
                                                        <label for="txtAreaInterestName">
                                                            Area
                                                        </label>
                                                        <div class="form-group">
                                                            <asp:TextBox ID="txtAreaInterestName" runat="server" type="text"
                                                                class="form-control" ReadOnly="true">
                                                            </asp:TextBox>

                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="col-lg-6 col-sm-12 col-xs-12">
                                                    <div class="form-group">
                                                        <label for="txtSubscriberFullName">
                                                            Full Name
                                                        </label>
                                                        <div class="form-group">
                                                            <asp:TextBox ID="txtSubscriberFullName" runat="server" type="text"
                                                                class="form-control" ReadOnly="true">
                                                            </asp:TextBox>

                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-6 col-sm-12 col-xs-12">
                                                    <div class="form-group">
                                                        <label for="txtSubscriberEmail">
                                                            Email
                                                        </label>
                                                        <div class="form-group">
                                                            <asp:TextBox ID="txtSubscriberEmail" runat="server" type="text"
                                                                class="form-control" placeholder=""
                                                                ReadOnly="true">
                                                            </asp:TextBox>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-6 col-sm-12 col-xs-12">
                                                    <div class="form-group">
                                                        <label for="txtSubscriberTitle">
                                                            Title
                                                        </label>
                                                        <div class="form-group">
                                                            <asp:TextBox ID="txtSubscriberTitle" runat="server" type="text"
                                                                class="form-control" placeholder=""
                                                                ReadOnly="true">
                                                            </asp:TextBox>

                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-6 col-sm-12 col-xs-12">
                                                    <div class="form-group">
                                                        <label for="txtSubscriberOrganization">
                                                            Organization
                                                        </label>
                                                        <div class="form-group">
                                                            <asp:TextBox ID="txtSubscriberOrganization" runat="server" type="text"
                                                                class="form-control" placeholder=""
                                                                ReadOnly="true">
                                                            </asp:TextBox>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-6 col-sm-12 col-xs-12">
                                                    <div class="form-group">
                                                        <label for="txtSubscriberContact">
                                                            Phone Contact
                                                        </label>
                                                        <div class="form-group">
                                                            <asp:TextBox ID="txtSubscriberContact" runat="server" type="text"
                                                                class="form-control" placeholder=""
                                                                ReadOnly="true">
                                                            </asp:TextBox>

                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-6 col-sm-12 col-xs-12">
                                                    <div class="form-group">
                                                        <label for="txtSubscriberAddress">
                                                            Address
                                                        </label>
                                                        <div class="form-group">
                                                            <asp:TextBox ID="txtSubscriberAddress" runat="server" type="text"
                                                                class="form-control" placeholder=""
                                                                ReadOnly="true">
                                                            </asp:TextBox>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <%--  <div class="row">
                                                 <div class="col-lg-6 col-sm-12 col-xs-12">
                                                    <div class="form-group">
                                                        <label for="txtInterestStatus">
                                                            Active
                                                        </label>
                                                        <div class="form-group">
                                                            <asp:TextBox ID="txtInterestStatus" runat="server" type="text"
                                                                class="form-control" placeholder=""
                                                                ReadOnly="true">
                                                            </asp:TextBox>

                                                        </div>
                                                    </div>
                                                </div>
                                                
                                            </div>--%>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-default" data-dismiss="modal" aria-hidden="true">Cancel</button>
                                </div>
                            </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <div id="copyEmailModal" class="bootbox modal fade modal-silver in" tabindex="-1" role="dialog" style="display: none;" aria-hidden="true">
                    <asp:UpdatePanel ID="upEmail" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                        <ContentTemplate>
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                        <h4 class="modal-title">ContactHub</h4>
                                    </div>
                                    <div class="modal-body">
                                        <span class="alert-header darker">COPY THE SELECTED EMAILS</span>
                                        <div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group">

                                                        <CKEditor:CKEditorControl ID="CKEmail" runat="server"></CKEditor:CKEditorControl>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-default" data-dismiss="modal" aria-hidden="true">Exit</button>
                                </div>
                            </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <div id="deleteModal" class="bootbox modal fade modal-silver in" tabindex="-1" role="dialog" style="display: none;" aria-hidden="true">

                    <asp:UpdatePanel ID="upDel" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="BtnDelete" EventName="Click" />
                        </Triggers>
                        <ContentTemplate>
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                        <h4 class="modal-title">ContactHub Lebanon</h4>
                                    </div>
                                    <div class="modal-body">
                                        <asp:Label ID="lblDeletemessage" runat="server" Text="This subscriber will be removed from your contact list. Please confirm"></asp:Label>
                                    </div>
                                    <div class="modal-footer">
                                        <asp:Button ID="BtnDelete" UseSubmitBehavior="false" type="button" CssClass="btn btn-danger" runat="server" Text="Remove" OnClick="BtnDelete_Click" />
                                        <button class="btn btn-default" data-dismiss="modal" aria-hidden="true">Cancel</button>
                                    </div>

                                </div>
                                <!-- /.modal-content -->
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>



            </div>


        </div>


    </div>
    <script type="text/javascript" src="https://cdn.ckeditor.com/4.5.7/standard/ckeditor.js"></script>
    <script type="text/javascript">
        $(function () {
            // Replace the <textarea id="editor1"> with a CKEditor
            // instance, using default configuration.
            CKEDITOR.replace('ContentPlaceHolder1_Sheetaction');
            CKEDITOR.replace('ContentPlaceHolder1_sheetDesc');


            //bootstrap WYSIHTML5 - text editor
            $(".textarea").wysihtml5();
        });
    </script>


</asp:Content>
