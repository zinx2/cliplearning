#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "display_information.h"
#include "model.h"
#include "option.h"
#include "networker.h"
#include "commander.h"
#include "settings.h"
#include "imageresponseprovider.h"
#include <QThread>
#include <QSettings>
#include <QtWebView/QtWebView>
//#include <qtwebengineglobal.h>

int main(int argc, char *argv[])
{
//    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    DisplayInfo dpInfo;

//     QtWebEngine::initialize();
//	QtWebView::initialize();

//    qmlRegisterType<NetWorker>("ac.olei.cliplearning", 1, 0, "NetWorker");

	Option opt; opt.setDs(false);

	Model *model = Model::getInstance();
    NetWorker *wk = NetWorker::getInstance();
//    wk->getDummyAll();
    Commander *cmd = Commander::getInstance();
    Settings *settings = Settings::getInstance();

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("di", &dpInfo);
	engine.rootContext()->setContextProperty("md", model);
    engine.rootContext()->setContextProperty("wk", wk);
	engine.rootContext()->setContextProperty("opt", &opt);
    engine.rootContext()->setContextProperty("cmd", cmd);
    engine.rootContext()->setContextProperty("settings", settings);
	engine.addImageProvider("async", new AsyncImageProvider);

    engine.load(QUrl(QLatin1String("qrc:/qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
