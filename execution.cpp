#include "execution.h"


Execution::Execution(QObject *parent) :
    QObject(parent),
    model(),
    mainWindows(),
    m_process(new QProcess(this))
    {
        p=3;
    }
/*
    void Execution::setTimeR(char* time)
    {
        struct tm tm;
        _strptime(time, "%H:%M:%S", &tm);
        timeRemaining = mktime(&tm);
        emit signalData("");
    }
    */
    QString Execution::launch(const QString &program)
    {
        QString l = "";

        #ifdef linux
            l = program.toLower();
        #endif
            m_process->startDetached(l);
            std::cout << l.toStdString() << std::endl;
        //emit signalExit();
        quit();
        //quit();
        return "output";
    }
    void Execution::lockScreen()
    {
        QString l = "";
        std::cout << "def" << std::endl;
        #ifdef linux
            l = "dbus-send --type=method_call --dest=org.gnome.ScreenSaver \
                /org/gnome/ScreenSaver org.gnome.ScreenSaver.Lock";
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
            l = "gnome-session-quit --no-prompt";
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

                ShowWindow(hWnd,SW_SHOWMINNOACTIVE);
            #endif

            #ifdef linux
                mainWindows->hide();
            #endif
    }
    /*
        std::cout << "de :"+model.m_animals[0].m_size.toStdString() << std::endl;
        QString l = program.toLower();
        std::cout << l.toStdString() << std::endl;
        m_process->start(l);
        m_process->waitForFinished(-1);
        QByteArray bytes = m_process->readAllStandardOutput();
        QString output = QString::fromLocal8Bit(bytes);
        return output;
    }

*/
