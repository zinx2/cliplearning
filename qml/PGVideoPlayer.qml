import QtQuick 2.0
import QtMultimedia 5.8
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import "Resources.js" as R

Item {
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
            orientation: md.fullScreen ? 90 : 0
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
        color: "transparent"
        visible: true

        MouseArea {
            anchors.fill: parent
            onClicked: hideCtrlArea();
        }

        Column
        {
            width: parent.width
            height: parent.height

            LYMargin { height: 200 }
            Row
            {
                width: parent.width
                height: parent.height - 200 - 200
                spacing: 10
                CPButton
                {
                    id: cmdPrev

                    visible: true
                    width: R.dp(200)
                    height: parent.height
                    sourceWidth: R.dp(48)
                    sourceHeight: R.dp(48)
                    imageSource: R.image("prev_48dp.png")
                    type: "image"
                    onClicked:
                    {

                    }
                }
                CPButton
                {
                    id: cmdPlay1

                    visible: true
                    width: parent.width - R.dp(400)
                    height: parent.height
                    sourceWidth: R.dp(48)
                    sourceHeight: R.dp(48)
                    imageSource: R.image("play_48dp.png")
                    type: "image"
                    onClicked: play();
                }

//                Button
//                {
//                    id: cmdStop1
//                    width: 200
//                    height: 300
//                    text: "STOP"
//                    onClicked: stop();
//                    style: ButtonStyle {
//                            background: Rectangle {
//                                implicitWidth: 300
//                                implicitHeight: 300
//                                color: "#F6E8D6"
//                            }
//                        }
//                }
//                Button
//                {
//                    id: cmdFull
//                    width: 200
//                    height: 300
//                    text: "FULL"
//                    onClicked: expend();
//                    style: ButtonStyle {
//                            background: Rectangle {
//                                implicitWidth: 300
//                                implicitHeight: 300
//                                color: "#F6E8D6"
//                            }
//                        }
//                }
                CPButton
                {
                    id: cmdNext
                    visible: true
                    width: R.dp(200)
                    height: parent.height
                    sourceWidth: R.dp(48)
                    sourceHeight: R.dp(48)
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
                height: 100

                Text
                {

                }
            }
        }
    }

    Rectangle
    {
        id: controllBigArea
        width: parent.width
        height : parent.height
        color: "transparent"
        visible: false

        MouseArea {
            anchors.fill: parent
            onClicked: hideCtrlArea();
        }

        Column
        {
            rotation: -90
            width: parent.height
            height: parent.width

            Row
            {
                width: parent.width

            }
            Row
            {
                width: parent.width
                height: 300
                spacing: 10
                Button
                {
                    id: cmdPrev2
                    width: 300
                    height: 300
                    text: "PREV"
                    onClicked: prev();
                    style: ButtonStyle {
                            background: Rectangle {
                                implicitWidth: 300
                                implicitHeight: 300
                                color: "#F6E8D6"
                            }
                        }
                }
                Button
                {
                    id: cmdPlay2
                    width: 300
                    height: 300
                    text: "PLAY"
                    onClicked: play();
                    style: ButtonStyle {
                            background: Rectangle {
                                implicitWidth: 300
                                implicitHeight: 300
                                color: "#F6E8D6"
                            }
                        }
                }
                Button
                {
                    id: cmdStop2
                    width: 300
                    height: 300
                    text: "STOP"
                    onClicked: stop();
                    style: ButtonStyle {
                            background: Rectangle {
                                implicitWidth: 300
                                implicitHeight: 300
                                color: "#F6E8D6"
                            }
                        }
                }
                Button
                {
                    id: cmdShirnk
                    width: 300
                    height: 300
                    text: "Shrink"
                    onClicked: shrink();
                    style: ButtonStyle {
                            background: Rectangle {
                                implicitWidth: 300
                                implicitHeight: 300
                                color: "#F6E8D6"
                            }
                        }
                }
                Button
                {
                    id: cmdNext2
                    width: 300
                    height: 300
                    text: "NEXT"
                    onClicked: next();
                    style: ButtonStyle {
                            background: Rectangle {
                                implicitWidth: 300
                                implicitHeight: 300
                                color: "#F6E8D6"
                            }
                        }
                }
            }
            Row
            {
                width: parent.width
                height: 100

                Text
                {

                }
            }
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
        timer.stop();

        if(video.playbackState == MediaPlayer.PlayingState)
        {
            video.pause();
        }
        else if(video.playbackState == MediaPlayer.PausedState || video.playbackState == MediaPlayer.StoppedState)
        {
            video.play();
        }

        cmdPlay1.imageSource = video.playbackState == MediaPlayer.PlayingState ? R.image("pause_48dp.png") : R.image("play_48dp.png");
        cmdPlay2.text = video.playbackState == MediaPlayer.PlayingState ? "PAUSE" : "PLAY";

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
            cmdPlay2.text = "PLAY";
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
}
