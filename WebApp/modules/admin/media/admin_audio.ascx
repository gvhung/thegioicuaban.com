﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="admin_audio.ascx.cs"
    Inherits="WebApp.modules.admin.media.admin_audio" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<script type="text/javascript" src="<%# Request.Url.Host.ToString() %>/scripts/js/RunFlashPlayer.js"> </script>
<script type="text/javascript">
    //Reference of the GridView. 
    var TargetBaseControl = null;
    //Total no of checkboxes in a particular column inside the GridView.
    var CheckBoxes;
    //Total no of checked checkboxes in a particular column inside the GridView.
    var CheckedCheckBoxes;
    //Array of selected item's Ids.
    var SelectedItems;
    //Hidden field that wil contain string of selected item's Ids separated by '|'.
    var SelectedValues;

    window.onload = function () {
        //Get reference of the GridView. 
        try {
            TargetBaseControl = document.getElementById('<%= this.GridView1.ClientID %>');
        }
        catch (err) {
            TargetBaseControl = null;
        }

        //Get total no of checkboxes in a particular column inside the GridView.
        try {
            CheckBoxes = parseInt('<%= this.GridView1.Rows.Count %>');
        }
        catch (err) {
            CheckBoxes = 0;
        }

        //Get total no of checked checkboxes in a particular column inside the GridView.
        CheckedCheckBoxes = 0;

        //Get hidden field that wil contain string of selected item's Ids separated by '|'.
        SelectedValues = document.getElementById('<%= this.hdnFldSelectedValues.ClientID %>');

        //Get an array of selected item's Ids.
        if (SelectedValues.value == '')
            SelectedItems = new Array();
        else
            SelectedItems = SelectedValues.value.split('|');

        //Restore selected CheckBoxes' states.
        if (TargetBaseControl != null)
            RestoreState();
    }

    function HeaderClick(CheckBox) {
        //Get all the control of the type INPUT in the base control.
        var Inputs = TargetBaseControl.getElementsByTagName('input');

        //Checked/Unchecked all the checkBoxes in side the GridView & modify selected items array.
        for (var n = 0; n < Inputs.length; ++n)
            if (Inputs[n].type == 'checkbox' && Inputs[n].id.indexOf('chkBxSelect', 0) >= 0) {
                Inputs[n].checked = CheckBox.checked;
                if (CheckBox.checked)
                    SelectedItems.push(document.getElementById(Inputs[n].id.replace('chkBxSelect', 'hdnFldId')).value);
                else
                    DeleteItem(document.getElementById(Inputs[n].id.replace('chkBxSelect', 'hdnFldId')).value);
            }

        //Update Selected Values. 
        SelectedValues.value = SelectedItems.join('|');

        //Reset Counter
        CheckedCheckBoxes = CheckBox.checked ? CheckBoxes : 0;
    }

    function ChildClick(CheckBox, HCheckBox, Id) {
        //Modifiy Counter;            
        if (CheckBox.checked && CheckedCheckBoxes < CheckBoxes)
            CheckedCheckBoxes++;
        else if (CheckedCheckBoxes > 0)
            CheckedCheckBoxes--;

        //Change state of the header CheckBox.
        if (CheckedCheckBoxes < CheckBoxes)
            HCheckBox.checked = false;
        else if (CheckedCheckBoxes == CheckBoxes)
            HCheckBox.checked = true;

        //Modify selected items array.
        if (CheckBox.checked)
            SelectedItems.push(Id);
        else
            DeleteItem(Id);

        //Update Selected Values. 
        SelectedValues.value = SelectedItems.join('|');
    }

    function RestoreState() {
        //Get all the control of the type INPUT in the base control.
        var Inputs = TargetBaseControl.getElementsByTagName('input');

        //Header CheckBox
        var HCheckBox = null;

        //Restore previous state of the all checkBoxes in side the GridView.
        for (var n = 0; n < Inputs.length; ++n)
            if (Inputs[n].type == 'checkbox' && Inputs[n].id.indexOf('chkBxSelect', 0) >= 0)
                if (IsItemExists(document.getElementById(Inputs[n].id.replace('chkBxSelect', 'hdnFldId')).value) > -1) {
                    Inputs[n].checked = true;
                    CheckedCheckBoxes++;
                }
                else
                    Inputs[n].checked = false;
            else if (Inputs[n].type == 'checkbox' && Inputs[n].id.indexOf('chkBxHeader', 0) >= 0)
                HCheckBox = Inputs[n];

        //Change state of the header CheckBox.
        if (CheckedCheckBoxes < CheckBoxes)
            HCheckBox.checked = false;
        else if (CheckedCheckBoxes == CheckBoxes)
            HCheckBox.checked = true;
    }

    function DeleteItem(Text) {
        var n = IsItemExists(Text);
        if (n > -1)
            SelectedItems.splice(n, 1);
    }

    function IsItemExists(Text) {
        for (var n = 0; n < SelectedItems.length; ++n)
            if (SelectedItems[n] == Text)
                return n;

        return -1;
    }     
