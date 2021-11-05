QT += quick
CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += main.cpp \
    directorymodel.cpp \
    execution.cpp \
    filter.cpp \
    appmodel.cpp \
    categoriemodel.cpp

RESOURCES += qml.qrc \
    application/image.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
win32:LIBS += -luser32
HEADERS += \
    directorymodel.h \
    execution.h \
    filter.h \
    appmodel.h \
    categoriemodel.h
	
	

DISTFILES += \
    application/SFCompactDisplay-Black.ttf \
    application/SFCompactText-Medium.ttf \
    application/SFCompactText-SemiBoldItalic.ttf \
    application/SFProDisplay-Bold.ttf \
    application/SFProDisplay-Semibold.ttf \
    application/SFProDisplay-Ultralight.ttf \
    application/SFProText-Medium.ttf \
    application/accueil-interface.png \
    application/accueil-interface@2x.png \
    application/app2_ew.png \
    application/assistance-telephonique-2_dz.png \
    application/assistance-telephonique-2_ee.png \
    application/burgerMenuIcon.svg \
    application/cadenas-verrouille_dn.png \
    application/carbon bl.ttf \
    application/deconnexion.png \
    application/digital-7.ttf \
    application/documentsDirectory.png \
    application/downloadsDirectory.png \
    application/icon_espacetravail.png \
    application/icon_group.png \
    application/informations.png \
    application/lhorloge-2.png \
    application/linternet-2.png \
    application/linux_app_icon.png \
    application/lockButton.png \
    application/lockButtonWhite.png \
    application/loupe-2.png \
    application/miniatureinfra_ep.png \
    application/miniatureinfra_ex.png \
    application/n_tv-a-ecran-plat.png \
    application/notification.png \
    application/partage-de-fichiers@2x.png \
    application/pc.png \
    application/powerButton (copie).png \
    application/powerButton.jpg \
    application/powerButton.png \
    application/profile-user_dp.png \
    application/search.png \
    application/user.png \
    application/windows_app_icon.png \
    application/windows_log_off.png
