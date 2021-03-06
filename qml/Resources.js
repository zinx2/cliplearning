function dp(size) { return di.dp(size); }
function pt(size) { return di.pt(size); }

function log() { di.log(); }
function image(name) { return "../img/" + name; }
function font(name) { return "../font/" + name }
function qml() { return "../qml/" + name }
function os() { return Qt.platform.os; }

function toTime(mSecs)
{
    var hours = parseInt((mSecs / (1000*60*60))%24);
    var minutes = parseInt((mSecs / (1000*60))%60);
    var seconds = parseInt(mSecs / (1000)%60);

    hours = (hours < 10) ? "0" + hours : hours;
    minutes = (minutes < 10) ? "0" + minutes : minutes;
    seconds = (seconds < 10) ? "0" + seconds : seconds;

    return hours + ":" + minutes + ":" + seconds;
}

var height_statusbar = Qt.platform.os == "ios" ? 20 : 0
var height_titlaBar = dp(120);
var height_button_middle = dp(144);

var color_appTitlebar = "#ffffff"
var color_appTitleText = "#ffffff"
var color_buttonPressed = "#44000000"

var color_theme01 = "#fa7070"

var color_bgColor001 = "#fa7070"
var color_bgColor002 = "#f9acac"
var color_bgColor003 = "#ffe9e9"
var color_buttonColor001 = "#5460e0"

var color_orange = "#f6712a"
var color_toast = "#656565"

var color_kut_orange = "#ff7f00"
var color_kut_blue = "#183072"
var color_kut_lightBlue = "#22449c"
var color_kut_lightGray = "#b3b3aa"
var color_kut_gray = "#4c4c4c"

var color_gray001 = "#f5f6f6"

var MARGIN_XL     =   pt(45)//80
var MARGIN_L      =  pt(37.5)//72
var MARGIN_ML     = pt(33.5)//64
var MARGIN_M      = pt(21)//40
var MARGIN_MS      = pt(17)//32
var MARGIN_S       =  pt(12.5)//24
var MARGIN_XS       = pt(8)//16
var MARGIN_XXS       = pt(5)//8

var font_XXXXL        =  pt(89.25)//170
var font_XXXL        =  pt(51)//98
var font_XXL        = pt(38.5)//74
var font_XL         =  pt(35)//67
var font_L         =pt(30)//57
var font_ML        = pt(24.5)//47
var font_M           = pt(21.5)//41
var font_S         =  pt(19)//36
var font_XS         =  pt(17)//32.5


var string_title  = "OLEI ekoreatech"


var design_size_width = dp(1242); //di.width();
var design_size_height = dp(2208); //di.height();

var view_file_popup = "CPPopup.qml"

var view_file_home = "PGHome.qml"
var view_file_joinDesk = "PGJoinDesk.qml"
var view_file_joinEmail = "PGJoinEmail.qml"
var view_file_loginEmail = "PGLoginEmail.qml"
var view_file_loginDesk = "PGLoginDesk.qml"
var view_file_myClassRoom = "PGRoomMyClass.qml"
var view_file_option = "PGOption.qml"
var view_file_boardNotice = "PGBoardNotice.qml"
var view_file_boardQnA = "PGBoardQnA.qml"
var view_file_boardData = "PGBoardData.qml"
var view_file_videoPlayer = "PGVideoPlayer.qml"
var view_file_regularLecture = "PGLectureRegular.qml"
var view_file_recentlyLecture = "PGLectureRecently.qml"
var view_file_myLecture = "PGLectureMine.qml"