</script>
<%----- ModalPopupExtender JavaScript -------%>
<script type="text/javascript">
    var add_url = '<%=add_url %>';
    var edit_url = '<%=edit_url %>';
    var loading_url = '<%=loading_url %>';

    function ShowAddModal() {
        var frame = $get('IframeAdd');
        frame.src = add_url;
        $find('AddModalPopup').show();
    }

    function AddCancelScript() {
        var frame = $get('IframeAdd');
        frame.src = loading_url;
    }

    function AddOkayScript() {
        RefreshDataGrid();
        AddCancelScript();
    }

    function ShowModalEdit() {
        //Get hidden field that wil contain string of selected item's Ids separated by '|'.
        var SelectedValues = document.getElementById('<%= this.hdnFldSelectedValues.ClientID %>').value;
        if (SelectedValues != '') {
            if (SelectedItems.length == 1) {
                var frame = $get('IframeEdit');
                frame.src = edit_url + SelectedValues;
                $find('EditModalPopup').show();
            } else {
                alert('Vui lòng chỉ check chọn 1 item để edit');
            }
        }
    }

    function ShowEditModal(idx) {
        var frame = $get('IframeEdit');
        frame.src = edit_url + idx;
        $find('EditModalPopup').show();
    }

    function EditCancelScript() {
        var frame = $get('IframeEdit');
        frame.src = loading_url;
    }

    function EditOkayScript() {
        RefreshDataGrid();
        EditCancelScript();
    }

    function RefreshDataGrid() {
        $get('btnReload').click();
    }

    

