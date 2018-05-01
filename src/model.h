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

class Dummy : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int i READ i WRITE setI NOTIFY iChanged)
    Q_PROPERTY(QString s READ s WRITE setS NOTIFY sChanged)
    Q_PROPERTY(bool b READ b WRITE setB NOTIFY bChanged)
    Q_PROPERTY(QString c READ c WRITE setC NOTIFY cChanged)

public:
    Dummy(int i, QString s, QString c, bool b) : m_i(i), m_s(s), m_c(c), m_b(b) { }

    Q_INVOKABLE int i() const { return m_i; }
    Q_INVOKABLE QString s() const { return m_s; }
    Q_INVOKABLE bool b() const { return m_b; }
        Q_INVOKABLE QString c() const { return m_c; }


public slots:
    void setI(const int m) { m_i = m; }
    void setS(const QString &m) { m_s = m; emit sChanged(); }
    void setB(const bool &m) { m_b = m; emit bChanged(); }
    void setC(const QString &m) { m_c = m; emit cChanged(); }

signals:
    void iChanged();
    void sChanged();
    void bChanged();
    void cChanged();


private:
    int m_i= -1;
    QString m_s;
    bool m_b = false;
    QString m_c;
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
    Q_PROPERTY(QList<QObject*> dlist READ dlist NOTIFY dlistChanged)

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
    Q_INVOKABLE QList<QObject*> dlist() const { return m_dlist; }

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

signals:
    void listChanged();
    void currentIndexChanged();
    void titleChanged();
    void errorChanged();
    void blockedDrawerChanged();
    void openedDrawerChanged();
    void fullScreenChanged();
    void dlistChanged();

private:
    static Model* m_instance;
    Model()
    {
        Dummy* d1 = new Dummy(0, "test1.png", "transparent", false);
        Dummy* d2 = new Dummy(1, "test2.png", "transparent", false);
        Dummy* d3 = new Dummy(2, "test3.png", "transparent", false);
        Dummy* d4 = new Dummy(3, "test4.png", "transparent", false);
        Dummy* d5 = new Dummy(4, "test5.png", "transparent", false);
        Dummy* d6 = new Dummy(5, "test6.png", "transparent", false);
        Dummy* d7 = new Dummy(6, "test7.png", "transparent", false);
        Dummy* d8 = new Dummy(7, "test8.png", "transparent", false);
        Dummy* d9 = new Dummy(8, "test9.png", "transparent", false);

        m_dlist.append(d1);
        m_dlist.append(d2);
        m_dlist.append(d3);
        m_dlist.append(d4);
        m_dlist.append(d5);
        m_dlist.append(d6);
        m_dlist.append(d7);
        m_dlist.append(d8);
        m_dlist.append(d9);

    }

    QList<QObject*> m_list;
    int m_currentIndex = 0;
    QString m_title = "TITLE";
    QString m_error = "ERROR";
    bool m_blockedDrawer = false;
    bool m_openedDrawer = false;
    bool m_fullScreen = false;
    QList<QObject*> m_dlist;
};
