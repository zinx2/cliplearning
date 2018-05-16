import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "Resources.js" as R

Paper {
    id: mainView
    visibleSearchBtn: false
    titleText: "설정"
    titleLineColor: "black"
    titleTextColor: "black"

    onEvtBack:
    {
        homeStackView.pop();
    }
}
