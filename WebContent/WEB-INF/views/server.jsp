<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<head>
    <title>Hello WebSocket</title>
    <link href="<%=request.getContextPath()%>/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/chat/main.css" rel="stylesheet">
    <script src="<%=request.getContextPath()%>/static/jquery/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/static/sockjs-client/sockjs.min.js"></script>
    <script src="<%=request.getContextPath()%>/static/stomp-websocket/stomp.min.js"></script>
    <script src="<%=request.getContextPath()%>/static/js/app.js"></script>
</head>
<body>
<noscript><h2 style="color: #ff0000">Seems your browser doesn't support Javascript! Websocket relies on Javascript being
    enabled. Please enable
    Javascript and reload this page!</h2></noscript>
<div id="main-content" class="container">
    From =>${from}</br>
	To =>${to}
    <div class="row">
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
</body>
</html>