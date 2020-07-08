#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickView>
#include <QtQuick/QQuickItem>
#include <QQmlContext>
#include <execution.h>
#include <appmodel.h>
#include <categoriemodel.h>
#include <iostream>

#include <QAbstractListModel>
#include <QSortFilterProxyModel>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("applicationDirPath", QGuiApplication::applicationDirPath());

    char* timeR = "03:00:00";




    int i = 1;

    AppModel* model= new AppModel();
    //->addAnimal(Animal("Wolf", "Medium","gimp","Application Photos"));
    //model->addAnimal(Animal("Polar bear", "Large","firefox","Application Photos"));
    //model->addAnimal(Animal("Quoll", "Small","gimp","Application Photos"));

    CategorieModel* modelCategorie = new CategorieModel();
    engine.rootContext()->setContextProperty("myModel",model);
    engine.rootContext()->setContextProperty("modelCategorie",modelCategorie);

    std::cout << "lsss "<< std::endl;
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

    QObject *rect = (engine.rootObjects().first())->findChild<QObject*>("execution");
    //QObject *win = (engine.rootObjects().first())->findChild<QObject*>("mainAppliWindow");

    if (rect)
    {
        AppModel* add = ((qobject_cast<Execution*>(rect))->model) ;
         ((qobject_cast<Execution*>(rect))->model) = model;
        (qobject_cast<Execution*>(rect))->setTimeR(timeR);

        (qobject_cast<Execution*>(rect))->addRow("Firefox", "mozilla.png","firefox","Navigateur Internet");
        (qobject_cast<Execution*>(rect))->addRow("Photoshop", "Adobe_Photoshop_CS6_icon.png","photoshop","Navigateur Internet");
        (qobject_cast<Execution*>(rect))->addRow("Gimp", "600px-The_GIMP_icon_-_gnome.svg.png","gimp","Navigateur Internet");
        (qobject_cast<Execution*>(rect))->addRow("Matlab", "Matlab_Logo.png","firefox","Mathématiques");

        (qobject_cast<Execution*>(rect))->addRow("Facebook", "icon-facebook-logo.png","firefox","Navigateur Internet");
        (qobject_cast<Execution*>(rect))->addRow("Visual Studio", "visual studio icon.png","firefox","Navigateur Internet");
        (qobject_cast<Execution*>(rect))->addRow("Discord", "discord_101785.png","firefox","Navigateur Internet");
        (qobject_cast<Execution*>(rect))->addRow("Skype", "Skype-icon-new.png","firefox","Navigateur Internet");

        (qobject_cast<Execution*>(rect))->addRow("Twitter", "Twitter_Bird.svg.png","firefox","Navigateur Internet");
        (qobject_cast<Execution*>(rect))->addRow("Chrome", "Google_Chrome_icon_(2011).png","firefox","Navigateur Internet");
        (qobject_cast<Execution*>(rect))->addRow("Word", "word.png","firefox","Navigateur Internet");
        (qobject_cast<Execution*>(rect))->addRow("Acrobat Reader", "acroat.png","firefox","Navigateur Internet");

        (qobject_cast<Execution*>(rect))->addRow("VLC media player", "vlc.png","firefox","Navigateur Internet");
        (qobject_cast<Execution*>(rect))->addRow("Football", "soccerball.png","firefox","Navigateur Internet");
        (qobject_cast<Execution*>(rect))->addRow("Logithèque Ubuntu", "1200px-Ubuntu_Software_Center_icon_v3.svg.png","firefox","Navigateur Internet");
        (qobject_cast<Execution*>(rect))->addRow("Instagram", "1024px-Instagram_icon.png","firefox","Navigateur Internet");

        (qobject_cast<Execution*>(rect))->addRow("Help", "help.png","firefox","Navigateur Internet");
        (qobject_cast<Execution*>(rect))->addRow("Service", "service.png","firefox","Navigateur Internet");





    }

    return app.exec();
}
