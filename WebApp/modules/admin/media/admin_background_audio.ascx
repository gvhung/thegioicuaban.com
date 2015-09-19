﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="admin_background_audio.ascx.cs" Inherits="WebApp.modules.admin.media.admin_background_audio" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

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
 <script language="javascript" type="text/javascript">
     var add_url = '<%=add_url %>';
     var edit_url = '<%=edit_url %>';
     var loading_url = '<%=loading_url %>';
     var select_page_url = '<%=select_page_url %>';
     
     function ShowModalSelect() {
         var frame = $get('IframeSelect');
         frame.src = select_page_url;
         $find('SelectModalPopup').show();
     }

     function SelectCancelScript() {
         var frame = $get('IframSelect');
         frame.src = loading_url;
     }

     function SelectOkayScript() {
         RefreshDataGrid();
         SelectCancelScript();
     }
     //======================================================

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

<div class="wrap_gp" >      
    <div class="commontool">
        <h3>Quản lý nhạc nền</h3>
        <div class="toolbar">  
                <asp:LinkButton ID="btnAdd" runat="server" CssClass="btn" OnClientClick="ShowAddModal();return false;"><span class="icon-32-new"></span>Thêm</asp:LinkButton>               
                <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn" OnClientClick="ShowModalEdit();return false;"><span class="icon-32-edit"></span>Sửa</asp:LinkButton>                                                 
                <asp:LinkButton ID="btnSelect" runat="server" CssClass="btn" OnClientClick="ShowModalSelect();return false;"><span class="icon-32-edit"></span>Chọn Nhạc Nền</asp:LinkButton> 

                <asp:LinkButton ID="btnSoundOff" runat="server" CssClass="btn" 
                    onclick="btnSoundOff_Click" ><span class="icon-32-edit"></span>Bỏ chọn toàn bộ</asp:LinkButton>                                                 
                <asp:LinkButton ID="btnMultipleRowDelete" runat="server" CssClass="btn" 
                    onclick="btnMultipleRowDelete_Click" ><span class="icon-32-trash"></span>Xóa nhiều dòng</asp:LinkButton>                               
                <asp:LinkButton ID="btnReload" runat="server" CssClass="btn" OnClick="btnReload_Click" Visible="false"><span class="icon-32-unpublish"></span>Reload</asp:LinkButton>         
                <asp:HiddenField ID="hdnFldSelectedValues" runat="server" />
         </div>
    </div>      
    <div class="group_commands">       
            <div class="left">                                                      
            </div> 
            <div class="right">
                <div class="fillter_tool">
                     Portal :<asp:DropDownList ID="ddlPortalList" runat="server" onselectedindexchanged="ddlPortalList_SelectedIndexChanged"></asp:DropDownList>  
                     &nbsp;
                     Media Type: <asp:DropDownList ID="ddlMediaTypeList" runat="server" onselectedindexchanged="ddlMediaTypeList_SelectedIndexChanged"></asp:DropDownList>  
                     &nbsp;

                </div>  
            </div>   
    </div>
    <div style="clear:both;"></div>
    <div class="group_panel">
            <asp:GridView ID="GridView1" DataKeyNames="Id" runat="server" 
                AllowPaging="True" Width="100%" Height="100%"    
            AllowSorting="True" AutoGenerateColumns="False" BackColor="White" 
            BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" 
            CellPadding="3" EmptyDataText="No Data" ForeColor="Black" GridLines="Vertical" 
            ShowFooter="True"  EnableModelValidation="True"
            onpageindexchanged="GridView1_SelectedIndexChanged" 
            onrowcancelingedit="GridView1_RowCancelingEdit" onrowcreated="GridView1_RowCreated" 
            onrowediting="GridView1_RowEditing" 
            onselectedindexchanged="GridView1_SelectedIndexChanged" 
            onselectedindexchanging="GridView1_SelectedIndexChanging" 
            ondatabound="GridView1_DataBound" 
            onpageindexchanging="GridView1_PageIndexChanging" 
            onrowdatabound="GridView1_RowDataBound" onsorting="GridView1_Sorting" 
            onrowcommand="GridView1_RowCommand">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <Columns>
                <asp:TemplateField HeaderText="x">
                <EditItemTemplate>                                         
                    <asp:TextBox ID="txtIdx" runat="server" Text='<%# Bind("Id") %>' Width="30px"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chkBxSelect" runat="server" />
                    <asp:HiddenField ID="hdnFldId" runat="server" Value='<%# Eval("Id") %>' />
                </ItemTemplate>
                <HeaderTemplate>
                    <asp:CheckBox ID="chkBxHeader" onclick="javascript:HeaderClick(this);" runat="server" />
                </HeaderTemplate>
            </asp:TemplateField>                                      
                <asp:BoundField DataField="Id" HeaderText="Id" />
                <asp:BoundField DataField="Title" HeaderText="Title" />
                <asp:BoundField DataField="FileName" HeaderText="FileName" />
                <asp:TemplateField HeaderText="Preview">
                    <ItemTemplate>                                
                        <object type="application/x-shockwave-flash" data='<%# Eval("FileName", "../../../scripts/plugins/dewplayer/dewplayer-vol.swf?mp3=../../../user_files/media/audio/background_audio/{0}") %>' width="240" height="20" id="dewplayer-vol">
                            <param name="wmode" value="transparent" />
                            <param name="movie" value='<%# Eval("FileName", "../../../scripts/plugins/dewplayer/dewplayer-vol.swf?mp3=../../../user_files/media/audio/background_audio/{0}") %>'/>
                        </object>
                    </ItemTemplate>                          
                </asp:TemplateField>          
                <asp:TemplateField HeaderText="SortKey">
                    <ItemTemplate>                                
                        <asp:TextBox ID="txtSortKey" runat="server" Text='<%# Bind("SortKey") %>' Width="20px"></asp:TextBox>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtEditSortKey" runat="server" Text='<%# Bind("SortKey") %>' Width="20px"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField> 
                 <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("Status") %>'></asp:Label>                               
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtStatus" runat="server" Text='<%# Bind("Status") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>  
            </Columns>
            <EmptyDataTemplate>No Data</EmptyDataTemplate>
                <PagerTemplate>
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
                </PagerTemplate> 
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
        </asp:GridView>
    </div>
