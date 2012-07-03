<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" language="javascript" src="ScriptCam/jquery.min.js"></script>
    <script type="text/javascript" language="JavaScript" src="ScriptCam/jquery.swfobject.1-1-1.min.js"></script>
    <script type="text/javascript" language="JavaScript" src="ScriptCam/scriptcam.js"></script>
    <link href="Style.css" type="text/css" rel="Stylesheet" />
    <!-- This is where we start customizing our webcam plugin -->
    <script type="text/javascript">
        $(document).ready(function () {
            $("#webcam").scriptcam({
                appID: 'BB6EA93A-66',
                setVolume: 0,
                width: 320, //These are default values, you don't need to define unless you're not going to change,
                height: 240, //Thought decreasing width value too much may cause problems on work. I tried 240 min.
                showMicrophoneErrors: false,
                onWebcamReady: onWebcamReady
            });
            //This line helps us to hide the binary code text box.
        });
        function base64_tofield() {
            $('#formfield').val($.scriptcam.getFrameAsBase64());
        };
        function base64_toimage() {
            document.getElementById('<%= imgBinary.ClientID %>').src = "data:image/png;base64," + $.scriptcam.getFrameAsBase64();
            document.getElementById('<%= txtImgBinary.ClientID %>').value = $.scriptcam.getFrameAsBase64();

            var object = new ActiveXObject("Scripting.FileSystemObject");
            var file = object.CreateTextFile("C:\\Users\\Compaq1\\Documents\\Visual Studio 2010\\Shared\\Hello.txt", false);
            file.WriteLine($.scriptcam.getFrameAsBase64());
            file.Close();
        };
        function changeCamera() {
            $.scriptcam.changeCamera($('#cameraNames').val());
        }
        function onWebcamReady(cameraNames, camera, microphoneNames, microphone, volume) {
            $.each(cameraNames, function (index, text) {
                $('#cameraNames').append($('<option></option>').val(index).html(text))
            });
            $('#cameraNames').val(camera);
        }
        function hideTheButton() {
            document.getElementById('<%= txtImgBinary.ClientID %>').style.display = 'none';
        }
        //You can see more about customization in the plugin website.
        //Here: http://www.scriptcam.com/docs.cfm
    </script>
    <!-- Here it ends -->
</head>
<body>
    <form id="form1" runat="server">
    <div align="left">
        <h4>
            <b>1. Webcam List</b></h4>
        <h5>
            This list is binded after user "allow" the flash plugin when the page first loads.<br />
            You can also list the avaliable microphones for sound input but you should go find
            detail about this in the <a href="http://www.scriptcam.com" target="_blank">plugin website</a>.<br />
            Since I'll be using the plugin <b>only</b> for taking screenshots, I'm going on.</h5>
        <div id="webcam">
            <!--This div is being generated as the webcam area by ScriptCam plugin. You better leave it empty.-->
        </div>
        <select id="cameraNames" name="D1" onchange="$.scriptcam.changeCamera($('#cameraNames').val());"
            size="1">
        </select>
        <h4>
            <b>2. Capture Me!</b></h4>
        <h5>
            Just click the button and you will be cloned.<br />
            I know it's scary, but this is where the world's coming to...
        </h5>
        <asp:Button ID="btnTakeSnapshot" runat="server" Text="Clone Me!" OnClientClick="base64_toimage(); return false;"
            UseSubmitBehavior="False" />
        <h4>
            <b>3. Say Hello to Your Twin, Dolly v2</b></h4>
        <h5>
            Most important thing is that we are avoiding postbacks(until ve actually <b>save</b>
            the binary code).<br />
            But beware that we are using ASP.NET native controls and they are all running at
            <b>server</b>!
        </h5>
        <div id="cloned">
            <asp:Image ID="imgBinary" runat="server" Width="160" Height="120" />
        </div>
        <h4>
            <b>4. Do you know binarish?</b></h4>
        <h5>
            You don't believe it's happening? See the binary code here.<br />
            Now you see.<br />
            You might take the snapshot and show it on an image but you also need to get its
            binary code, right?<br />
            All I'm saying is that you don't need to get lost, just get the code when you already
            transferring it to the image.
        </h5>
        <asp:TextBox ID="txtImgBinary" TextMode="MultiLine" runat="server"></asp:TextBox>
        <h4>
            <b>5. Get User Friendly</b></h4>
        <h5>
            Users don't need to see binary code, they don't need to see all details, they get
            confused!<br />
            So it's better we hide the text box. I could hide it from the very beginning but
            I thought you might wanna see.<br />
        </h5>
        <asp:Button ID="btnHideBinaryTextBox" runat="server" Text="Erase User Memory" OnClientClick="hideTheButton(); return false;" />
        <h4>
            <b>Move it to the next level.</b></h4>
        <h5>
            Beware: You have the binary code of the captured image without any postback.<br />
            Now you want to save it in the server.<br />
            Cool, click the save button and you'll see your clone in the next page.</h5>
        <asp:Button ID="btnSaveMyImage" runat="server" Text="Save" OnClick="btnSaveMyImage_Click" />
    </div>
    </form>
</body>
</html>
