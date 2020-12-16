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
#include "appwindow.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("applicationDirPath", QGuiApplication::applicationDirPath());

    char timeRA[] = "03:00:00";
    char* timeR = timeRA;

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
        }

        ex->model = model;

        QJsonParseError err;

        QString val;
        QFile file;
        // Modifier le chemin d'accès au Json
        QString jsonPath;
        #ifdef linux
            jsonPath = ".config/edutice/launcher.json";
        #else
            jsonPath = "C:\\Users\\dev\\Documents\\applications.json";
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
                icon = "C:\\Users\\dev\\Documents\\téléchargement.png";
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
