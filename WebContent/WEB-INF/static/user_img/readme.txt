要上傳頭像前需要先在server.xml新增下面虛擬路徑(可以更改)
<!--新增虛擬路徑，JSP才能找到圖片 -->
<Context docBase="C:\DataSource\FinalProject\user_img" path="/user_img" reloadable="true"/>