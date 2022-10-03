#include "execution.h"
#include <QDir>

Execution::Execution(QObject *parent) :
    QObject(parent),
    model(),
    mainWindows(),
    m_process(new QProcess(this))
{
    p=3;
}


QString Execution::launch(const QString &program){
    qInfo() << "In Execution::launch with " << program;

    // There are some applications(BiblioManuels) that do not launch with the path of the json file. We move to the desired folder. Then, we define the currentpath.
    QFileInfo info(program);

    if ((info.exists())) {

        QString path = info.absolutePath();
        QString fileName = info.fileName();

        QDir::setCurrent(path);

        if(m_process->startDetached(fileName)){
           qInfo() << "Launched with success";
        }
    }


    return "";
}

QString Execution::openFolder(const QString &path)
{
    QDesktopServices::openUrl(QUrl::fromLocalFile(path));

    return "";
}

QString Execution::open(const QString &path)
{
    QDesktopServices::openUrl(path);
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
    l = "qdbus org.kde.ksmserver /KSMServer logout 0 0 0";
#endif
#ifdef _WIN32
    l = "shutdown -L";
#endif
    m_process->startDetached(l);
    m_process->waitForFinished(-1);
}

void Execution :: addRow(QString name, QString img,QString src,QString cat, bool installed)
{
    (model)->addApplication(Application(name, img, src, cat, installed));
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
    m_process->startDetached(l);
#endif
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

void Execution::shutdown()
{
    QString l = "";
#ifdef linux
    // todo: replace qdbus command by "pure" Qt DBus code
    l = "qdbus org.kde.ksmserver /KSMServer logout 0 2 2";
#endif
#ifdef _WIN32
    l = "shutdown -S -T 0";
#endif
    m_process->startDetached(l);
}

