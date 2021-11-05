#ifndef DIRECTORYMODEL_H
#define DIRECTORYMODEL_H

#include <QObject>
#include <QAbstractListModel>

class Directory
{
public:
    Directory(const QString &path, const QString &name, const QString &icon, const QString &description);
    QString path() const;
    QString name() const;
    QString icon() const;
    QString description() const;

    QString m_path;
    QString m_name;
    QString m_icon;
    QString m_description;
};

class DirectoryModel : public QAbstractListModel
{
    Q_OBJECT
    public:
        enum DirectoryRoles {
            path = Qt::UserRole + 1,
            name,
            icon,
            description
        };

        explicit DirectoryModel(QObject *parent = 0);

        QHash<int, QByteArray> roleNames() const;
        void addDirectory(const Directory &directory);
        int rowCount(const QModelIndex &parent = QModelIndex()) const;
        QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

        QList<Directory> m_directories;
};

#endif // DIRECTORYMODEL_H
