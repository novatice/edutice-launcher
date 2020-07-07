#ifndef EXECUTION_H
#define EXECUTION_H
#include <QObject>
#include <QProcess>
#include <appmodel.h>

class Execution : public QObject
{

    Q_OBJECT
    public:
        explicit Execution(QObject *parent = 0);
        Q_INVOKABLE QString launch(const QString &program);
    Q_INVOKABLE void lockScreen();
    Q_INVOKABLE void disconnectScreen();
        Q_INVOKABLE void addRow(QString name, QString img,QString src,QString cat);
    Q_INVOKABLE QString getTimeRemaining(int interval);
        void setTimeR(char* time);
        QQmlContext *ctxt;
        AppModel* model;
        int p;

        Q_INVOKABLE void quit();
    signals:
        void signalData(QString data);
        void signalExit(void);

protected:
        QProcess *m_process;

        time_t timeRemaining;
};


#endif // EXECUTION_H
