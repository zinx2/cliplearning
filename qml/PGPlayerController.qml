import QtQuick 2.0
import "Resources.js" as R

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

        Row
        {
            width: parent.width
            height: R.dp(120)
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
                        onPositionChanged: seek()
                        onPressed: seek()
                    }
                }
            }
        }
    }
}
