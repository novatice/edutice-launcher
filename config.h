#ifndef CONFIG_H
#define CONFIG_H

#include "appmodel.h"
#include "directorymodel.h"
#include "qscreen.h"
#include "qsize.h"
#include <QObject>

class Workspace: public QObject  {
    Q_OBJECT
    Q_PROPERTY(bool userIsTeacher READ userIsTeacher CONSTANT)
    Q_PROPERTY(bool lockScreenEnable READ lockScreenEnable CONSTANT)
    Q_PROPERTY(bool missingDefaultBrowser READ missingDefaultBrowser CONSTANT)
    Q_PROPERTY(AppModel* applications READ applications CONSTANT)
    Q_PROPERTY(DirectoryModel* links READ links CONSTANT)
    Q_PROPERTY(AppModel* recommendedApps READ recommendedApps CONSTANT)

public:
    Workspace(const bool userIsTeacher,const bool lockScreenEnable,
              const bool missingDefaultBrowser, AppModel* applications,
               AppModel* recommendedApps,DirectoryModel* links);

    bool userIsTeacher() const
    {return m_userIsTeacher;}
    bool lockScreenEnable() const
    {return m_lockScreenEnable;}
    bool missingDefaultBrowser() const
    {return m_missingDefaultBrowser;}
    AppModel* applications()
    {return m_applications;}
    DirectoryModel* links()
    {return m_links;}
    AppModel* recommendedApps()
    {return m_recommendedApps;}

private:    
    bool m_userIsTeacher;
    bool m_lockScreenEnable;
    bool m_missingDefaultBrowser;
    AppModel* m_applications;
    AppModel* m_recommendedApps;
    DirectoryModel* m_links;
};


class Config: public QObject {
    Q_OBJECT
    Q_PROPERTY(QString agentVersion READ agentVersion CONSTANT)
    Q_PROPERTY(bool assistance READ assistance CONSTANT)
    Q_PROPERTY(QString OSVersion READ OSVersion CONSTANT)
    Q_PROPERTY(QString serverAddress READ serverAddress CONSTANT)
    Q_PROPERTY(Workspace* workspace READ workspace CONSTANT)
    Q_PROPERTY(QString token READ token CONSTANT)

public:
    Config(const QString &agentVersion, const bool assistance, const QString &OSVersion, const QString &serverAddress,
           const QString &token,Workspace* workspace);
    QString agentVersion() const
    {return m_agentVersion;}
    bool assistance() const
    {return m_assistance;}
    QString OSVersion() const
    {return m_OSVersion;}
    QString serverAddress() const
    {return m_serverAddress;}
    QString token() const
    {return m_token;}
    Workspace* workspace()
    {return m_workspace;}

private:
    QString m_agentVersion;
    bool m_assistance;
    QString m_OSVersion;
    QString m_serverAddress;
    QString m_token;
    Workspace* m_workspace;
};


class DefaultValues : public QObject {
    Q_OBJECT
    Q_PROPERTY(DirectoryModel* defaultDirectoriesModel READ defaultDirectoriesModel CONSTANT)
    Q_PROPERTY(DirectoryModel* mountedDirectoriesModel READ mountedDirectoriesModel CONSTANT)
    Q_PROPERTY(QScreen* mouseScreen READ mouseScreen CONSTANT)
    Q_PROPERTY(QSize screenSize READ screenSize CONSTANT)

public:
    DefaultValues(DirectoryModel* defaultDirectoriesModel, DirectoryModel* mountedDirectoriesModel,
                  QScreen* mouseScreen, const QSize &screenSize);
    DirectoryModel* defaultDirectoriesModel() const
    {return m_defaultDirectoriesModel;}
    DirectoryModel* mountedDirectoriesModel() const
    {return m_mountedDirectoriesModel;}
    QScreen* mouseScreen() const
    {return m_mouseScreen;}
    QSize screenSize() const
    {return m_screenSize;}

private:
    DirectoryModel* m_defaultDirectoriesModel;
    DirectoryModel* m_mountedDirectoriesModel;
    QScreen* m_mouseScreen;
    QSize m_screenSize;
};

#endif //CONFIG_H
