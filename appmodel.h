#ifndef APPMODEL_H
#define APPMODEL_H

#include <QAbstractListModel>
#include <QObject>
#include <QProcess>
#include <QQmlContext>
#include <QSortFilterProxyModel>
class Application {
public:
  Application(const QString &type, const QString &size, const QString &src,
              const bool installed, const QStringList &args);
  QString type() const;
  QString size() const;
  QString src() const;
  bool installed() const;
  QStringList args() const;

  void setType(QString q) { m_type = q; }

  // private:
  QString m_type;
  QString m_size;
  QString m_src;
  bool m_installed;
  QStringList m_args;
};

class AppModel : public QAbstractListModel {
  Q_OBJECT
public:
  enum DemoRoles { name = Qt::UserRole + 1, icon, src, installed, args };

  explicit AppModel(QObject *parent = 0);

  QHash<int, QByteArray> roleNames() const;
  void addApplication(const Application &application);

  int rowCount(const QModelIndex &parent = QModelIndex()) const;

  QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

  // private:
  QVector<QString> backing;
  QList<Application> m_applications;
};

#endif // APPMODEL_H
