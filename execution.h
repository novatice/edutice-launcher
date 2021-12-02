#ifndef EXECUTION_H
#define EXECUTION_H

#ifdef _WIN32
#include <windows.h>
#endif


#include <QObject>
#include <QProcess>
#include <appmodel.h>
#include <time.h>
#include <QGuiApplication>
#include <QtQuick/QQuickView>
#include <QtQuick/QQuickItem>
#include <QQmlContext>
#include <QProcess>
#include <iostream>
#include <QDesktopServices>

class Execution : public QObject
{

    Q_OBJECT
public:
    explicit Execution(QObject *parent = 0);
    Q_INVOKABLE QString launch(const QString &program);
    Q_INVOKABLE QString open(const QString &path);
    Q_INVOKABLE void lockScreen();
    Q_INVOKABLE void disconnectScreen();
    Q_INVOKABLE void addRow(QString name, QString img,QString src,QString cat);
    //void setTimeR(char* time);
    QQmlContext *ctxt;
    AppModel* model;
    int p;
    QWindow* mainWindows;
    Q_INVOKABLE void quit();
signals:
    void signalData(QString data);
    void signalExit(void);

protected:
    QProcess *m_process;

    time_t timeRemaining;
};


#endif // EXECUTION_H
