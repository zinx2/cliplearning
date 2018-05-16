import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "Resources.js" as R

Rectangle {

    property bool visibleBackBtn : true
    property string backImg : R.image("back.png")
    property bool visibleSearchBtn : true
    property string searchImg : R.image("setting.png")
    property string titleText : opt.ds ? R.string_title : md.title
    property string titleBgColor : R.color_appTitlebar
    property string titleTextColor : R.color_appTitleText
    property string titleLineColor : R.color_theme01
    property int lineHeight : Qt.platform.os === "ios" ? 1 : R.dp(2)
    property int titleType : 0 /* 0: text, 1: image */
    signal evtBack()
    signal evtSearch()

    width: opt.ds ? R.design_size_width : parent.width
    height: opt.ds ? R.design_size_height : parent.height

    Column
    {
        width: parent.width
        height: R.height_statusbar + R.height_titlaBar
        Rectangle
        {
            id: bgStatusBar
            color: R.color_appTitlebar
            width: parent.width
            height: R.height_statusbar
        }

        Rectangle
        {
            id: titleBar
            height: R.height_titlaBar - lineHeight
            width: parent.width
            color: titleBgColor

            CPButton
            {
                id: btnBack
                x: 0; y: 0
                visible: visibleBackBtn
                width: parent.height
                height: parent.height
                sourceWidth: R.dp(80)
                sourceHeight: R.dp(80)
                imageSource: backImg
                type: "image"
                onClicked:
                {
                    evtBack()
                }
            }

            Rectangle
            {
                width: parent.width
                height: parent.height
                color: "transparent"

                Label
                {
                    width: parent.width
                    height: parent.height
                    text: titleText
                    color: R.titleTextColor
                    horizontalAlignment : Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: R.pt(20)
                    font.family: fontNanum.name
                    font.bold: true
                    FontLoader {
                        id: fontNanum
                        source: "../font/NanumSquareBold.ttf"
                    }
                }

                CPImage
                {
                    id: img
                    width: R.dp(373)
                    height: R.dp(60)
                    fillMode: Image.PreserveAspectFit
                    visible: titleType == 1
                    source: "../img/title.png"
                    anchors
                    {
                        horizontalCenter: parent.horizontalCenter
                        verticalCenter: parent.verticalCenter
                    }
                }
            }

            CPButton
            {
                id: btnSearch
                anchors
                {
                    right: parent.right
                }

                visible: visibleSearchBtn
                width: parent.height
                height: parent.height
                sourceWidth: R.dp(60)
                sourceHeight: R.dp(60)
                imageSource: searchImg
                type: "image"
                onClicked:
                {
                    if (Qt.inputMethod.visible)
                        Qt.inputMethod.hide()

                    evtSearch()
                }
            }
        }

        Rectangle
        {
            width: parent.width
            height: lineHeight
            color: titleLineColor
        }
    }

    CPAlarmPopup
    {
        id: alarmPopup
        width: parent.width
        height: parent.height
        z: 9998

    }

    OpacityAnimator {
        id:fadeinAnimator
        target: alarmPopup;
        from: 0;
        to: 1;
        duration: 500
        running: opt.ds ? false : ap.visible
    }

    OpacityAnimator {
        id:fadeoutAnimator
        target: alarmPopup;
        from: 1;
        to: 0;
        duration: 500
        running: opt.ds ? false : ap.visible
    }

    Rectangle
    {
        id: busyArea
        width: parent.width
        height: parent.height
        color: "transparent"
        //        opacity: 0.7
        visible: opt.ds ? false : md.busy
        z: 9999

        Column
        {
            width: parent.width
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: parent.width*0.5 - busyIndi.width + R.dp(20)
            }
            CPBusyIndicator
            {
                id: busyIndi
            }
            LYMargin {
                height: R.dp(100)
            }
        }

        MouseArea
        {
            id: ma
            width: parent.width
            height: parent.height
            //            onClicked: busy(false);
        }
    }

    function busy(isBusy)
    {
        busyArea.visible = isBusy;
        busyIndi.running = isBusy;
    }

    CPToast
    {
        id: toastPopup
        z: 9999
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: R.dp(150)
        }
    }

    function toast(message)
    {
        toastPopup.show(message);
    }
}
