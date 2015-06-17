	var cookieScripts = document.getElementsByTagName("script"),
    cookieScriptSrc = cookieScripts[cookieScripts.length-1].src,
	cookieQuery = null,
	cookieScriptPosition = "bottom",
	cookieScriptSource = "cookie-script.com",
	cookieScriptDomain = "",
	cookieScriptReadMore = "https://datavacature.nl/privacycookies",
	cookieId="dabedb59533d631813360df6f31b7b2e",
	cookieScriptDebug = 0,
	cookieScriptTitle= '<h4 id="cookiescript_header">Datavacature.nl gebruikt Cookies</h4>',
	cookieScriptDesc= "Wij gebruiken cookies voor het verbeteren van de gebruikerservaring. door het accepteren ga je akkoord met onze Cookie verklaring.<br \/>",
	cookieScriptAccept='Accepteren',
	cookieScriptMore='Meer informatie',
	cookieScriptCopyrights='Accepteren',
	cookieBackground='#111',
	cookieTextColor='#FFF',
	cookieScriptLoadJavaScript = function (d, b) {
        var c = document.getElementsByTagName("head")[0],
            a = document.createElement("script");
        a.type = "text/javascript", a.src = d, b != undefined && (a.onload = a.onreadystatechange = function () {
            (!a.readyState || /loaded|complete/.test(a.readyState)) && (a.onload = a.onreadystatechange = null, c && a.parentNode && c.removeChild(a), a = undefined, b())
        }), c.insertBefore(a, c.firstChild)
    }, 
	
	InjectCookieScript = function () {
				
		cookieScriptCreateCookie = function (n, t, i) {
			var u = "",
				r, f;
			i && (r = new Date, r.setTime(r.getTime() + i * 864e5), u = "; expires=" + r.toGMTString()), f = "", cookieScriptDomain != "" && (f = "; domain=" + cookieScriptDomain), document.cookie = n + "=" + t + u + f + "; path=/"
		}, 
		
		cookieScriptReadCookie = function (n) {
			for (var r = n + "=", u = document.cookie.split(";"), t, i = 0; i < u.length; i++) {
				for (t = u[i]; t.charAt(0) == " ";) t = t.substring(1, t.length);
				if (t.indexOf(r) == 0) return t.substring(r.length, t.length)
			}
			return null
		};
        cookieQuery(function () {
			/*if (window!=window.top) { cookieScriptWindow=window.parent.document }	
			else */
			cookieScriptWindow=window.document;
			cookieQuery("#cookiescript_injected",cookieScriptWindow).remove();
			cookieQuery("#cookiescript_overlay",cookieScriptWindow).remove();
			cookieQuery("#cookiescript_info_box",cookieScriptWindow).remove();
						if(cookieScriptReadCookie("cookiescriptaccept") == "visit") 
				return false; 
			            cookieQuery("body",cookieScriptWindow).append('<div id="cookiescript_injected"><div id="cookiescript_wrapper">'+cookieScriptTitle+cookieScriptDesc+'<div id="cookiescript_buttons"><div id="cookiescript_accept">'+cookieScriptAccept+'</div><div id="cookiescript_readmore">'+cookieScriptMore+'</div></div><a href="//'+cookieScriptSource+'" target="_blank" id="cookiescript_link" style="display:none !important">Free cookie consent by cookie-script.com</a><div id="cookiescript_pixel"></div></div>');
            cookieQuery("#cookiescript_injected",cookieScriptWindow).css({
               "background-color": "#111111",
                "z-index": 999999,
                opacity: 1,
                position: "fixed",
                padding: "15px 0px 5px 0",
                width: "100%",
				left: 0,
				"font-size": "13px",
				"font-weight": "normal",
                "text-align": "left",
                color: "#FFFFFF",
                "font-family": "Arial, sans-serif",
                display: "none",
				"-moz-box-shadow": "0px 0px 8px #000000",
				"-webkit-box-shadow": "0px 0px 8px #000000",
				"box-shadow": "0px 0px 8px #000000"
            });
			
			cookieQuery("#cookiescript_buttons",cookieScriptWindow).css({
				width: "240px",
				"margin":"0 auto",
				"font-size": "13px",
				"font-weight": "normal",
                "text-align": "center",
                "font-family": "Arial, sans-serif"
            });
			cookieQuery("#cookiescript_wrapper",cookieScriptWindow).css({
				width: "100%",
				"margin":"0 auto",
				"font-size": "13px",
				"font-weight": "normal",
                "text-align": "center",
                color: "#FFFFFF",
                "font-family": "Arial, sans-serif",
				"line-height": "18px"
            });
			
            if (cookieScriptPosition == "top") {
                cookieQuery("#cookiescript_injected",cookieScriptWindow).css("top", 0);
				
            } else {
                cookieQuery("#cookiescript_injected",cookieScriptWindow).css("bottom", 0);
            }
			
			cookieQuery("#cookiescript_injected h4#cookiescript_header",cookieScriptWindow).css({
                "background-color": "#111111",
                "z-index": 999999,
                padding: "0 0 7px 0",
                "text-align": "center",
                color: "#FFFFFF",
                "font-family": "Arial, sans-serif",
				 display: "block",
                "font-size": "15px",
				"font-weight": "bold",
                margin: "0"
            });
			
            cookieQuery("#cookiescript_injected span",cookieScriptWindow).css({
                display: "block",
                "font-size": "100%",
                margin: "5px 0"
            });
            cookieQuery("#cookiescript_injected a",cookieScriptWindow).css({
                "text-decoration": "underline",
                color: cookieTextColor
            }); 
           
			 cookieQuery("#cookiescript_injected a#cookiescript_link",cookieScriptWindow).css({
                "text-decoration": "none", 
                color: "#FFFFFF",
                "font-size": "85%",
                "text-decoration": "none",
                "float": "right",
				padding: "0px 10px 0 0"
                
            });
             cookieQuery("#cookiescript_injected div#cookiescript_accept,#cookiescript_injected div#cookiescript_readmore",cookieScriptWindow).css({
                "-webkit-border-radius": "5px",
                "-khtml-border-radius": "5px",
                "-moz-border-radius": "5px",
                "border-radius": "5px",
                border: 0,
                padding: "6px 10px",
                "font-weight": "bold",
				"font-size": "13px",
                cursor: "pointer",
                margin: "5px 0px",
				"-webkit-transition": "0.25s",
				"-moz-transition": "0.25s",
				"transition": "0.25s",
				"text-shadow": "rgb(0, 0, 0) 0px 0px 2px"
            });
            cookieQuery("#cookiescript_injected div#cookiescript_readmore",cookieScriptWindow).css({
                "background-color": "#7B8A8B",
				color: "#FFFFFF",
				"float": "right"
            });
			cookieQuery("#cookiescript_injected div#cookiescript_accept",cookieScriptWindow).css({
                "background-color": "#5BB75B",
				color: "#FFFFFF",
				"float": "left"
            });
			 
			cookieQuery("#cookiescript_injected div#cookiescript_pixel",cookieScriptWindow).css({
				"width": "1px",
				"height":"1px",
				"float": "left"
            });
						
			/*cookieQuery("#cookiescript_injected div#cookiescript_accept",cookieScriptWindow).hover( function(){
				cookieQuery(this).css('background-color', '#51a351');
			},function(){
				cookieQuery(this).css('background-color', '#5bb75b');
			});
			
			
			cookieQuery('#cookiescript_injected div#cookiescript_readmore').hover( function(){
				cookieQuery(this).css('background-color', '#697677');
			},function(){
				cookieQuery(this).css('background-color', '#7B8A8B');
			});
			*/
			
			
            cookieQuery("#cookiescript_injected",cookieScriptWindow).fadeIn(1000); 
			
			
			
			cookieQuery("#cookiescript_injected div#cookiescript_accept",cookieScriptWindow).click(function(){
								cookieScriptAcceptFunction();
			}); 
			
			cookieQuery("#cookiescript_injected div#cookiescript_readmore",cookieScriptWindow).click(function(){
								
								window.open(cookieScriptReadMore, '_blank');
				return false;
								
			})
			
			cookieQuery("#cookiescript_overlay",cookieScriptWindow).click(function(){
				cookieScriptDoBox("hide");
			});
			
			cookieQuery("#cookiescript_info_close",cookieScriptWindow).click(function(){
				cookieScriptDoBox("hide");
			});
			
			document.onkeydown = function(evt) {
				evt = evt || window.event;
				if (evt.keyCode == 27) {
					cookieScriptDoBox("hide");
				}
			};
			        });  
		function cookieScriptAcceptFunction(){
			cookieQuery("#cookiescript_injected",cookieScriptWindow).fadeOut(200);
			cookieScriptCreateCookie("cookiescriptaccept", "visit", 30);
			cookieScriptDoBox("hide");
			cookieScriptAllowJS();
		}
		function cookieScriptDoBox(action) {	
			if (action == "show") {
				cookieQuery("#cookiescript_overlay",cookieScriptWindow).show();
				cookieQuery("#cookiescript_info_box",cookieScriptWindow).show();
			} else if (action == "hide") {
				cookieQuery("#cookiescript_overlay",cookieScriptWindow).hide();
				cookieQuery("#cookiescript_info_box",cookieScriptWindow).hide();
			}
		}
		
	(function (factory) {
			if (typeof define === 'function' && define.amd) {
				// AMD
				define(['jquery'], factory);
			} else if (typeof exports === 'object') {
				// CommonJS
				factory(require('jquery'));
			} else {
				// Browser globals
				factory(cookieQuery);
			}
		}
		(function (cookieQuery) {
		
			var pluses = /\+/g;
		
			function encode(s) {
				return config.raw ? s : encodeURIComponent(s);
			}
		
			function decode(s) {
				return config.raw ? s : decodeURIComponent(s);
			}
		
			function stringifyCookieValue(value) {
				return encode(config.json ? JSON.stringify(value) : String(value));
			}
		
			function parseCookieValue(s) {
				if (s.indexOf('"') === 0) {
					// This is a quoted cookie as according to RFC2068, unescape...
					s = s.slice(1, -1).replace(/\\"/g, '"').replace(/\\\\/g, '\\');
					
				}
		
				try {
					// Replace server-side written pluses with spaces.
					// If we can't decode the cookie, ignore it, it's unusable.
					// If we can't parse the cookie, ignore it, it's unusable.
					s = decodeURIComponent(s.replace(pluses, ' '));
					return config.json ? JSON.parse(s) : s;
				} catch(e) {}
			}
		
			function read(s, converter) {
				var value = config.raw ? s : parseCookieValue(s);
				return cookieQuery.isFunction(converter) ? converter(value) : value;
			}
		
			var config = cookieQuery.cookie = function (key, value, options) {
		
				// Write
		
				if (value !== undefined && !cookieQuery.isFunction(value)) {
					options = cookieQuery.extend({}, config.defaults, options);
		
					if (typeof options.expires === 'number') {
						var days = options.expires, t = options.expires = new Date();
						t.setTime(+t + days * 864e+5);
					}
		
					return (document.cookie = [
						encode(key), '=', stringifyCookieValue(value),
						options.expires ? '; expires=' + options.expires.toUTCString() : '', // use expires attribute, max-age is not supported by IE
						options.path    ? '; path=' + options.path : '',
						options.domain  ? '; domain=' + options.domain : '',
						options.secure  ? '; secure' : ''
					].join(''));
				}
		
				// Read
		
				var result = key ? undefined : {};
		
				// To prevent the for loop in the first place assign an empty array
				// in case there are no cookies at all. Also prevents odd result when
				// calling $.cookie().
				var cookies = document.cookie ? document.cookie.split('; ') : [];
		
				for (var i = 0, l = cookies.length; i < l; i++) {
					var parts = cookies[i].split('=');
					var name = decode(parts.shift());
					var cookie = parts.join('=');
		
					if (key && key === name) {
						// If second argument (value) is a function it's a converter...
						result = read(cookie, value);
						break;
					}
		
					// Prevent storing a cookie that we couldn't decode.
					if (!key && (cookie = read(cookie)) !== undefined) {
						result[name] = cookie;
					}
				}
		
				return result;
			};
		
			config.defaults = {};
		
			cookieQuery.removeCookie = function (key, options) {
				if (cookieQuery.cookie(key) === undefined) {
					return false;
				}
				if(key=='gifexclusioncookiecheck') {return false;}
				// Must not alter options, thus extending a fresh object...
				cookieQuery.cookie(key, '', cookieQuery.extend({}, options, { expires: -1 }));
				return !cookieQuery.cookie(key);
			};
		 
		}));
		function cookieScriptClearAllCookies(){
			if(cookieScriptDebug)
			{
				console.log(window.location.host);
				console.log(cookieQuery.cookie());
			}
			var cookies = cookieQuery.cookie();
			for(var cookie in cookies) {
				if(!cookieQuery.removeCookie(cookie))
				{
					cookiePossibleHosts=[window.location.host, '.'+window.location.host];
					//now removing subdomains
					var regexParse = new RegExp('[a-z\-0-9]{2,63}\.[a-z\.]{2,5}$');
					var urlParts = regexParse.exec(window.location.host);
					var cookieSubdomain=window.location.host.replace(urlParts[0],'').slice(0, -1);
					if(cookieSubdomain != '') cookiePossibleHosts.push(window.location.host.substr(cookieSubdomain.length));
					for(var cookiePossibleHost in cookiePossibleHosts)
					{	
						if(cookieQuery.removeCookie(cookie, { path: '/',domain: cookiePossibleHosts[cookiePossibleHost] }) && cookieScriptDebug)
						console.log('deleting cookie:'+cookie+'| domain:'+cookiePossibleHosts[cookiePossibleHost]);
					} 
				}
			}
		}
		if(cookieScriptReadCookie('cookiescriptaccept') != 'visit') 
			setTimeout(cookieScriptClearAllCookies,500);
		
		function cookieScriptAllowJS(){
			cookieQuery('script.cscookiesaccepted'+'[type="text/plain"]').each(function () {
				if (cookieQuery(this).attr('src')) {
					cookieQuery(this).after('<script type="text/javascript" src="' + cookieQuery(this).attr("src") + '"><\/script>')
				} else {
					cookieQuery(this).after('<script type="text/javascript">' + cookieQuery(this).html() + '<\/script>')
				}
				cookieQuery(this).empty();
       		});
		}
		if(cookieScriptReadCookie('cookiescriptaccept') == 'visit') 
			cookieScriptAllowJS();	
    };

window.jQuery && jQuery.fn && /^(1\.[8-9]|2\.[0-9])/.test(jQuery.fn.jquery) ? (cookieScriptDebug && window.console && console.log("Using existing jQuery version " + jQuery.fn.jquery), cookieQuery = window.jQuery, InjectCookieScript()) : (cookieScriptDebug && window.console && console.log("Loading jQuery 1.8.1 from ajax.googleapis.com"), cookieScriptLoadJavaScript(("https:" == document.location.protocol ? "https://" : "http://") + "ajax.googleapis.com/ajax/libs/jquery/1.8.1/jquery.min.js", function () {cookieQuery = jQuery.noConflict(!0), InjectCookieScript();}));