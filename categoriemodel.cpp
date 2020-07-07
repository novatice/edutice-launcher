#include "categoriemodel.h"

Categorie::Categorie(const QString &type, const QString &name)
    : m_type(type), m_name(name)
{
}

QString Categorie::type() const
{
    return m_type;
}

QString Categorie::name() const
{
    return m_name;
}

CategorieModel::CategorieModel(QObject *parent) : QAbstractListModel(parent)
{

}

QHash<int, QByteArray> CategorieModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[name] = "name";
    roles[type] = "type";
    return roles;
}

void CategorieModel::addCategorie(const Categorie &categorie)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_categories << categorie;
    endInsertRows();
    //emit CategorieModel::dataChanged(QModelIndex(),0);
}

int CategorieModel::rowCount(const QModelIndex & parent) const {
    Q_UNUSED(parent);
    return m_categories.count();
}

QVariant CategorieModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= m_categories.count())
        return QVariant();

    const Categorie &categorie = m_categories[index.row()];

    if (role == name)
        return categorie.name();
    else if (role == type)
        return categorie.type();
    return QVariant();
}

