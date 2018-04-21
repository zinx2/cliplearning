import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtWebView 1.1
import QtMultimedia 5.8
import "Resources.js" as R

Paper {
    id: mainView
    visibleSearchBtn: false
    titleText: "웹테스트"


//    WebView {

//        id: webView
//        y: R.height_titlaBar
//        width: parent.width
//        height: parent.height - R.height_titlaBar
//        url: "http://tv.naver.com/v/2853949"
////        url: "https://cradmaser.blog.me/221232633863"
//        onLoadingChanged: {
//            if (loadRequest.errorString)
//                console.error(loadRequest.errorString);
//        }
//    }

     MediaPlayer {
         id: mediaplayer
         source: "http://yt-dash-mse-test.commondatastorage.googleapis.com/media/car-20120827-86.mp4"
     }

     VideoOutput {
         id: videoOutput
         anchors.fill: parent
         source: mediaplayer
     }
     MouseArea {
         id: playArea
         anchors.fill: parent
         onPressed: mediaplayer.play();
     }
     Row {
         Button
         {
             text : "재생"
             onClicked: mediaplayer.play();
         }
         Button
         {
             text : "일시정지"
             onClicked: mediaplayer.pause();
         }
         Button
         {
             text : "정지"
             onClicked: mediaplayer.stop();
         }
         Button
         {
             text : "전체화"
             onClicked:
             {
                 videoOutput.orientation = 90;
                 cmd.full();
             }
         }
         Button
         {
             text : "전체화해제"
             onClicked:
             {
                 videoOutput.orientation = 0;
             }
         }
     }

    onEvtBack:
    {
        webView.visible  = false;
        webView.url = "";

        homeStackView.pop();
        if(homeStackView.depth === 1)
            md.setBlockedDrawer(false);
    }
}
