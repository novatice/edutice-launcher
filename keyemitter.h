#ifndef KEYEMITTER_H
#define KEYEMITTER_H
#include "windows.h"
#include "WinUser.h"
#include <QObject>
#include <QCoreApplication>
#include <QKeyEvent>
class KeyEmitter : public QObject
{
    Q_OBJECT
public:
    KeyEmitter(QObject* parent=nullptr) : QObject(parent) {}
    Q_INVOKABLE void keyPressed(QObject* tf, Qt::Key k) {
        QKeyEvent keyPressEvent = QKeyEvent(QEvent::Type::KeyPress, k, Qt::MetaModifier, QKeySequence(k).toString());
        QCoreApplication::sendEvent(tf, &keyPressEvent);
    }

    Q_INVOKABLE void openScreenDisplaySettings() {
        INPUT inputs[4] = {};
        ZeroMemory(inputs, sizeof(inputs));

        inputs[0].type = INPUT_KEYBOARD;
        inputs[0].ki.wVk = VK_LWIN;

        inputs[1].type = INPUT_KEYBOARD;
        inputs[1].ki.wVk = 0x50;

        inputs[2].type = INPUT_KEYBOARD;
        inputs[2].ki.wVk = 0x50;
        inputs[2].ki.dwFlags = KEYEVENTF_KEYUP;

        inputs[3].type = INPUT_KEYBOARD;
        inputs[3].ki.wVk = VK_LWIN;
        inputs[3].ki.dwFlags = KEYEVENTF_KEYUP;

        UINT uSent = SendInput(ARRAYSIZE(inputs), inputs, sizeof(INPUT));
        if (uSent != ARRAYSIZE(inputs))
        {
            qInfo("Error");
        }
        else
        {
            qInfo("Success");
        }
    }
};
#endif // KEYEMITTER_H
