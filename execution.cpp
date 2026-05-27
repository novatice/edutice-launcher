#include "execution.h"
#include <QDir>
#include <QDBusConnection>
#include <QDBusMessage>

Execution::Execution(QObject *parent)
    : QObject(parent), model(), mainWindows() {}

QString Execution::launch(const QString &program, const QStringList &args) {
  qInfo() << "In Execution::launch with " << program << " with args " << args;

  QFileInfo info(program);

  if ((info.exists())) {
    QProcess *process = new QProcess();

#ifdef _WIN32
    // There are some applications(BiblioManuels) that do not launch with the
    // path of the json file. We move to the desired folder. Then, we define the
    // currentpath.
    QString path = info.absolutePath();
    process->setWorkingDirectory(path + "/");
#endif

#ifdef __linux
    QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
    // this is done to avoid QProcess behavior that put a bad LD_LIBRARY_PATH
    env.insert("LD_LIBRARY_PATH", "");

    process->setProcessEnvironment(env);
#endif

    // keep full path as file might not be in PATH
    process->start(program, args);

    if (process->waitForStarted()) {
      qInfo() << "Launched with success";
    } else {
      qInfo() << "Launched with error";
      qWarning() << "error during launch: " << process->errorString();
    }
  } else {
    qWarning() << "the programe " << program << " doesn't exist";
  }

  return "";
}

QString Execution::openFolder(const QString &path) {
  QDesktopServices::openUrl(QUrl::fromLocalFile(path));

  return "";
}

QString Execution::open(const QString &path) {
  QDesktopServices::openUrl(path);
  return "";
}
void Execution::lockScreen() {
  std::cout << "def" << std::endl;
#ifdef linux
  // todo: replace qdbus command by "pure" Qt DBus code
  //l = "qdbus org.freedesktop.ScreenSaver /ScreenSaver Lock";
  QDBusMessage message = QDBusMessage::createMethodCall("org.kde.ksmserver",
                                                        "/ScreenSaver",
                                                        "org.freedesktop.ScreenSaver",
                                                        "Lock");
  QDBusConnection::sessionBus().send(message);
#endif
#ifdef _WIN32
  QString l = "rundll32.exe";
  QStringList args = {"user32.dll","LockWorkStation"};
  QProcess::startDetached(l,args);
#endif
}

void Execution::disconnectScreen() {
#ifdef linux
  QDBusMessage message = QDBusMessage::createMethodCall("org.kde.ksmserver","/KSMServer","org.kde.KSMServerInterface","logout");
  //Method args
  message.setArguments({0,0,0});
  QDBusConnection::sessionBus().send(message);
#elif _WIN32
  QString l = "shutdown";
  QStringList args = {"-L"};
  bool result = QProcess::startDetached(l,args);
#endif
}

void Execution::openScreenDisplaySettings() {
#ifdef WIN32
  INPUT inputs[4] = {};
  ZeroMemory(inputs, sizeof(inputs));

  inputs[0].type = INPUT_KEYBOARD;
  inputs[0].ki.wVk = VK_LWIN;

  inputs[1].type = INPUT_KEYBOARD;
  inputs[1].ki.wVk = 0x50;

  inputs[2].type = INPUT_KEYBOARD;
  inputs[2].ki.wVk = 0x50;
  inputs[2].ki.dwFlags = KEYEVENTF_KEYUP;

  inputs[3].type = INPUT_KEYBOARD;
  inputs[3].ki.wVk = VK_LWIN;
  inputs[3].ki.dwFlags = KEYEVENTF_KEYUP;

  SendInput(ARRAYSIZE(inputs), inputs, sizeof(INPUT));

#endif
#ifdef linux
  QString l = "xdotool key Super_L+p";
  QProcess::startDetached(l);
#endif
}

void Execution::quit() {
#ifdef _WIN32
  HWND hWnd = (HWND)mainWindows->winId();

  ShowWindow(hWnd, SW_HIDE);
#endif

#ifdef linux
  mainWindows->hide();
#endif
}

//Needs to be changed to put arguments in QStringList if we want to reimplement it.
void Execution::shutdown() {
#ifdef linux
  // todo: replace qdbus command by "pure" Qt DBus code
  QDBusMessage message = QDBusMessage::createMethodCall("org.kde.ksmserver","/KSMServer","org.kde.KSMServerInterface","logout");
  //Method args
  message.setArguments({0,2,2});
  QDBusConnection::sessionBus().send(message);
#elif _WIN32
  QString l = "shutdown -S -T 0";
  QProcess::startDetached(l);
#endif
}
