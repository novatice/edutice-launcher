#include "appwindow.h"
#include <QGuiApplication>
AppWindow::AppWindow()
{
}
void AppWindow::setSize(int p_width, int p_height)
{
    this->setWidth(p_width);
    this->setHeight(p_height);
}
