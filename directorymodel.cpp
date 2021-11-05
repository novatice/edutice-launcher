#include "directorymodel.h"

Directory::Directory(const QString &path, const QString &name, const QString &icon, const QString &description)
    : m_path(path), m_name(name), m_icon(icon), m_description(description)
{
}

QString Directory::path() const
{
    return m_path;
}

QString Directory::name() const
{
    return m_name;
}

QString Directory::icon() const
{
    return m_icon;
}

QString Directory::description() const
{
    return m_description;
}

DirectoryModel::DirectoryModel(QObject *parent) : QAbstractListModel(parent)
{
}

QHash<int, QByteArray> DirectoryModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[path] = "path";
    roles[name] = "name";
    roles[icon] = "icon";
    roles[description] = "description";
    return roles;
}

void DirectoryModel::addDirectory(const Directory &directory)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_directories << directory;
    endInsertRows();
}

int DirectoryModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_directories.count();
}

QVariant DirectoryModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_directories.count())
        return QVariant();

    const Directory &directory = m_directories[index.row()];

    switch (role) {
        case path:
            return directory.path();
        case name:
            return directory.name();
        case icon:
            return directory.icon();
        case description:
            return directory.description();
    }

    return QVariant();
}
