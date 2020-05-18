var stompClient = null;

function setConnected() {
	$("#connect").prop("disabled", connected);
    $("#disconnect").prop("disabled", !connected);
    if (connected) {
        $("#conversation").show();
    }
    else {
        $("#conversation").hide();
    }
	$("#notice").html("");
}

function connect() {
	var from = $("#from").val();
	var socket = new SockJS('/endpoint-websocket');
	stompClient = Stomp.over(socket);
	stompClient.connect({}, function(frame) {
		setConnected(true);
		console.log('Connected: ' + frame);
        stompClient.subscribe('/chat/single/' + from, function (result) {
            showOnlieUser(JSON.parse(result.body));
        });
	});
}

function disconnect() {
	if (stompClient !== null) {
		stompClient.disconnect();
	}
	setConnected(false);
	console.log("Disconnected");
}

function sendName() {
	stompClient.send("/app/ptp/single/chat", {}, JSON.stringify({
		'content' : $("#content").val(),
		'to' : $("#to").val(),
		'from' : $("#from").val()
	}));
}

function showContent(body) {
	$("#notice").append(
			"<tr><td>" + body.content + "</td> <td>"
					+ new Date(body.time).toLocaleString() + "</td></tr>");
}

$(function() {
	
	connect();
	
	$("form").on('submit', function(e) {
		e.preventDefault();
	});
	$("#disconnect").click(function() {
		disconnect();
	});
	$("#send").click(function() {
		sendName();
	});
});
