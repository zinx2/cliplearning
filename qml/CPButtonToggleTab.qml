import QtQuick 2.0

Rectangle {

    width: 200
    height: 200
    color: "white"

    property bool selected: false
    signal evtSelect()

    property int iconWidth: 50
    property int iconHeight: 50
    property string releasedSource: "../img/noitem_released_24dp.png"
    property string pressedSource: "../img/noitem_pressed_24dp.png"

    property int heightTextArea: 30
    property int fontSize: 20
    property string title: "untitled"
    property string releasedColor: "white"
    property string pressedColor: "black"
    property int spacingValue : 0

    Column
    {
        width: parent.width
        height: iconHeight + heightTextArea
        anchors.verticalCenter: parent.verticalCenter
        spacing: spacingValue
        Image
        {
            cache: true
            width: iconWidth
            height: iconHeight
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            source: selected ? pressedSource : releasedSource
        }

        Text
        {
            width: parent.width
            height: heightTextArea
            wrapMode: Text.Wrap
            text: title
            color: selected ? pressedColor : releasedColor

            font.family: fontNanum.name
            font.pointSize: fontSize
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            FontLoader {
                id: fontNanum
                source: "../font/NanumSquareRegular.ttf"
//                {
//                    switch(Qt.platform.os)
//                    {
//                        case "android": return "../font/NanumBarunGothic_android.ttf"
//                        case "ios": return "../font/NanumBarunGothic_ios.ttf"
//                        case "osx": return "../font/NanumBarunGothic_mac.ttf"
//                        case "window": return "../font/NanumBarunGothic_win.ttf"
//                        default: return "../font/NanumBarunGothic_win.ttf"
//                    }
//                }
            }
        }
    }
    MouseArea
    {
        anchors.fill: parent
        onClicked:
        {
            if(opt.ds) return;

            evtSelect();
        }
    }
}
