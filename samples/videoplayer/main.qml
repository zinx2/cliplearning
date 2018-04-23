import QtQuick 2.10
import QtQuick.Window 2.10


Window {

    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    flags: Qt.FramelessWindowHint
    visibility: md.full ? Window.FullScreen : Window.AutomaticVisibility

    CPVideoPlayer
    {
        width: parent.width
        height: parent.height
    }


}
