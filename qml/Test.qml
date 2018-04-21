import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {

    id: rect
    width: 1000
    height: 500
    color: "blue"

    Row
    {
        Column
        {
            Button
            {
                width: 100
                height: 100
                text: "버튼1"
            }

            Button
            {
                width: 100
                height: 100
                text: "버튼3"
            }
        }

        Button
        {
            width: 100
            height: 100
            text: "버튼4"
            onClicked: func("QWTQWTQWT")
        }
    }

    Button
    {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
//        anchors { verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter  }

        width: 100
        height: 100
        text: "버튼2"
    }

    function func(txt)
    {
        rect.color = "red"
        console.log(txt)
    }


}
