#include "appmodel.h"

Animal::Animal(const QString &type, const QString &size, const QString &src, const QString &categorie)
    : m_type(type), m_size(size),m_src(src), m_categorie(categorie)
{
}

QString Animal::type() const
{
    return m_type;
}

QString Animal::size() const
{
    return m_size;
}

QString Animal::src() const
{
    return m_src;
}
QString Animal::categorie() const
{
    return m_categorie;
}
AppModel::AppModel(QObject *parent) : QAbstractListModel(parent)
{

}

QHash<int, QByteArray> AppModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[name] = "name";
    roles[icon] = "icon";
    roles[src] = "src";
    roles[categorie] = "categorie";
    return roles;
}

/*
QVariant AppModel::data(const QModelIndex &index, int role) const {
    if(!index.isValid()) {
        return QVariant();
    }
    if(role == NameRole) {
        return QVariant(backing[index.row()]);
    }
    return QVariant();
}
*/

void AppModel::addAnimal(const Animal &animal)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_animals << animal;
    endInsertRows();
    //emit AppModel::dataChanged(QModelIndex(),0);
}

int AppModel::rowCount(const QModelIndex & parent) const {
    Q_UNUSED(parent);
    return m_animals.count();
}

QVariant AppModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= m_animals.count())
        return QVariant();

    const Animal &animal = m_animals[index.row()];
    if (role == name)
        return animal.type();
    else if (role == icon)
        return animal.size();
    else if (role == src)
        return animal.src();
    else if (role == categorie)
        return animal.categorie();
    return QVariant();
}

