#ifndef EXECUTION_H
#define EXECUTION_H

#ifdef WIN32
#include "WinUser.h"
#include "windows.h"
#endif

#include <QDesktopServices>
#include <QGuiApplication>
#include <QObject>
#include <QProcess>
#include <QQmlContext>
#include <QtQuick/QQuickItem>
#include <QtQuick/QQuickView>
#include <qmetatype.h>

#include <appmodel.h>
#include <iostream>

class Execution : public QObject {

  Q_OBJECT
public:
  explicit Execution(QObject *parent = 0);
  Q_INVOKABLE QString launch(const QString &program,
                             const QStringList &args = QStringList());
  Q_INVOKABLE QString open(const QString &path);
  Q_INVOKABLE QString openFolder(const QString &path);
  Q_INVOKABLE void lockScreen();
  Q_INVOKABLE void disconnectScreen();
  Q_INVOKABLE void openScreenDisplaySettings();

  QQmlContext *ctxt;
  AppModel *model;
  QWindow *mainWindows;
  Q_INVOKABLE void quit();
  Q_INVOKABLE void shutdown();
signals:
  void signalData(QString data);
  void signalExit(void);
};

#endif // EXECUTION_H
