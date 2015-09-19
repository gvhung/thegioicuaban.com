﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApp.templates.admin_templates.default_temp
{
    public partial class PopUp : System.Web.UI.MasterPage
    {
        public void Page_PreInit(Object sender, EventArgs e)
        {
            Page.Title = "5EAGLES";
            Page.Theme = "default";
            lblTitleBar.Text = "Edit";
        }

        private void Page_PreRender(object sender, EventArgs e)
        {
            Page.Culture = "vi-VN";
            Page.UICulture = "vi";            
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}