</script>
<div class="wrap_gp">
    <div class="commontool">
        <h3>
            Quản lý Audio</h3>
        <div class="toolbar">
            <asp:LinkButton ID="btnAdd" runat="server" CssClass="btn" OnClientClick="ShowAddModal();return false;"><span class="icon-32-new"></span>Thêm</asp:LinkButton>
            <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn" OnClientClick="ShowModalEdit();return false;"><span class="icon-32-edit"></span>Sửa</asp:LinkButton>
            <asp:LinkButton ID="btnReload" runat="server" CssClass="btn" OnClick="btnReload_Click"
                Visible="false"><span class="icon-32-unpublish"></span>Reload</asp:LinkButton>
            <asp:HiddenField ID="hdnFldSelectedValues" runat="server" />
        </div>
    </div>
    <div class="group_commands">
        <div class="left">
        </div>
        <div class="right">
            <div class="fillter_tool">
                Phân Nhóm&nbsp;<asp:DropDownList ID="ddlMediaTypeList" runat="server" CssClass="combobox" OnSelectedIndexChanged="ddlMediaTypeList_SelectedIndexChanged">
                </asp:DropDownList>
                &nbsp; Topic:
                <asp:DropDownList ID="ddlMediaTopicList" runat="server" CssClass="combobox" OnSelectedIndexChanged="ddlMediaTopicList_SelectedIndexChanged">
                </asp:DropDownList>
                &nbsp; Status:
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="combobox" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                </asp:DropDownList>
            </div>
        </div>
    </div>
    <div style="clear: both;">
    </div>
    <div class="group_panel">
    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
        <Triggers>
            <asp:PostBackTrigger ControlID="ddlMediaTypeList" />
            <asp:PostBackTrigger ControlID="ddlMediaTopicList" />
            <asp:PostBackTrigger ControlID="ddlStatus" />
        </Triggers>
        <ContentTemplate>
            <asp:GridView ID="GridView1" DataKeyNames="FileId" runat="server" AllowPaging="True" ShowHeaderWhenEmpty="true"
                Width="100%" Height="100%" AllowSorting="True" AutoGenerateColumns="False" BackColor="White"
                BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" EmptyDataText="No Data"
                ForeColor="Black" GridLines="Vertical" ShowFooter="False" EnableModelValidation="True"
                OnPageIndexChanged="GridView1_SelectedIndexChanged" OnRowCancelingEdit="GridView1_RowCancelingEdit"
                OnRowEditing="GridView1_RowEditing" OnSelectedIndexChanged="GridView1_SelectedIndexChanged"
                OnSelectedIndexChanging="GridView1_SelectedIndexChanging" OnDataBound="GridView1_DataBound"
                OnPageIndexChanging="GridView1_PageIndexChanging" OnRowDataBound="GridView1_RowDataBound"
                OnSorting="GridView1_Sorting" OnRowDeleting="GridView1_RowDeleting">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>
                    <asp:TemplateField HeaderText="x">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtIdx" runat="server" Text='<%# Bind("FileId") %>' Width="30px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkBxSelect" runat="server" />
                            <asp:HiddenField ID="hdnFldId" runat="server" Value='<%# Eval("FileId") %>' />
                        </ItemTemplate>
                        <HeaderTemplate>
                            <asp:CheckBox ID="chkBxHeader" onclick="javascript:HeaderClick(this);" runat="server" />
                        </HeaderTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="FileId" HeaderText="FileId" />
                    <asp:BoundField DataField="TopicId" HeaderText="TopicId" />
                    <asp:BoundField DataField="FileName" HeaderText="FileName" />
                    <asp:BoundField DataField="FileUrl" HeaderText="FileUrl" />
                    <asp:BoundField DataField="Title" HeaderText="Title" />
                    <asp:TemplateField HeaderText="Preview" >
                        <ItemTemplate>
                            <asp:Label ID="lblPlayer" runat="server"></asp:Label>                        
                            <%--<object type="application/x-shockwave-flash" data='https://prac-gadget.googlecode.com/svn/branches/dewplayer.swf?mp3=<%# Eval("FileName") == DBNull.Value || Eval("FileName") =="" ? Eval("FileUrl", "{0}") : String.Format("/user_files/media/audio/{0}/{1}", Eval("TopicId"), Eval("FileName")) %>' width="63"
                                height="20">
                                <param name="wmode" value="transparent" />
                                <param name="movie" value='https://prac-gadget.googlecode.com/svn/branches/dewplayer.swf?mp3=<%# Eval("FileName") == DBNull.Value || Eval("FileName") =="" ? Eval("FileUrl", "{0}") : String.Format("/user_files/media/audio/{0}/{1}", Eval("TopicId"), Eval("FileName")) %>' />                                                                                  
                                <param name="FlashVars" value='mp3=<%# Eval("FileName") == DBNull.Value || Eval("FileName") =="" ? Eval("FileUrl", "{0}") : String.Format("/user_files/media/audio/{0}/{1}", Eval("TopicId"), Eval("FileName")) %>' />
                                <embed src='https://prac-gadget.googlecode.com/svn/branches/dewplayer.swf?mp3=<%# Eval("FileName") == DBNull.Value || Eval("FileName") =="" ? Eval("FileUrl", "{0}") : String.Format("/user_files/media/audio/{0}/{1}", Eval("TopicId"), Eval("FileName")) %>' quality="high" bgcolor="CCCCCC" width="200" height="20" 
                                name="dewplayer" wmode="transparent" align="middle" allowScriptAccess="sameDomain" 
                                type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer">
                                </embed>
                            </object>--%>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtStatus" runat="server" Text='<%# Bind("Status") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnDelete" runat="server" CausesValidation="false" CommandName="Delete"
                                CommandArgument='<%# Bind("FileId") %>' ImageUrl="~/images/icons/btnDelete.gif"
                                Text="btnDelete" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    No Data</EmptyDataTemplate>
                <PagerTemplate>
                    <asp:ImageButton ID="imgBtnFirst" runat="server" ImageUrl="~/images/Icons/arrow_first.png"
                        CommandArgument="First" CommandName="Page" Height="22px" Width="26px" />
                    <asp:ImageButton ID="imgBtnPrev" runat="server" ImageUrl="~/images/Icons/arrow_previous.png"
                        CommandArgument="Prev" CommandName="Page" Height="23px" Width="29px" />
                    Page
                    <asp:DropDownList ID="ddlPages" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlPages_SelectedIndexChanged">
                    </asp:DropDownList>
                    of
                    <asp:Label ID="lblPageCount" runat="server"></asp:Label>
                    <asp:ImageButton ID="imgBtnNext" runat="server" ImageUrl="~/images/Icons/arrow_next.png"
                        CommandArgument="Next" CommandName="Page" Height="21px" Width="27px" />
                    <asp:ImageButton ID="imgBtnLast" runat="server" ImageUrl="~/images/Icons/arrow_last.png"
                        CommandArgument="Last" CommandName="Page" Height="21px" Width="31px" />
                </PagerTemplate>
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</div>
<%----------------------------- ModalPopupExtender_Add -------------------------------------%>
<ajaxToolkit:ModalPopupExtender ID="btnAdd_ModalPopupExtender" BackgroundCssClass="ModalPopupBG"
    runat="server" CancelControlID="btnCancel" OkControlID="btnOk" TargetControlID="btnAdd"
    PopupControlID="Panel1" Drag="true" PopupDragHandleControlID="PopupHeader" OnCancelScript="AddCancelScript"
    OnOkScript="ShowAddModal();" BehaviorID="AddModalPopup">
