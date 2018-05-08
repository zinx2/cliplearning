#include "networker.h"
#include <QMutexLocker>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>
#include <QHttpMultiPart>
#include "imageresponseprovider.h"

NetWorker* NetWorker::m_instance = nullptr;
NetWorker::NetWorker(QObject *parent) : QObject(parent)
{
    m = Model::getInstance();
    connect(this, SIGNAL(next()), this, SLOT(request()));
}
NetWorker::~NetWorker()
{
    //delete m;
}

void NetWorker::request()
{
    if (m_hosts.isEmpty())
        return;

    NetHost* host = m_hosts.front();
    QNetworkRequest req;

    if (!host->type().compare("post"))
    {
        QUrl url(DOMAIN_NAME + host->addr());
        QNetworkRequest req(url);
        req.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded;charset=UTF-8");
        m_netReply = m_netManager.post(req, host->queries().toString(QUrl::FullyDecoded).toUtf8());
    }
    else if (!host->type().compare("get"))
    {
        req = createRequest(host->addr(), host->queries());
        m_netReply = m_netManager.get(req);
    }
    else if (!host->type().compare("file"))
    {
        QHttpMultiPart *multiPart = new QHttpMultiPart(QHttpMultiPart::FormDataType);
        QHttpPart imagePart;
        imagePart.setHeader(QNetworkRequest::ContentTypeHeader, QVariant("image/jpeg")); /*jpeg*/
        imagePart.setHeader(QNetworkRequest::ContentDispositionHeader, QVariant("form-data; name=\"file\"; filename=\"" + host->file() + "\""));

        QFile *file = new QFile(host->file());
        file->open(QIODevice::ReadOnly);
        imagePart.setBodyDevice(file);
        file->setParent(multiPart);
        multiPart->append(imagePart);

        QUrl url(DOMAIN_NAME + host->addr());
        if (!host->queries().isEmpty())
            url.setQuery(host->queries());

        req.setUrl(url);
        m_netReply = m_netManager.post(req, multiPart);
        multiPart->setParent(m_netReply);

        /*QUrl url(DOMAIN_NAME + host->addr());
        QNetworkRequest req(url);
        req.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded;charset=UTF-8");
        m_netReply = m_netManager.post(req, multiPart);
        multiPart->setParent(m_netReply);*/


    }
    else return;

    qDebug() << "########## NETWORK INFORMATION ##########";
    QString msg = DOMAIN_NAME + host->addr();
    QList<QPair<QString, QString>> qItems = host->queries().queryItems();
    int size = qItems.size();
    if (size > 0)
    {
        for(int i=0; i<size; i++)
        {
            QPair<QString, QString> p = qItems.at(i);
            msg  += "\n[" + QString::number(i + 1) + "] key: " + p.first  + ", value: " +  p.second;
        }
    }
    qDebug().noquote() << msg;
    qDebug() << "#########################################";

    connect(m_netReply, QOverload<QNetworkReply::NetworkError>::of(&QNetworkReply::error), this, QOverload<QNetworkReply::NetworkError>::of(&NetWorker::httpError));
    connect(m_netReply, &QNetworkReply::finished, host->func());
    connect(m_netReply, SIGNAL(uploadProgress(qint64, qint64)), this, SLOT(progress(qint64, qint64)));
    m_hosts.pop_front();
}

void NetWorker::done()
{
    qDebug() << "done";
    QMutexLocker locker(&m_mtx);

    QJsonDocument jsonDoc = QJsonDocument::fromJson(m_netReply->readAll());
    QJsonObject jsonObj = jsonDoc.object();
    bool isSuccess = jsonObj["is_success"].toBool();
    QString url = jsonObj["file_url"].toString();
    QString name = jsonObj["file_name"].toString();

    //    Notificator * nott = new Notificator(isSuccess, jsonObj["error_message"].toString(), url, name, Notificator::File);
    //    nott->showDialog(true);
    //    m->setNotificator(nott);
}
void NetWorker::progress(qint64 a, qint64 b)
{
    qDebug() << a << "/" << b;
}

QNetworkRequest NetWorker::createRequest(QString suffixUrl, QUrlQuery queries)
{
    QUrl url(DOMAIN_NAME + suffixUrl);
    if (!queries.isEmpty())
        url.setQuery(queries);

    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded;charset=UTF-8");

    queries.clear();
    return request;
}

void NetWorker::httpError(QNetworkReply::NetworkError msg)
{
    qDebug() << "[**] THE ERROR WAS OCCURED. " << msg;
}

