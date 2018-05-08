#pragma once
#include <QObject>
#include <QList>
#include <QDebug>

using namespace std;

class Concept : public QObject {
    Q_OBJECT
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString src READ src WRITE setSrc NOTIFY srcChanged)
    Q_PROPERTY(bool visibled READ visibled WRITE setVisibled NOTIFY visibledChanged)


public:
    Concept(QObject* parent = 0) : QObject(parent) { }
    Concept(int id, QString name, QString src) : m_id(id), m_name(name), m_src(src) { }

    Q_INVOKABLE int id() const { return m_id; }
    Q_INVOKABLE QString name() const { return m_name; }
    Q_INVOKABLE QString src() const { return m_src; }
    Q_INVOKABLE bool visibled() const { return m_visibled; }


public slots:
    void setId(const int id) { m_id = id; }
    void setName(const QString &m) { m_name = m; emit nameChanged(); }
    void setSrc(const QString &m) { m_src = m; emit srcChanged(); }
    void setVisibled(const bool &m) { m_visibled = m; emit visibledChanged(); }


signals:
    void idChanged();
    void nameChanged();
    void srcChanged();
    void visibledChanged();


private:
    int m_id = -1;
    QString m_name;
    QString m_src;
    bool m_visibled = true;


};
//Q_DECLARE_METATYPE(Concept*)

class Category: public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(bool selected READ selected WRITE select NOTIFY selectedChanged)

public:
    Category() {}
    Category(int id, QString name) : m_id(id), m_name(name) {}

    Q_INVOKABLE int id() const { return m_id; }
    Q_INVOKABLE QString name() const { return m_name; }
    Q_INVOKABLE bool selected() const { return m_selected;}

signals:
    void idChanged();
    void nameChanged();
    void selectedChanged();

public slots:
    void setId(int m) { m_id = m; emit idChanged();}
    void setName(QString m) { m_name = m; emit nameChanged();}
    void select(bool m) {m_selected = m; emit selectedChanged();}

private:
    int m_id;
    QString m_name;
    bool m_selected = false;

};

class Color: public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString code READ code WRITE setCode NOTIFY codeChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString desc READ desc WRITE setDesc NOTIFY descChanged)

public:
    Color() {}
    Color(int id, QString code, QString name, QString desc) : m_code(code), m_id(id), m_name(name), m_desc(desc) {}

    Q_INVOKABLE int id() const { return m_id; }
    Q_INVOKABLE QString code() const { return m_code; }
    Q_INVOKABLE QString name() const { return m_name; }
    Q_INVOKABLE QString desc() const { return m_desc; }

signals:
    void idChanged();
    void nameChanged();
    void codeChanged();
    void descChanged();

public slots:
    void setId(int m) { m_id = m; }
    void setCode(QString m) { m_code = m; emit idChanged();}
    void setName(QString m) { m_name = m; emit nameChanged();}
    void setDesc(QString m) { m_desc = m; emit descChanged();}

private:
    int m_id;
    QString m_code;
    QString m_name;
    QString m_desc;
};

