import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.4
import "Resources.js" as R

Rectangle
{
    width: R.dp(1080) //parent.width
    height: R.dp(1920) //parent.height
    color: "transparent"

    property int dLength : opt.ds ? 20 : md.dlist.length
    property int pagerCount : opt.ds ? contactModel.count : md.pagerlist.length
    property int categoryCount : opt.ds ? 7 : md.categorylist.length

    property int widthListItem : R.dp(1080)
    property int widthCategoryArea: R.dp(200)
    property int heightListItemImg : R.dp(500)
    property int heightListItemLb : R.dp(90)

    property int heightViewPager : R.dp(500)
    property int heightScvPadding: R.dp(10)
    property int heightCategoryArea: R.dp(100)
    property int heightListItem : heightListItemImg + heightListItemLb

    ListModel
    {
        id: contactModel
        ListElement {
            imgPath: "../img/noimage.png"
        }
        ListElement {
            imgPath: "../img/noimage.png"
        }
        ListElement {
            imgPath: "../img/noimage.png"
        }
        ListElement {
            imgPath: "../img/noimage.png"
        }
    }

    Flickable
    {
        id: flick
        anchors.fill: parent
        contentWidth : parent.width
        contentHeight: R.dp(100) + R.height_titlaBar + R.height_statusbar + heightViewPager + heightCategoryArea + heightScvPadding + (heightListItem * dLength)
        maximumFlickVelocity: heightListItem * dLength
        clip: true
        rebound: Transition {
            NumberAnimation {
                properties: "x, y"
                duration: 700
                easing.type: Easing.OutBounce
            }
        }
        //        boundsBehavior: Flickable.StopAtBounds

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

            //            Column
            //            {
            //                id: box
            //                width: parent.width
            //                height:  R.height_titlaBar
            //                Rectangle
            //                {
            //                    width: parent.width
            //                    height: R.height_titlaBar - R.dp(2)
            //                    color:"transparent"
            //                }
            //                Rectangle
            //                {
            //                    width: parent.width
            //                    height: R.dp(2)
            //                    color: R.color_theme01
            //                }

            //                states: [
            //                    State
            //                    {
            //                        when: md.homeScrolled
            //                        PropertyChanges { target: box; height: 0 }
            //                    },
            //                    State
            //                    {
            //                        when: !md.homeScrolled
            //                        PropertyChanges { target: box; height: R.height_titleBar }
            //                    }
            //                ]

            //                transitions:  Transition {
            //                    NumberAnimation { properties: "y, height"; easing.type: Easing.InOutQuad;}
            //                }
            //            }

            Rectangle
            {
                id: viewPager
                width: parent.width
                height: R.dp(500)

                CPBusyIndicatorEKr {
                    id: viewPagerBusy
                    anchors {
                        left: parent.left
                        leftMargin: parent.width*0.5 - viewPagerBusy.width + R.dp(20)
                        verticalCenter: parent.verticalCenter
                    }
                }

                PathView {
                    id: pathView
                    anchors.fill: parent
                    model: opt.ds ? contactModel : md.pagerlist
                    delegate: CPImage {
                        source: opt.ds ? imgPath : ("image://async/"+md.pagerlist[md.pagerlist[index].order-1].imgUrl)
                        height : viewPager.height;
                        width: viewPager.width
                        fillMode: Image.PreserveAspectCrop
                        clip: true
                    }

                    path: Path {
                        startX: viewPager.width * (pagerCount > 1 ? -0.5 : 0.5)
                        startY: viewPager.height*0.5
                        PathLine {
                            x: viewPager.width * ( pagerCount > 1 ? (pagerCount - 0.5) : 0.501)
                            y: viewPager.height*0.5;
                        }
                    }
                }

                PageIndicator
                {
                    id: pageIndicator
                    count: pathView.count
                    currentIndex: pathView.currentIndex

                    anchors
                    {
                        bottom: viewPager.bottom
                        horizontalCenter: parent.horizontalCenter
                        bottomMargin: R.dp(20)
                    }
                    delegate: Rectangle {
                        width: R.dp(40)
                        height: R.dp(40)
                        color: "transparent"

                        Rectangle
                        {
                            anchors
                            {
                                horizontalCenter: parent.horizontalCenter
                                verticalCenter: parent.verticalCenter
                            }

                            implicitWidth: R.dp(25)
                            implicitHeight: R.dp(25)
                            radius: width
                            color: "gray"
                            opacity: index === pathView.currentIndex ? 1.0 : pressed ? 0.7 : 0.45
                        }
                    }
                }

                Timer
                {
                    id: pagerControl
                    interval:5000
                    running: true
                    repeat: true
                    onTriggered: {
                        if(pathView.currentIndex == pathView.count-1)
                            pathView.currentIndex = 0;
                        else
                            pathView.currentIndex += 1;

                        pageIndicator.currentIndex = pathView.currentIndex;
                    }
                }

                Component.onCompleted:
                {
                    if(pathView.count > 0) {
                        viewPagerBusy.visible = false;
                        viewPagerBusy.running = false;
                    }
                }
            }

            ScrollView
            {
                id: scvCategory
                width: parent.width
                height: heightCategoryArea
                horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

                Rectangle
                {
                    width: widthCategoryArea * (opt.ds ? 7 : md.categorylist.length)
                    height: scvCategory.height
                    color: "white"
                    Row
                    {
                        width: parent.width
                        height: parent.height
                        Repeater
                        {
                            model: categoryCount

                            Rectangle
                            {
                                width: widthCategoryArea; height: heightCategoryArea;
                                color:"transparent"

                                Column{
                                    width: parent.width; height: parent.height;
                                    LYMargin { height: R.dp(20)}
                                    CPText
                                    {
                                        font.pointSize: R.pt(12)
                                        width: widthCategoryArea
                                        height: R.dp(70)
                                        text: opt.ds ? "Untitledddd" : md.categorylist[index].name
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                        color: "black"
                                    }
                                    Rectangle
                                    {
                                        width: widthCategoryArea * 0.7;
                                        height: index == 0 ? R.dp(6) : 0;
                                        anchors.right: parent.right
                                        color: opt.ds ? R.color_theme01 : (md.categorylist[index].selected ? R.color_theme01 : "#f5f6f6");
                                    }
                                    Rectangle
                                    {
                                        width: widthCategoryArea;
                                        height: index != 0 && index != (categoryCount-1) ? R.dp(6) : 0;
                                        color: opt.ds ? R.color_theme01 : (md.categorylist[index].selected ? R.color_theme01 : "#f5f6f6");
                                    }
                                    Rectangle
                                    {
                                        width: widthCategoryArea * 0.7;
                                        height: index == (categoryCount-1) ?  R.dp(6) : 0;
                                        anchors.left: parent.left
                                        color: opt.ds ? R.color_theme01 : (md.categorylist[index].selected ? R.color_theme01 : "#f5f6f6");
                                    }
                                }
                                MouseArea
                                {
                                    anchors.fill: parent
                                    onClicked:
                                    {
                                        if(opt.ds) return;
                                        clearCategoryButtons();
                                        md.categorylist[index].select(true);
                                    }
                                }
                            }
                        }
                    }
                }

            }

            Rectangle
            {
                id: scvPadding
                width: parent.width
                height: heightScvPadding
                color: "white"
            }

            Rectangle {

                id: rectList
                width: parent.width
                height: dLength == 0 ? parent.height : heightListItem * dLength
                y: viewPager.height
                color: "white"

                Component.onCompleted:
                {
                    if(opt.ds) return;

                    //            wk.getDummyAll();
                    //            console.log("@@Length : " + md.dlist.length);
                    //            console.log("@@Size : " + md.dlist.size);
                    //            console.log("@@Count : " + md.dlist.count);
                }

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

                        CPButton
                        {
                            sourceWidth: parent.width  * 0.5 - 1
                            sourceHeight: R.height_button_middle
                            btnName: "새로고침"
                            textColor: "white"
                            rectColor: R.color_buttonColor001
                            anchors.horizontalCenter: parent.horizontalCenter
                            onClicked:
                            {
                                /* DESIGN LOGIC */
                                if(opt.ds)
                                {
                                    return; /* PLEASE DON'T REMVOE! */
                                }

                                /* NOT DESIGN LOGIC */
                                wk.getDummyAll();
                                md.setBusy(true);
                                wk.request();
                            }
                        }
                    }
                }

                Column
                {
                    id: colRect
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
                            color: (opt.ds ? "gray" : md.dlist[index].bgColor)

                            Rectangle
                            {
                                id: imgRect
                                width: widthListItem
                                height: heightListItemImg
                                opacity: 0.0

                                CPImage
                                {
                                    id: img
                                    width: widthListItem
                                    height: heightListItemImg
                                    fillMode: Image.PreserveAspectCrop
                                    source : opt.ds ? "../img/noimage.png" : "image://async/"+md.dlist[index].imgUrl
                                    anchors
                                    {
                                        horizontalCenter: parent.horizontalCenter
                                        //                                verticalCenter: parent.verticalCenter
                                    }
                                }

                                OpacityAnimator {
                                    target: imgRect;
                                    from: 0;
                                    to: 1;
                                    duration: 500
                                    running:
                                    {
                                        if(index < 2) return true;
                                        else
                                        {
                                            if(imgRect.opacity < 0.5 ) return (flick.contentY > R.dp(200) + heightListItem * (index-2))
                                            return false;
                                        }
                                    }
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
                                    running: (opt.ds ? false : md.dlist[index].clicked)
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
                                        else return "[" + md.getCategory(md.dlist[index].category) + "]  " + md.dlist[index].title
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
                                    text: "조회수" + (opt.ds ? "999" : md.dlist[index].viewCount)
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
                                    md.dlist[index].isClicked(true);
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
                                        source: opt.ds ? R.image("like.png") : (md.dlist[index].myLike ? R.image("like_pink.png") : R.image("like.png"))
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
                                                likeImg.source = R.image("favorite_pressed_36dp.png");
                                                likeTxt.color = R.color_theme01;
                                                return;
                                            }
                                            z
                                            md.setLikeDummy(index);
                                        }
                                    }
                                }

                                CPText
                                {
                                    id: likeTxt
                                    width: R.dp(100)
                                    height: R.dp(30)
                                    color: opt.ds ? "black" : (md.dlist[index].myLike ? R.color_theme01 : "black")
                                    text: opt.ds ? "999" : md.dlist[index].viewCount
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



    //    states: [

    //        State
    //        {
    //            when: itemY < 200
    //            PropertyChanges { target: rectList; y: viewPager.height }
    //            PropertyChanges { target: viewPager; y: 0 }
    //        },
    //        State
    //        {
    //            when: itemY > 200
    //            PropertyChanges { target: rectList; y: 0 }
    //            PropertyChanges { target: viewPager; y: -viewPager.height }
    //        }]


    //    transitions:  Transition {
    //        id: trans
    //        enabled: false;
    //        NumberAnimation { properties: "y"; easing.type: Easing.InOutQuad;}
    //////        NumberAnimation { properties: "x, y, height"; easing.type: Easing.InOutQuad;}
    //    }

    //    Timer
    //    {
    //        id: ttt
    //        running: true
    //        repeat: true
    //        interval: 50
    //        onTriggered:
    //        {
    //            console.log(trans.running);
    //            trans.enabled = false;
    //        }
    //    }

    //    Timer
    //    {
    //        id: offAnimation
    //        running: flick.contentY > 200
    //        repeat: false
    //        onTriggered:
    //        {

    //            flick.interactive = false;
    //            onAnimation.running = true;
    //            console.log("RURURURURU")
    //        }
    //    }

    //    Timer
    //    {
    //        id: onAnimation
    //        running: false
    //        repeat: false
    //        interval: 1000
    //        onTriggered:
    //        {
    //            flick.interactive = true;
    //        }
    //    }

    //    Timer {
    //        running: flick.moving
    //        repeat: true
    //        interval: 200
    //        onTriggered:
    //        {
    //            console.log("flick.moving >> " + flick.contentY);

    //            if(flick.contentY < 200)
    //            {
    //                rectList.y = viewPager.height
    //                viewPager.y = 0
    //            }
    //            else
    //            {
    //                rectList.y = 0
    //                viewPager.y = -viewPager.height

    //            }
    //        }
    //    }


    //    Timer {
    //        running: flick.moving
    //        repeat: true
    //        interval: 200
    //        onTriggered:
    //        {
    //            console.log("flick.moving >> " + flick.contentY);


    //            if(flick.contentY <= 0) return;
    //            if(flick.contentY <= viewPager.height)
    //                rectList.y = viewPager.height - flick.contentY;
    //        }
    //    }


    function clearListButton()
    {
        for(var i=0; i<md.dlist.length; i++)
        {
            md.dlist[i].isClicked(false);
        }
    }

    function clearCategoryButtons()
    {
        for(var i=0; i<md.categorylist.length; i++)
        {
            md.categorylist[i].select(false);
        }
    }

}