void NetWorker::getDummyAll()
{
    /********** SET URL QUERIES **********/

    m_hosts.append(new NetHost("get", "/getDummyAll",
                               [&]()-> void {

                                   m->setBusy(true);

                                   /********** PROCESS SEQUENTIALLY REQUESTS, SO BE DECLARED MUTEX **********/
                                   QMutexLocker locker(&m_mtx);

                                   /********** PARSE BINARY DATA TO JSON **********/
                                   QJsonDocument jsonDoc = QJsonDocument::fromJson(m_netReply->readAll());
                                   QJsonObject jsonObj = jsonDoc.object();
                                   QJsonArray jsonArr = jsonObj["list"].toArray();

                                   /********** MAKE MODEL USING PARSED JSON DATA **********/
                                   foreach(const QJsonValue &value, jsonArr)
                                   {
                                       QJsonObject obj = value.toObject();
                                       Dummy* d = new Dummy();
                                       d->setId(obj["id"].toInt());
                                       d->setContents(obj["contents"].toString());
                                       d->setTitle(obj["title"].toString());
                                       d->setDate(obj["date"].toString());
                                       d->setImgUrl(m->getImgUrl(obj["img"].toInt()));
                                       d->setBgColor(m->getColor(obj["bg_color"].toInt()));
                                       d->setCategory(obj["category"].toInt());
                                       d->setType(obj["type"].toInt());
                                       d->setOrder(obj["order"].toInt());
                                       d->setViewCount(obj["view_count"].toInt());
                                       d->setLikeCount(obj["like_count"].toInt());
                                       d->isMyLike(obj["my_like"].toInt() > 0);
                                       d->setCommentCount(obj["comment_count"].toInt());
                                       d->isMyComment(obj["my_comment"].toInt() > 0);

                                       qDebug() << d->category() << "/" << d->id() << "/" << d->contents() << "/" << d->title()<< "/" << d->imgUrl()<< "/" << d->viewCount()<< "/" << d->likeCount()<< "/" << d->commentCount()<< "/" << d->myLike()<< "/" << d->myComment() << "/" << d->bgColor();
                                       QObject* o = qobject_cast<QObject*>(d);
                                       m->addDummy(o);

                                       if(d->type() == 1) m->addPager(o);
                                   }
                                   qDebug() << m->dlist().size();

                                   if(m_hosts.length() == 0) m->setBusy(false);

                                   /********** CLEAR QNetworkReply INSTANCE **********/
                                   m_netReply->deleteLater();
                               }));

}

void NetWorker::getImageAll()
{
    /********** SET URL QUERIES **********/

    m_hosts.append(new NetHost("get", "/getImageAll",
                               [&]()-> void {

                                   m->setBusy(true);

                                   /********** PROCESS SEQUENTIALLY REQUESTS, SO BE DECLARED MUTEX **********/
                                   QMutexLocker locker(&m_mtx);

                                   /********** PARSE BINARY DATA TO JSON **********/
                                   QJsonDocument jsonDoc = QJsonDocument::fromJson(m_netReply->readAll());
                                   QJsonObject jsonObj = jsonDoc.object();
                                   QJsonArray jsonArr = jsonObj["list"].toArray();

                                   /********** MAKE MODEL USING PARSED JSON DATA **********/
                                   foreach(const QJsonValue &value, jsonArr)
                                   {
                                       QJsonObject obj = value.toObject();
                                       Image* d = new Image();
                                       d->setId(obj["id"].toInt());
                                       d->setWidth(obj["width"].toInt());
                                       d->setHeight(obj["height"].toInt());
                                       d->setName(obj["name"].toString());

                                       qDebug() << d->id() << "/" << d->width() << "/" << d->height()<< "/" << d->name();
                                       QObject* o = qobject_cast<QObject*>(d);
                                       m->addImage(o);
                                   }

                                   if(m_hosts.length() == 0) m->setBusy(false);

                                   /********** CLEAR QNetworkReply INSTANCE **********/
                                   m_netReply->deleteLater();
                                   emit next();
                               }));

}
void NetWorker::getColorAll()
{
    /********** SET URL QUERIES **********/

    m_hosts.append(new NetHost("get", "/getColorAll",
                               [&]()-> void {

                                   m->setBusy(true);

                                   /********** PROCESS SEQUENTIALLY REQUESTS, SO BE DECLARED MUTEX **********/
                                   QMutexLocker locker(&m_mtx);

                                   /********** PARSE BINARY DATA TO JSON **********/
                                   QJsonDocument jsonDoc = QJsonDocument::fromJson(m_netReply->readAll());
                                   QJsonObject jsonObj = jsonDoc.object();
                                   QJsonArray jsonArr = jsonObj["list"].toArray();

                                   /********** MAKE MODEL USING PARSED JSON DATA **********/
                                   foreach(const QJsonValue &value, jsonArr)
                                   {
                                       QJsonObject obj = value.toObject();
                                       Color* d = new Color();
                                       d->setId(obj["id"].toInt());
                                       d->setCode(obj["code"].toString());
                                       d->setDesc(obj["desc"].toString());
                                       d->setName(obj["name"].toString());

                                       qDebug() << d->id() << "/" << d->code() << "/" << d->desc()<< "/" << d->name();
                                       QObject* o = qobject_cast<QObject*>(d);
                                       m->addColor(o);
                                   }

                                   if(m_hosts.length() == 0) m->setBusy(false);

                                   /********** CLEAR QNetworkReply INSTANCE **********/
                                   m_netReply->deleteLater();
                                   emit next();
                               }));

}
void NetWorker::getCategoryAll()
{
    /********** SET URL QUERIES **********/

    m_hosts.append(new NetHost("get", "/getCategoryAll",
                               [&]()-> void {

                                   m->setBusy(true);

                                   /********** PROCESS SEQUENTIALLY REQUESTS, SO BE DECLARED MUTEX **********/
                                   QMutexLocker locker(&m_mtx);

                                   /********** PARSE BINARY DATA TO JSON **********/
                                   QJsonDocument jsonDoc = QJsonDocument::fromJson(m_netReply->readAll());
                                   QJsonObject jsonObj = jsonDoc.object();
                                   QJsonArray jsonArr = jsonObj["list"].toArray();

                                   /********** MAKE MODEL USING PARSED JSON DATA **********/
                                   int count = 0;
                                   foreach(const QJsonValue &value, jsonArr)
                                   {
                                       QJsonObject obj = value.toObject();
                                       Category* d = new Category();
                                       d->setId(obj["id"].toInt());
                                       d->setName(obj["name"].toString());
                                       if(m->categorylist().size() == 0) d->select(true);


                                       qDebug() << d->id() << "/" << d->name();
                                       QObject* o = qobject_cast<QObject*>(d);
                                       m->addCategory(o);
                                   }

                                   if(m_hosts.length() == 0) m->setBusy(false);

                                   /********** CLEAR QNetworkReply INSTANCE **********/
                                   m_netReply->deleteLater();
                                   emit next();
                               }));

}

