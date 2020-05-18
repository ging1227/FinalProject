<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Hello WebSocket</title>
    <link href="<%=request.getContextPath()%>/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/main.css" rel="stylesheet">
    
    <script src="<%=request.getContextPath()%>/static/jquery/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/static/sockjs-client/sockjs.min.js"></script>
    <script src="<%=request.getContextPath()%>/static/stomp-websocket/stomp.min.js"></script>
    <!-- <script src="<%=request.getContextPath()%>/static/js/app.js"></script> -->
</head>

<body>
    <noscript>
        <h2 style="color: #ff0000">Seems your browser doesn't support Javascript! Websocket relies on Javascript being
            enabled. Please enable
            Javascript and reload this page!</h2>
    </noscript>
	<% 
		
	
	
	%>
    <div id="main-content" class="container">
        <div class="row">

            <div class="col-md-6">
                <form class="form-inline">
                    <div class="form-group">
                    <input type="text" id="from" class="form-control" value="${from}" style="display:none"></div>
                    <input type="text" id="to" class="form-control" value="${to}" style="display:none"></div>
                        <input type="text" id="content" class="form-control" placeholder="請輸入...">
                    </div>
                    <button id="send" class="btn btn-default" type="submit">送出</button>
                </form>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <table id="conversation" class="table table-striped">
                    <thead>
                        <tr>
                            <th>歷史</th>
                        </tr>
                    </thead>
                    <tbody id="notice">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <form class="form-inline">
            <div class="form-group">
                <label for="connect">連線</label>
                    <button id="connect" class="btn btn-default" type="submit">Connect</button>
                    <button id="disconnect" class="btn btn-default" type="submit" disabled="disabled">Disconnect
                    </button>
            </div>
        </form>
    </div>
    
    <script>
	    var stompClient = null;
	
	    function setConnected(connected) {
	    	$("#connect").prop("disabled", connected);
	    	$("#disconnect").prop("disabled", !connected);
	    	if (connected) {
	    		$("#conversation").show();
	    	} else {
	    		$("#conversation").hide();
	    	}
	    	$("#notice").html("");
	    }
	
	    function connect() {
	    	var from = $("#from").val();
	    	var socket = new SockJS('http://localhost:8080/endpoint-websocket');
	    	stompClient = Stomp.over(socket);
	    	stompClient.connect({}, function(frame) {
	    		console.log('try to connect');
	    		setConnected(true);
	    		console.log('Connected: ' + frame);
	    		// 通过+from就可以指定我订阅的是我自己用户的信息
	    		stompClient.subscribe('/chat/single/' + from, function(result) {
	    			showContent(JSON.parse(result.body));
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
	    	// 这里出了发送content信息外，还发送发送信息的用户信息，和接受信息的用户信息
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
	    	$("form").on('submit', function(e) {
	    		e.preventDefault();
	    	});
	    	$("#connect").click(function() {
	    		connect();
	    	});
	    	$("#disconnect").click(function() {
	    		disconnect();
	    	});
	    	$("#send").click(function() {
	    		sendName();
	    	});
	    });
    </script>
</body>

</html>