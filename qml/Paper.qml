import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "Resources.js" as R

Rectangle {

    property bool visibleBackBtn : true
    property string backImg : R.image("back_white.png")
    property bool visibleSearchBtn : true
    property string searchImg : R.image("settings_36dp.png")
    property string titleText : opt.ds ? R.string_title : md.title
    property string titleBgColor : R.color_appTitlebar
    signal evtBack()
    signal evtSearch()

    width: opt.ds ? R.design_size_width : parent.width
    height: opt.ds ? R.design_size_height : parent.height

    Rectangle
    {
        id: titleBar
        height: R.height_titlaBar
        width: parent.width
        color: titleBgColor
        z: 999
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

        Label
        {
            width: parent.width
            height: parent.height
            text: titleText
            color: R.color_appTitleText
            horizontalAlignment : Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: R.pt(24)
            font.family: fontNanumBarunGothic.name
            FontLoader {
                id: fontNanumBarunGothic
                source:
                {
                    switch(Qt.platform.os)
                    {
                        case "android": return "../font/NanumBarunGothic_android.ttf"
                        case "ios": return "../font/NanumBarunGothic_ios.ttf"
                        case "osx": return "../font/NanumBarunGothic_mac.ttf"
                        case "window": return "../font/NanumBarunGothic_win.ttf"
                        default: return "../font/NanumBarunGothic_win.ttf"
                    }
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
            sourceWidth: R.dp(80)
            sourceHeight: R.dp(80)
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
        id: busyArea
        width: parent.width
        height: parent.height
        color: "transparent"
        //        opacity: 0.7
        visible: false
        z: 9999

        Column
        {
            width: parent.width
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: parent.width*0.5 - busyIndi.width + R.dp(20)
            }
            CPBusyIndicatorEKr
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
            onClicked: busy(false);
        }
    }

    function busy(isBusy)
    {
        busyArea.visible = isBusy;
        busyIndi.running = isBusy;
    }

    property bool doQuit: false
    Timer
    {
        id: doQuitControl
        interval:1500
        repeat: false
        onTriggered: {
            doQuit = false
        }
    }

    Keys.onBackPressed:
    {
        if (Qt.inputMethod.visible)
        {
            Qt.inputMethod.hide()
            return;
        }

        if(popupStack.depth > 0)
        {
            popupStack.clear();
            return;
        }

        if(homeStackView.depth > 1)
            homeStackView.pop();
        else
        {
            if(!doQuit)
            {
                toast("한번 더 누르면 앱을 종료합니다.");
                doQuit = true;
                doQuitControl.start();
            }
            else
                Qt.quit();
        }
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
