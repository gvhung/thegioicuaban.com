﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CommonLibrary.Security.Permissions
{
    internal class CompareDesktopModulePermissions : System.Collections.IComparer
    {
        public int Compare(object x, object y)
        {
            return ((DesktopModulePermissionInfo)x).DesktopModulePermissionID.CompareTo(((DesktopModulePermissionInfo)y).DesktopModulePermissionID);
        }
    }
}