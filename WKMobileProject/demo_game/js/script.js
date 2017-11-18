var fApp = function(){
	
	wxmSlider = null;
	wxmLoader = null;
	wxmAnalytics = null;
	//wxmPlayer = null;
	
	var handleWxmSlider = function(){
		if( $("body.use-wxmslider").length > 0){
			var sel = $("body").data("wxmslider");
			sel = sel ? sel : ".screen";
			wxmSlider = new WxMoment.PageSlider({
	            pages: document.querySelectorAll(sel)
	        });
		}
	};
	
	return {
		init: function(){
			//handleWxmSlider();
			//handleTvpVideo();
		},
		slider: function(selector){
			if(!selector){
				if( $("body.use-wxmslider").length > 0){
					var sel = $("body").data("wxmslider");
					if(sel && sel != ''){
						selector = sel;
					}
				}
			}
			if(selector){
				var slider = new WxMoment.PageSlider({
		            pages: document.querySelectorAll(sel)
		        });
		        return slider;
			}
		    return null;
		},
		load: function(imgs){
			wxmLoader = new WxMoment.Loader();
			if(imgs){
				for(var url in imgs){
					wxmLoader.addImage(imgs[url]);
				}
			}
			return wxmLoader;
		},
		analytics: function(prj){
			wxmAnalytics = new WxMoment.Analytics({
			    projectName: prj
			});
			return wxmAnalytics;
		},
		video: function(selector, vid, options){
			var screenHeight = document.documentElement.clientHeight,screenWidth = document.documentElement.clientWidth;
			var video = new tvp.VideoInfo();
			var videoWidth = screenWidth - 20;
			var videoHeight = videoWidth * (1080 / 1920);
			var isFullScreen=false;
			$selector = $(selector);
			$selector.find(".video-box").css({"width": videoWidth, "height": videoHeight});
			$selector.find(".video-wrap").css("margin-left", -videoWidth / 2);
			var playerid = $selector.find(".video-box")[0].getAttribute("id");
			video.setVid(vid);
			player = new tvp.Player();
			var option = {
				width: '100%',
				height: '100%',
				video: video,
				modId: playerid,
				isHtml5ControlAlwaysShow: false,
				isHtml5UseUI: true,
				html5LiveUIFeature: false,
				isHtml5UseFakeFullScreen: false,
				isiPhoneShowPlaysinline: true,
				vodFlashExtVars: {
					share: 0, follow: 0, showlogo: 0, clientbar: 0
				},
				plugins: {
					AppBanner: 0,
					AppRecommend: 0
				},
				autoplay: false,
				onplay: function () {
					// 开始加载视频资源准备播放
				},				
				onplaying: function () {
					if(options.beginPlayingEvent){
						options.beginPlayingEvent();
					}
					// 开始播放视频第一帧
					// 去掉视频缩略图
					console.log("player.onplaying", $selector.find(".tvp_shadow"));
					$('#' + playerid).addClass('mod_player_off');
					$selector.find(".tvp_shadow").css("display", "none");
					flag = 1;
					$selector.find(".video-control").css("opacity", "1");
				},
				onpause: function () {
					// 当输出播放器时
					flag = 0;
					if(!isFullScreen) $selector.find(".tvp_shadow").css("display", "block");
				},
				onallended: function () {
					//播放到最后完毕
					//doSomething();
				},
				onfullscreen: function (a) {
					isFullScreen=a;
					// alert(parseInt(player.getPlayer().currentTime) + 'xx' + parseInt(player.getPlayer().duration))
					// 用户点击 done 退出全屏的时候 a 为 false
					// 切当前已播放时长等于视频总时长才触发
					$selector.find(".video-control").css("opacity", "0");
					var currentTime = parseInt(player.getPlayer().currentTime);
					var fulltTime = parseInt(player.getPlayer().duration);

					// 若没放完成，则会返回时长是 0
					if (!a && currentTime && fulltTime && currentTime == fulltTime) {
						// 执行后面的动画 -> 设备动画小于 iPhone 5c
						// 注意这种情况下,包括最上方的 onallended , doSomething(),执行了两遍, 有些事件需要先解绑在绑定
						//doSomething();
					}
				}
			} || options;
			player.create(option);
			var $control = $selector.find("video-control");
			$control.on("touchstart", function () {
				if (flag == 0) {
					player.getPlayer().play();
					$control.removeClass("video-control_play");
				}
				else {
					player.getPlayer().pause();
					$control.addClass("video-control_play");
				}
			});
			player.debug_selector = $selector;
			return player;
		},
        browser : {
            versions: function () {
                var u = navigator.userAgent, app = navigator.appVersion;
                return {//移动终端浏览器版本信息 
                    trident: u.indexOf('Trident') > -1, //IE内核
                    presto: u.indexOf('Presto') > -1, //opera内核
                    webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
                    gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核
                    mobile: !!u.match(/AppleWebKit.*Mobile.*/) || !!u.match(/AppleWebKit/), //是否为移动终端
                    ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
                    android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或者uc浏览器
                    iPhone: u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1, //是否为iPhone或者QQHD浏览器
                    iPad: u.indexOf('iPad') > -1, //是否iPad
                    webApp: u.indexOf('Safari') == -1 //是否web应该程序，没有头部与底部
                };
            } (),
            language: (navigator.browserLanguage || navigator.language).toLowerCase()
        }
		
		
	}
	
}();