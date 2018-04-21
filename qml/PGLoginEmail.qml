import QtQuick 2.9
import QtQuick.Controls 2.2
import "Resources.js" as R

Paper {
    titleText: "이메일 로그인"

    id: mainView
    visibleBackBtn: true
    visibleSearchBtn: false


    /* 테스트용 */
    CPButton
    {
        sourceWidth: parent.width
        sourceHeight: R.height_button_middle
        btnName: "홈으로"
        rectColor: R.color_buttonColor001
        textColor: "white"
        onClicked:
        {
            settings.setLogined(true);
        }
    }

    onEvtBack:
    {
        userStackView.pop();
    }
}
