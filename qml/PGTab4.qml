import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.4
import "Resources.js" as R

Rectangle
{
    id: rectMain
    width: R.dp(1080) //parent.width
    height: R.dp(1920) //parent.height
    color: "#f5f6f6"

    property int dLength : opt.ds ? 20 : md.likecliplist.length
    property int widthListItem : R.dp(1080)
    property int widthCategoryArea: rectMain.width * 0.5
    property int heightListItemImg : R.dp(500)
    property int heightListItemLb : R.dp(90)

    property int heightCategoryArea: R.dp(120)
    property int heightScvPadding: R.dp(10)
    property int heightListItem : heightListItemImg + heightListItemLb

    Rectangle
    {
        id: scvPadding
        width: parent.width
        height: heightScvPadding
        color: "#f5f6f6"//R.color_theme01
        z: 3
    }


    ScrollView
    {
        id: scvCategory
        width: parent.width
        height: heightCategoryArea
        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
        y: heightScvPadding
        z: 3

        Rectangle
        {
            width: widthCategoryArea * (opt.ds ? 2 : md.catelikelist.length)
            height: heightCategoryArea
            color: "white"
            Row
            {
                width: parent.width
                height: parent.height
                Repeater
                {
                            model: opt.ds ? 2 : md.catelikelist.length

                    Rectangle
                    {
                        width: widthCategoryArea; height: heightCategoryArea;
                        color:"transparent"

                        Column{
                            width: widthCategoryArea; height: parent.height;
                            LYMargin { height: R.dp(20)}
                            CPText
                            {
                                font.pointSize: R.pt(14)
                                width: widthCategoryArea
                                height: R.dp(94)
                                text: opt.ds ? "Untitledddd" : md.catelikelist[index].name
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                color: "black"
                            }
                            Rectangle
                            {
                                width: widthCategoryArea; height: R.dp(6);
                                color: opt.ds ? R.color_theme01 : (md.catelikelist[index].selected ? R.color_theme01 : "#f5f6f6");
                            }
                        }
                        MouseArea
                        {
                            anchors.fill: parent
                            onClicked:
                            {
                                if(opt.ds) return;
                                if(md.catelikelist[index].selected) return;

                                clearCategoryButtons();
                                md.catelikelist[index].select(true);
                                wk.getLikeClipList(index);
                                wk.request();
                            }
                        }
                    }
                }
            }
        }
    }


    Flickable
    {
        id: flick
        anchors.fill: parent
        contentWidth : parent.width
        contentHeight: heightCategoryArea + heightScvPadding + heightListItem * dLength
        maximumFlickVelocity: heightListItem * dLength
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        z: 2

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
            width: parent.width
            height: flick.height

            Rectangle
            {
                width: parent.width
                height: heightCategoryArea + heightScvPadding
                color: "transparent"
            }

            Rectangle {

                id: rectList
                width: parent.width
                height: dLength == 0 ? parent.height : heightListItem * dLength
                color: "transparent"

                Rectangle
                {
                    width: parent.width
                    height: parent.height
                    visible: dLength == 0

                    Column
                    {
                        width: parent.width
                        height: R.height_button_middle + R.dp(100)
                        anchors.verticalCenter: parent.verticalCenter

                        CPText
                        {
                            //                    width: parent.width
                            //                    height: R.dp(100)
                            text: "데이터가 존재하지 않습니다."
                            font.pointSize: R.pt(12)
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }

                Column
                {
                    width: parent.width
                    height: heightListItem * dLength
                    Repeater
                    {
                        id: rt
                        model: dLength
                        Rectangle
                        {
                            width: parent.width
                            height: heightListItem
                            color: (opt.ds ? "gray" : md.likecliplist[index].bgColor)
                            CPImage
                            {
                                id: img
                                width: widthListItem
                                height: heightListItemImg
                                fillMode: Image.PreserveAspectCrop
                                source: opt.ds ? "../img/noimage.png" : ("image://async/"+md.likecliplist[index].imgUrl)
                                anchors
                                {
                                    horizontalCenter: parent.horizontalCenter
                                    //                                verticalCenter: parent.verticalCenter
                                }
                            }

                            Rectangle
                            {
                                width: parent.width
                                height: heightListItemImg
                                opacity: 0.5
                                color: "transparent"

                                /* http://doc.qt.io/qt-5/qml-qtgraphicaleffects-lineargradient.html */
                                LinearGradient {
                                    anchors.fill: parent
                                    start: Qt.point(0, 0)
                                    end: Qt.point(0, heightListItemImg)
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
                                    running: (opt.ds ? false : md.likecliplist[index].clicked)
                                    onStopped: {
                                        clearListButton();
                                    }
                                }
                            }

                            Rectangle
                            {
                                width: parent.width
                                height: heightListItemLb
                                y: heightListItemImg
                                color: "white"

                                CPText
                                {
                                    text:
                                    {
                                        if(opt.ds) return "[cateogory]  " + (index+1) + ". untitled";
                                        else return "[" + md.getCategory(md.likecliplist[index].category) + "]  " + md.likecliplist[index].title
                                    }
                                    font.pointSize: R.pt(15)
                                    color: "black"
                                    anchors
                                    {
                                        left: parent.left
                                        leftMargin: R.dp(20)
                                        top: parent.top
                                        topMargin: R.dp(20)

                                    }
                                }

                                CPText
                                {
                                    text: "조회수" + (opt.ds ? "999" : md.likecliplist[index].viewCount)
                                    font.pointSize: R.pt(12)
                                    color: "gray"
                                    anchors
                                    {
                                        right: parent.right
                                        rightMargin: R.dp(20)
                                        top: parent.top
                                        topMargin: R.dp(25)
                                    }
                                }
                            }



                            MouseArea
                            {
                                anchors.fill: parent
                                onClicked:
                                {
                                    if(opt.ds) return;

                                    clearListButton();
                                    md.likecliplist[index].isClicked(true);
                                }

                            }

                            Rectangle
                            {
                                width: R.dp(100)
                                height: R.dp(130)
                                color: "transparent"

                                anchors
                                {
                                    right: parent.right
                                    rightMargin: R.dp(0)
                                    top: parent.top
                                    topMargin: R.dp(0)
                                }

                                Rectangle
                                {
                                    id: likeIcon
                                    width: R.dp(100)
                                    height: R.dp(100)
                                    color: "transparent"

                                    anchors
                                    {
                                        horizontalCenter: parent.horizontalCenter
                                        top: parent.top
                                    }
                                    CPImage
                                    {
                                        id: likeImg
                                        width: R.dp(50)
                                        height: R.dp(50)
                                        fillMode: Image.PreserveAspectFit
                                        source: opt.ds ? R.image("like.png") : (md.likecliplist[index].myLike ? R.image("like_pink.png") : R.image("like.png"))
                                        anchors
                                        {
                                            horizontalCenter: parent.horizontalCenter
                                            verticalCenter: parent.verticalCenter
                                        }
                                    }
                                    MouseArea
                                    {
                                        anchors.fill: parent
                                        onClicked:
                                        {
                                            if(opt.ds)
                                            {
                                                likeImg.source = R.image("like_pink.png");
                                                likeTxt.color = R.color_theme01;
                                                return;
                                            }
z
                                            md.setLikeClip(index);
                                        }
                                    }
                                }

                                CPText
                                {
                                    id: likeTxt
                                    width: R.dp(100)
                                    height: R.dp(30)
                                    color: opt.ds ? "black" : (md.likecliplist[index].myLike ? R.color_theme01 : "black")
                                    text: opt.ds ? "999" : md.likecliplist[index].viewCount
                                    font.pointSize: R.pt(10)
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    anchors
                                    {
                                       top: likeIcon.bottom
                                       topMargin: R.dp(-20)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    function clearListButton()
    {
        for(var i=0; i<md.dlist.length; i++)
        {
            md.likecliplist[i].isClicked(false);
        }
    }


    function clearCategoryButtons()
    {
        for(var i=0; i<md.catelikelist.length; i++)
        {
            md.catelikelist[i].select(false);
        }
    }

}

