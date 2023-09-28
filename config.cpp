#include "config.h"

Config::Config(const QString &agentVersion, const bool assistance, const QString &OSVersion,const QString &serverAdress, Workspace* workspace)
    : m_agentVersion(agentVersion), m_assistance(assistance),m_OSVersion(OSVersion), m_serverAdress(serverAdress), m_workspace(workspace) {}

Workspace::Workspace(const bool userIsTeacher,const bool lockScreenEnable,
          const bool missingDefaultBrowser, AppModel* applications,
                      AppModel* recommendedApps, DirectoryModel* links)
    : m_userIsTeacher(userIsTeacher), m_lockScreenEnable(lockScreenEnable), m_missingDefaultBrowser(missingDefaultBrowser),
    m_applications(applications),m_recommendedApps(recommendedApps), m_links(links) {}

DefaultValues::DefaultValues(DirectoryModel* defaultDirectoriesModel, DirectoryModel* mountedDirectoriesModel,
                             QScreen* mouseScreen, const QSize &screenSize)
    : m_defaultDirectoriesModel(defaultDirectoriesModel), m_mountedDirectoriesModel(mountedDirectoriesModel),
    m_mouseScreen(mouseScreen), m_screenSize(screenSize){}