</ajaxToolkit:ModalPopupExtender>
<div class="popup_Buttons" style="display: none">
    <input id="btnOk" value="Done" type="button" />
    <input id="btnCancel" value="Cancel" type="button" />
</div>
<div id="Panel1" style="display: none;" class="popupConfirmation">
    <iframe id="IframeAdd" frameborder="0" width="900" height="600" scrolling="no"></iframe>
</div>
<%----------------------------- ModalPopupExtender_Edit -------------------------------------%>
<asp:Button ID="ButtonEdit" runat="server" Text="Edit" Style="display: none" />
<ajaxToolkit:ModalPopupExtender ID="btnEdit_ModalPopupExtender" BackgroundCssClass="ModalPopupBG"
    runat="server" CancelControlID="ButtonEditCancel" OkControlID="ButtonEditDone"
    TargetControlID="ButtonEdit" PopupControlID="DivEditWindow" OnCancelScript="EditCancelScript();"
    OnOkScript="EditOkayScript();" BehaviorID="EditModalPopup">
</ajaxToolkit:ModalPopupExtender>
<div class="popup_Buttons" style="display: none">
    <input id="ButtonEditDone" value="Done" type="button" />
    <input id="ButtonEditCancel" value="Cancel" type="button" />
</div>
<div id="DivEditWindow" style="display: none;" class="popupConfirmation">
    <iframe id="IframeEdit" frameborder="0" width="900" height="600" scrolling="no">
    </iframe>
</div>
