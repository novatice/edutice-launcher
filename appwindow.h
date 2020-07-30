#ifndef APPWINDOW_H
#define APPWINDOW_H

 #include <QQuickWindow>

class AppWindow : public QQuickWindow
{Q_OBJECT
public:
    AppWindow();
    void setSize(int width,int height);
};

#endif // APPWINDOW_H
