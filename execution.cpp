#include "execution.h"
#include <QDir>

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
    QString fileName = info.fileName();
    QString path = info.absolutePath();
    process->setWorkingDirectory(path + "/");
    process->start(fileName, args);
#endif

#ifdef __linux
    QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
    // this is done to avoid QProcess behavior that put a bad LD_LIBRARY_PATH
    env.insert("LD_LIBRARY_PATH", "");

    process->setProcessEnvironment(env);
    // keep full path as file might not be in PATH
    process->start(program, args);
#endif

    if (process->waitForStarted()) {
      qInfo() << "Launched with success";
    } else {
      qInfo() << "Launched with error";
      qWarning() << "error during launch";
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
  QString l = "";
  std::cout << "def" << std::endl;
#ifdef linux
  // todo: replace qdbus command by "pure" Qt DBus code
  l = "qdbus org.freedesktop.ScreenSaver /ScreenSaver Lock";
#endif
#ifdef _WIN32
  l = "rundll32.exe user32.dll,LockWorkStation";
#endif
  QProcess::startDetached(l);
  // m_process->waitForFinished(-1);
}

void Execution::disconnectScreen() {
  QString l = "";
#ifdef linux
  // todo: replace qdbus command by "pure" Qt DBus code
  l = "qdbus org.kde.ksmserver /KSMServer logout 0 0 0";
#endif
#ifdef _WIN32
  l = "shutdown -L";
#endif
  // m_process->startDetached(l);
  QProcess::startDetached(l);
  // m_process->waitForFinished(-1);
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

void Execution::shutdown() {
  QString l = "";
#ifdef linux
  // todo: replace qdbus command by "pure" Qt DBus code
  l = "qdbus org.kde.ksmserver /KSMServer logout 0 2 2";
#endif
#ifdef _WIN32
  l = "shutdown -S -T 0";
#endif
  QProcess::startDetached(l);
}