class Image: public QObject
{
    Q_OBJECT
    Q_PROPERTY(int id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(int width READ width WRITE setWidth NOTIFY widthChanged)
    Q_PROPERTY(int height READ height WRITE setHeight NOTIFY heightChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)

public:
    Image() {}
    Image(int id, int width, int height, QString name) : m_id(id), m_width(width), m_height(m_height), m_name(name) {}

    Q_INVOKABLE int id() const { return m_id; }
    Q_INVOKABLE int width() const { return m_width; }
    Q_INVOKABLE int height() const { return m_height; }
    Q_INVOKABLE QString name() const { return m_name; }

signals:
    void idChanged();
    void widthChanged();
    void heightChanged();
    void nameChanged();

public slots:
    void setId(int m) { m_id = m; }
    void setWidth(int m) { m_width = m; }
    void setHeight(int m) { m_height = m; }
    void setName(QString m) { m_name = m; }

private:
    int m_id;
    int m_width;
    int m_height;
    QString m_name;
};


class Dummy : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int           id READ id           WRITE setId           NOTIFY idChanged)
    Q_PROPERTY(QString contents READ contents     WRITE setContents     NOTIFY contentsChanged)
    Q_PROPERTY(QString    title READ title        WRITE setTitle        NOTIFY titleChanged)
    Q_PROPERTY(QString   imgUrl READ imgUrl       WRITE setImgUrl       NOTIFY imgUrlChanged)
    Q_PROPERTY(QString   date READ date       WRITE setDate       NOTIFY dateChanged)
    Q_PROPERTY(int   category READ category       WRITE setCategory  NOTIFY categoryChanged)
    Q_PROPERTY(int   type READ type WRITE setType NOTIFY typeChanged)
    Q_PROPERTY(int   order READ order WRITE setOrder NOTIFY orderChanged)
    Q_PROPERTY(int    viewCount READ viewCount    WRITE setViewCount    NOTIFY viewCountChanged)
    Q_PROPERTY(int    likeCount READ likeCount    WRITE setLikeCount    NOTIFY likeCountChanged)
    Q_PROPERTY(bool      myLike READ myLike       WRITE isMyLike        NOTIFY myLikeChanged)
    Q_PROPERTY(int commentCount READ commentCount WRITE setCommentCount NOTIFY commentCountChanged)
    Q_PROPERTY(bool   myComment READ myComment    WRITE isMyComment     NOTIFY myCommentChanged)
    Q_PROPERTY(bool   clicked   READ clicked      WRITE isClicked       NOTIFY clickedChanged)
    Q_PROPERTY(QString bgColor  READ bgColor      WRITE setBgColor      NOTIFY bgColorChanged)


public:
    Dummy() {}
    Dummy(int id, QString contents, QString title, QString imgUrl, QString date, int category, int viewCount, int likeCount, bool myLike, int commentCount, bool myComment)
        : m_id(id), m_contents(m_contents), m_title(title), m_imgUrl(imgUrl), m_date(date), m_category(category), m_viewCount(viewCount), m_likeCount(likeCount), m_myLike(myLike), m_commentCount(commentCount), m_myComment(myComment)
    {

    }

    Q_INVOKABLE int id()            const { return m_id;           }
    Q_INVOKABLE QString contents()  const { return m_contents;     }
    Q_INVOKABLE QString title()     const { return m_title;        }
    Q_INVOKABLE QString imgUrl()    const { return m_imgUrl;       }
    Q_INVOKABLE int viewCount()     const { return m_viewCount;    }
    Q_INVOKABLE int type()     const { return m_type;    }
    Q_INVOKABLE int order()     const { return m_order;    }
    Q_INVOKABLE int likeCount()     const { return m_likeCount;    }
    Q_INVOKABLE bool myLike()       const { return m_myLike;       }
    Q_INVOKABLE int commentCount()  const { return m_commentCount; }
    Q_INVOKABLE bool myComment()    const { return m_myComment;    }
    Q_INVOKABLE bool clicked()    const { return m_clicked;    }
    Q_INVOKABLE QString bgColor() const { return m_bgColor; }
    Q_INVOKABLE QString date() const { return m_date; }
    Q_INVOKABLE int category() const { return m_category; }


public slots:
    void setId(int m)            { m_id = m; emit idChanged();}
    void setContents(QString m) { m_contents = m; emit contents();}
    void setTitle(QString m)    { m_title = m; emit titleChanged();}
    void setImgUrl(QString m)   { m_imgUrl = m; emit imgUrlChanged();}
    void setType(int m)     { m_type = m; emit typeChanged();}
    void setOrder(int m)     { m_order = m; emit orderChanged();}
    void setViewCount(int m)     { m_viewCount = m; emit viewCountChanged();}
    void setLikeCount(int m)     { m_likeCount = m; emit likeCountChanged();}
    void isMyLike(bool m)        { m_myLike = m; emit myLikeChanged();}
    void setCommentCount(int m)  { m_commentCount = m; emit commentCountChanged();}
    void isMyComment(bool m)     { m_myComment = m; emit myCommentChanged();}
    void isClicked(bool m)       { m_clicked = m; emit clickedChanged();}
    void setBgColor(QString m)  {m_bgColor = m; emit bgColorChanged();}
    void setDate(QString m) {m_date = m; emit dateChanged();}
    void setCategory(int m) {m_category = m; emit categoryChanged();}


