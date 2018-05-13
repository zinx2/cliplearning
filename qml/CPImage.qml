import QtQuick 2.7

Image
{
    id: img
    asynchronous: true
    cache: true
    fillMode: Image.PreserveAspectFit
    horizontalAlignment : Image.AlignHCenter
    verticalAlignment: Image.AlignVCenter
    property bool isLoaded : false

}
