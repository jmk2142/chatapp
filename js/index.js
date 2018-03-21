// $(".messages").animate({ scrollTop: $(document).height() }, "fast");
//
// $("#profile-img").click(function() {
// 	$("#status-options").toggleClass("active");
// });
//
// $(".expand-button").click(function() {
//   $("#profile").toggleClass("expanded");
// 	$("#contacts").toggleClass("expanded");
// });
//
// $("#status-options ul li").click(function() {
// 	$("#profile-img").removeClass();
// 	$("#status-online").removeClass("active");
// 	$("#status-away").removeClass("active");
// 	$("#status-busy").removeClass("active");
// 	$("#status-offline").removeClass("active");
// 	$(this).addClass("active");
//
// 	if($("#status-online").hasClass("active")) {
// 		$("#profile-img").addClass("online");
// 	} else if ($("#status-away").hasClass("active")) {
// 		$("#profile-img").addClass("away");
// 	} else if ($("#status-busy").hasClass("active")) {
// 		$("#profile-img").addClass("busy");
// 	} else if ($("#status-offline").hasClass("active")) {
// 		$("#profile-img").addClass("offline");
// 	} else {
// 		$("#profile-img").removeClass();
// 	};
//
// 	$("#status-options").removeClass("active");
// });
//
// function newMessage() {
// 	message = $(".message-input input").val();
// 	if($.trim(message) == '') {
// 		return false;
// 	}
// 	$('<li class="sent"><img src="http://emilcarlsson.se/assets/mikeross.png" alt="" /><p>' + message + '</p></li>').appendTo($('.messages ul'));
// 	$('.message-input input').val(null);
// 	$('.contact.active .preview').html('<span>You: </span>' + message);
// 	$(".messages").animate({ scrollTop: $(document).height() }, "fast");
// };
//
// $('.submit').click(function() {
//   newMessage();
// });
//
// $(window).on('keydown', function(e) {
//   if (e.which == 13) {
//     newMessage();
//     return false;
//   }
// });

function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+ d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for(var i = 0; i <ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}
