import QtQuick 2.0
import QtMultimedia 5.8
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "Resources.js" as R

Rectangle {

    width: R.dp(1080)
    height: R.dp(1920)
    color: "#84c9c1"

    Timer
    {
        id: timer
        running: false; repeat: false;
        interval: 3000
        onTriggered:
        {
            hideCtrlArea();
            timer.running = false;
        }
    }
    Timer
    {
        id: seekTimer
        running: false; repeat: true;
        interval: 1000
        onTriggered:
        {
            if(!md.fullScreen)
                seek.x = (seekBar.width - seek.width) * (video.position / video.duration);
            else
                seek2.y = (seekBar2.height - seek2.width) * (video.position / video.duration);
        }
    }

    Timer
    {
        id: bufferCheck
        running: true; repeat: true;
        interval: 1000
        onTriggered:
        {
            if(video.playbackState == MediaPlayer.PlayingState)
            {
                if(video.bufferProgress < 1.0) indiCtrl.visible = true;
                else indiCtrl.visible = false;
            }
        }
    }

    Rectangle
    {
        width : parent.width
        height :  md.fullScreen ? parent.height : parent.width * 0.5625
        color : "#0082A2"
        Video {
            id: video
            width : parent.width
            height :  md.fullScreen ? parent.height : parent.width * 0.5625
            //            rotation: 270
            orientation: md.fullScreen ? -90 : 0
            source: "http://www.html5videoplayer.net/videos/toystory.mp4"
            //            source: "https://github.com/mediaelement/mediaelement-files/blob/master/big_buck_bunny.mp4"
            //                        source: "http://clips.vorwaerts-gmbh.de/VfE_html5.mp4"
            //            source: "http://yt-dash-mse-test.commondatastorage.googleapis.com/media/car-20120827-86.mp4"

            MouseArea {
                anchors.fill: parent
                onClicked: showCtrlArea();
            }

            focus: true
        }
    }

    Rectangle
    {
        id: bgCtrl
        width: parent.width
        height : md.fullScreen ? (parent.height) : (parent.width * 0.5625)
        color: "black"
        opacity: 0.3
        visible: true
    }

    Rectangle
    {
        id: controllSmallArea
        width: parent.width
        height :  parent.width * 0.5625
        color : "transparent"
        visible: true

        MouseArea {
            anchors.fill: parent
            onClicked: hideCtrlArea();
        }

        Column
        {
            width: parent.width
            height: parent.height

            Rectangle
            {
                width: parent.width
                height: R.dp(120)
                color : "transparent"
                CPButton
                {
                    id: cmdVolume
                    anchors
                    {
                        right: parent.right
                        top: parent.top
                    }

                    width: R.dp(150)
                    height: R.dp(150)
                    sourceWidth: R.dp(80)
                    sourceHeight: R.dp(80)
                    imageSource: !video.muted ? R.image("volume_on_48dp.png") : R.image("volume_off_48dp.png")
                    type: "image"
                    onClicked:
                    {
                        video.muted = !video.muted;
                    }
                }
            }

            Rectangle
            {
                width: parent.width
                height: parent.height - R.dp(170)
                color: "transparent"
                CPButton
                {
                    id: cmdPrev
                    anchors
                    {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                    }
                    visible: true
                    width: R.dp(200)
                    height: R.dp(200)
                    sourceWidth: R.dp(100)
                    sourceHeight: R.dp(100)
                    imageSource: R.image("prev_48dp.png")
                    type: "image"
                    onClicked:
                    {

                    }
                }
                CPButton
                {
                    id: cmdPlay1
                    anchors
                    {
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }
                    width: R.dp(300)
                    height: R.dp(300)
                    sourceWidth: R.dp(150)
                    sourceHeight: R.dp(150)
                    imageSource: R.image("play_48dp.png")
                    type: "image"
                    onClicked: play();
                }

                CPButton
                {
                    id: cmdNext
                    anchors
                    {
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                    }
                    width: R.dp(200)
                    height: R.dp(200)
                    sourceWidth: R.dp(100)
                    sourceHeight: R.dp(100)
                    imageSource: R.image("next_48dp.png")
                    type: "image"
                    onClicked:
                    {

                    }
                }
            }
            Row
            {
                id: row3
                width: parent.width
                height: R.dp(50)

                Column
                {
                    width: parent.width
                    height: parent.height
                    Rectangle
                    {
                        height: R.dp(20)
                        width: parent.width
                        color: "transparent"

                        CPText
                        {
                            id: currentTime
                            text: R.toTime(video.position)
                            color: "white"
                            font.pointSize: R.pt(12)
                            anchors
                            {
                                left: parent.left
                                leftMargin: R.dp(20)
                                bottom: parent.bottom
                            }
                        }

                        CPButton
                        {
                            id:cmdFull
                            anchors
                            {
                                right: parent.right
                                bottom: parent.bottom
                                bottomMargin: R.dp(-20)
                            }

                            width: R.dp(100)
                            height: R.dp(100)
                            sourceWidth: R.dp(100)
                            sourceHeight: R.dp(100)
                            imageSource: R.image("full_48dp.png")
                            type: "image"
                            onClicked:expend();
                        }

                        CPText
                        {
                            text: R.toTime(video.duration)//"총 재생시간"
                            color: "white"
                            font.pointSize: R.pt(12)
                            anchors
                            {
                                right: cmdFull.left
                                rightMargin: R.dp(5)
                                bottom: parent.bottom
                            }
                        }
                    }

                    Rectangle
                    {
                        id: ctrlSeek
                        width: parent.width
                        height: R.dp(50)
                        color : "transparent"
                        anchors
                        {
                            left: parent.left
                            leftMargin: R.dp(20)
                        }
                        Rectangle
                        {
                            id: seekBar
                            anchors
                            {
                                top: parent.top
                                topMargin: R.dp(20)
                            }

                            width: parent.width - R.dp(40)
                            height: R.dp(10)
                            color: "red"
                        }

                        Rectangle
                        {
                            id: seek
                            anchors
                            {
                                top: parent.top
                                topMargin: R.dp(10)
                            }
                            radius: width*0.5
                            width: R.dp(30)
                            height: R.dp(30)
                            color: "red"
                        }

                        MouseArea
                        {
                            anchors.fill: parent
                            drag.target: seek
                            drag.axis: Drag.XAxis
                            drag.minimumX: 0
                            drag.maximumX: parent.width - R.dp(60)
                            onPositionChanged: move(mouseX)
//                            {
//                                if(mouseX > seekBar.width) return;
//                                else if(mouseX > seekBar.width - seek.width) seek.x = seekBar.width - seek.width;
//                                else seek.x = parseInt(mouseX);
//                                video.seek(parseInt(video.duration * (seek.x / seekBar.width)))
//                                console.log(seek.x)
//                            }

                            onPressed: move(mouseX)
//                            {
//                                if(mouseX > seekBar.width) return;
//                                else if(mouseX > seekBar.width - seek.width) seek.x = seekBar.width - seek.width;
//                                else seek.x = parseInt(mouseX);
//                                video.seek(parseInt(video.duration * (seek.x / seekBar.width)))
//                                console.log(seek.x)
//                            }
                        }
                    }
                }
            }
        }
    }

    Rectangle
    {
        id: controllBigArea
        width: parent.width
        height : parent.height
        color : "transparent"
        visible: false

        MouseArea {
            anchors.fill: parent
            onClicked: hideCtrlArea();
        }

        Row
        {
            width: parent.width
            height: parent.height

            Rectangle
            {
                color: "transparent"
                width: R.dp(150)
                height: parent.height

                Row
                {
                    width: parent.width
                    height: parent.height

                    Rectangle
                    {
                        id: ctrlSeek2
                        width: R.dp(60)
                        height: parent.height
                        color : "transparent"

                        Rectangle
                        {
                            id: seekBar2
                            anchors
                            {
                                horizontalCenter: parent.horizontalCenter
                            }
                            width: R.dp(10)
                            height: parent.height
                            color: "red"
                        }

                        Rectangle
                        {
                            id: seek2
                            anchors
                            {
                                horizontalCenter: parent.horizontalCenter
                            }
                            x: R.dp(-15)
                            radius: width*0.5
                            width: R.dp(40)
                            height: R.dp(40)
                            color: "red"
                        }

                        MouseArea
                        {
                            anchors.fill: parent
                            drag.target: seek2
                            drag.axis: Drag.YAxis
                            drag.minimumY: 0
                            drag.maximumY: parent.height
                            onPositionChanged: move(mouseY)
                            onPressed: move(mouseY)
                        }
                    }

                    Rectangle
                    {
                        height: parent.height
                        width: R.dp(20)
                        color: "transparent"

                        CPText
                        {
                            id: currentTime2
                            rotation: 90
                            text: R.toTime(video.position)
                            color: "white"
                            font.pointSize: R.pt(12)
                            anchors
                            {
                                left: parent.left
                                leftMargin: R.dp(-30)
                                top: parent.top
                                topMargin: R.dp(90)
                            }
                        }

                        CPButton
                        {
                            id:cmdFull2
                            anchors
                            {
                                left: parent.left
                                leftMargin: R.dp(-30)
                                bottom: parent.bottom
                                bottomMargin: R.dp(20)
                            }

                            width: R.dp(150)
                            height: R.dp(150)
                            sourceWidth: R.dp(120)
                            sourceHeight: R.dp(120)
                            imageSource: R.image("full_exit_48dp.png")
                            type: "image"
                            onClicked:shrink();
                        }

                        CPText
                        {
                            rotation: 90
                            text: R.toTime(video.duration)//"총 재생시간"
                            color: "white"
                            font.pointSize: R.pt(12)
                            anchors
                            {
                                left: parent.left
                                leftMargin: R.dp(-30)
                                bottom: cmdFull2.bottom
                                bottomMargin: R.dp(200)
                            }
                        }
                    }

                }
            }

            Rectangle
            {
                width: parent.width - R.dp(270)
                height: parent.height
                color: "transparent"

                CPButton
                {
                    id: cmdPrev2
                    rotation: 90
                    anchors
                    {
                        horizontalCenter: parent.horizontalCenter
                        top: parent.top
                        topMargin: R.dp(150)
                    }
                    visible: true
                    width: R.dp(300)
                    height: R.dp(300)
                    sourceWidth: R.dp(150)
                    sourceHeight: R.dp(150)
                    imageSource: R.image("prev_48dp.png")
                    type: "image"
                    onClicked:
                    {

                    }
                }

                CPButton
                {
                    id: cmdPlay2
                    rotation: 90
                    anchors
                    {
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }
                    width: R.dp(400)
                    height: R.dp(400)
                    sourceWidth: R.dp(200)
                    sourceHeight: R.dp(200)
                    imageSource: R.image("play_48dp.png")
                    type: "image"
                    onClicked: play();
                }

                CPButton
                {
                    id: cmdNext2
                    rotation: 90
                    anchors
                    {
                        horizontalCenter: parent.horizontalCenter
                        bottom: parent.bottom
                        bottomMargin: R.dp(150)
                    }
                    width: R.dp(300)
                    height: R.dp(300)
                    sourceWidth: R.dp(150)
                    sourceHeight: R.dp(150)
                    imageSource: R.image("next_48dp.png")
                    type: "image"
                    onClicked:
                    {

                    }
                }

            }
            Rectangle
            {
                color:"transparent"
                width: R.dp(120)
                height: parent.height
                CPButton
                {
                    id: cmdVolume2
                    rotation: 90
                    anchors
                    {
                        right: parent.right
                        bottom: parent.bottom
                    }

                    width: R.dp(150)
                    height: R.dp(150)
                    sourceWidth: R.dp(80)
                    sourceHeight: R.dp(80)
                    imageSource: !video.muted ? R.image("volume_on_48dp.png") : R.image("volume_off_48dp.png")
                    type: "image"
                    onClicked:
                    {
                        video.muted = !video.muted;
                    }
                }
            }

        }
    }


    Rectangle
    {
        id: indiCtrl
        width: parent.width
        height : md.fullScreen ? (parent.height) : (parent.width * 0.5625)
        color: "black"
        opacity: 0.3
        visible: false;

        CPBusyIndicator
        {
            width: R.dp(200)
            height: R.dp(200)
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

        }
    }

    function prev()
    {
        console.log("PREV");
    }

    function next()
    {
        console.log("next");
    }

    function play()
    {
        console.log(video.duration);
        timer.stop();

        if(video.playbackState == MediaPlayer.PlayingState)
        {
            video.pause();
            seekTimer.stop();
        }
        else if(video.playbackState == MediaPlayer.PausedState || video.playbackState == MediaPlayer.StoppedState)
        {
            video.play();
            seekTimer.start();
        }

        cmdPlay1.imageSource = video.playbackState == MediaPlayer.PlayingState ? R.image("pause_48dp.png") : R.image("play_48dp.png");
        cmdPlay2.imageSource = video.playbackState == MediaPlayer.PlayingState ? R.image("pause_48dp.png") : R.image("play_48dp.png");

        if(video.playbackState == MediaPlayer.PlayingState)
            timer.start();
    }

    function stop()
    {
        if(video.playbackState == MediaPlayer.PlayingState || video.playbackState == MediaPlayer.PausedState)
        {
            video.pause();
            /* seek position */
            showCtrlArea();

            cmdPlay1.imageSource = R.image("play_48dp.png");
            cmdPlay2.imageSource = R.image("play_48dp.png");
        }
    }

    function expend()
    {
        md.setFullScreen(true);
        showCtrlBigArea();
    }

    function shrink()
    {
        md.setFullScreen(false);
        showCtrlSmallArea();
    }

    function showCtrlArea()
    {
        timer.stop();

        if(md.fullScreen) showCtrlBigArea();
        else showCtrlSmallArea();
        bgCtrl.visible = true;

        if(video.playbackState == MediaPlayer.PlayingState)
            timer.start();
    }

    function showCtrlBigArea()
    {
        controllSmallArea.visible = false;
        controllBigArea.visible = true;
    }

    function showCtrlSmallArea()
    {
        controllSmallArea.visible = true;
        controllBigArea.visible = false;
    }

    function hideCtrlArea()
    {
        controllSmallArea.visible = false;
        controllBigArea.visible = false;
        bgCtrl.visible = false;
    }

    function move(mouse)
    {
        if(!md.fullScreen)
        {
            if(mouse > seekBar.width) return;
            else if(mouse > seekBar.width - seek.width) seek.x = seekBar.width - seek.width;
            else seek.x = parseInt(mouse);
            video.seek(parseInt(video.duration * (seek.x / seekBar.width)))
            console.log(seek.x)
        }
        else
        {
            if(mouse > seekBar2.height) return;
            else if(mouse > seekBar2.height - seek2.width) seek2.y = seekBar2.height - seek2.width;
            else seek2.y = parseInt(mouse);
            video.seek(parseInt(video.duration * (seek2.y / seekBar2.height)))
        }
    }
}