signals:
    void idChanged();
    void contentsChanged();
    void titleChanged();
    void imgUrlChanged();
    void viewCountChanged();
    void likeCountChanged();
    void myLikeChanged();
    void commentCountChanged();
    void myCommentChanged();
    void clickedChanged();
    void bgColorChanged();
    void categoryChanged();
    void dateChanged();
    void typeChanged();
    void orderChanged();

private:
    int m_id = 0;
    QString m_contents;
    QString m_title;
    QString m_imgUrl;
    int m_viewCount = 0;
    int m_likeCount = 0;
    bool m_myLike = false;
    int m_commentCount = 0;
    bool m_myComment = false;
    bool m_clicked = false;
    QString m_bgColor = "transparent";
    QString m_date;
    int m_category = 0;
    int m_type = 0;
    int m_order = 0;
};

class Tab : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int                id READ id          WRITE setId          NOTIFY idChanged)
    Q_PROPERTY(QString         title READ title       WRITE setTitle       NOTIFY titleChanged)
    Q_PROPERTY(QString    pressedImg READ pressedImg  WRITE setPressedImg  NOTIFY pressedImgChanged)
    Q_PROPERTY(QString   releasedImg READ releasedImg WRITE setReleasedImg NOTIFY releasedImgChanged)
    Q_PROPERTY(QString    pressedColor READ pressedColor  WRITE setPressedColor  NOTIFY pressedColorChanged)
    Q_PROPERTY(QString   releasedColor READ releasedColor WRITE setReleasedColor NOTIFY releasedColorChanged)
    Q_PROPERTY(bool         selected READ selected    WRITE select         NOTIFY selectedChanged)

public:
    Tab(int id, QString title, QString pressedImg, QString releasedImg, QString pressedColor, QString releasedColor, bool selected)
        : m_id(id), m_title(title), m_pressedImg(pressedImg), m_releasedImg(releasedImg), m_selected(selected), m_pressedColor(pressedColor), m_releasedColor(releasedColor) {}

    Q_INVOKABLE int id()            const { return m_id;           }
    Q_INVOKABLE QString title()     const { return m_title;        }
    Q_INVOKABLE QString pressedImg()    const { return m_pressedImg;       }
    Q_INVOKABLE QString releasedImg()    const { return m_releasedImg;       }
    Q_INVOKABLE QString pressedColor()    const { return m_pressedColor;       }
    Q_INVOKABLE QString releasedColor()    const { return m_releasedColor;       }
    Q_INVOKABLE bool selected()       const { return m_selected;       }

public slots:
    void setId(int m)            { m_id = m; emit idChanged();}
    void setTitle(QString m)    { m_title = m; emit titleChanged();}
    void setPressedImg(QString m)   { m_pressedImg = m; emit pressedImgChanged();}
    void setReleasedImg(QString m)   { m_releasedImg = m; emit releasedImgChanged();}
    void setPressedColor(QString m)   { m_pressedColor = m; emit pressedColorChanged();}
    void setReleasedColor(QString m)   { m_releasedColor = m; emit releasedColorChanged();}
    void select(bool m)        { m_selected = m; emit selectedChanged();}

signals:
    void idChanged();
    void titleChanged();
    void pressedImgChanged();
    void releasedImgChanged();
    void selectedChanged();
    void pressedColorChanged();
    void releasedColorChanged();

private:
    int m_id = 0;
    QString m_title;
    QString m_pressedImg;
    QString m_releasedImg;
    QString m_pressedColor;
    QString m_releasedColor;
    bool m_selected = false;
};

