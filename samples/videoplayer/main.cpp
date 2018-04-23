#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "model.h"
int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);



    Model *model = Model::instance();

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    engine.rootContext()->setContextProperty("md", model);
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
