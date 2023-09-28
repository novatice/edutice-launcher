#include "qcursor.h"
#include "qdir.h"
#include "qguiapplication.h"
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonValue>
#include <QJsonArray>
#include <config.h>
#include <appmodel.h>
#include <directorymodel.h>
#include <QStandardPaths>
#include <QScreen>

Config* parseConfig(QJsonDocument &jsonDocument){
    QString agentVersion = jsonDocument.object().value("agentVersion").toString();
    QString OSVersion = jsonDocument.object().value("OSVersion").toString();
    QString serverAdress = jsonDocument.object().value("serverAdress").toString();
    bool assistance = jsonDocument.object().value("assistance").toBool();
    QJsonObject workspaceJson = jsonDocument.object().value("workspace").toObject();
    bool userIsTeacher = workspaceJson.value("user_is_teacher").toBool();
    bool missingDefaultBrowser =workspaceJson.value("missing_default_browser").toBool();
    bool lockScreenEnable = workspaceJson.value("lock_screen_enable").toBool();

    AppModel *applications = new AppModel();
    AppModel *recommendedApplications= new AppModel();
    DirectoryModel *linksModel = new DirectoryModel();
    QJsonArray apps = workspaceJson.value("applications").toArray();
    while (!apps.isEmpty()) {
        QJsonObject application = apps.first().toObject();
        QString name = application.value("name").toString();
        QString icon = "qrc:/icons/not_installed_app.svg";
        QString path = application.value("path").toString();
        QVariantList args =
            application.value("arguments").toArray().toVariantList();

        QStringList parsedArgs = QStringList();

        std::for_each(args.begin(), args.end(), [&parsedArgs](QVariant v) {
            // qDebug() << v.toString();
            parsedArgs.append(v.toString());
        });

        bool installed = false;
        if (path != "") {
            installed = true;
            if (application.value("icon").isUndefined()) {
                icon = "qrc:/icons/applications.png";
            } else {
                icon = "file:" + application.value("icon").toString();
            }
        } else {
            name += " [Non installée]";
        }
        Application app (name, icon, path, installed, parsedArgs);
        applications->addApplication(app);
        if (application.value("recommended").toBool())
            recommendedApplications->addApplication(app);
        apps.removeFirst();
    }

    QJsonValue links = workspaceJson.value("links");
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
    Workspace* workspace = new Workspace(userIsTeacher,lockScreenEnable,missingDefaultBrowser,applications,recommendedApplications,linksModel);
    Config* config = new Config(agentVersion,assistance,OSVersion,serverAdress,workspace);
    return config;
}

DefaultValues* setDefaultValues(QGuiApplication* app){
// The default directories (Documents, Pictures, Downloads, ...)
DirectoryModel *defaultDirectoriesModel = new DirectoryModel();
// The mounted directories from logon script
DirectoryModel *mountedDirectoriesModel = new DirectoryModel();
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
  if (dir.exists(userShareHome)) {
    mountedDirectoriesModel->addDirectory(
        Directory(userShareHome, "Dossier personnel", "documents.png",
                  "Dossier personnel enregistré sur le serveur"));
  }
  if (dir.exists(userShares)) {
    mountedDirectoriesModel->addDirectory(
        Directory(userShares, "Dossiers partagés", "documents.png",
                  "Dossiers partagés enregistrés sur le serveur"));
  }
  // Fill defaultDirectoriesModel with some directories
  Directory downloads = Directory(
      QStandardPaths::writableLocation(QStandardPaths::DownloadLocation),
      QStandardPaths::displayName(QStandardPaths::DownloadLocation),
      "downloads.png", "Dossier contenant les fichiers téléchargés");
  Directory documents = Directory(
      QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation),
      QStandardPaths::displayName(QStandardPaths::DocumentsLocation),
      "documents.png", "Dossier contenant les documents de la session");
  Directory pictures = Directory(
      QStandardPaths::writableLocation(QStandardPaths::PicturesLocation),
      QStandardPaths::displayName(QStandardPaths::PicturesLocation),
      "pictures.png", "Dossier contenant les images de la session");
  QString temp = QString(QDir::homePath() + "/Ressources temporaires");
  QString name = "Resources Temporaires";

  Directory TemporaryResources =
      Directory(temp, name, "dossier temporaire.png",
                "Resources Temporaires de la session");

  defaultDirectoriesModel->addDirectory(documents);
  defaultDirectoriesModel->addDirectory(pictures);
  defaultDirectoriesModel->addDirectory(downloads);
  defaultDirectoriesModel->addDirectory(TemporaryResources);

  QScreen *screen = app->primaryScreen();
  QPoint globalCursorPos = QCursor::pos();
  QScreen *mouseScreen = app->screenAt(globalCursorPos);
  QSize screenSize = screen->availableSize();
  DefaultValues* defaultValues = new DefaultValues(defaultDirectoriesModel,mountedDirectoriesModel,mouseScreen,screenSize);
  return defaultValues;
}
