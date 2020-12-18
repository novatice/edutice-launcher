#include "execution.h"


Execution::Execution(QObject *parent) :
    QObject(parent),
    model(),
    mainWindows(),
    m_process(new QProcess(this))
{
    p=3;
}

QString Execution::launch(const QString &program)
{
    qInfo() << "In Execution::launch with " << program;

    QStringList arguments;
    if (m_process->startDetached(program, arguments)) {
        qInfo() << "Launched with success";
    }

    return "";
}

void Execution::lockScreen()
{
    QString l = "";
    std::cout << "def" << std::endl;
#ifdef linux
    // todo: replace qdbus command by "pure" Qt DBus code
    l = "qdbus org.freedesktop.ScreenSaver /ScreenSaver Lock";
#endif
#ifdef _WIN32
            l = "rundll32.exe user32.dll,LockWorkStation";
#endif
    m_process->startDetached(l);
    m_process->waitForFinished(-1);
}

void Execution::disconnectScreen()
{
    QString l = "";
#ifdef linux
    // todo: replace qdbus command by "pure" Qt DBus code
    l = "qdbus org.kde.ksmserver /KSMServer logout 1 0 0"; // first parameter =1 means "wait for confirmation"
#endif
#ifdef _WIN32
    l = "shutdown -L";
#endif
    m_process->startDetached(l);
    m_process->waitForFinished(-1);
}

QString Execution::getTimeRemaining(int interval)
{
    //return QString::fromUtf8("%d,%d,%d",timeRemaining.tm_hour,timeRemaining.tm_min,timeRemaining.tm_sec);
    return "null";
}
void Execution :: addRow(QString name, QString img,QString src,QString cat)
{
    (model)->addApplication(Application(name, img, src, cat));


}

void Execution::quit()
{
#ifdef _WIN32
    HWND hWnd = (HWND)mainWindows->winId();

    ShowWindow(hWnd,SW_HIDE);
#endif

#ifdef linux
    mainWindows->hide();
#endif
}

