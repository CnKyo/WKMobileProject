/**
 * Created by liuqiang on 16/6/27.
 * 整合mwcloudapi提交接口方便以后项目中使用
 * 基于Zepto.js
 */
(function($, owner) {	
    //判断访问终端
    owner.browser={
        versions:function(){
            var u = navigator.userAgent, app = navigator.appVersion;
            return {
                trident: u.indexOf('Trident') > -1, //IE内核
                presto: u.indexOf('Presto') > -1, //opera内核
                webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
                gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1,//火狐内核
                mobile: !!u.match(/AppleWebKit.*Mobile.*/), //是否为移动终端
                ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
                android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或者uc浏览器
                iPhone: u.indexOf('iPhone') > -1 , //是否为iPhone或者QQHD浏览器
                iPad: u.indexOf('iPad') > -1, //是否iPad
                MicroMessenger: u.indexOf('MicroMessenger') > -1, //是否为微信
                webApp: u.indexOf('Safari') == -1 //是否web应该程序，没有头部与底部
            };
        }(),language:(navigator.browserLanguage || navigator.language).toLowerCase()};

    //提交地址
    var post_url= "http://webapp.aboutnew.net/mwcloudapi/",
		mer_url= "http://webapp.aboutnew.net/mwcloudapi/merchant/",
		user_reg_rul= "http://webapp.aboutnew.net/mwcloudapi/user_registration/";
    var add_user_post_url= post_url+"merchant/user_add.php";
    var pay_order_post_url= post_url+"pay/order.php";
	var get_prize_url= post_url+"prize/index.php"; // 奖品
	var add_share_url= mer_url+"user_add_share.php"; // 增加分享朋友圈次数
	var bm_url= user_reg_rul+"index.php"; // 报名
	var set_thirdparty_interface_post_url=post_url+"game/thirdparty_interface.php";

    /**
     * 新用户注册
     * callbackErr 错误提示
     * callbackData 返回数据
     **/
    owner.add_user = function(appData, callbackErr,callbackData) {
        callbackErr = callbackErr || owner.noop;
        callbackData = callbackData || owner.noop;
        appData = appData || {};
        appData.openid = appData.openid || '';
        appData.wb_uid = appData.wb_uid || '';
        if (!(appData.openid || appData.wb_uid)) {
            return callbackErr('用户数据不能为空');
        }

        $.post(add_user_post_url, {
            wxoid: appData.openid,
            wbuid: appData.wb_uid,
            form_id: appData.form_id,
            merchant_id: appData.merchant_id,
            merchant_token: appData.merchant_token,
            project_id: appData.project_id,
            project_token: appData.project_token
        }, function(data) {
            if (!!Number(data.err_code)) {
                return callbackErr(data.err_msg);
            } else {
                return callbackData(data);
            }
        }, 'json');

    };
	
    /**
     * 创建支付订单
     * callbackErr 错误提示
     * callbackData 返回数据
     **/
    owner.pay_order = function(appData, callbackErr,callbackData) {
        callbackErr = callbackErr || owner.noop;
        callbackData = callbackData || owner.noop;
        appData = appData || {};
        var pay_info= appData.pay_info;
        pay_info.payee_user_id = pay_info.payee_user_id || '';
        appData.wb_uid = appData.wb_uid || '';
        if (!pay_info.payee_user_id) {
            return callbackErr('收款方不能为空');
        }
        if (!appData.user_id) {
            return callbackErr('支付方不能为空');
        }

        $.post(pay_order_post_url, {
            money: pay_info.money,//钱
            pay_way: pay_info.pay_way,//支付方式
            pay_body: pay_info.pay_body,//描述
            return_url: pay_info.return_url,//支付完成后返回地址
            payee_user_id: pay_info.payee_user_id,//收款方
            user_id: appData.user_id,//付款方
            form_id: appData.form_id,
            merchant_id: appData.merchant_id,
            merchant_token: appData.merchant_token,
            project_id: appData.project_id,
            project_token: appData.project_token
        }, function(data) {
            if (!!Number(data.err_code)) {
                return callbackErr(data.err_msg);
            } else {
                return callbackData(data);
            }
        }, 'json');

    };
    /*
     *由于微信下定单时的不稳定性，先要去访问地址有效（下定成功）
     * 再跳转到指定地址
     */
    owner.pay_url = function(url){
        $.ajax({
            url: url,
            type: 'GET',
            complete: function(response){
                if(response.status == 200){
                    console.log('有效');
                    window.location.href=url;
                }else{
                    console.log('无效');
                    setTimeout(function(){ owner.pay_url(url);},3000);
                }
            }
        });
    };

	/**
	 * 获取formid
	 */
	owner.get_formid = function(){
		//生成游戏ＮＩＤ
		var MathNum = "";
		for (var i = 0; i < 6; i++) {
			MathNum += Math.floor(Math.random() * 10);
		}
		var myDate = new Date();
		var mm = myDate.getMonth() + 1;
		var dd = myDate.getDate();
		var form_id = myDate.getFullYear().toString() + (mm > 10 ? mm.toString() : '0' + mm).toString() + (dd > 10 ? dd.toString() : '0' + dd).toString() + myDate.getTime() + MathNum;
		return form_id;
	};

	/**
	 * 提示框
	 */
	owner.msg = function(msg){
		$(".weui_dialog_bd").html(msg);
		$(".weui_dialog_alert").css("display", "block");
		$(".weui_btn_dialog").click(function() {
			$(".weui_dialog_alert").css("display", "none");
		})
	};
	
	/**
     * 抽奖
     */
	owner.get_prize = function(appData, callbackErr,callbackData) {
		callbackErr = callbackErr || owner.noop;
        callbackData = callbackData || owner.noop;
        appData = appData || {};
        appData.openid = appData.openid || '';
        appData.wb_uid = appData.wb_uid || '';
        if (!(appData.openid || appData.wb_uid)) {
            return callbackErr('用户数据不能为空');
        }

        $.post(get_prize_url, {
            wxoid : appData.openid,
			wbuid : '',
            merchant_id: appData.merchant_id,
            merchant_token: appData.merchant_token,
            project_id: appData.project_id,
            project_token: appData.project_token
        }, function(data) {
            if (!!Number(data.err_code)) {
				//we_alert("您已抢到过红包，把机会留给别人吧！");
                return callbackErr(data.err_msg);
            } else {
                return callbackData(data);
            }
        }, 'json');
	};
	
    /**
     * 查询抽奖次数
     */
    owner.check_cjcs = function(id,appData, callbackErr,callbackData) {
		callbackErr = callbackErr || owner.noop;
        callbackData = callbackData || owner.noop;
        appData = appData || {};
        appData.openid = appData.openid || '';
        appData.wb_uid = appData.wb_uid || '';
        if (!(appData.openid || appData.wb_uid)) {
            return callbackErr('用户数据不能为空');
        }

		var slimit= 0,elimit= 1;
        $.post(get_prize_url, {
            wxoid: appData.openid,
            wbuid: appData.wb_uid,
			prize_now :"1",
			user_id: id,
			slimit: slimit,
			elimit: elimit,
            form_id: appData.form_id,
            merchant_id: appData.merchant_id,
            merchant_token: appData.merchant_token,
            project_id: appData.project_id,
            project_token: appData.project_token
        }, function(data) {
            if (!!Number(data.err_code)) {
                return callbackErr(data.err_msg);
            } else {
                return callbackData(data);
            }
        }, 'json');
	};
	
	/**
     * 增加朋友圈分享次数
     */
    owner.add_share_num = function(appData, callbackErr,callbackData) {
		callbackErr = callbackErr || owner.noop;
        callbackData = callbackData || owner.noop;
        appData = appData || {};
        appData.openid = appData.openid || '';
        appData.wb_uid = appData.wb_uid || '';
        if (!(appData.openid || appData.wb_uid)) {
            return callbackErr('用户数据不能为空');
        }

        $.post(add_share_url, {
            form_id: appData.form_id,
            wxoid: appData.openid,
            merchant_id: appData.merchant_id,
            merchant_token: appData.merchant_token,
            project_id: appData.project_id,
            project_token: appData.project_token
        }, function(data) {
            if (!!Number(data.err_code)) {
                return callbackErr(data.err_msg);
            } else {
                return callbackData(data);
            }
        }, 'json');
	};
	
	/**
     * 查询当前用户本次活动获得的奖品
     */
	owner.check_prize_now = function(appData, callbackErr,callbackData) {
		callbackErr = callbackErr || owner.noop;
        callbackData = callbackData || owner.noop;
        appData = appData || {};
        appData.openid = appData.openid || '';
        appData.wb_uid = appData.wb_uid || '';
        if (!(appData.openid || appData.wb_uid)) {
            return callbackErr('用户数据不能为空');
        }

		var slimit= 0,elimit= 1;
        $.post(get_prize_url, {
            wxoid : appData.openid,
			wbuid : '',
			count :"1",
			slimit: slimit,
			elimit: elimit,
			form_id : appData.form_id,
            merchant_id: appData.merchant_id,
            merchant_token: appData.merchant_token,
            project_id: appData.project_id,
            project_token: appData.project_token
        }, function(data) {
            if (!!Number(data.err_code)) {
                return callbackErr(data.err_msg);
            } else {
                return callbackData(data);
            }
        }, 'json');
	};
	
	/**
     * 查询剩余奖品数量
     */
	owner.check_sy_prize = function(appData, callbackErr,callbackData) {
		callbackErr = callbackErr || owner.noop;
        callbackData = callbackData || owner.noop;
        appData = appData || {};
        appData.openid = appData.openid || '';
        appData.wb_uid = appData.wb_uid || '';
        if (!(appData.openid || appData.wb_uid)) {
            return callbackErr('用户数据不能为空');
        }

        $.post(get_prize_url, {
            wxoid : appData.openid,
			wbuid : '',
			prize_now: 1,
			form_id : appData.form_id,
            merchant_id: appData.merchant_id,
            merchant_token: appData.merchant_token,
            project_id: appData.project_id,
            project_token: appData.project_token
        }, function(data) {
            if (!!Number(data.err_code)) {
                return callbackErr(data.err_msg);
            } else {
                return callbackData(data);
            }
        }, 'json');
	};
	
	/**
     * 查询是否提交手机号
     */
	owner.check_tel = function(appData, callbackErr,callbackData) {
		callbackErr = callbackErr || owner.noop;
        callbackData = callbackData || owner.noop;
        appData = appData || {};
        appData.openid = appData.openid || '';
        appData.wb_uid = appData.wb_uid || '';
        if (!(appData.openid || appData.wb_uid)) {
            return callbackErr('用户数据不能为空');
        }

        $.post(bm_url, {
            wxoid : appData.openid,
			is_add: 1,
			parameter_name: "registration_tel",
            merchant_id: appData.merchant_id,
            merchant_token: appData.merchant_token,
            project_id: appData.project_id,
            project_token: appData.project_token
        }, function(data) {
            if (!!Number(data.err_code)) {
                return callbackErr(data.err_msg);
            } else {
                return callbackData(data);
            }
        }, 'json');
	};

	/**
     * 查询本次活动分享朋友圈次数
     */
	owner.check_share_num = function(appData, callbackErr,callbackData) {
		callbackErr = callbackErr || owner.noop;
        callbackData = callbackData || owner.noop;
        appData = appData || {};
        appData.openid = appData.openid || '';
        appData.wb_uid = appData.wb_uid || '';
        if (!(appData.openid || appData.wb_uid)) {
            return callbackErr('用户数据不能为空');
        }

        $.post(add_share_url, {
            form_id: appData.form_id,
            wxoid: appData.openid,
			count:"1",
			slimit:0,
			elimit:1,
            merchant_id: appData.merchant_id,
            merchant_token: appData.merchant_token,
            project_id: appData.project_id,
            project_token: appData.project_token
        }, function(data) {
            if (!!Number(data.err_code)) {
                return callbackErr(data.err_msg);
            } else {
                return callbackData(data);
            }
        }, 'json');
	};

	/**
     * 第三方接口发送数据
     * interface_id 接口id
     * interface_data 接口数据
     * callbackErr 错误提示
     * callbackData 返回数据
     **/
    owner.set_thirdparty_interface = function(appData, callbackErr,callbackData) {
        callbackErr = callbackErr || owner.noop;
        callbackData = callbackData || owner.noop;
        appData = appData || {};
        var interface_arr = appData.interface_arr ||owner.noop;
        if (!interface_arr) {
            return callbackErr('用户数据不能为空');
        }
       	
        $.post(set_thirdparty_interface_post_url, {
            user_id: appData.user_id,
            interface_user: appData.interface_user,
            interface_arr:interface_arr ,
            form_id: appData.form_id,
            merchant_id: appData.merchant_id,
            merchant_token: appData.merchant_token,
            project_id: appData.project_id,
            project_token: appData.project_token
        }, function(data) {
            if (!!Number(data.err_code)) {
                return callbackErr(data.err_msg);
            } else {
                return callbackData(data);
            }
        }, 'json');

    };

    /**
     * noop(function)
     */
    owner.noop = function() {};

}(Zepto, window.mwapi = {}));