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
    //->addAnimal(Animal("Wolf", "Medium","gimp","Application Photos"));
    //model->addAnimal(Animal("Polar bear", "Large","firefox","Application Photos"));
    //model->addAnimal(Animal("Quoll", "Small","gimp","Application Photos"));

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


    modelCategorie->addCategorie(Categorie("1", "Application Internet"));
    modelCategorie->addCategorie(Categorie("2", "Mathématiques"));
    modelCategorie->addCategorie(Categorie("3", "Physique"));
    modelCategorie->addCategorie(Categorie("4", "Chimie"));
    modelCategorie->addCategorie(Categorie("5", "Applications Photos"));
    modelCategorie->addCategorie(Categorie("6", "Traitement de texte"));
    modelCategorie->addCategorie(Categorie("4", "Chimie"));
    modelCategorie->addCategorie(Categorie("5", "Applications Photos"));
    modelCategorie->addCategorie(Categorie("6", "Traitement de texte"));


    //QObject *win = (engine.rootObjects().first())->findChild<QObject*>("mainAppliWindow");
    QObject *rect = (engine.rootObjects().first())->findChild<QObject*>("execution");
    Execution* ex = (qobject_cast<Execution*>(rect));


    if (rect)
    {
        if( QWindow* window = qobject_cast<QWindow*>( engine.rootObjects().at(0) ) )
        {
            ex->mainWindows = window;
        }

        //AppModel* add = ((qobject_cast<Execution*>(rect))->model) ;
        ex->model = model;
        //(qobject_cast<Execution*>(rect))->setTimeR(timeR);

        ex->addRow("Firefox", "mozilla.png","firefox","Navigateur Internet");
        ex->addRow("Photoshop", "Adobe_Photoshop_CS6_icon.png","photoshop","Navigateur Internet");
        ex->addRow("Gimp", "600px-The_GIMP_icon_-_gnome.svg.png","gimp","Navigateur Internet");
        ex->addRow("Matlab", "Matlab_Logo.png","firefox","Mathématiques");

        ex->addRow("Facebook", "icon-facebook-logo.png","firefox","Navigateur Internet");
        ex->addRow("Visual Studio", "visual studio icon.png","firefox","Navigateur Internet");
        ex->addRow("Discord", "discord_101785.png","firefox","Navigateur Internet");
        ex->addRow("Skype", "Skype-icon-new.png","firefox","Navigateur Internet");

        ex->addRow("Twitter", "Twitter_Bird.svg.png","firefox","Navigateur Internet");
        ex->addRow("Chrome", "Google_Chrome_icon_(2011).png","firefox","Navigateur Internet");
        ex->addRow("Word", "word.png","firefox","Navigateur Internet");
        ex->addRow("Acrobat Reader", "acroat.png","firefox","Navigateur Internet");

        ex->addRow("VLC media player", "vlc.png","firefox","Navigateur Internet");
        ex->addRow("Football", "soccerball.png","firefox","Navigateur Internet");
        ex->addRow("Logithèque Ubuntu", "1200px-Ubuntu_Software_Center_icon_v3.svg.png","firefox","Navigateur Internet");
        ex->addRow("Instagram", "1024px-Instagram_icon.png","firefox","Navigateur Internet");

        ex->addRow("Help", "help.png","firefox","Navigateur Internet");
        ex->addRow("Service", "service.png","firefox","Navigateur Internet");





    }

    return app.exec();
}
