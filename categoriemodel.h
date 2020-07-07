#ifndef CATEGORIEMODEL_H
#define CATEGORIEMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QSortFilterProxyModel>
#include <QQmlContext>
class Categorie
{
    public:
        Categorie(const QString &type, const QString &name);
        QString type() const;
        QString name() const;

        void setType(QString q) {
            m_type = q;
        }

    //private:
        QString m_type;
        QString m_name;
};

class CategorieModel : public QAbstractListModel
{
    Q_OBJECT
    public:
        enum DemoRoles {
            type = Qt::UserRole + 1,
            name
        };

        explicit CategorieModel(QObject *parent = 0);

        QHash<int, QByteArray> roleNames() const;
        void addCategorie(const Categorie &categorie);

       int rowCount(const QModelIndex & parent = QModelIndex()) const;

       QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

    //private:
        QVector<QString> backing;
        QList<Categorie> m_categories;
};



#endif // CATEGORIEMODEL_H
