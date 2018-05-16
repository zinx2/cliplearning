import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.10
import "Resources.js" as R

//ApplicationWindow
//{
//        width: 1500
//        height: 888
//        visible: true
////    visibility: md.fullScreen ? Window.FullScreen : Window.AutomaticVisibility

////    flags: (Qt.platform.os == "android" || Qt.platform.os == "ios") ? (Qt.Window | Qt.MaximizeUsingFullscreenGeometryHint) : Qt.Window

////    PGVideoPlayer
////    {
////        width: parent.width
////        height: parent.height
////    }

//    Component.onCompleted:
//    {
//        cmd.setStatusBarColor("#2a6576");
//    }

//    Test
//    {
//        width: parent.width
//        height: parent.height
//    }
//}

ApplicationWindow {
    id: appWindow
    visible: true
    width: 1500
    height: 888
    flags: (Qt.platform.os == "android" || Qt.platform.os == "ios") ? (Qt.Window | Qt.MaximizeUsingFullscreenGeometryHint) : Qt.Window

    Component.onCompleted: {


        cmd.setStatusBarColor(R.color_appTitlebar);
        if(cmd.isOnline() || (Qt.platform.os !== "android" && Qt.platform.os !== "ios"))
        {
            fadeoutTimer.running = true;


            wk.getImageAll();
            wk.getCategoryAll();
            wk.getColorAll();
            wk.getDummyAll();
            wk.request();
            return;
        }
        toast("네트워크가 연결되어 있지 않습니다. 네트워크 상태를 확인해주세요.");
    }

    StackView
    {
        id: homeStackView
        anchors.fill: parent
        initialItem: PGHome
        {

        }
        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 200
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 200
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 200
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 200
            }
        }

        //        onVisibleChanged: {
        //            console.log("onVisibleChanged : " + settings.logined);
        //            if(settings.logined) {
        //                homeStackView.clear();
        //                homeStackView.push(Qt.createComponent(R.view_file_home), { });
        //            }
        //        }
    }

    Timer
    {
        id: ctrlUserStack_hide
        running: userStackView.depth == 1
        repeat: false
        interval: 500
        onTriggered:
        {
            userStackView.visible = false;
        }
    }

    Timer
    {
        id: ctrlUserStack_show
        running: userStackView.depth > 1
        repeat: false
        interval: 0
        onTriggered:
        {
            userStackView.visible = true
        }
    }

    StackView
    {
        id: userStackView
        width: parent.width
        height: parent.height
        pushEnter: Transition {
            PropertyAnimation {
                property: "y"
                from: homeStackView.height
                to:0
                duration: 200
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "y"
                from: 0
                to:0
                duration: 200
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "y"
                from: 0
                to:0
                duration: 200
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "y"
                from: 0
                to: homeStackView.height
                duration: 200
            }
        }
        visible: false
        initialItem: Rectangle
        {
            color: "transparent"
//            enabled: false
        }

//        initialItem: PGLoginDesk
//        {
//            width: opt.ds ? R.design_size_width : userStackView.width
//            height: opt.ds ? R.design_size_height : userStackView.height

//            Component.onCompleted: {
//                /* When Logined... AutoLogin. */
//                console.log("Component.onCompleted : " + settings.logined);
//                console.log("Device ID: " + cmd.getDeviceId());
//                if(settings.logined) {
//                    homeStackView.clear();
//                    homeStackView.push(Qt.createComponent(R.view_file_home), { });
//                }
//            }
//        }
    }


    StackView
    {
        id: popupStack
        z: 9997
    }

    PGSplash
    {
        id: splashView
    }

    Timer
    {
        id:fadeoutTimer
        interval:2000
        repeat: false
        onTriggered:{
            splashView.opacity = 0;
            hideTimer.start();
        }
    }
    Timer
    {
        id:hideTimer
        interval:800
        repeat: false
        onTriggered: {
            splashView.visible=false;
        }
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

    Item {
        focus: true
        Keys.onBackPressed:
        {
            if(popupStack.depth > 0)
            {
                popupStack.clear();
                return;
            }

            if(userStackView.depth > 0)
            {
                userStackView.pop();
                return;
            }

            console.log("stackView.depth >> " + homeStackView.depth)
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
    }

    CPToast
    {
        id: toastPopup
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

    function popup(component/*src*/, properties, callback)
    {
        //        var component = Qt.createComponent(src);
        if(component.status == Component.Ready)
        {
            if(typeof properties === "undefined" || properties === null) properties = {"x":0, "y":0}

            //            var obj = Qt.createComponent(src).createObject(this, properties);
            var obj = component.createObject(this, properties);
            if(obj === null || typeof obj === "undefined") return;
            obj.evtBack.connect(function() {
                popupStack.clear()
            });
            obj.evtCallback.connect(callback);

            popupStack.push(obj, StackView.Immediate);
        }
    }
}

