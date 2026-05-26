#ifdef _WIN32
#ifndef WINDOWSNATIVEEVENTFILTER_H
#define WINDOWSNATIVEEVENTFILTER_H
#include <QAbstractNativeEventFilter>
#include <QByteArray>
#include <QGuiApplication>
#include <QObject>
#include <QQmlApplicationEngine>
#include <appconstants.h>
#include <configparser.h>
#include <windows.h>


class WindowsNativeEventFilter : public QAbstractNativeEventFilter
{
public:
    bool nativeEventFilter(const QByteArray &eventType, void *message, qintptr *) override
    {
        if (eventType == "windows_generic_MSG") {
            MSG *msg = static_cast<MSG *>(message);
            if (msg->message == WM_DEVICECHANGE) {
                if (ApplicationConstants::defaultValues != NULL) {
                    UpdateDirectories(ApplicationConstants::defaultValues);
                }
            }
        }
        return false;
    }
};
#endif
#endif // WINDOWSNATIVEEVENTFILTER_H
