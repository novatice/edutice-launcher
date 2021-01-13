#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickView>
#include <QtQuick/QQuickItem>
#include <QQmlContext>
#include <execution.h>
#include <appmodel.h>
#include <categoriemodel.h>
#include <iostream>
#include <QScreen>
#include <QAbstractListModel>
#include <QSortFilterProxyModel>
#include <QQmlProperty>
#include <QCursor>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>
#include <QDebug>
#include <QDir>
#include <QCommandLineParser>

#ifdef linux
#include <signal.h>

#ifdef linux
void catchUnixSignals(std::initializer_list<int> quitSignals) {

    auto handler = [](int sig) -> void {
        qDebug() << "received signal : " << sig;

        if (sig == 1) {
            const QWindowList windows = QGuiApplication::allWindows();
            for (QWindow *window : windows) {
                qDebug() << "visible=" << window->isVisible();
                if (window->isVisible()) {
                    window->hide();
                } else {
                    window->show();
                }
            }
        }
    };

    sigset_t blocking_mask;
    sigemptyset(&blocking_mask);
    for (auto sig : quitSignals)
        sigaddset(&blocking_mask, sig);

    struct sigaction sa;
    sa.sa_handler = handler;
    sa.sa_mask    = blocking_mask;
    sa.sa_flags   = 0;

    for (auto sig : quitSignals)
        sigaction(sig, &sa, nullptr);
}
#endif

#endif

int main(int argc, char *argv[])
{

#ifdef linux
    catchUnixSignals({SIGHUP});
#endif

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QCommandLineParser parser;
    QCommandLineOption hideOption(QStringList() << "hidden",  "start with window hidden");
    parser.addOption(hideOption);
    parser.process(app);

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("applicationDirPath", QGuiApplication::applicationDirPath());

    AppModel* model= new AppModel();

    CategorieModel* modelCategorie = new CategorieModel();
    engine.rootContext()->setContextProperty("myModel",model);
    engine.rootContext()->setContextProperty("modelCategorie",modelCategorie);


    QScreen* scsreen = app.primaryScreen();

    QPoint globalCursorPos = QCursor::pos();
    QScreen* mouseScreen = app.screenAt(globalCursorPos);
    QSize screenSize = scsreen->availableSize();

    engine.rootContext()->setContextProperty("screenWidth", screenSize.width());
    engine.rootContext()->setContextProperty("screenHeight", screenSize.height());
    engine.rootContext()->setContextProperty("screenNumberId", mouseScreen);

    qmlRegisterType<Execution>("Eexecution", 1, 0, "Execution");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;


    modelCategorie->addCategorie(Categorie("1", "Navigateur Internet"));
    modelCategorie->addCategorie(Categorie("2", "Mathématiques"));
    modelCategorie->addCategorie(Categorie("3", "Physique"));
    modelCategorie->addCategorie(Categorie("4", "Chimie"));
    modelCategorie->addCategorie(Categorie("5", "Applications Photos"));
    modelCategorie->addCategorie(Categorie("6", "Traitement de texte"));

    QObject *rect = (engine.rootObjects().first())->findChild<QObject*>("execution");
    Execution* ex = (qobject_cast<Execution*>(rect));

    if (rect)
    {
        if( QWindow* window = qobject_cast<QWindow*>( engine.rootObjects().at(0) ) )
        {
            ex->mainWindows = window;
            if (parser.isSet(hideOption)) {
                    window->hide();
            }
        }

        ex->model = model;

        QJsonParseError err;

        QString val;
        QFile file;
        // Modifier le chemin d'accès au Json
        QString jsonPath;
        #ifdef linux
            jsonPath = QDir::homePath() + "/.config/edutice/launcher.json";
        #else
            jsonPath = QDir::homePath() + "/AppData/Local/Novatice/Edutice/Launcher/launcher.json";
        #endif

        file.setFileName(jsonPath);
        file.open(QIODevice::ReadOnly | QIODevice::Text);
        val = file.readAll();
        file.close();
        qInfo() << "val :: " << val;

        QByteArray utf8String = val.toUtf8();
        QJsonDocument d = QJsonDocument::fromJson(utf8String, &err);

        QJsonValue terminal = d.object().value("terminal");
        qInfo() << "terminal :: " << terminal.toString();

        QJsonValue username = d.object().value("username");
        qInfo() << "username :: " << username.toString();

        QJsonObject workspace = d.object().value("workspace").toObject();
        QString workspaceName = workspace.value("name").toString();
        qInfo() << "Workspace name ::: " << workspaceName;

        QJsonArray apps = workspace.value("applications").toArray();
        qInfo() << "apps :: " << apps.count();
        while (!apps.isEmpty()) {
            QJsonObject application = apps.first().toObject();
            QString name = application.value("name").toString();
            QString icon = application.value("icon").toString();
            QString path = application.value("path").toString();
            QString category = application.value("category").toString();
            qInfo() << "Name ::: " << name;
            qInfo() << "Icon ::: " << icon;
            if(icon == "") {
                #ifdef linux
                icon = "linux_app_icon.png";
                #else
                icon = "windows_app_icon.png";
                #endif
            } else {
                icon = "file:" + icon;
            }
            qInfo() << "Icon ::: " << icon;
            qInfo() << "Path ::: " << path;
            Application app = Application(name, icon, path, category);
            ex->addRow(app.type(), app.size(), app.src(), app.categorie());
            apps.removeFirst();
        }
    }

    return app.exec();
}
