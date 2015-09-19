﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="apps.ascx.cs" Inherits="WebApp.modules.admin.security.applications.apps" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<script type="text/javascript">
    //variable that will store the id of the last clicked row
    var previousRow;

    function ChangeRowColor(row) {

        //If last clicked row and the current clicked row are same
        if (previousRow == row)
            return; //do nothing

        //If there is row clicked earlier
        else if (previousRow != null)

        //change the color of the previous row back to white
        //document.getElementById(previousRow).style.backgroundColor = "#ffffff";
            document.getElementById(previousRow).style.backgroundColor = "";

        //change the color of the current row to light yellow
        document.getElementById(row).style.backgroundColor = "#FF885F";

        //assign the current row id to the previous row id for next row to be clicked
        previousRow = row;

    }
    //---------------------------------------------------------------------------------
    function DeleteConfirmation() {
        if (confirm("Are you sure you want to delete selected records ?") == true)
            return true;
        else
            return false;
    }

    function UpdateMultipleSortKeyConfirmation() {
        if (confirm("Are you sure you want to update selected records ?") == true)
            return true;
        else
            return false;
    }
    //================================================================================
    //================================================================================
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
            if (Inputs[n].type == 'checkbox' && Inputs[n].id.indexOf('chkBxSelect', 0) >= 0 && Inputs[n].checked) {
                Inputs[n].checked = CheckBox.checked;
                if (CheckBox.checked)
                    SelectedItems.push(document.getElementById(Inputs[n].id.replace('chkBxSelect', 'hdnFldId')).value);
                else {
                    DeleteItem(document.getElementById(Inputs[n].id.replace('chkBxSelect', 'hdnFldId')).value);
                    //alert('Select at least one checkbox!');
                }
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

  <%----------------------------- ModalPopupExtender JavaScript -----------------------------%>                                                                                                                                                                                                                                    
<script language="javascript" type="text/javascript">
    function ShowAddModal() {
        var frame = $get('IframeAdd');
        frame.src = "modules/admin/security/applications/apps_edit.aspx?mode=add";
        $find('AddModalPopup').show();
    }

    function AddCancelScript() {
        var frame = $get('IframeAdd');
        frame.src = "loading.aspx";
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
                var edit_path = "modules/admin/security/applications/apps_edit.aspx?mode=edit&idx=";
                var frame = $get('IframeEdit');
                frame.src = edit_path + SelectedValues;
                $find('EditModalPopup').show();
            } else {
                alert('Vui lòng chỉ check chọn 1 item để edit');
            }
        }
    }

    function ShowEditModal(idx) {
        var frame = $get('IframeEdit');
        var edit_path = "modules/admin/security/applications/apps_edit.aspx?mode=edit&idx=";
        var frame = $get('IframeEdit');
        frame.src = edit_path + idx;
        $find('EditModalPopup').show();
    }


    function EditCancelScript() {
        var frame = $get('IframeEdit');
        frame.src = "loading.aspx";
    }

    function EditOkayScript() {
        RefreshDataGrid();
        EditCancelScript();
    }

    function RefreshDataGrid() {
        $get('btnReload').click();
    }
</script> 



<div class="wrap_gp" > 
   
            <div class="commontool">
                <h3>Quản lý ứng dụng</h3>
                <div class="toolbar">      
                     <asp:LinkButton ID="btnAdd" runat="server" CssClass="btn" OnClientClick="ShowAddModal();return false;"><span class="icon-32-new"></span>Thêm</asp:LinkButton>                                                                                                                         
                     <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn" OnClientClick="ShowModalEdit();return false;"><span class="icon-32-edit"></span>Sửa</asp:LinkButton>                    
                    <asp:LinkButton ID="btnMultipleDelete" runat="server" CssClass="btn" OnClick="btnMultipleDelete_Click"><span class="icon-32-trash"></span>Xóa nhiều dòng</asp:LinkButton>                                                                                    
                    <asp:LinkButton ID="btnReload" runat="server" CssClass="btn" OnClick="btnReload_Click"><span class="icon-32-trash"></span>Reload</asp:LinkButton>                                                                                    

                    <asp:HiddenField ID="hdnFldSelectedValues" runat="server" /> 
                </div>
            </div>              
            <div style="clear:both;">&nbsp;</div>             
            <div class="group_panel" >         
                <asp:GridView ID="GridView1" DataKeyNames="ApplicationId" PageSize="20"  
                    runat="server" AllowPaging="True"  Width="100%"    
                    AllowSorting="True" CssClass="table_list" AutoGenerateColumns="False" 
                    CellPadding="3" EmptyDataText="No Data" GridLines="Both" ShowFooter="false"                                
                onpageindexchanged="GridView1_SelectedIndexChanged" 
                onrowcancelingedit="GridView1_RowCancelingEdit" onrowcreated="GridView1_RowCreated" 
                onrowediting="GridView1_RowEditing"           
                onselectedindexchanged="GridView1_SelectedIndexChanged" 
                onselectedindexchanging="GridView1_SelectedIndexChanging" 
                ondatabound="GridView1_DataBound" 
                onpageindexchanging="GridView1_PageIndexChanging" 
                onrowdatabound="GridView1_RowDataBound" onsorting="GridView1_Sorting" 
                    EnableViewState="False" BackColor="White" BorderColor="#999999" 
                    BorderStyle="Solid" BorderWidth="1px" ForeColor="Black">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>                                                            
                        <asp:TemplateField HeaderText="x">
                            <EditItemTemplate>                                         
                                <asp:TextBox ID="txtIdx" runat="server" Text='<%# Bind("ApplicationId") %>' Width="30px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkBxSelect" runat="server" />
                                <asp:HiddenField ID="hdnFldId" runat="server" Value='<%# Eval("ApplicationId") %>' />
                            </ItemTemplate>
                            <HeaderTemplate>
                                <asp:CheckBox ID="chkBxHeader" onclick="javascript:HeaderClick(this);" runat="server" />
                            </HeaderTemplate>
                        </asp:TemplateField> 
                                        
                        <asp:TemplateField HeaderText="No">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:BoundField DataField="ApplicationId" HeaderText="ApplicationId" Visible="true"/> 
                        <asp:BoundField DataField="ApplicationName" HeaderText="ApplicationName"/>
                        <asp:BoundField DataField="LoweredApplicationName" HeaderText="LoweredApplicationName" />
                        <asp:BoundField DataField="Description" HeaderText="Description"/>                                    
                    </Columns>
                    <EmptyDataTemplate>No Data</EmptyDataTemplate>
                        <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <PagerTemplate>
                        <div class="pagination">
                        <asp:ImageButton ID="imgBtnFirst" runat="server"
                            ImageUrl="~/images/Icons/arrow_first.png"
                            CommandArgument="First" CommandName="Page" Height="22px" Width="26px" />
                            <asp:ImageButton ID="imgBtnPrev" runat="server"
                            ImageUrl="~/images/Icons/arrow_previous.png"
                            CommandArgument="Prev" CommandName="Page" Height="23px" Width="29px" />
                                    Page
                        <asp:DropDownList ID="ddlPages" runat="server"
                            AutoPostBack="True" OnSelectedIndexChanged="ddlPages_SelectedIndexChanged"> </asp:DropDownList> of <asp:Label ID="lblPageCount"
                            runat="server"></asp:Label>
                        <asp:ImageButton ID="imgBtnNext" runat="server"
                            ImageUrl="~/images/Icons/arrow_next.png"
                            CommandArgument="Next" CommandName="Page" Height="21px" Width="27px" />
                        <asp:ImageButton ID="imgBtnLast" runat="server"
                            ImageUrl="~/images/Icons/arrow_last.png"
                            CommandArgument="Last" CommandName="Page" Height="21px" Width="31px" />
                        </div>
                    </PagerTemplate> 
                                   
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                                   
                </asp:GridView> 
            </div>
