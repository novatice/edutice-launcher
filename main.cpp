#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickView>
#include <QtQuick/QQuickItem>
#include <QQmlContext>
#include <execution.h>
#include <appmodel.h>
#include <categoriemodel.h>
#include <directorymodel.h>
#include <iostream>
#include <QScreen>
#include <QIODevice>
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
#include <QHostInfo>

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

    // Create a new model for Files

    AppModel* modelApplication= new AppModel();

    AppModel* recommendedApplications = new AppModel();

    CategorieModel* modelCategorie = new CategorieModel();
    // The default directories (Documents, Pictures, Downloads, ...)
    DirectoryModel* defaultDirectoriesModel = new DirectoryModel();
    // The mounted directories from logon script
    DirectoryModel* mountedDirectoriesModel = new DirectoryModel();

    DirectoryModel* linksModel = new DirectoryModel();


    engine.rootContext()->setContextProperty("modelApplication", modelApplication);
    engine.rootContext()->setContextProperty("favoritesModel", recommendedApplications);
    engine.rootContext()->setContextProperty("defaultDirectoriesModel", defaultDirectoriesModel);
    engine.rootContext()->setContextProperty("mountedDirectoriesModel", mountedDirectoriesModel);
    engine.rootContext()->setContextProperty("linksModel", linksModel);
    engine.rootContext()->setContextProperty("modelCategorie", modelCategorie);

    // Fill mountedDirectoriesModel
    QString userShareHome = "";
    QString userShares = "";
#ifdef WIN32
    // Z
    userShareHome = "Z:/";
    // Y
    userShares = "Y:/";
#else
    userShareHome = "/media/" + qgetenv("USER") + "/home";
    userShares = "/media/" + qgetenv("USER") + "/partages";
#endif
    QDir dir;
    if (dir.exists(userShareHome))
    {
        mountedDirectoriesModel->addDirectory(Directory(userShareHome, "Dossier personnel", "documents.png", "Dossier personnel enregistré sur le serveur"));
    }
    if (dir.exists(userShares))
    {
        mountedDirectoriesModel->addDirectory(Directory(userShares, "Dossiers partagés", "documents.png", "Dossiers partagés enregistrés sur le serveur"));
    }


    // Fill defaultDirectoriesModel with some directories
    Directory downloads = Directory(
                QStandardPaths::writableLocation(QStandardPaths::DownloadLocation),
                QStandardPaths::displayName(QStandardPaths::DownloadLocation),
                "downloads.png",
                "Dossier contenant les fichiers téléchargés");
    Directory documents = Directory(
                QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation),
                QStandardPaths::displayName(QStandardPaths::DocumentsLocation),
                "documents.png",
                "Dossier contenant les documents de la session");
    Directory pictures = Directory(
                QStandardPaths::writableLocation(QStandardPaths::PicturesLocation),
                QStandardPaths::displayName(QStandardPaths::PicturesLocation),
                "pictures.png",
                "Dossier contenant les images de la session");

    defaultDirectoriesModel->addDirectory(documents);
    defaultDirectoriesModel->addDirectory(pictures);
    defaultDirectoriesModel->addDirectory(downloads);

    QScreen* screen = app.primaryScreen();

    QPoint globalCursorPos = QCursor::pos();
    QScreen* mouseScreen = app.screenAt(globalCursorPos);
    QSize screenSize = screen->availableSize();

    engine.rootContext()->setContextProperty("screenWidth", screenSize.width());
    engine.rootContext()->setContextProperty("screenHeight", screenSize.height());
    engine.rootContext()->setContextProperty("screenNumberId", mouseScreen);

    qmlRegisterType<Execution>("Eexecution", 1, 0, "Execution");

    modelCategorie->addCategorie(Categorie("1", "Default"));

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


    QByteArray utf8String = val.toUtf8();
    QJsonDocument d = QJsonDocument::fromJson(utf8String, &err);

    QJsonValue agentVersion = d.object().value("agentVersion");
    engine.rootContext()->setContextProperty("agentVersion",  agentVersion.isUndefined() ? "Non renseigné" : agentVersion);

    QJsonValue OSVersion = d.object().value("OSVersion");
    engine.rootContext()->setContextProperty("OSVersion", OSVersion.isUndefined() ? "Non renseigné" : OSVersion);

    engine.rootContext()->setContextProperty("launcherVersion", VERSION);

    QJsonValue serverAddress = d.object().value("serverAddress");
    engine.rootContext()->setContextProperty("serverAddress", serverAddress);

    engine.rootContext()->setContextProperty(
                "username",
            #ifdef WIN32
                qgetenv("USERNAME")
            #else
                qgetenv("USER")
            #endif
                );

    QJsonObject workspace = d.object().value("workspace").toObject();
    QString workspaceName = workspace.value("name").toString();
    engine.rootContext()->setContextProperty("workspace", workspaceName);

    engine.rootContext()->setContextProperty("group", "");
    engine.rootContext()->setContextProperty("machine", QHostInfo::localHostName());

    QJsonArray apps = workspace.value("applications").toArray();
    while (!apps.isEmpty()) {
        QJsonObject application = apps.first().toObject();
        QString name = application.value("name").toString();
        QString icon = application.value("icon").toString();
        QString path = application.value("path").toString();
        QString category = application.value("category").toString();
        if(icon == "") {
            #ifdef linux
            icon = "linux_app_icon.png";
            #else
            icon = "windows_app_icon.png";
            #endif
        } else {
            icon = "file:" + icon;
        }
        // We use a temp category, as we didn't have them right now !
        Application app = Application(name, icon, path, "Default");
        if (application.value("recommended").toBool())
            recommendedApplications->addApplication(app);
        modelApplication->addApplication(app);
        //ex->addRow(app.type(), app.size(), app.src(), app.categorie());
        apps.removeFirst();
    }

    QJsonValue links = workspace.value("links");
    if (!links.isUndefined()) {
        QJsonArray linksArray = links.toArray();
        while (!linksArray.isEmpty()) {
            QJsonObject link = linksArray.first().toObject();
            QString name = link.value("name").toString();
            QString icon = link.value("icon").toString();
            QString path = link.value("url").toString();
            Directory dir = Directory(path, name, icon, "");
            linksModel->addDirectory(dir);
            linksArray.removeFirst();
        }
    }



    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

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
    }

    return app.exec();
}
