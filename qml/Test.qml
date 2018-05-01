import QtQuick 2.7
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import "Resources.js" as R

Rectangle {

    id: rect
    color: "#e41f69"

    Component.onCompleted:
    {

    }

    Flickable
    {
        id: flick
        anchors.fill: parent
        contentWidth : parent.width
        contentHeight: R.dp(500) * md.dlist.length
        maximumFlickVelocity: R.dp(500) * md.dlist.length

        //        ScrollBar.horizontal: ScrollBar { id: hbar; active: vbar.active }
        //        ScrollBar.vertical: ScrollBar { id: vbar; active: hbar.active }

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
                    color: md.dlist[index].c
                    CPImage
                    {
                        width: R.dp(500)
                        height: R.dp(500)
                        source: R.image(md.dlist[index].s)
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
                            running: md.dlist[index].b;
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
                            text: md.dlist[index].s;
                            color: "white"
                        }
                    }



                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked:
                        {
                            clearButtons();
                            md.dlist[index].setB(true);
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


    Component
    {
        Item
        {
            Rectangle
            {
            CPImage {
                source: imgPath
                height : viewPager.height;
                width: viewPager.width
                fillMode: Image.PreserveAspectFit
                clip: true
            }
            }
        }
    }

    //    CPButton
    //    {
    //        sourceWidth: parent.width
    //        sourceHeight: R.dp(100)
    //        width: parent.width
    //        height: R.dp(100)
    //        type: "image"
    //        btnName: "GET ALL DEMO LIST~"
    //        rectColor: "orange"
    //        textColor: "white"
    //        fontSize: R.pt(15)
    //        imageSource: R.image("volume_on_48dp.png")
    //        onClicked: {
    //            //                nt.title();
    //            wk.getDemoAll();
    //        }
    //    }


    //    Row
    //    {
    //        Column
    //        {
    //            Button
    //            {
    //                width: 100
    //                height: 100
    //                text: "버튼1"
    //            }

    //            Button
    //            {
    //                width: 100
    //                height: 100
    //                text: "버튼3"
    //            }
    //        }

    //        Button
    //        {
    //            width: 100
    //            height: 100
    //            text: "버튼4"
    //            onClicked: func("QWTQWTQWT")
    //        }
    //    }

    //    Button
    //    {
    //        anchors.horizontalCenter: parent.horizontalCenter
    //        anchors.verticalCenter: parent.verticalCenter
    ////        anchors { verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter  }

    //        width: 100
    //        height: 100
    //        text: "버튼2"
    //    }

    function func(txt)
    {
        rect.color = "red"
        console.log(txt)
    }

    function clearButtons()
    {
        for(var i=0; i<md.dlist.length; i++)
        {
            md.dlist[i].setB(false);
        }


    }


}
