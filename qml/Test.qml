import QtQuick 2.7
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import "Resources.js" as R

Rectangle {

    id: rect
    color: "#e41f69"

    width: 1080
    height: 1920
    property int dLenth : opt.ds ? 20 : md.dlist.length

    Component.onCompleted:
    {
        console.log("@@QtPlatform : " + Qt.platform.os);
        if(opt.ds) return;
        wk.getDummyAll();
        console.log("@@Length : " + dLenth);
    }

//    Timer
//    {
//        running: true;
//        repeat: true;
//        interval: 1000;
//        onTriggered:
//        {
//            console.log("@@Length : " + md.dlist.length);
//            console.log("@@Size : " + md.dlist.size);
//            console.log("@@Count : " + md.dlist.count);
//        }
//    }

    Flickable
    {
        id: flick
        anchors.fill: parent
        contentWidth : parent.width
        contentHeight: R.dp(500) * dLenth
        maximumFlickVelocity: R.dp(500) * dLenth

        //        ScrollBar.horizontal: ScrollBar { id: hbar; active: vbar.active }
        //        ScrollBar.vertical: ScrollBar { id: vbar; active: hbar.active }

        Column
        {
            width: parent.width
            height: R.dp(500) * dLenth
            Repeater
            {
                id: rt
                model: dLenth
                Rectangle
                {
                    width: parent.width
                    height: R.dp(500)
                    color: (opt.ds ? "gray" : md.dlist[index].bgColor)
                    CPImage
                    {
                        width: R.dp(500)
                        height: R.dp(500)
                        source: opt.ds ? "../img/noimage.png" : ("image://async/"+md.dlist[index].imgUrl)
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
                            running: (opt.ds ? false : md.dlist[index].clicked)
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
                            text: (opt.ds ? "untitled" : md.dlist[index].title)
                            color: "white"
                        }
                    }



                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked:
                        {
                            if(opt.ds) return;

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
