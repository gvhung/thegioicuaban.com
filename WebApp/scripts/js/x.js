﻿/* Built from X 4.23 by XAG 1.0. 14May11 19:06 UT */
xLibrary = { version: "4.23", license: "GNU LGPL", url: "http://cross-browser.com/" }; function xEvent(evt) {
    var e = evt || window.event; if (!e) { return } this.type = e.type; this.target = e.target || e.srcElement; this.relatedTarget = e.relatedTarget;
    /*@cc_onif (e.type == 'mouseover') this.relatedTarget = e.fromElement;
    else if (e.type == 'mouseout') this.relatedTarget = e.toElement; @*/
    if (xDef(e.pageX)) { this.pageX = e.pageX; this.pageY = e.pageY } else { if (xDef(e.clientX)) { this.pageX = e.clientX + xScrollLeft(); this.pageY = e.clientY + xScrollTop() } } if (xDef(e.offsetX)) { this.offsetX = e.offsetX; this.offsetY = e.offsetY } else { if (xDef(e.layerX)) { this.offsetX = e.layerX; this.offsetY = e.layerY } else { this.offsetX = this.pageX - xPageX(this.target); this.offsetY = this.pageY - xPageY(this.target) } } this.keyCode = e.keyCode || e.which || 0; this.shiftKey = e.shiftKey; this.ctrlKey = e.ctrlKey; this.altKey = e.altKey; if (typeof e.type == "string") {
        if (e.type.indexOf("click") != -1) { this.button = 0 } else {
            if (e.type.indexOf("mouse") != -1) {
                this.button = e.button;
                /*@cc_onif (e.button & 1) this.button = 0;
                else if (e.button & 4) this.button = 1;
                else if (e.button & 2) this.button = 2; @*/
            } 
        } 
    } 
} function xAddEventListener(d, c, b, a) { if (!(d = xGetElementById(d))) { return } c = c.toLowerCase(); if (d.addEventListener) { d.addEventListener(c, b, a || false) } else { if (d.attachEvent) { d.attachEvent("on" + c, b) } else { var f = d["on" + c]; d["on" + c] = typeof f == "function" ? function (e) { f(e); b(e) } : b } } } function xCamelize(d) { var e, g, b, f; b = d.split("-"); f = b[0]; for (e = 1; e < b.length; ++e) { g = b[e].charAt(0); f += b[e].replace(g, g.toUpperCase()) } return f } function xClientHeight() { var b = 0, c = document, a = window; if ((!c.compatMode || c.compatMode == "CSS1Compat") && c.documentElement && c.documentElement.clientHeight) { b = c.documentElement.clientHeight } else { if (c.body && c.body.clientHeight) { b = c.body.clientHeight } else { if (xDef(a.innerWidth, a.innerHeight, c.width)) { b = a.innerHeight; if (c.width > a.innerWidth) { b -= 16 } } } } return b } function xClientWidth() { var b = 0, c = document, a = window; if ((!c.compatMode || c.compatMode == "CSS1Compat") && !a.opera && c.documentElement && c.documentElement.clientWidth) { b = c.documentElement.clientWidth } else { if (c.body && c.body.clientWidth) { b = c.body.clientWidth } else { if (xDef(a.innerWidth, a.innerHeight, c.height)) { b = a.innerWidth; if (c.height > a.innerHeight) { b -= 16 } } } } return b } function xDef() { for (var b = 0, a = arguments.length; b < a; ++b) { if (typeof (arguments[b]) === "undefined") { return false } } return true } function xEachE() { var c, b = arguments, d = b.length - 1; for (c = 0; c < d; ++c) { b[d](xGetElementById(b[c]), c) } } function xEachN(g, a, h, b) { var c = xGetElementById(g + a); while (c) { b(c, a, h); c = xGetElementById(g + (++a)) } } function xGetComputedStyle(g, f, c) { if (!(g = xGetElementById(g))) { return null } var d, a = "undefined", b = document.defaultView; if (b && b.getComputedStyle) { d = b.getComputedStyle(g, ""); if (d) { a = d.getPropertyValue(f) } } else { if (g.currentStyle) { a = g.currentStyle[xCamelize(f)] } else { return null } } return c ? (parseInt(a) || 0) : a } function xGetElementById(a) { if (typeof (a) == "string") { if (document.getElementById) { a = document.getElementById(a) } else { if (document.all) { a = document.all[a] } else { a = null } } } return a } function xGetElementsByClassName(k, b, n, h) { var a = [], m, j, g, d; m = new RegExp("(^|\\s)" + k + "(\\s|$)"); j = xGetElementsByTagName(n, b); for (g = 0, d = j.length; g < d; ++g) { if (m.test(j[g].className)) { a[a.length] = j[g]; if (h) { h(j[g]) } } } return a } function xGetElementsByTagName(a, c) { var b = null; a = a || "*"; c = xGetElementById(c) || document; if (typeof c.getElementsByTagName != "undefined") { b = c.getElementsByTagName(a); if (a == "*" && (!b || !b.length)) { b = c.all } } else { if (a == "*") { b = c.all } else { if (c.all && c.all.tags) { b = c.all.tags(a) } } } return b || [] } function xHasPoint(f, i, g, j, a, h, d) { if (!xNum(j)) { j = a = h = d = 0 } else { if (!xNum(a)) { a = h = d = j } else { if (!xNum(h)) { d = a; h = j } } } var c = xPageX(f), k = xPageY(f); return (i >= c + d && i <= c + xWidth(f) - a && g >= k + j && g <= k + xHeight(f) - h) } function xHeight(g, d) { var c, f = 0, b = 0, a = 0, i = 0; if (!(g = xGetElementById(g))) { return 0 } if (xNum(d)) { if (d < 0) { d = 0 } else { d = Math.round(d) } } else { d = -1 } c = xDef(g.style); if (g == document || g.tagName.toLowerCase() == "html" || g.tagName.toLowerCase() == "body") { d = xClientHeight() } else { if (c && xDef(g.offsetHeight) && xStr(g.style.height)) { if (d >= 0) { if (document.compatMode == "CSS1Compat") { f = xGetComputedStyle(g, "padding-top", 1); if (f !== null) { b = xGetComputedStyle(g, "padding-bottom", 1); a = xGetComputedStyle(g, "border-top-width", 1); i = xGetComputedStyle(g, "border-bottom-width", 1) } else { if (xDef(g.offsetHeight, g.style.height)) { g.style.height = d + "px"; f = g.offsetHeight - d } } } d -= (f + b + a + i); if (isNaN(d) || d < 0) { return } else { g.style.height = d + "px" } } d = g.offsetHeight } else { if (c && xDef(g.style.pixelHeight)) { if (d >= 0) { g.style.pixelHeight = d } d = g.style.pixelHeight } } } return d } function xLeft(c, a) { if (!(c = xGetElementById(c))) { return 0 } var b = xDef(c.style); if (b && xStr(c.style.left)) { if (xNum(a)) { c.style.left = a + "px" } else { a = parseInt(c.style.left); if (isNaN(a)) { a = xGetComputedStyle(c, "left", 1) } if (isNaN(a)) { a = 0 } } } else { if (b && xDef(c.style.pixelLeft)) { if (xNum(a)) { c.style.pixelLeft = a } else { a = c.style.pixelLeft } } } return a } function xMoveTo(b, a, c) { xLeft(b, a); xTop(b, c) } function xNum() { for (var b = 0, a = arguments.length; b < a; ++b) { if (isNaN(arguments[b]) || typeof (arguments[b]) !== "number") { return false } } return true } function xOffset(d, a) { var b = { x: 0, y: 0 }; d = xGetElementById(d); a = xGetElementById(a); while (d && d != a) { b.x += d.offsetLeft; b.y += d.offsetTop; d = d.offsetParent } return b } function xOpacity(a, b) { var c = xDef(b); if (!(a = xGetElementById(a))) { return 2 } if (xStr(a.style.opacity)) { if (c) { a.style.opacity = b + "" } else { b = parseFloat(a.style.opacity) } } else { if (xStr(a.style.filter)) { if (c) { a.style.filter = "alpha(opacity=" + (100 * b) + ")" } else { if (a.filters && a.filters.alpha) { b = a.filters.alpha.opacity / 100 } } } else { if (xStr(a.style.MozOpacity)) { if (c) { a.style.MozOpacity = b + "" } else { b = parseFloat(a.style.MozOpacity) } } else { if (xStr(a.style.KhtmlOpacity)) { if (c) { a.style.KhtmlOpacity = b + "" } else { b = parseFloat(a.style.KhtmlOpacity) } } } } } return isNaN(b) ? 1 : b } function xPageX(b) { var a = 0; b = xGetElementById(b); while (b) { if (xDef(b.offsetLeft)) { a += b.offsetLeft } b = xDef(b.offsetParent) ? b.offsetParent : null } return a } function xPageY(a) { var b = 0; a = xGetElementById(a); while (a) { if (xDef(a.offsetTop)) { b += a.offsetTop } a = xDef(a.offsetParent) ? a.offsetParent : null } return b } function xPreventDefault(a) { if (a && a.preventDefault) { a.preventDefault() } else { if (window.event) { window.event.returnValue = false } } } function xRemoveEventListener(d, c, b, a) { if (!(d = xGetElementById(d))) { return } c = c.toLowerCase(); if (d.removeEventListener) { d.removeEventListener(c, b, a || false) } else { if (d.detachEvent) { d.detachEvent("on" + c, b) } else { d["on" + c] = null } } } function xResizeTo(c, a, b) { return { w: xWidth(c, a), h: xHeight(c, b)} } function xScrollLeft(c, b) { var a, d = 0; if (!xDef(c) || b || c == document || c.tagName.toLowerCase() == "html" || c.tagName.toLowerCase() == "body") { a = window; if (b && c) { a = c } if (a.document.documentElement && a.document.documentElement.scrollLeft) { d = a.document.documentElement.scrollLeft } else { if (a.document.body && xDef(a.document.body.scrollLeft)) { d = a.document.body.scrollLeft } } } else { c = xGetElementById(c); if (c && xNum(c.scrollLeft)) { d = c.scrollLeft } } return d } function xScrollTop(c, b) { var a, d = 0; if (!xDef(c) || b || c == document || c.tagName.toLowerCase() == "html" || c.tagName.toLowerCase() == "body") { a = window; if (b && c) { a = c } if (a.document.documentElement && a.document.documentElement.scrollTop) { d = a.document.documentElement.scrollTop } else { if (a.document.body && xDef(a.document.body.scrollTop)) { d = a.document.body.scrollTop } } } else { c = xGetElementById(c); if (c && xNum(c.scrollTop)) { d = c.scrollTop } } return d } function xStopPropagation(a) { if (a && a.stopPropagation) { a.stopPropagation() } else { if (window.event) { window.event.cancelBubble = true } } } function xStr(c) { for (var b = 0, a = arguments.length; b < a; ++b) { if (typeof (arguments[b]) !== "string") { return false } } return true } function xStyle(p, v) {
    var i, e; for (i = 2; i < arguments.length; ++i) {
        e = xGetElementById(arguments[i]); try { e.style[p] = v } catch (ex) {
            /*@cc_on
            @if (@_jscript_version <= 5.7) // IE7 and down
            if (p != 'display') { continue; } var s = '', t = e.tagName.toLowerCase(); switch (t) { case 'table': case 'tr': case 'td': case 'li': s = 'block'; break; case 'caption': s = 'inline'; break; } e.style[p] = s;
            @end@*/
        } 
    } 
} function xTop(b, c) { if (!(b = xGetElementById(b))) { return 0 } var a = xDef(b.style); if (a && xStr(b.style.top)) { if (xNum(c)) { b.style.top = c + "px" } else { c = parseInt(b.style.top); if (isNaN(c)) { c = xGetComputedStyle(b, "top", 1) } if (isNaN(c)) { c = 0 } } } else { if (a && xDef(b.style.pixelTop)) { if (xNum(c)) { b.style.pixelTop = c } else { c = b.style.pixelTop } } } return c } function xWidth(f, a) { var c, d = 0, h = 0, g = 0, b = 0; if (!(f = xGetElementById(f))) { return 0 } if (xNum(a)) { if (a < 0) { a = 0 } else { a = Math.round(a) } } else { a = -1 } c = xDef(f.style); if (f == document || f.tagName.toLowerCase() == "html" || f.tagName.toLowerCase() == "body") { a = xClientWidth() } else { if (c && xDef(f.offsetWidth) && xStr(f.style.width)) { if (a >= 0) { if (document.compatMode == "CSS1Compat") { d = xGetComputedStyle(f, "padding-left", 1); if (d !== null) { h = xGetComputedStyle(f, "padding-right", 1); g = xGetComputedStyle(f, "border-left-width", 1); b = xGetComputedStyle(f, "border-right-width", 1) } else { if (xDef(f.offsetWidth, f.style.width)) { f.style.width = a + "px"; d = f.offsetWidth - a } } } a -= (d + h + g + b); if (isNaN(a) || a < 0) { return } else { f.style.width = a + "px" } } a = f.offsetWidth } else { if (c && xDef(f.style.pixelWidth)) { if (a >= 0) { f.style.pixelWidth = a } a = f.style.pixelWidth } } } return a };