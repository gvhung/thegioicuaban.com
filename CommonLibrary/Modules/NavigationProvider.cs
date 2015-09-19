﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CommonLibrary.Modules
{
    public abstract class NavigationProvider : Framework.UserControlBase
    {
        public event NodeClickEventHandler NodeClick;
        public delegate void NodeClickEventHandler(NavigationEventArgs args);
        public event PopulateOnDemandEventHandler PopulateOnDemand;
        public delegate void PopulateOnDemandEventHandler(NavigationEventArgs args);
        public enum Orientation
        {
            Horizontal,
            Vertical
        }
        public enum Alignment
        {
            Left,
            Right,
            Center,
            Justify
        }
        public enum HoverAction
        {
            Expand,
            None
        }
        public enum HoverDisplay
        {
            Highlight,
            Outset,
            None
        }
        public static new NavigationProvider Instance(string FriendlyName)
        {
            return (NavigationProvider)Framework.Reflection.CreateObject("navigationControl", FriendlyName, "", "");
        }
        public abstract System.Web.UI.Control NavigationControl { get; }
        public abstract string ControlID { get; set; }
        public abstract bool SupportsPopulateOnDemand { get; }
        public virtual string PathImage
        {
            get { return ""; }
            set { }
        }
        public virtual string PathSystemImage
        {
            get { return ""; }
            set { }
        }
        public virtual string PathSystemScript
        {
            get { return ""; }
            set { }
        }
        public virtual string WorkImage
        {
            get { return ""; }
            set { }
        }
        public virtual string IndicateChildImageSub
        {
            get { return ""; }
            set { }
        }
        public virtual string IndicateChildImageRoot
        {
            get { return ""; }
            set { }
        }
        public virtual string IndicateChildImageExpandedSub
        {
            get { return ""; }
            set { }
        }
        public virtual string IndicateChildImageExpandedRoot
        {
            get { return ""; }
            set { }
        }
        public abstract string CSSControl { get; set; }
        public virtual string CSSContainerRoot
        {
            get { return ""; }
            set { }
        }
        public virtual string CSSContainerSub
        {
            get { return ""; }
            set { }
        }
        public virtual string CSSNode
        {
            get { return ""; }
            set { }
        }
        public virtual string CSSNodeRoot
        {
            get { return ""; }
            set { }
        }
        public virtual string CSSIcon
        {
            get { return ""; }
            set { }
        }
        public virtual string CSSNodeHover
        {
            get { return ""; }
            set { }
        }
        public virtual string CSSNodeHoverSub
        {
            get { return ""; }
            set { }
        }
        public virtual string CSSNodeHoverRoot
        {
            get { return ""; }
            set { }
        }
        public virtual string CSSBreak
        {
            get { return ""; }
            set { }
        }
        public virtual string CSSIndicateChildSub
        {
            get { return ""; }
            set { }
        }
        public virtual string CSSIndicateChildRoot
        {
            get { return ""; }
            set { }
        }
        public virtual string CSSBreadCrumbSub
        {
            get { return ""; }
            set { }
        }
        public virtual string CSSBreadCrumbRoot
        {
            get { return ""; }
            set { }
        }
        public virtual string CSSNodeSelectedSub
        {
            get { return ""; }
            set { }
        }
        public virtual string CSSNodeSelectedRoot
        {
            get { return ""; }
            set { }
        }
        public virtual string CSSSeparator
        {
            get { return ""; }
            set { }
        }
        public virtual string CSSLeftSeparator
        {
            get { return ""; }
            set { }
        }
        public virtual string CSSRightSeparator
        {
            get { return ""; }
            set { }
        }
        public virtual string CSSLeftSeparatorSelection
        {
            get { return ""; }
            set { }
        }
        public virtual string CSSRightSeparatorSelection
        {
            get { return ""; }
            set { }
        }
        public virtual string CSSLeftSeparatorBreadCrumb
        {
            get { return ""; }
            set { }
        }
        public virtual string CSSRightSeparatorBreadCrumb
        {
            get { return ""; }
            set { }
        }
        public virtual string StyleBackColor
        {
            get { return ""; }
            set { }
        }
        public virtual string StyleForeColor
        {
            get { return ""; }
            set { }
        }
        public virtual string StyleHighlightColor
        {
            get { return ""; }
            set { }
        }
        public virtual string StyleIconBackColor
        {
            get { return ""; }
            set { }
        }
        public virtual string StyleSelectionBorderColor
        {
            get { return ""; }
            set { }
        }
        public virtual string StyleSelectionColor
        {
            get { return ""; }
            set { }
        }
        public virtual string StyleSelectionForeColor
        {
            get { return ""; }
            set { }
        }
        public virtual decimal StyleControlHeight
        {
            get { return 25; }
            set { }
        }
        public virtual decimal StyleBorderWidth
        {
            get { return 0; }
            set { }
        }
        public virtual decimal StyleNodeHeight
        {
            get { return 25; }
            set { }
        }
        public virtual decimal StyleIconWidth
        {
            get { return 0; }
            set { }
        }
        public virtual string StyleFontNames
        {
            get { return ""; }
            set { }
        }
        public virtual decimal StyleFontSize
        {
            get { return 0; }
            set { }
        }
        public virtual string StyleFontBold
        {
            get { return "False"; }
            set { }
        }
        public virtual string StyleRoot
        {
            get { return ""; }
            set { }
        }
        public virtual string StyleSub
        {
            get { return ""; }
            set { }
        }
        public virtual string EffectsStyle
        {
            get { return ""; }
            set { }
        }
        public virtual string EffectsTransition
        {
            get { return "'"; }
            set { }
        }
        public virtual double EffectsDuration
        {
            get { return -1; }
            set { }
        }
        public virtual string EffectsShadowColor
        {
            get { return ""; }
            set { }
        }
        public virtual string EffectsShadowDirection
        {
            get { return ""; }
            set { }
        }
        public virtual int EffectsShadowStrength
        {
            get { return -1; }
            set { }
        }
        public virtual Orientation ControlOrientation
        {
            get { return Orientation.Horizontal; }
            set { }
        }
        public virtual Alignment ControlAlignment
        {
            get { return Alignment.Left; }
            set { }
        }
        public virtual string ForceDownLevel
        {
            get { return false.ToString(); }
            set { }
        }
        public virtual decimal MouseOutHideDelay
        {
            get { return -1; }
            set { }
        }
        public virtual HoverDisplay MouseOverDisplay
        {
            get { return HoverDisplay.Highlight; }
            set { }
        }
        public virtual HoverAction MouseOverAction
        {
            get { return HoverAction.Expand; }
            set { }
        }
        public virtual string ForceCrawlerDisplay
        {
            get { return "False"; }
            set { }
        }
        public virtual bool IndicateChildren
        {
            get { return true; }
            set { }
        }
        public virtual string SeparatorHTML
        {
            get { return ""; }
            set { }
        }
        public virtual string SeparatorLeftHTML
        {
            get { return ""; }
            set { }
        }
        public virtual string SeparatorRightHTML
        {
            get { return ""; }
            set { }
        }
        public virtual string SeparatorLeftHTMLActive
        {
            get { return ""; }
            set { }
        }
        public virtual string SeparatorRightHTMLActive
        {
            get { return ""; }
            set { }
        }
        public virtual string SeparatorLeftHTMLBreadCrumb
        {
            get { return ""; }
            set { }
        }
        public virtual string SeparatorRightHTMLBreadCrumb
        {
            get { return ""; }
            set { }
        }
        public virtual string NodeLeftHTMLSub
        {
            get { return ""; }
            set { }
        }
        public virtual string NodeLeftHTMLRoot
        {
            get { return ""; }
            set { }
        }
        public virtual string NodeRightHTMLSub
        {
            get { return ""; }
            set { }
        }
        public virtual string NodeRightHTMLRoot
        {
            get { return ""; }
            set { }
        }
        public virtual string NodeLeftHTMLBreadCrumbSub
        {
            get { return ""; }
            set { }
        }
        public virtual string NodeRightHTMLBreadCrumbSub
        {
            get { return ""; }
            set { }
        }
        public virtual string NodeLeftHTMLBreadCrumbRoot
        {
            get { return ""; }
            set { }
        }
        public virtual string NodeRightHTMLBreadCrumbRoot
        {
            get { return ""; }
            set { }
        }
        public virtual bool PopulateNodesFromClient
        {
            get { return false; }
            set { }
        }
        public virtual System.Collections.Generic.List<CommonLibrary.UI.Skins.CustomAttribute> CustomAttributes
        {
            get { return null; }
            set { }
        }
        public abstract void Initialize();
        public abstract void Bind(CommonLibrary.UI.WebControls.Common.NodeCollection objNodes);
        public virtual void ClearNodes()
        {
        }
        protected void RaiseEvent_NodeClick(CommonLibrary.UI.WebControls.Common.Node objNode)
        {
            if (NodeClick != null)
            {
                NodeClick(new NavigationEventArgs(objNode.ID, objNode));
            }
        }
        protected void RaiseEvent_NodeClick(string strID)
        {
            if (NodeClick != null)
            {
                NodeClick(new NavigationEventArgs(strID, null));
            }
        }
        protected void RaiseEvent_PopulateOnDemand(CommonLibrary.UI.WebControls.Common.Node objNode)
        {
            if (PopulateOnDemand != null)
            {
                PopulateOnDemand(new NavigationEventArgs(objNode.ID, objNode));
            }
        }
        protected void RaiseEvent_PopulateOnDemand(string strID)
        {
            if (PopulateOnDemand != null)
            {
                PopulateOnDemand(new NavigationEventArgs(strID, null));
            }
        }
    }
    public class NavigationEventArgs
    {
        public string ID;
        public CommonLibrary.UI.WebControls.Common.Node Node;
        public NavigationEventArgs(string strID, CommonLibrary.UI.WebControls.Common.Node objNode)
        {
            this.ID = strID;
            this.Node = objNode;
        }
    }
}