#include <QAbstractListModel>
#include <QCommandLineParser>
#include <QCursor>
#include <QDebug>
#include <QDir>
#include <QGuiApplication>
#include <QHostInfo>
#include <QIODevice>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlProperty>
#include <QScreen>
#include <QSortFilterProxyModel>
#include <QtQuick/QQuickItem>
#include <QtQuick/QQuickView>
#include "windowsnativeeventfilter.h"
#include <appmodel.h>
#include <directorymodel.h>
#include <iostream>
//#include <keyemitter.h>
#include <appconstants.h>
#include <config.h>
#include <configparser.h>
#include <execution.h>

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
  sa.sa_mask = blocking_mask;
  sa.sa_flags = 0;

  for (auto sig : quitSignals)
    sigaction(sig, &sa, nullptr);
}
#endif

#endif

int main(int argc, char *argv[]) {
#ifdef linux
  catchUnixSignals({SIGHUP});
#endif

  QGuiApplication app(argc, argv);

  QCommandLineParser parser;
  QCommandLineOption hideOption(QStringList() << "hidden",
                                "start with window hidden");
  parser.addOption(hideOption);
  parser.process(app);

  QQmlApplicationEngine engine;

  ApplicationConstants::applicationEngine = &engine;
  ApplicationConstants::guiApplication = &app;

  engine.addImportPath("qrc:/");

  engine.rootContext()->setContextProperty(
      "applicationDirPath", QGuiApplication::applicationDirPath());
  ApplicationConstants::defaultValues = setDefaultValues(&app);
  //engine.setInitialProperties({{"defaultValues", QVariant::fromValue(defaultValues)}});
  engine.rootContext()->setContextProperty("defaultValues", ApplicationConstants::defaultValues);

  qmlRegisterType<Execution>("Execution", 1, 0, "Execution");

  QJsonParseError err;
  QString val;
  QFile file;
  // Modifier le chemin d'accès au Json
  QString jsonPath;
#ifdef linux
  jsonPath = QDir::homePath() + "/.config/edutice/launcher.json";
#else
  jsonPath = QDir::homePath() +
             "/AppData/Local/Novatice/Edutice/Launcher/launcher.json";
#endif
  file.setFileName(jsonPath);
  file.open(QIODevice::ReadOnly | QIODevice::Text);
  val = file.readAll();
  file.close();

  QByteArray utf8String = val.toUtf8();
  QJsonDocument d = QJsonDocument::fromJson(utf8String, &err);

  Config *config = parseConfig(d);
  engine.rootContext()->setContextProperty("config", config);

  engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
  if (engine.rootObjects().isEmpty())
    return -1;

  //    KeyEmitter keyEmitter;
  //    engine.rootContext()->setContextProperty("keyEmitter", &keyEmitter);

  QObject *rect =
      (engine.rootObjects().constFirst())->findChild<QObject *>("execution");
  Execution *ex = (qobject_cast<Execution *>(rect));

  if (rect) {
    if (QWindow *window = qobject_cast<QWindow *>(engine.rootObjects().at(0))) {
      ex->mainWindows = window;
      if (parser.isSet(hideOption)) {
        window->hide();
      }
    }
  }
  app.installNativeEventFilter(new WindowsNativeEventFilter());

  return app.exec();
}
