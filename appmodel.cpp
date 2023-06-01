#include "appmodel.h"

Application::Application(const QString &type, const QString &size,
                         const QString &src, const QString &categorie,
                         const bool installed, const QStringList &args)
    : m_type(type), m_size(size), m_src(src), m_categorie(categorie),
      m_installed(installed), m_args(args) {}

QString Application::type() const { return m_type; }

QString Application::size() const { return m_size; }

QString Application::src() const { return m_src; }
QString Application::categorie() const { return m_categorie; }
bool Application::installed() const { return m_installed; }
QStringList Application::args() const { return m_args; }

AppModel::AppModel(QObject *parent) : QAbstractListModel(parent) {}

QHash<int, QByteArray> AppModel::roleNames() const {
  QHash<int, QByteArray> roles;
  roles[name] = "name";
  roles[icon] = "icon";
  roles[src] = "src";
  roles[categorie] = "categorie";
  roles[installed] = "installed";
  roles[args] = "args";
  return roles;
}

void AppModel::addApplication(const Application &application) {
  beginInsertRows(QModelIndex(), rowCount(), rowCount());
  m_applications << application;
  endInsertRows();
  // emit AppModel::dataChanged(QModelIndex(),0);
}

int AppModel::rowCount(const QModelIndex &parent) const {
  Q_UNUSED(parent);
  return m_applications.count();
}

QVariant AppModel::data(const QModelIndex &index, int role) const {
  if (index.row() < 0 || index.row() >= m_applications.count())
    return QVariant();

  const Application &application = m_applications[index.row()];
  if (role == name)
    return application.type();
  else if (role == icon)
    return application.size();
  else if (role == src)
    return application.src();
  else if (role == categorie)
    return application.categorie();
  else if (role == installed)
    return application.installed();
  else if (role == args)
    return application.args();
  return QVariant();
}
