import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "Resources.js" as R

Paper {
    id: mainView
    visibleBackBtn: false
    backImg: R.image("menu_36dp.png")
    visibleSearchBtn: true
    titleText: "<font color='" + R.color_theme01 +"'>CLIP</font>" +"<font color='black'> LEARNING</font>"
    titleBgColor: "transparent"

    property bool initTab1 : false
    property bool initTab2 : false
    property bool initTab3 : false
    property bool initTab4 : false
    property int tabHeight : R.dp(150)
    property int tLength : opt.ds ? 5 : md.tablist.length

    Component.onCompleted:
    {
        loader.sourceComponent = componentTab1;
        if(!opt.ds)
        {
            md.catelikelist[0].select(true);
            md.tablist[0].select(true);
        }
    }

    onEvtSearch:
    {
        homeStackView.push(Qt.createComponent(R.view_file_option), { });
    }

    width: opt.ds ? R.design_size_width : homeStackView.width
    height: opt.ds ? R.design_size_height : homeStackView.height

    //    Drawer
    //    {
    //        id: drawer
    //        width: parent.width * 2 / 3
    //        height: parent.height
    //        dragMargin : opt.ds ? R.dp(50) : (md.blockedDrawer ? R.dp(0) : R.dp(50))
    //        position: opt.ds ? 0.0 : (md.openedDrawer ? 1.0 : 0.0)
    //        interactive: opt.ds ? true :settings.logined

    //        PGDrawer
    //        {
    //            onEvtMyClassRoom:
    //            {
    //                homeStackView.push(Qt.createComponent(R.view_file_myClassRoom), { });
    //            }

    //            onEvtBoardNotice:
    //            {
    //                homeStackView.push(Qt.createComponent(R.view_file_boardNotice), { });
    //            }

    //            onEvtBoardQnA:
    //            {
    //                homeStackView.push(Qt.createComponent(R.view_file_boardQnA), { });
    //            }

    //            onEvtBoardData:
    //            {
    //                homeStackView.push(Qt.createComponent(R.view_file_boardData), { });
    //            }

    //            onEvtBoardOption:
    //            {
    //                homeStackView.push(Qt.createComponent(R.view_file_option), { });
    //            }
    //        }
    //    }

    Column
    {
        width: parent.width
        height: parent.height
        //        ListModel {
        //            id: contactModel
        //            ListElement {
        //                imgPath: "image://async/img021.jpg"
        //            }
        //            ListElement {
        //                imgPath: "image://async/img038.jpg"
        //            }
        //            ListElement {
        //                imgPath: "image://async/img039.jpg"
        //            }
        //            ListElement {
        //                imgPath: "image://async/img040.jpg"
        //            }
        //        }

        //        Rectangle
        //        {
        //            id: viewPager
        //            width: parent.width
        //            height: R.dp(500)

        //            CPBusyIndicatorEKr {
        //                id: viewPagerBusy
        //                anchors {
        //                    left: parent.left
        //                    leftMargin: parent.width*0.5 - viewPagerBusy.width + R.dp(20)
        //                    verticalCenter: parent.verticalCenter
        //                }
        //            }

        //            PathView {
        //                id: pathView
        //                anchors.fill: parent
        //                model: contactModel
        //                delegate: CPImage {
        //                    source: imgPath
        //                    height : viewPager.height;
        //                    width: viewPager.width
        //                    fillMode: Image.PreserveAspectFit
        //                    clip: true
        //                }


        //                path: Path {
        //                    startX: viewPager.width * (contactModel.count>1 ? -0.5 : 0.5)
        //                    startY: viewPager.height*0.5
        //                    PathLine {
        //                        x: viewPager.width * (contactModel.count>1 ? (contactModel.count - 0.5) : 0.501)
        //                        y: viewPager.height*0.5;
        //                    }
        //                }
        //            }

        //            PageIndicator
        //            {
        //                id: pageIndicator
        //                count: pathView.count
        //                currentIndex: pathView.currentIndex
        //                anchors
        //                {
        //                    bottom: viewPager.bottom
        //                    horizontalCenter: parent.horizontalCenter
        //                    bottomMargin: R.dp(20)
        //                }
        //                delegate: Rectangle {
        //                    implicitWidth: R.dp(25)
        //                    implicitHeight: R.dp(25)
        //                    radius: width
        //                    color: "gray"
        //                    opacity: index === pathView.currentIndex ? 1.0 : pressed ? 0.7 : 0.45
        //                }
        //            }

        //            Timer
        //            {
        //                id: pagerControl
        //                interval:5000
        //                running: true
        //                repeat: true
        //                onTriggered: {
        //                    if(pathView.currentIndex == pathView.count-1)
        //                        pathView.currentIndex = 0;
        //                    else
        //                        pathView.currentIndex += 1;

        //                    pageIndicator.currentIndex = pathView.currentIndex;
        //                }
        //            }

        //            Component.onCompleted:
        //            {
        //                if(pathView.count > 0) {
        //                    viewPagerBusy.visible = false;
        //                    viewPagerBusy.running = false;
        //                }
        //            }
        //        }

        //        Row
        //        {
        //            width: parent.width
        //            height: R.height_button_middle
        //            LYMargin
        //            {
        //                width: 1
        //            }

        //            CPButton
        //            {
        //                sourceWidth: parent.width * 0.5 - 1
        //                sourceHeight: R.height_button_middle
        //                btnName: "카카오 로그아웃"
        //                rectColor: R.color_buttonColor001
        //                textColor: "white"
        //                onClicked:
        //                {
        //                    /* DESIGN LOGIC */
        //                    if(opt.ds)
        //                    {
        //                        return; /* PLEASE DON'T REMVOE! */
        //                    }

        //                    /* NOT DESIGN LOGIC */
        //                    cmd.logoutKakao();
        //                }
        //            }

        //            LYMargin
        //            {
        //                width: 1
        //            }

        //            CPButton
        //            {
        //                sourceWidth: parent.width  * 0.5 - 1
        //                sourceHeight: R.height_button_middle
        //                btnName: "카카오 연결해제"
        //                rectColor: R.color_buttonColor001
        //                textColor: "white"
        //                onClicked:
        //                {
        //                    /* DESIGN LOGIC */
        //                    if(opt.ds)
        //                    {
        //                        return; /* PLEASE DON'T REMVOE! */
        //                    }

        //                    /* NOT DESIGN LOGIC */
        //                    cmd.withdrawKakao();
        //                }
        //            }
        //        }

        //        Row
        //        {
        //            width: parent.width
        //            height: R.height_button_middle
        //            LYMargin
        //            {
        //                width: 1
        //            }

        //            CPButton
        //            {
        //                sourceWidth: parent.width * 0.5 -1
        //                sourceHeight: R.height_button_middle
        //                btnName: "페이스북 로그아웃"
        //                rectColor: R.color_buttonColor001
        //                textColor: "white"
        //                onClicked:
        //                {
        //                    /* DESIGN LOGIC */
        //                    if(opt.ds)
        //                    {



        //                        return; /* PLEASE DON'T REMVOE! */
        //                    }

        //                    /* NOT DESIGN LOGIC */
        //                    cmd.logoutFacebook();
        //                }
        //            }
        //            LYMargin
        //            {
        //                width: 1
        //            }

        //            CPButton
        //            {
        //                sourceWidth: parent.width * 0.5 -1
        //                sourceHeight: R.height_button_middle
        //                btnName: "페이스북 연결해제"
        //                rectColor: R.color_buttonColor001
        //                textColor: "white"
        //                onClicked:
        //                {
        //                    /* DESIGN LOGIC */
        //                    if(opt.ds)
        //                    {



        //                        return; /* PLEASE DON'T REMVOE! */
        //                    }

        //                    /* NOT DESIGN LOGIC */
        //                    cmd.withdrawFacebook();
        //                }
        //            }
        //        }


        //        Row
        //        {
        //            width: parent.width
        //            height: R.height_button_middle
        //            LYMargin
        //            {
        //                width: 1
        //            }

        //            CPButton
        //            {
        //                sourceWidth: parent.width * 0.5 - 1
        //                sourceHeight: R.height_button_middle
        //                btnName: "카카오 초대하기"
        //                rectColor: R.color_buttonColor001
        //                textColor: "white"
        //                onClicked:
        //                {
        //                    /* DESIGN LOGIC */
        //                    if(opt.ds)
        //                    {



        //                        return; /* PLEASE DON'T REMVOE! */
        //                    }

        //                    /* NOT DESIGN LOGIC */
        //                    cmd.inviteKakao();
        //                }
        //            }
        //            LYMargin
        //            {
        //                width: 1
        //            }
        //            CPButton
        //            {
        //                sourceWidth: parent.width * 0.5 - 1
        //                sourceHeight: R.height_button_middle
        //                btnName: "페이스북 공유하기"
        //                rectColor: R.color_buttonColor001
        //                textColor: "white"
        //                onClicked:
        //                {
        //                    /* DESIGN LOGIC */
        //                    if(opt.ds)
        //                    {



        //                        return; /* PLEASE DON'T REMVOE! */
        //                    }

        //                    /* NOT DESIGN LOGIC */
        //                    cmd.inviteFacebook();
        //                }
        //            }
        //        }

        //        Row
        //        {
        //            width: parent.width
        //            height: R.height_button_middle
        //            LYMargin
        //            {
        //                width: 1
        //            }
        //            CPButton
        //            {
        //                sourceWidth: parent.width * 0.5 - 1
        //                sourceHeight: R.height_button_middle
        //                btnName: "인디케이터 테스트"
        //                rectColor: R.color_buttonColor001
        //                textColor: "white"
        //                onClicked:
        //                {
        //                    busy(true);
        //                }
        //            }
        //            LYMargin
        //            {
        //                width: 1
        //            }
        //            CPButton
        //            {
        //                sourceWidth: parent.width * 0.5 - 1
        //                sourceHeight: R.height_button_middle
        //                btnName: "슬라이드 메뉴 열기"
        //                rectColor: R.color_buttonColor001
        //                textColor: "white"
        //                onClicked:
        //                {
        //                    drawer.open();
        //                }
        //            }
        //        }

        //        Row
        //        {
        //            width: parent.width
        //            height: R.height_button_middle
        //            LYMargin
        //            {
        //                width: 1
        //            }
        //            CPButton
        //            {
        //                sourceWidth: parent.width * 0.5 - 1
        //                sourceHeight: R.height_button_middle
        //                btnName: "앱존재여부1"
        //                rectColor: R.color_buttonColor001
        //                textColor: "white"
        //                onClicked:
        //                {
        //                    if(cmd.isInstalledApp("com.kakao.talk"))
        //                        toast("앱이 존재하네요.")
        //                    else
        //                        toast("앱이 없네요.")
        //                }
        //            }
        //            LYMargin
        //            {
        //                width: 1
        //            }
        //            CPButton
        //            {
        //                sourceWidth: parent.width * 0.5 - 1
        //                sourceHeight: R.height_button_middle
        //                btnName: "웹뷰테스트"
        //                rectColor: R.color_buttonColor001
        //                textColor: "white"
        //                onClicked:
        //                {
        //                    homeStackView.push(Qt.createComponent(R.view_file_videoPlayer), { });
        //                    //                    if(cmd.isInstalledApp("com.kakao.talk111"))
        //                    //                        toast("앱이 존재하네요.")
        //                    //                    else
        //                    //                        toast("앱이 없네요.")

        //                    //                                 userStackView.push(Qt.createComponent(R.view_file_joinEmail), { });
        //                }
        //            }
        //        }

        Loader
        {
            id: loader
            width: parent.width
            height: parent.height - tabHeight

        }

        Component
        {
            id: componentTab1
            PGTab1
            {
                width: loader.width
                height: loader.height + (R.height_statusbar + R.height_titlaBar)
                y: R.height_statusbar + R.height_titlaBar
                Component.onCompleted:
                {
                    mainView.titleType = 1;
                    mainView.titleText = ""
                    mainView.titleLineColor = R.color_theme01
                    if(opt.ds) return;

                    md.setHomeScrolled(false);
                }
            }
        }

        Component
        {
            id: componentTab2
            PGTab2
            {
                width: loader.width
                height: loader.height + (R.height_statusbar + R.height_titlaBar)
                y: R.height_statusbar + R.height_titlaBar
                Component.onCompleted:
                {
                    mainView.titleType = 0;
                    mainView.titleText = "<font color='black'>알림</font>"
                    mainView.titleLineColor = "black"
                    if(opt.ds) return;

                    md.setHomeScrolled(true);
                }
            }
        }

        Component
        {
            id: componentTab3
            PGTab3
            {
                width: loader.width
                height: loader.height + (R.height_statusbar + R.height_titlaBar)
                y: R.height_statusbar + R.height_titlaBar
                Component.onCompleted:
                {
                    mainView.titleType = 0;
                    mainView.titleText = "<font color='black'>검색</font>"
                    mainView.titleLineColor = "black"
                    if(opt.ds) return;

                    md.setHomeScrolled(true);
                }
            }
        }

        Component
        {
            id: componentTab4
            PGTab4
            {
                width: loader.width
                height: loader.height + (R.height_statusbar + R.height_titlaBar)
                y: R.height_statusbar + R.height_titlaBar
                Component.onCompleted:
                {
                    mainView.titleType = 0;
                    mainView.titleText = "<font color='black'>좋아요</font>"
                    mainView.titleLineColor = "black"
                    if(opt.ds) return;

                    md.setHomeScrolled(true);
                    md.catelikelist[0].select(true);

                    wk.getLikeClipList(0);
                    wk.request();
                }
            }
        }

        Component
        {
            id: componentTab5
            PGLoginDesk
            {
                width: loader.width
                height: loader.height + (R.height_statusbar + R.height_titlaBar)
                y: R.height_statusbar + R.height_titlaBar
                Component.onCompleted:
                {
                    mainView.titleType = 0;
                    mainView.titleText = "<font color='black'>로그인</font>"
                    mainView.titleLineColor = "black"
                    if(opt.ds) return;

                    md.setHomeScrolled(true);
                }
            }
        }

        Component
        {
            id: componentTab6
            PGMyPage
            {
                width: loader.width
                height: loader.height + (R.height_statusbar + R.height_titlaBar)
                y: R.height_statusbar + R.height_titlaBar
                Component.onCompleted:
                {
                    mainView.titleType = 0;
                    mainView.titleText = "<font color='black'>마이페이지</font>"
                    mainView.titleLineColor = "black"
                    if(opt.ds) return;

                    md.setHomeScrolled(true);
                }
            }
        }

        Rectangle
        {
            width: parent.width
            height: tabHeight

            Column
            {
                width: parent.width
                height: parent.height

                Rectangle
                {
                    id: line
                    width: parent.width
                    height: Qt.platform.os === "ios" ? 1 : R.dp(4)
                    color:R.color_gray001
                }

                Row
                {
                    width: parent.width
                    height: tabHeight - line.height

                    Repeater
                    {
                        model: tLength
                        CPButtonToggleTab
                        {
                            width: parent.width / tLength
                            height: tabHeight - line.height
                            title: opt.ds ? "untitled" : (md.tablist[index].title)
                            fontSize: R.pt(10)
                            iconWidth: R.dp(85)
                            iconHeight: R.dp(85)
                            heightTextArea: R.dp(30)
                            releasedColor: "black"
                            pressedColor: R.color_theme01
                            spacingValue: R.dp(12)
                            selected:
                            {
                                if(opt.ds) return false;
                                return md.tablist[index].selected;
                            }
                            onEvtSelect:
                            {
                                if(opt.ds) return;

                                switch(index)
                                {
                                case 0: loader.sourceComponent = componentTab1; break;
                                case 1: loader.sourceComponent = componentTab2; break;
                                case 2: loader.sourceComponent = componentTab3; break;
                                case 3: loader.sourceComponent = componentTab4; break;
                                case 4:
                                {
                                    if(!settings.logined)
                                        userStackView.push(Qt.createComponent(R.view_file_loginDesk), { })
                                    else
                                        userStackView.push(Qt.createComponent(R.view_file_option), { })
                                    return;
                                }
                                }

                                for(var i=0; i<md.tablist.length; i++)
                                {
                                    md.tablist[i].select(false);
                                }
                                md.tablist[index].select(true);
                            }

                            pressedSource:
                            {
                                if(!opt.ds) return md.tablist[index].pressedImg;

                                switch(index)
                                {
                                case 0: return R.image("home_pink.png");
                                case 1: return R.image("alarm_pink.png");
                                case 2: return R.image("search_pink.png");
                                case 3: return R.image("like_pink.png");
//                                case 4: return R.image("user_pink.png");
                                default: return R.image("noitem_pressed_24dp.png");
                                }
                            }
                            releasedSource:
                            {
                                if(!opt.ds) return md.tablist[index].releasedImg;

                                switch(index)
                                {
                                case 0: return R.image("home.png");
                                case 1: return R.image("alarm.png");
                                case 2: return R.image("search.png");
                                case 3: return R.image("like.png");
//                                case 4: return R.image("user.png");
                                default: return R.image("noitem_released_24dp.png");
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

