import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "Resources.js" as R

Paper {
    id: mainView
    visibleSearchBtn: false
    titleText: "내 강의실"

    onEvtBack:
    {
        homeStackView.pop();
        if(homeStackView.depth === 1)
            md.setBlockedDrawer(false);
    }

    Column
    {
        y: R.height_titlaBar

        Row
        {
            CPButton
            {
                id: tabBtn1
                sourceWidth: parent.width / 3
                sourceHeight: R.height_button_middle
                btnName: "정규 수강강좌"
                rectColor: view.currentIndex == 0 ? "red" : R.color_buttonColor001
                textColor: "white"
                onClicked:
                {
                    view.currentIndex = 0;
                }
            }
            CPButton
            {
                id: tabBtn2
                sourceWidth: parent.width
                sourceHeight: R.height_button_middle
                btnName: "내가 만든 강좌"
                rectColor: view.currentIndex == 1 ? "red" : R.color_buttonColor001
                textColor: "white"
                onClicked:
                {
                    view.currentIndex = 1;
                }
            }
            CPButton
            {
                id: tabBtn3
                sourceWidth: parent.width
                sourceHeight: R.height_button_middle
                btnName: "나의 최근활동"
                rectColor: view.currentIndex == 2 ? "red" : R.color_buttonColor001
                textColor: "white"
                onClicked:
                {
                    view.currentIndex = 2;
                }
            }
        }

        SwipeView {
            id: view

            currentIndex: 0
            width: mainView.width
            height: mainView.height

            Item {
                id: firstPage
                PGLectureRegular {
                }
            }
            Item {
                id: secondPage
                PGLectureMine {
                }
            }
            Item {
                id: thirdPage
                PGLectureRecently {
                }
            }
        }
        //        SwipeView {
        //            id: view

        //            currentIndex: 0
        //            PGLectureRegular {
        //                id: firstPage
        //                anchors.fill: parent
        //            }
        //            PGLectureMine {
        //                id: secondPage
        //                anchors.fill: parent
        //            }
        //            PGLectureRecently {
        //                id: thirdPage
        //                anchors.fill: parent
        //            }
        //        }

        /* 테스트 코드 */
        //        Rectangle {

        //            y: R.height_titlaBar

        //            id: rect
        //            width: R.dp(1000)
        //            height: R.dp(500)
        //            color: "blue"

        //            Row
        //            {
        //                Column
        //                {
        //                    Button
        //                    {
        //                        width: R.dp(100)
        //                        height: R.dp(100)
        //                        text: "버튼1"
        //                    }

        //                    Button
        //                    {
        //                        width: R.dp(100)
        //                        height: R.dp(100)
        //                        text: "버튼3"
        //                    }
        //                }

        //                Button
        //                {
        //                    width: R.dp(100)
        //                    height: R.dp(100)
        //                    text: "버튼4"
        //                    onClicked: func("QWTQWTQWT")
        //                }
        //            }

        //            Button
        //            {
        //                anchors.horizontalCenter: parent.horizontalCenter
        //                anchors.verticalCenter: parent.verticalCenter
        //                //        anchors { verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter  }

        //                width: R.dp(100)
        //                height: R.dp(100)
        //                text: "버튼2"
        //            }
        //        }
    }

    function func(txt)
    {
        rect.color = "red"
        console.log(txt)
    }


}
