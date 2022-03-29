#ifndef APPMODEL_H
#define APPMODEL_H

#include <QObject>
#include <QProcess>
#include <QAbstractListModel>
#include <QSortFilterProxyModel>
#include <QQmlContext>
class Application
{
    public:
        Application(const QString &type, const QString &size, const QString &src, const QString &categorie, const bool installed);
        QString type() const;
        QString size() const;
        QString src() const;
        QString categorie() const;
        bool installed() const;

        void setType(QString q) {
            m_type = q;
        }

    //private:
        QString m_type;
        QString m_size;
        QString m_src;
        QString m_categorie;
        bool m_installed;
};

class AppModel : public QAbstractListModel
{
    Q_OBJECT
    public:
        enum DemoRoles {
            name = Qt::UserRole + 1,
            icon,
            src,
            categorie,
            installed
        };

        explicit AppModel(QObject *parent = 0);

        QHash<int, QByteArray> roleNames() const;
        void addApplication(const Application &application);

       int rowCount(const QModelIndex & parent = QModelIndex()) const;

       QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

    //private:
        QVector<QString> backing;
        QList<Application> m_applications;
};

#endif // APPMODEL_H