</div>             
<%----------------------------- ModalPopupExtender_Add -------------------------------------%>                                                                                                  
<ajaxToolkit:ModalPopupExtender ID="btnAdd_ModalPopupExtender" BackgroundCssClass="ModalPopupBG"
    runat="server" OkControlID="btnOkay" CancelControlID="btnCancel" TargetControlID="btnAdd"
    PopupControlID="DivAddWindow" Drag="true" PopupDragHandleControlID="PopupHeader" 
    OnOkScript="ShowAddModal();" OnCancelScript="AddCancelScript" BehaviorID="AddModalPopup">
</ajaxToolkit:ModalPopupExtender>
<div class="popup_Buttons" style="display: none">
    <input id="btnOkay" value="Done" type="button" />
    <input id="btnCancel" value="Cancel" type="button" />
</div>
<div id="DivAddWindow" style="display: none;" class="popupConfirmation">
    <iframe id="IframeAdd" frameborder="0" height="680" width="750" scrolling="no"></iframe>
</div>

<%----------------------------- ModalPopupExtender_Edit -------------------------------------%>    
<asp:Button ID="ButtonEdit" runat="server" Text="Edit" style="display:none" />
<ajaxToolkit:ModalPopupExtender ID="btnEdit_ModalPopupExtender" BackgroundCssClass="ModalPopupBG"
        runat="server" CancelControlID="ButtonEditCancel" OkControlID="ButtonEditDone" 
        TargetControlID="ButtonEdit" PopupControlID="DivEditWindow" 
        OnCancelScript="EditCancelScript();" OnOkScript="EditOkayScript();"
        BehaviorID="EditModalPopup">
    </ajaxToolkit:ModalPopupExtender>
<div class="popup_Buttons" style="display: none">
    <input id="ButtonEditDone" value="Done" type="button" />
    <input id="ButtonEditCancel" value="Cancel" type="button" />
</div>
<div id="DivEditWindow" style="display: none;" class="popupConfirmation">
    <iframe id="IframeEdit" frameborder="0" height="680" width="750" scrolling="no">
    </iframe>
</div>  

<%----------------------------- Delete -------------------------------------------------------%>   
<ajaxToolkit:ModalPopupExtender BackgroundCssClass="ModalPopupBG" ID="btnMultipleDelete_ModalPopupExtender"
    runat="server" TargetControlID="btnMultipleDelete" PopupControlID="DivDeleteConfirmation"
    OkControlID="ButtonDeleleOkay" CancelControlID="ButtonDeleteCancel">
    </ajaxToolkit:ModalPopupExtender>
    <ajaxToolkit:ConfirmButtonExtender ID="btnMultipleDelete_ConfirmButtonExtender" runat="server" Enabled="True"
    TargetControlID="btnMultipleDelete" DisplayModalPopupID="btnMultipleDelete_ModalPopupExtender">
</ajaxToolkit:ConfirmButtonExtender> 
<asp:Panel runat="server" ID="DivDeleteConfirmation" Style="display: none;" class="popupConfirmation">
<div class="popup_Container">
    <div class="popup_Titlebar" id="PopupHeader">
        <div class="TitlebarLeft">
            Delete </div>
        <div class="TitlebarRight" onclick="$get('ButtonDeleteCancel').click();">
        </div>
    </div>
    <div class="popup_Body">
        <p>
            Are you sure, you want to delete the item?
        </p>
    </div>
    <div class="popup_Buttons">
        <input id="ButtonDeleleOkay" value="Okay" type="button" />
        <input id="ButtonDeleteCancel" value="Cancel" type="button" />
    </div>
</div>
</asp:Panel>