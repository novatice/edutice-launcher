#ifndef APPCONSTANTS_H
#define APPCONSTANTS_H

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <config.h>

//We might have to review this to make a lock or singleton of some sort
class ApplicationConstants
{
public:
    static inline QQmlApplicationEngine *applicationEngine{};
    static inline QGuiApplication *guiApplication{};
    static inline DefaultValues *defaultValues{};
};

#endif // APPCONSTANTS_H
