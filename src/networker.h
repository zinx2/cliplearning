#pragma once

#include <QObject>
#include <QThread>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QMutex>
#include <QUrlQuery>
#include "model.h"
#include <QImage>
#include <QQueue>

typedef std::function<void()> FUNC;
class NetHost : public QObject {
    Q_OBJECT
public:
    NetHost(QString type, QString addr, QUrlQuery queries, FUNC func, QString file="")
        : m_type(type), m_addr(addr), m_queries(queries), m_func(func), m_file(file) { }
    NetHost(QString type, QString addr, FUNC func)
        : m_type(type), m_addr(addr), m_func(func) { }
    QString type() const { return m_type; }
    QString addr() const { return m_addr; }
    QString file() const { return m_file; }
    QUrlQuery queries() const { return m_queries; }
    FUNC func() const { return m_func; }

public slots :
    void setType(const QString &m) { m_type = m; }
    void setAddr(const QString &m) { m_addr = m; }
    void setQueries(const QUrlQuery &m) { m_queries = m; }
    void setFunc(const FUNC &m) { m_func = m;}
    void setFile(const QString &m) { m_file = m; }

private:
    QString m_type;
    QString m_addr;
    QString m_file;
    QUrlQuery m_queries;
    FUNC m_func;
};

class NetWorker : public QObject
{
    Q_OBJECT
public:
    static NetWorker* getInstance()
    {
        if (m_instance == nullptr)
            m_instance = new NetWorker();
        return m_instance;
    }

    //	void requestGET(QNetworkRequest req, std::function<void()> parser);
    //	void requestPOST(QNetworkRequest req, std::function<void()> parser);

    void clearBuf() { m_hosts.clear(); }

public slots:
    void request();
    void httpError(QNetworkReply::NetworkError msg);
    void progress(qint64, qint64);
    void done();

    /************* API CALL METHODS ****************/
//    NetWorker* getDemoAll();
//    NetWorker* getDemo(int id);
//    NetWorker* postDemoAll();
//    NetWorker* postDemo(int id);
    void getDummyAll();
    void getImageAll();
    void getColorAll();
    void getCategoryAll();
    void getLikeClipList(int type=0);

signals:
    void next();
    void update(bool result);
    void upload(bool result);
    void finished();


private:
    QNetworkRequest createRequest(QString suffixUrl, QUrlQuery queries);

private:	
    NetWorker(QObject *parent = NULL);
    ~NetWorker();
    static NetWorker* m_instance;
    QQueue<NetHost*> m_hosts;

    QNetworkReply* m_netReply;
    Model* m = nullptr;
    QNetworkAccessManager m_netManager;

    QString receivedMsg;

    QMutex m_mtx;
    QUrlQuery m_queries;

    const QString DOMAIN_NAME = "http://favorite.cafe24app.com";
};

