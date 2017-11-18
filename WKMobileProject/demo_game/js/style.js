/*! 移动端自适应 - v0.0.2 - 2015-04-15 09:40:27
 * Copyright (c) 2015
 * Powered by Manwei Team LIUQ
*/
(function(d,c){var e=d.documentElement,a="orientationchange" in window?"orientationchange":"resize",b=function(){var g=e.clientWidth;var f=e.clientHeight;if(!g){return}if(g>=320&&g<=640){e.style.fontSize=g/6.4+"px"}else{if(g<320){e.style.fontSize=320/6.4+"px"}else{if(g>640){e.style.fontSize=640/6.4+"px"}}}};if(!d.addEventListener){return}c.addEventListener(a,b,false);d.addEventListener("DOMContentLoaded",b,false)})(document,window);