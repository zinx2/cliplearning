import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import "Resources.js" as R

Rectangle
{
    width: parent.width
    height: parent.height
    color: "transparent"

    ListModel
    {
        id: contactModel
        ListElement {
            imgPath: "image://async/img021.jpg"
        }
        ListElement {
            imgPath: "image://async/img038.jpg"
        }
        ListElement {
            imgPath: "image://async/img039.jpg"
        }
        ListElement {
            imgPath: "image://async/img040.jpg"
        }
    }

    Rectangle
    {
        id: viewPager
        width: parent.width
        height: R.dp(500)

        CPBusyIndicatorEKr {
            id: viewPagerBusy
            anchors {
                left: parent.left
                leftMargin: parent.width*0.5 - viewPagerBusy.width + R.dp(20)
                verticalCenter: parent.verticalCenter
            }
        }

        PathView {
            id: pathView
            anchors.fill: parent
            model: contactModel
            delegate: CPImage {
                source: imgPath
                height : viewPager.height;
                width: viewPager.width
                fillMode: Image.PreserveAspectFit
                clip: true
            }


            path: Path {
                startX: viewPager.width * (contactModel.count>1 ? -0.5 : 0.5)
                startY: viewPager.height*0.5
                PathLine {
                    x: viewPager.width * (contactModel.count>1 ? (contactModel.count - 0.5) : 0.501)
                    y: viewPager.height*0.5;
                }
            }
        }

        PageIndicator
        {
            id: pageIndicator
            count: pathView.count
            currentIndex: pathView.currentIndex
            anchors
            {
                bottom: viewPager.bottom
                horizontalCenter: parent.horizontalCenter
                bottomMargin: R.dp(20)
            }
            delegate: Rectangle {
                implicitWidth: R.dp(25)
                implicitHeight: R.dp(25)
                radius: width
                color: "gray"
                opacity: index === pathView.currentIndex ? 1.0 : pressed ? 0.7 : 0.45
            }
        }

        Timer
        {
            id: pagerControl
            interval:5000
            running: true
            repeat: true
            onTriggered: {
                if(pathView.currentIndex == pathView.count-1)
                    pathView.currentIndex = 0;
                else
                    pathView.currentIndex += 1;

                pageIndicator.currentIndex = pathView.currentIndex;
            }
        }

        Component.onCompleted:
        {
            if(pathView.count > 0) {
                viewPagerBusy.visible = false;
                viewPagerBusy.running = false;
            }
        }
    }

    states: [
        State
        {
            when: R.dp(100) < flick.contentY && flick.contentY <= R.dp(200)
            PropertyChanges { target: listRect; y: viewPager.height }
            PropertyChanges { target: viewPager; y: 0 }
        },
        State
        {
            when: flick.contentY > R.dp(200)
            PropertyChanges { target: listRect; y: 0 }
            PropertyChanges { target: viewPager; y: -viewPager.height }
        }]


    transitions:  Transition {
        NumberAnimation { properties: "x, y, height"; easing.type: Easing.InOutQuad;}
//        NumberAnimation { properties: "x, y, height"; easing.type: Easing.InOutQuad;}
    }

    Rectangle {

        id: listRect
        width: parent.width
        height: flick.contentY == 0 ? (parent.height - viewPager.height) : parent.height
        y: viewPager.height
        color: "#e41f69"

        Component.onCompleted:
        {
//            wk.getDummyAll();
            console.log("@@Length : " + md.dlist.length);
            console.log("@@Size : " + md.dlist.size);
            console.log("@@Count : " + md.dlist.count);
        }

        Rectangle
        {
            width: parent.width
            height: parent.height
            visible: md.dlist.length == 0

            Column
            {
                width: parent.width
                height: R.height_button_middle + R.dp(100)
                anchors.verticalCenter: parent.verticalCenter

                CPText
                {
//                    width: parent.width
//                    height: R.dp(100)
                    text: "데이터가 존재하지 않습니다."
                    font.pointSize: R.pt(12)
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                CPButton
                {
                    sourceWidth: parent.width  * 0.5 - 1
                    sourceHeight: R.height_button_middle
                    btnName: "새로고침"
                    textColor: "white"
                    rectColor: R.color_buttonColor001
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked:
                    {
                        /* DESIGN LOGIC */
                        if(opt.ds)
                        {
                            return; /* PLEASE DON'T REMVOE! */
                        }

                        /* NOT DESIGN LOGIC */
                        wk.getDummyAll();
                    }
                }
            }
        }

        Flickable
        {
            id: flick
            anchors.fill: parent
            contentWidth : parent.width
            contentHeight: R.dp(500) * md.dlist.length
            maximumFlickVelocity: R.dp(500) * md.dlist.length
            visible: md.dlist.length > 0
            clip: true
            y:0

            onMovementStarted:
            {
                console.log("MoveStarted");
//                console.log("Flickable >> " + flick.y);
//                console.log("visibleArea >> " + flick.visibleArea.yPosition)
                console.log("contentY >> " + flick.contentY)
//                console.log("originY >> " + flick.originY)
            }

            onMovementEnded:
            {
                console.log("MoveEnded");
//                console.log("Flickable >> " + flick.y);
//                console.log("visibleArea >> " + flick.visibleArea.yPosition)
                console.log("contentY >> " + flick.contentY)
//                console.log("originY >> " + flick.originY)
            }

            Column
            {
                width: parent.width
                height: R.dp(500) * md.dlist.length
                Repeater
                {
                    id: rt
                    model: md.dlist.length
                    Rectangle
                    {
                        width: parent.width
                        height: R.dp(500)
                        color: md.dlist[index].bgColor
                        CPImage
                        {
                            width: R.dp(500)
                            height: R.dp(500)
                            source: "image://async/" + md.dlist[index].imgUrl
                            anchors
                            {
                                horizontalCenter: parent.horizontalCenter
                                verticalCenter: parent.verticalCenter
                            }
                        }

                        Rectangle
                        {
                            width: parent.width
                            height: R.dp(500)
                            opacity: 0.5
                            color: "transparent"

                            /* http://doc.qt.io/qt-5/qml-qtgraphicaleffects-lineargradient.html */
                            LinearGradient {
                                anchors.fill: parent
                                start: Qt.point(0, 0)
                                end: Qt.point(0, R.dp(500))
                                gradient: Gradient {
                                    //                                GradientStop { position: 1.0; color: "gray" }
                                    GradientStop { position: 0.0; color: "#00000000" }
                                    GradientStop { position: 1.0; color: "#FF000000" }
                                }
                            }

                            /* http://doc.qt.io/qt-5/qml-qtquick-animator.html */
                            OpacityAnimator on opacity
                            {
                                from: 0;
                                to: 0.5;
                                duration: 500;
                                running: md.dlist[index].clicked;
                                onStopped: {
                                    clearButtons();
                                }
                            }
                        }

                        Rectangle
                        {
                            width: parent.width
                            height: R.dp(500)
                            color: "transparent"
                            CPText
                            {
                                text: md.dlist[index].title;
                                color: "white"
                            }
                        }



                        MouseArea
                        {
                            anchors.fill: parent
                            onClicked:
                            {
                                clearButtons();
                                md.dlist[index].isClicked(true);
                            }

                        }
                    }
                }
            }

            rebound: Transition {
                NumberAnimation {
                    properties: "x, y"
                    duration: 700
                    easing.type: Easing.OutBounce
                }
            }
        }

        function clearButtons()
        {
            for(var i=0; i<md.dlist.length; i++)
            {
                md.dlist[i].isClicked(false);
            }
        }
    }


}