class Model : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int currentIndex READ currentIndex WRITE setCurrentIndex NOTIFY currentIndexChanged)
    Q_PROPERTY(QList<QObject*> list READ list NOTIFY listChanged)
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(QString error READ error WRITE setError NOTIFY errorChanged)
    Q_PROPERTY(bool blockedDrawer READ blockedDrawer WRITE setBlockedDrawer NOTIFY blockedDrawerChanged)
    Q_PROPERTY(bool openedDrawer READ openedDrawer WRITE setOpenedDrawer NOTIFY openedDrawerChanged)
    Q_PROPERTY(bool fullScreen READ fullScreen WRITE setFullScreen NOTIFY fullScreenChanged)
    Q_PROPERTY(bool homeScrolled READ homeScrolled WRITE setHomeScrolled NOTIFY homeScrolledChanged)
    Q_PROPERTY(bool busy READ busy WRITE setBusy NOTIFY busyChanged)
    Q_PROPERTY(QList<QObject*> dlist READ dlist NOTIFY dlistChanged)
    Q_PROPERTY(QList<QObject*> pagerlist READ pagerlist NOTIFY pagerlistChanged)
    Q_PROPERTY(QList<QObject*> tablist READ tablist  NOTIFY tablistChanged)
    Q_PROPERTY(QList<QObject*> imglist READ imglist NOTIFY imglistChanged)
    Q_PROPERTY(QList<QObject*> categorylist READ categorylist NOTIFY categorylistChanged)
    Q_PROPERTY(QList<QObject*> colorlist READ colorlist NOTIFY colorlistChanged)
    Q_PROPERTY(QList<QObject*> catelikelist READ catelikelist NOTIFY catelikelistChanged)
    Q_PROPERTY(QList<QObject*> likecliplist READ likecliplist NOTIFY likecliplistChanged)
    Q_PROPERTY(int messageInt READ messageInt WRITE setMessageInt NOTIFY messageIntChanged)

public:
    static Model* getInstance() {
        if (m_instance == nullptr)
            m_instance = new Model();
        return m_instance;
    }

    Q_INVOKABLE int currentIndex() const { return m_currentIndex; }
    Q_INVOKABLE int size() const { return m_list.length(); }
    Q_INVOKABLE QString getName(int index) { return qobject_cast<Concept*>(m_list[index])->name(); }
    Q_INVOKABLE QString getSrc(int index) { return qobject_cast<Concept*>(m_list[index])->src(); }
    Q_INVOKABLE QList<QObject*> list() const { return m_list; }
    Q_INVOKABLE QObject* getCurrentConcept() { return m_list[m_currentIndex]; }
    Q_INVOKABLE QString title() const { return m_title; }
    Q_INVOKABLE QString error() const { return m_error; }
    Q_INVOKABLE bool blockedDrawer()  const { return m_blockedDrawer; }
    Q_INVOKABLE bool openedDrawer()  const { return m_openedDrawer; }
    Q_INVOKABLE bool fullScreen()  const { return m_fullScreen; }
    Q_INVOKABLE bool homeScrolled()  const { return m_homeScrolled; }
    Q_INVOKABLE bool busy() const { return m_busy; }
    Q_INVOKABLE QList<QObject*> dlist() const { return m_dlist; }
    Q_INVOKABLE QList<QObject*> pagerlist() const { return m_pagerlist; }
    Q_INVOKABLE QList<QObject*> tablist() const { return m_tablist; }
    Q_INVOKABLE QList<QObject*> categorylist() const { return m_categorylist; }
    Q_INVOKABLE QList<QObject*> catelikelist() const { return m_catelikelist; }
    Q_INVOKABLE QList<QObject*> colorlist() const { return m_colorlist; }
    Q_INVOKABLE QList<QObject*> imglist() const { return m_imglist; }
    Q_INVOKABLE QList<QObject*> likecliplist() const { return m_likecliplist; }
    Q_INVOKABLE int messageInt() { int temp = m_messageInt; m_messageInt = -1; return temp; }

