#ifndef EXECUTION_H
#define EXECUTION_H

#ifdef WIN32
#include "windows.h"
#include "WinUser.h"
#endif

#include <qmetatype.h>
#include <QObject>
#include <QProcess>
#include <QGuiApplication>
#include <QtQuick/QQuickView>
#include <QtQuick/QQuickItem>
#include <QQmlContext>
#include <QProcess>
#include <QDesktopServices>

#include <appmodel.h>
#include <iostream>

class Execution : public QObject
{

    Q_OBJECT
public:
    explicit Execution(QObject *parent = 0);
    Q_INVOKABLE QString launch(const QString &program);
    Q_INVOKABLE QString open(const QString &path);
    Q_INVOKABLE void lockScreen();
    Q_INVOKABLE void disconnectScreen();
    Q_INVOKABLE void addRow(QString name, QString img,QString src,QString cat, bool installed);
    Q_INVOKABLE void openScreenDisplaySettings();

    QQmlContext *ctxt;
    AppModel* model;
    int p;
    QWindow* mainWindows;
    Q_INVOKABLE void quit();
    Q_INVOKABLE void shutdown();
signals:
    void signalData(QString data);
    void signalExit(void);

protected:
    QProcess *m_process;

    time_t timeRemaining;
};


#endif // EXECUTION_H
