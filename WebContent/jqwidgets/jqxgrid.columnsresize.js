/*
jQWidgets v4.5.4 (2017-June)
Copyright (c) 2011-2017 jQWidgets.
License: http://jqwidgets.com/license/
*/
!function(a){a.extend(a.jqx._jqxGrid.prototype,{autoresizecolumns:function(b,c){"cells"!=b&&"all"!=b&&"column"!=b&&(b="all");var d=this.that,e=this.getrows();this.pageable&&(e=this.dataview.rows,this.groupable&&(e=this.dataview.records)),c=void 0==c?0:parseInt(c);var f=e.length;if(void 0==f&&void 0!=e){var g=new Array;a.each(e,function(a){g.push(this)}),e=g,f=e.length}var h=a("<span></span>");h.addClass(this.toThemeProperty("jqx-widget")),h.addClass(this.toThemeProperty("jqx-grid-cell")),a(document.body).append(h);var i=[],j=[],k=[],l=[],m=d.host.width();"hidden"!=d.vScrollBar[0].style.visibility&&(m-=this.scrollbarsize+5),m<0&&(m=0);for(var n=0;n<f;n++)for(var o=e[n],p=0;p<this.columns.records.length;p++){var q=this.columns.records[p];if(!q.hidden&&!(this.groups.length>0&&p<=this.groups.length-1)){void 0==j[q.displayfield]&&(j[q.displayfield]=0),void 0==k[q.displayfield]&&(k[q.displayfield]="");var r=o[q.displayfield];if(""!=q.cellsformat)a.jqx.dataFormat&&(a.jqx.dataFormat.isDate(r)?r=a.jqx.dataFormat.formatdate(r,q.cellsformat,this.gridlocalization):a.jqx.dataFormat.isNumber(r)&&(r=a.jqx.dataFormat.formatnumber(r,q.cellsformat,this.gridlocalization)));else if(q.cellsrenderer){var s=d._defaultcellsrenderer(r,q),t=q.cellsrenderer(n,q.datafield,r,s,q.getcolumnproperties(),o);void 0!=t&&(r=a(t).text())}if((void 0==b||"cells"==b||"all"==b)&&null!=r){var i=r.toString().length,u=r.toString(),v=u.replace(/[^A-Z]/g,"").length;if(i>j[q.displayfield]&&(j[q.displayfield]=i,k[q.displayfield]=r,l[q.displayfield]=v),i>0&&i>=v){var w=20*v+15*(i-v),x=20*l[q.displayfield]+15*(j[q.displayfield]-l[q.displayfield]);w>x&&w>0&&x>0&&(j[q.displayfield]=i,k[q.displayfield]=r,l[q.displayfield]=v)}}if("column"==b||"all"==b){if(q.text.toString().length>j[q.displayfield]){k[q.displayfield]=q.text,j[q.displayfield]=q.text.length;var u=q.text.toString(),v=u.replace(/[^A-Z]/g,"").length;l[q.displayfield]=v}var r=q.text,i=r.toString().length,u=r.toString(),v=u.replace(/[^A-Z]/g,"").length;if(i>0&&i>=v){var w=20*v+15*(i-v),x=20*l[q.displayfield]+15*(j[q.displayfield]-l[q.displayfield]);w>x&&w>0&&x>0&&(j[q.displayfield]=i,k[q.displayfield]=r,l[q.displayfield]=v)}}}}if(this.columns.records){for(var p=0;p<this.columns.records.length;p++){var q=this.columns.records[p];if(q.displayfield){void 0==k[q.displayfield]&&(k[q.displayfield]=q.text),h[0].className.indexOf("jqx-grid-column-header")>=0&&h.removeClass(this.toThemeProperty("jqx-grid-column-header")),k[q.displayfield]==q.text&&h.addClass(this.toThemeProperty("jqx-grid-column-header")),h[0].innerHTML=k[q.displayfield].toString();var y=h.outerWidth()+10;if(h.children().length>0&&(y=h.children().outerWidth()+10),a.jqx.browser.msie&&a.jqx.browser.version<8&&(y+=10),this.filterable&&this.showfilterrow&&(y+=5),y+=c,y>q.maxwidth&&(y=q.maxwidth),void 0!=q._width&&(q.__width=q._width),q._width=null,"auto"==q.maxwidth||y<=q.maxwidth){var z=q.width;y<q.minwidth&&(y=q.minwidth),q.width=y,void 0!=q._percentagewidth&&(q._percentagewidth=null),this._raiseEvent(14,{columntext:q.text,column:q.getcolumnproperties(),datafield:q.datafield,displayfield:q.displayfield,oldwidth:z,newwidth:y})}}}h.remove(),this._updatecolumnwidths(),this._updatecellwidths(),this._renderrows(this.virtualsizeinfo);for(var p=0;p<this.columns.records.length;p++){var q=this.columns.records[p];void 0!=q.__width&&(q._width=q.__width)}}},autoresizecolumn:function(b,c,d){if("cells"!=c&&"all"!=c&&"column"!=c&&(c="all"),void 0==b)return!1;var e=this.getrows();this.pageable&&(e=this.dataview.rows,this.groupable&&(e=this.dataview.records));var f=this.getcolumn(b);if(void 0==f)return!1;d=void 0==d?0:parseInt(d);var g=e.length,h=a("<span></span>");h.addClass(this.toThemeProperty("jqx-widget")),h.addClass(this.toThemeProperty("jqx-grid-cell")),a(document.body).append(h);var i=0,j="",k=0,l=this.that,m=l.host.width();if("hidden"!=l.vScrollBar[0].style.visibility&&(m-=this.scrollbarsize+5),m<0&&(m=0),void 0==c||"cells"==c||"all"==c)for(var n=0;n<g;n++){var o=e[n][f.displayfield];if(""!=f.cellsformat)a.jqx.dataFormat&&(a.jqx.dataFormat.isDate(o)?o=a.jqx.dataFormat.formatdate(o,f.cellsformat,this.gridlocalization):a.jqx.dataFormat.isNumber(o)&&(o=a.jqx.dataFormat.formatnumber(o,f.cellsformat,this.gridlocalization)));else if(f.cellsrenderer){var p=f.cellsrenderer(n,f,o);void 0!=p&&(o=a(p).text())}if(null!=o){var q=o.toString().length,r=o.toString(),s=r.replace(/[^A-Z]/g,"").length;if(q>i&&(i=q,j=o,k=s),q>0&&q>=s){var t=20*s+15*(q-s),u=20*k+15*(i-k);t>u&&t>0&&u>0&&(i=q,j=o,k=s)}}}if("column"==c||"all"==c){f.text.toString().length>i&&(j=f.text);var o=f.text.toString(),q=o.toString().length,r=o.toString(),s=r.replace(/[^A-Z]/g,"").length;if(q>0&&q>=s){var t=20*s+15*(q-s),u=20*k+15*(i-k);t>u&&t>0&&u>0&&(i=q,j=o,k=s)}}void 0==j&&(j=f.text),h[0].innerHTML=j,j==f.text&&h.addClass(this.toThemeProperty("jqx-grid-column-header"));var v=h.outerWidth()+10;if(a.jqx.browser.msie&&a.jqx.browser.version<8&&(v+=5),this.filterable&&this.showfilterrow&&(v+=5),v+=d,h.remove(),v>f.maxwidth&&(v=f.maxwidth),"auto"==f.maxwidth||v<=f.maxwidth){var w=f.width;v<f.minwidth&&(v=f.minwidth),f.width=v,void 0!=f._width&&(f.__width=f._width),f._width=null,void 0!=f._percentagewidth&&(f._percentagewidth=null),this._updatecolumnwidths(),this._updatecellwidths(),this._raiseEvent(14,{columntext:f.text,column:f.getcolumnproperties(),datafield:b,displayfield:f.displayfield,oldwidth:w,newwidth:v}),this._renderrows(this.virtualsizeinfo),void 0!=f._width&&(f._width=f.__width)}},_handlecolumnsresize:function(){var b=this.that;if(this.columnsresize){var c=!1;b.isTouchDevice()&&!0!==b.touchmode&&(c=!0);var d="mousemove.resize"+this.element.id,e="mousedown.resize"+this.element.id,f="mouseup.resize"+this.element.id;if(c)var d=a.jqx.mobile.getTouchEventName("touchmove")+".resize"+this.element.id,e=a.jqx.mobile.getTouchEventName("touchstart")+".resize"+this.element.id,f=a.jqx.mobile.getTouchEventName("touchend")+".resize"+this.element.id;this.removeHandler(a(document),d),this.addHandler(a(document),d,function(d){if(null!=a.data(document.body,"contextmenu"+b.element.id)&&b.autoshowcolumnsmenubutton)return!0;if(null!=b.resizablecolumn&&!b.disabled&&b.resizing&&null!=b.resizeline){var e=(b.resizablecolumn.columnelement,b.host.coord()),f=parseInt(b.resizestartline.coord().left),g=f-b._startcolumnwidth,h=b.resizablecolumn.column.minwidth;h="auto"==h?0:parseInt(h);var i=b.resizablecolumn.column.maxwidth;i="auto"==i?0:parseInt(i);var j=d.pageX;if(c){j=b.getTouches(d)[0].pageX}g+=h;var k=i>0?f+i:0,l=0==i||b._startcolumnwidth+j-f<i;if(b.rtl)var l=!0;if(l)if(b.rtl){if(j>=e.left&&j<=e.left+b.host.width()&&(b.resizeline.css("left",j),c))return!1}else if(j>=e.left&&j>=g&&(0!=k&&d.pageX<k?b.resizeline.css("left",j):0==k&&b.resizeline.css("left",j),c))return!1}return!(!c&&null!=b.resizablecolumn)&&void 0}),this.removeHandler(a(document),e),this.addHandler(a(document),e,function(c){if(null!=a.data(document.body,"contextmenu"+b.element.id)&&b.autoshowcolumnsmenubutton)return!0;if(null!=b.resizablecolumn&&!b.disabled){var d=b.resizablecolumn.columnelement;if(d.coord().top+d.height()+5<c.pageY)return void(b.resizablecolumn=null);if(d.coord().top-5>c.pageY)return void(b.resizablecolumn=null);if(b._startcolumnwidth=b.resizablecolumn.column.width,b.resizablecolumn.column._width=null,a(document.body).addClass("jqx-disableselect"),a(document.body).addClass("jqx-position-reset"),b.host.addClass("jqx-disableselect"),b.content.addClass("jqx-disableselect"),b._mouseDownResize=new Date,b.resizing=!0,b._lastmouseDownResize&&b.columnsautoresize&&b._lastmouseDownResize-b._mouseDownResize<300&&b._lastmouseDownResize-b._mouseDownResize>-500){var e=b.resizablecolumn.column;if(e.resizable){var f=(b.resizablecolumn.column.width,b.hScrollBar[0].style.visibility);return b._resizecolumn=null,b.resizeline.hide(),b.resizestartline.hide(),b.resizebackground.remove(),b.resizablecolumn=null,b.columndragstarted=!1,b.dragmousedown=null,b.__drag=!1,b.autoresizecolumn(e.displayfield,"all"),f!=b.hScrollBar[0].style.visibility&&b.hScrollInstance.setPosition(0),b.rtl&&b._arrange(),b.autosavestate&&b.savestate&&b.savestate(),c.stopPropagation(),b.suspendClick=!0,setTimeout(function(){b.suspendClick=!1},100),!1}}b._lastmouseDownResize=new Date,b._resizecolumn=b.resizablecolumn.column,b.resizeline=b.resizeline||a('<div style="position: absolute;"></div>'),b.resizestartline=b.resizestartline||a('<div style="position: absolute;"></div>'),b.resizebackground=b.resizebackground||a('<div style="position: absolute; left: 0; top: 0; background: #000;"></div>'),b.resizebackground.css("opacity",.01),b.resizebackground.css("cursor","col-resize"),b.resizeline.css("cursor","col-resize"),b.resizestartline.css("cursor","col-resize"),b.resizeline.addClass(b.toThemeProperty("jqx-grid-column-resizeline")),b.resizestartline.addClass(b.toThemeProperty("jqx-grid-column-resizestartline")),a(document.body).append(b.resizeline),a(document.body).append(b.resizestartline),a(document.body).append(b.resizebackground);var g=b.resizablecolumn.columnelement.coord();b.resizebackground.css("left",b.host.coord().left),b.resizebackground.css("top",b.host.coord().top),b.resizebackground.width(b.host.width()),b.resizebackground.height(b.host.height()),b.resizebackground.css("z-index",9999);var h=function(a){b.rtl?a.css("left",parseInt(g.left)):a.css("left",parseInt(g.left)+b._startcolumnwidth);var c=b._groupsheader(),d=c?b.groupsheader.height():0;d+=b.showtoolbar?b.toolbarheight:0,d+=b.showstatusbar?b.statusbarheight:0;var e=0;b.pageable&&(e=b.pagerheight);var f="visible"==b.hScrollBar.css("visibility")?17:0;a.css("top",parseInt(g.top)),a.css("z-index",99999),b.columngroups?a.height(b.host.height()+b.resizablecolumn.columnelement.height()-e-d-f-b.columngroupslevel*b.columnsheight):a.height(b.host.height()-e-d-f),b.enableanimations?a.show("fast"):a.show()};h(b.resizeline),h(b.resizestartline),b.dragmousedown=null}});var g=function(){if(a(document.body).removeClass("jqx-disableselect"),a(document.body).removeClass("jqx-position-reset"),(b.showfilterrow||b.showstatusbar||b.showtoolbar||b.enablebrowserselection)&&(b.host.removeClass("jqx-disableselect"),b.content.removeClass("jqx-disableselect")),b.resizing){b._mouseUpResize=new Date;if(b._mouseUpResize-b._mouseDownResize<200)return b.resizing=!1,void(null!=b._resizecolumn&&null!=b.resizeline&&"block"==b.resizeline.css("display")&&(b._resizecolumn=null,b.resizeline.hide(),b.resizestartline.hide(),b.resizebackground.remove()));if(b.resizing=!1,!b.disabled){var c=b.host.width();if("hidden"!=b.vScrollBar[0].style.visibility&&(c-=20),c<0&&(c=0),null!=b._resizecolumn&&null!=b.resizeline&&"block"==b.resizeline.css("display")){var d=parseInt(b.resizeline.css("left")),e=parseInt(b.resizestartline.css("left")),f=b._startcolumnwidth+d-e;if(b.rtl)var f=b._startcolumnwidth-d+e;var g=b._resizecolumn.width;b._closemenu(),f<b._resizecolumn.minwidth&&(f=b._resizecolumn.minwidth),b._resizecolumn.width=f,void 0!=b._resizecolumn._percentagewidth&&(b._resizecolumn._percentagewidth=f/c*100);for(var h=0;h<b._columns.length;h++)if(b._columns[h].datafield===b._resizecolumn.datafield){b._columns[h].width=b._resizecolumn.width,b._columns[h].width<b._resizecolumn.minwidth&&(b._columns[h].width=b._resizecolumn.minwidth);break}var i=b.hScrollBar[0].style.visibility;b._updatecolumnwidths(),b._updatecellwidths(),b._raiseEvent(14,{columntext:b._resizecolumn.text,column:b._resizecolumn.getcolumnproperties(),datafield:b._resizecolumn.datafield,oldwidth:g,newwidth:f}),b._renderrows(b.virtualsizeinfo),b.autosavestate&&b.savestate&&b.savestate(),i!=b.hScrollBar[0].style.visibility&&b.hScrollInstance.setPosition(0),b.rtl&&b._arrange(),b._resizecolumn=null,b.resizeline.hide(),b.resizestartline.hide(),b.resizebackground.remove(),b.resizablecolumn=null}else b.resizablecolumn=null}}};try{if(""!=document.referrer||window.frameElement){var h=null;if(null!=window.top&&window.top!=window.self&&window.parent&&document.referrer&&(h=document.referrer),h&&-1!=h.indexOf(document.location.host)){var i=function(a){g()};window.top.document.addEventListener?window.top.document.addEventListener("mouseup",i,!1):window.top.document.attachEvent&&window.top.document.attachEvent("onmouseup",i)}}}catch(a){}this.removeHandler(a(document),f),this.addHandler(a(document),f,function(c){if(null!=a.data(document.body,"contextmenu"+b.element.id)&&b.autoshowcolumnsmenubutton)return!0;g()})}}})}(jqxBaseFramework);