public slots:
    void setTitle(const QString m) { m_title = m; emit titleChanged(); }
    void setCurrentIndex(const int id) { m_currentIndex = id; emit currentIndexChanged(); }
    void initializeIndex() { m_currentIndex = -1; }
    void initialize()
    {
        for(QObject* obj : m_list)
        {
            Concept* cb = qobject_cast<Concept*>(obj);
            cb->setVisibled(true);
        }

        emit listChanged();
    }
    void search(QString str)
    {

        for(QObject* obj : m_list)
        {
            Concept* cb = qobject_cast<Concept*>(obj);
            cb->setVisibled(cb->name().contains(str));
            qDebug() << cb->name();
            qDebug() << str;
            qDebug() << cb->name().contains(str);
        }
        emit listChanged();
    }
    void setError(const QString m) { m_error = m; emit errorChanged(); }
    void setBlockedDrawer(const bool &m) { m_blockedDrawer = m; emit blockedDrawerChanged(); }
    void setOpenedDrawer(const bool &m) { m_openedDrawer = m; emit openedDrawerChanged(); }
    void setFullScreen(const bool &m) { m_fullScreen = m; emit fullScreenChanged(); }
    void setHomeScrolled(const bool &m) {m_homeScrolled = m; emit homeScrolledChanged();}
    void setBusy(const bool & m) { m_busy = m; emit busyChanged(); }
    void addDummy(QObject* m) { m_dlist.append(m); emit dlistChanged();}
    void addPager(QObject* m) { m_pagerlist.append(m); emit pagerlistChanged(); }
    void addImage(QObject* m) { m_imglist.append(m); emit imglistChanged();}
    void addColor(QObject* m) { m_colorlist.append(m); emit colorlistChanged();}
    void addCategory(QObject* m) { m_categorylist.append(m); emit categorylistChanged();}
    void addLikeClip(QObject* m) { m_likecliplist.append(m); emit likecliplistChanged(); }
    void clearLikeClip() { m_likecliplist.clear(); }
    void setLikeDummy(int index) {

        Dummy* d = qobject_cast<Dummy*>(m_dlist[index]);
        bool like = d->myLike();
        d->isMyLike(like);

        if(like) d->setViewCount(d->viewCount() + 1);
        else d->setViewCount(d->viewCount() - 1);
    }
    void setLikeClip(int index) {
        Dummy* d = qobject_cast<Dummy*>(m_likecliplist[index]);
        bool like = d->myLike();
        d->isMyLike(like);

        if(like) d->setViewCount(d->viewCount() + 1);
        else d->setViewCount(d->viewCount() - 1);
    }
    void setMessageInt(int m) { m_messageInt = m; emit messageIntChanged();}

    QString getImgUrl(int id)
    {
        for(QObject* obj : m_imglist)
        {
            Image* img = qobject_cast<Image*>(obj);
            if(img->id() == id) return img->name();
        }
        return "";
    }

    QString getColor(int id)
    {
        for(QObject* obj : m_colorlist)
        {
            Color* cr = qobject_cast<Color*>(obj);
            if(cr->id() == id) return cr->code();
        }
        return "";
    }

    QString getCategory(int id)
    {
        for(QObject* obj : m_categorylist)
        {
            Category* ct = qobject_cast<Category*>(obj);
            if(ct->id() == id) return ct->name();
        }
        return "";
    }

signals:
    void listChanged();
    void currentIndexChanged();
    void titleChanged();
    void errorChanged();
    void blockedDrawerChanged();
    void openedDrawerChanged();
    void fullScreenChanged();
    void homeScrolledChanged();
    void dlistChanged();
    void pagerlistChanged();
    void tablistChanged();
    void categorylistChanged();
    void colorlistChanged();
    void imglistChanged();
    void catelikelistChanged();
    void likecliplistChanged();
    void messageIntChanged();
    void busyChanged();

private:
    static Model* m_instance;
    Model()
    {
        m_tablist.append(new Tab(0, "홈", "../img/home_pressed_36dp.png", "../img/home_released_36dp.png", "black", "white", false));
        m_tablist.append(new Tab(0, "알림", "../img/alarm_pressed_36dp.png", "../img/alarm_released_36dp.png", "black", "white", false));
        m_tablist.append(new Tab(0, "검색", "../img/search_pressed_36dp.png", "../img/search_released_36dp.png", "black", "white", false));
        m_tablist.append(new Tab(0, "좋아요", "../img/favorite_pressed_36dp.png", "../img/favorite_released_36dp.png", "black", "white", false));
        m_tablist.append(new Tab(0, "로그인", "../img/account_pressed_36dp.png", "../img/account_released_36dp.png", "black", "white", false));

        m_catelikelist.append(new Category(1, "클립별"));
        m_catelikelist.append(new Category(2, "댓글별"));
    }

    QList<QObject*> m_list;
    int m_currentIndex = 0;
    QString m_title = "TITLE";
    QString m_error = "ERROR";
    bool m_blockedDrawer = false;
    bool m_openedDrawer = false;
    bool m_fullScreen = false;
    bool m_homeScrolled = false;
    bool m_busy = false;
    QList<QObject*> m_dlist;
    QList<QObject*> m_pagerlist;
    QList<QObject*> m_tablist;
    QList<QObject*> m_categorylist;
    QList<QObject*> m_catelikelist;
    QList<QObject*> m_colorlist;
    QList<QObject*> m_imglist;
    QList<QObject*> m_likecliplist;
    int m_messageInt = -1;
};
