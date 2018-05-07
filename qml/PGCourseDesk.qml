import QtQuick 2.0

Paper {
    property int index: 0
    titleText: opt.ds ? "과정소개" : md.dlist[index].title

    id: mainView
    visibleBackBtn: true
    visibleSearchBtn: false

    Column
    {
        y:R.height_titlaBar

        CPButton
        {
            sourceWidth: parent.width
            sourceHeight: R.height_button_middle
            btnName: "회원가입 완료"
            rectColor: R.color_kut_lightBlue
            textColor: "white"
            onClicked:
            {
                /* DESIGN LOGIC */
                if(opt.ds)
                {



                    return; /* PLEASE DON'T REMVOE! */
                }

                /* NOT DESIGN LOGIC */
                popupStack.pop();
            }
        }
    }

    onEvtBack:
    {
        userStackView.pop();
    }
}