void NetWorker::getLikeClipList(int type)
{
    m->setMessageInt(type);
    m_hosts.append(new NetHost("get", "/getDummyAll",
                               [&]()-> void {

                                   m->setBusy(true);

                                   /********** PROCESS SEQUENTIALLY REQUESTS, SO BE DECLARED MUTEX **********/
                                   QMutexLocker locker(&m_mtx);

                                   /********** PARSE BINARY DATA TO JSON **********/
                                   QJsonDocument jsonDoc = QJsonDocument::fromJson(m_netReply->readAll());
                                   QJsonObject jsonObj = jsonDoc.object();
                                   QJsonArray jsonArr = jsonObj["list"].toArray();

                                   m->clearLikeClip();
                                   int type = m->messageInt();
                                   /********** MAKE MODEL USING PARSED JSON DATA **********/
                                   foreach(const QJsonValue &value, jsonArr)
                                   {
                                       QJsonObject obj = value.toObject();
                                       Dummy* d = new Dummy();
                                       d->setId(obj["id"].toInt());
                                       d->setContents(obj["contents"].toString());
                                       d->setTitle(obj["title"].toString());
                                       d->setDate(obj["date"].toString());
                                       d->setImgUrl(m->getImgUrl(obj["img"].toInt()));
                                       d->setBgColor(m->getColor(obj["bg_color"].toInt()));
                                       d->setCategory(obj["category"].toInt());
                                       d->setType(obj["type"].toInt());
                                       d->setOrder(obj["order"].toInt());
                                       d->setViewCount(obj["view_count"].toInt());
                                       d->setLikeCount(obj["like_count"].toInt());
                                       d->isMyLike(obj["my_like"].toInt() > 0);
                                       d->setCommentCount(obj["comment_count"].toInt());
                                       d->isMyComment(obj["my_comment"].toInt() > 0);

                                       QObject* o = qobject_cast<QObject*>(d);
                                       qDebug() << "###### TYPE : " <<  type << "####";
                                       if(type == 0 && d->myLike())
                                       {
                                           qDebug() << d->category() << "/" << d->id() << "/" << d->contents() << "/" << d->title()<< "/" << d->imgUrl()<< "/" << d->viewCount()<< "/" << d->likeCount()<< "/" << d->commentCount()<< "/" << d->myLike()<< "/" << d->myComment() << "/" << d->bgColor();
                                           m->addLikeClip(o);
                                       }
                                       else if(type == 1 && d->myComment())
                                       {
                                           qDebug() << d->category() << "/" << d->id() << "/" << d->contents() << "/" << d->title()<< "/" << d->imgUrl()<< "/" << d->viewCount()<< "/" << d->likeCount()<< "/" << d->commentCount()<< "/" << d->myLike()<< "/" << d->myComment() << "/" << d->bgColor();
                                           m->addLikeClip(o);
                                       }
                                    }

                                   if(m_hosts.length() == 0) m->setBusy(false);

                                   /********** CLEAR QNetworkReply INSTANCE **********/
                                   m_netReply->deleteLater();
                               }));
}
