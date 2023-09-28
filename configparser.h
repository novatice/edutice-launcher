#ifndef CONFIGPARSER_H
#define CONFIGPARSER_H
#include "qguiapplication.h"
#include <QJsonDocument>
#include <config.h>

Config* parseConfig(QJsonDocument &jsonDocument);
DefaultValues* setDefaultValues(QGuiApplication* app);

#endif // CONFIGPARSER_H
