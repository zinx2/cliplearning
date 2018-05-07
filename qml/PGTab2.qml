import QtQuick 2.9
import QtQuick.Controls 2.2
import "Resources.js" as R

Rectangle
{
    width: R.design_size_width
    height: R.design_size_height
    color: "white"

    property int itemHeight: R.dp(180)
    property int dLength : opt.ds ? 40 : md.dlist.length

    Rectangle
    {
        width: parent.width
        height: R.height_titlaBar-R.dp(2)
        color: "white"
    }

    Rectangle
    {
        width: parent.width
        height: R.dp(2)
        color: "black"//R.color_theme01
        y: R.height_titlaBar - R.dp(2)
    }

    Flickable
    {
        id: flick
        width: parent.width
        height: parent.height
        contentWidth : parent.width
        contentHeight: itemHeight * dLength
        maximumFlickVelocity: itemHeight * dLength
        clip: true
        y: R.height_titlaBar
        boundsBehavior: Flickable.StopAtBounds

        onMovementStarted:
        {
            if(opt.ds) return;
            if(flick.contentY == 0)
                md.setHomeScrolled(true);
            console.log("onMovementStart >> " + flick.contentY)
        }
        onMovementEnded:
        {
            if(opt.ds) return;

            if(flick.contentY == 0)
                md.setHomeScrolled(false);
            console.log("onMovementEnded >> " + flick.contentY)
        }

        Column
        {
            id: mainColumn
            width: parent.width
            height: itemHeight * dLength

            Repeater
            {
                model: dLength
                Column
                {
                    width: parent.width
                    height: itemHeight

                    CPText
                    {
                        id: txtContents
                        width: parent.width - R.dp(80)
                        height: itemHeight * 0.5
                        color: "black"
                        text: opt.ds ? ("untitled") + index: md.dlist[index].title
                        font.pointSize: R.pt(15)
                        verticalAlignment: Text.AlignBottom
                        anchors
                        {
                            left: parent.left
                            leftMargin: R.dp(40)
                        }
                    }
                    LYMargin { height: R.dp(5) }
                    CPText
                    {
                        id: txtDate
                        width: parent.width - R.dp(80)
                        height: itemHeight * 0.5 - R.dp(2) - R.dp(5)
                        color: "gray"
                        text: opt.ds ? "untitled" : md.dlist[index].date
                        font.pointSize: R.pt(12)
                        verticalAlignment: Text.AlignTop
                        anchors
                        {
                            left: parent.left
                            leftMargin: R.dp(40)
                        }
                    }

                    LYMargin
                    {
                        color: "black"//R.color_theme01;
                        width: parent.width; height: R.dp(2)
                    }
                }
            }
        }
    }
}