</div>  


<%----------------------------- ModalPopupExtender_Add -------------------------------------%>                                                                                                  
<ajaxToolkit:ModalPopupExtender ID="btnAdd_ModalPopupExtender" BackgroundCssClass="ModalPopupBG"
    runat="server" CancelControlID="btnCancel" OkControlID="btnOk" TargetControlID="btnAdd"
    PopupControlID="Panel1" Drag="true" PopupDragHandleControlID="PopupHeader" OnCancelScript="AddCancelScript"
OnOkScript="ShowAddModal();"  BehaviorID="AddModalPopup">
</ajaxToolkit:ModalPopupExtender>
<div class="popup_Buttons" style="display: none">
<input id="btnOk" value="Done" type="button" />
<input id="btnCancel" value="Cancel" type="button" />
</div>
<div id="Panel1" style="display: none;" class="popupConfirmation">
<iframe id="IframeAdd" frameborder="0" width="600" height="500" scrolling="no"></iframe>
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
    <iframe id="IframeEdit" frameborder="0"  width="600" height="500" scrolling="no">
    </iframe>
</div>   

 <%----------------------------- Delete -------------------------------------------------------%>   
<ajaxToolkit:ModalPopupExtender BackgroundCssClass="ModalPopupBG" ID="btnMultipleRowDelete_ModalPopupExtender"
    runat="server" TargetControlID="btnMultipleRowDelete" PopupControlID="DivDeleteConfirmation"
    OkControlID="ButtonDeleleOkay" CancelControlID="ButtonDeleteCancel">
</ajaxToolkit:ModalPopupExtender>
<ajaxToolkit:ConfirmButtonExtender ID="btnMultipleRowDelete_ConfirmButtonExtender" runat="server" Enabled="True"
    TargetControlID="btnMultipleRowDelete" DisplayModalPopupID="btnMultipleRowDelete_ModalPopupExtender">
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

<%----------------------------- ModalPopupExtender_Select -------------------------------------%>    
<asp:Button ID="ButtonSelect" runat="server" Text="Select" style="display:none" />
<ajaxToolkit:ModalPopupExtender ID="btnSelect_ModalPopupExtender" BackgroundCssClass="ModalPopupBG"
        runat="server" CancelControlID="ButtonSelectCancel" OkControlID="ButtonSelectDone" 
        TargetControlID="ButtonSelect" PopupControlID="DivSelectWindow" 
        OnCancelScript="SelectCancelScript();" OnOkScript="SelectOkayScript();" 
        BehaviorID="SelectModalPopup">
    </ajaxToolkit:ModalPopupExtender>
<div class="popup_Buttons" style="display: none">
    <input id="ButtonSelectDone" value="Done" type="button" />
    <input id="ButtonSelectCancel" value="Cancel" type="button" />
</div>
<div id="DivSelectWindow" style="display: none;" class="popupConfirmation">
    <iframe id="IframeSelect" frameborder="0"  width="600" height="500" scrolling="no">
    </iframe>
</div> 