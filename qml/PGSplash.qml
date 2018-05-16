import QtQuick 2.7
import "Resources.js" as R

Rectangle
{
    width: parent.width
    height: parent.height
    visible: true
    color: "white"

    Rectangle
    {
        width: parent.height
        height: parent.height
        color: R.color_bgColor003
        rotation:48
        x: -parent.height * 0.54
        y: parent.height * 0.47
    }

    Column
    {
        id: ekoreaTextArea
        width: ekoreaText.contentWidth
        anchors
        {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }

        CPText
        {
            id: ekoreaText
            font.pointSize: R.pt(50)
            font.bold: true
            color: "black"
            text: "e-koreatech"
            horizontalAlignment: Text.AlignHCenter
        }
    }

    CPBusyIndicatorEKr
    {
        anchors
        {
            bottom: ekoreaTextArea.top
            right: ekoreaTextArea.right
            rightMargin: R.dp(50)
            bottomMargin: R.dp(10)
        }
    }
}
