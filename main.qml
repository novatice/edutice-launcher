import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtQml.Models 2.3
import QtGraphicalEffects 1.12
import Eexecution 1.0

ApplicationWindow {
    id: mainAppliWindow
    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.Tool
    color: "transparent"
    screen: screenNumberId
    width: screenWidth
    height: screenHeight
    x: screenNumberId.virtualX + ((screenNumberId.width - width) / 2)
    y: screenNumberId.virtualY + ((screenNumberId.height - height) / 2)


    Image {
        source: "accueil-interface.png"
        height: parent.height
        width: parent.width
    }

    Timer {
        id: timer
    }

    function delay(delayTime, cb) {
        timer.interval = delayTime
        timer.repeat = false
        timer.triggered.connect(cb)
        timer.start()
    }

    Connections {
        target: Qt.application
        onStateChanged: {
            if (Qt.application.state === Qt.ApplicationInactive) {
                mainAppliWindow.visible = false
            } else if (Qt.application.state === Qt.ApplicationActive) {
                mainAppliWindow.visible = true
            }
        }
    }

    Item {
        id: theme

        property string mainTitleColor: "#0442BF"
        property string mainTextColor: "black"
        property string mainBorderColor: mainTextColor
        property string mainLineColor: mainTextColor
        property string backgroundColor: "white"
        property real mainOpacity: 0

        property var appliBackgroundG1
        property var appliBackgroundG2

        Component.onCompleted: {
            mainTextColor = actualTheme.mainTextColor
            mainBorderColor = actualTheme.mainBorderColor
            mainLineColor = actualTheme.mainLineColor
            backgroundColor = actualTheme.backgroundColor

            mainOpacity = actualTheme.mainOpacity

            appliBackgroundG1 = actualTheme.appliBackgroundG1
            appliBackgroundG2 = actualTheme.appliBackgroundG2
        }
    }

    FontLoader {
        id: titleFont
        source: "SFCompactText-SemiBoldItalic.ttf"
    }

    FontLoader {
        id: font1
        source: "SFProDisplay-Semibold.ttf"
    }

    FontLoader {
        id: font2
        source: "SFProDisplay-Ultralight.ttf"
    }

    FontLoader {
        id: font3
        source: "SFProText-Medium.ttf"
    }
    MouseArea {
        anchors.fill: parent
        onClicked: forceActiveFocus()
    }

    Execution {
        id: execution
        objectName: "execution"
        //onSignalExit: mainAppliWindow.close()
    }

    Dialog {
        id: popup
        width: parent.width / 4
        height: 200

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
        title: "Fermeture de session"
        Text {
            text: "Vous vous appretez à fermer votre session. Etes vous sur ?"
        }

        standardButtons: Dialog.Ok | Dialog.Cancel
        onAccepted: execution.disconnectScreen()
        //onRejected: console.log("Cancel clicked")
    }

    DropShadow {
        cached: true
        horizontalOffset: 0
        verticalOffset: 0
        radius: 60
        samples: 32
        color: "red"
        smooth: true
    }

    Item {
        width: mainAppliWindow.width
        height: mainAppliWindow.height - 50
        anchors.horizontalCenter: parent.horizontalCenter


        Image {
            id: novaticeIcon
            fillMode: Image.PreserveAspectFit
            source: "miniatureinfra_ep.png"
            height: parent.height * (2/24)
            width: parent.height * (2/24)
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: parent.width * (1/24)
            anchors.topMargin: parent.width * (1/24)
        }

        Item {
            id: sessionInfo
            anchors.right: parent.right
            anchors.rightMargin: parent.width * (2/24)
            height: parent.width * (1/24)
            width: parent.width * (4/24)

            RowLayout {
                width: parent.width
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0

                Item {
                    width: parent.width / 5
                    height: parent.height

                    Rectangle {
                        id: informationsBack
                        color: "transparent"
                        width: 50
                        height: 50
                        radius: 25
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter

                        Image {
                            fillMode: Image.PreserveAspectFit
                            source: "informations.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            opacity: 1
                            height: 30 //parent.height - platformStyle.paddingMedium * 2
                            width: 30 //parent.height - platformStyle.paddingMedium * 2
                        }
                        MouseArea {
                            anchors.fill: parent
                            //cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                            onEntered: {
                                informationsBack.color = "lightgrey"
                                //informationsBack.color = "#518fdf"
                                informationsText.visible = true
                                informationsTextComingSoon.visible = true
                            }
                            onExited: {
                                informationsBack.color = "transparent"
                                informationsText.visible = false
                                informationsTextComingSoon.visible = false
                            }
                        }

                    }
                    Rectangle {
                        id: informationsTextComingSoon
                        width: childrenRect.width + 8
                        height: childrenRect.height + 8
                        color: "lightyellow"
                        border.color: "black"
                        border.width: 1
                        anchors.bottom: informationsBack.top
                        anchors.bottomMargin: 4
                        anchors.horizontalCenter: parent.horizontalCenter
                        visible: false
                        Text {
                            font.pointSize: 10
                            color: "black"
                            text: qsTr("Bientôt disponible")
                            anchors.horizontalCenter : parent.horizontalCenter
                            anchors.verticalCenter : parent.verticalCenter
                        }
                    }
                    Text {
                        id: informationsText
                        font.pointSize: 10
                        visible: false
                        text: qsTr("Informations")
                        anchors.top: informationsBack.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Item {
                    width: parent.width / 5
                    height: parent.height

                    Rectangle {
                        id: assistanceBack
                        color: "transparent"
                        width: 50
                        height: 50
                        radius: 25
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter

                        Image {
                            fillMode: Image.PreserveAspectFit
                            source: "assistance-telephonique-2_dz.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            opacity: 1
                            height: 30 //parent.height - platformStyle.paddingMedium * 2
                            width: 30 //parent.height - platformStyle.paddingMedium * 2
                        }
                        MouseArea {
                            anchors.fill: parent
                            //cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                            onEntered: {
                                assistanceBack.color = "lightgrey"
                                //assistanceBack.color = "#518fdf"
                                assistanceText.visible = true
                                assistanceTextComingSoon.visible = true
                            }
                            onExited: {
                                assistanceBack.color = "transparent"
                                assistanceText.visible = false
                                assistanceTextComingSoon.visible = false
                            }
                        }

                    }
                    Rectangle {
                        id: assistanceTextComingSoon
                        width: childrenRect.width + 8
                        height: childrenRect.height + 8
                        color: "lightyellow"
                        border.color: "black"
                        border.width: 1
                        anchors.bottom: assistanceBack.top
                        anchors.bottomMargin: 4
                        anchors.horizontalCenter: parent.horizontalCenter
                        visible: false
                        Text {
                            font.pointSize: 10
                            color: "black"
                            text: qsTr("Bientôt disponible")
                            anchors.horizontalCenter : parent.horizontalCenter
                            anchors.verticalCenter : parent.verticalCenter
                        }
                    }
                    Text {
                        id: assistanceText
                        font.pointSize: 10
                        color: "black"
                        visible: false
                        text: qsTr("Demande d'assistance")
                        anchors.top: assistanceBack.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Item {
                    width: parent.width / 5
                    height: parent.height

                    Rectangle {
                        id: clockBack
                        color: "transparent"
                        width: 50
                        height: 50
                        radius: 25
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter

                        Image {
                            fillMode: Image.PreserveAspectFit
                            source: "lhorloge-2.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            opacity: 1
                            height: 30 //parent.height - platformStyle.paddingMedium * 2
                            width: 30 //parent.height - platformStyle.paddingMedium * 2
                        }
                        MouseArea {
                            anchors.fill: parent
                            //cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                            onEntered: {
                                clockBack.color = "lightgrey"
                                //clockBack.color = "#518fdf"
                                clockText.visible = true
                                clockTextComingSoon.visible = true
                            }
                            onExited: {
                                clockBack.color = "transparent"
                                clockText.visible = false
                                clockTextComingSoon.visible = false
                            }
                        }
                    }
                    Rectangle {
                        id: clockTextComingSoon
                        width: childrenRect.width + 8
                        height: childrenRect.height + 8
                        color: "lightyellow"
                        border.color: "black"
                        border.width: 1
                        anchors.bottom: clockBack.top
                        anchors.bottomMargin: 4
                        anchors.horizontalCenter: parent.horizontalCenter
                        visible: false
                        Text {
                            font.pointSize: 10
                            color: "black"
                            text: qsTr("Bientôt disponible")
                            anchors.horizontalCenter : parent.horizontalCenter
                            anchors.verticalCenter : parent.verticalCenter
                        }
                    }
                    Text {
                        id: clockText
                        font.pointSize: 10
                        color: "black"
                        visible: false
                        text: qsTr("Temps restant")
                        anchors.top: clockBack.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }

        ColumnLayout {
            width: parent.width
            height: parent.height

            Item {
                id: search
                width: parent.width
                Layout.alignment: Qt.AlignHCenter
                height: 50
                Layout.topMargin: 50
                Layout.bottomMargin: 50
                Item {
                    //color:"blue"
                    height: parent.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width

                    RowLayout {
                        height: parent.height
                        anchors.horizontalCenter: parent.horizontalCenter


                        Item {
                            Layout.preferredHeight: parent.height
                            width: 50
                            //color:"red"

                            Image {
                                id: iconSearchtext
                                smooth: true
                                fillMode: Image.PreserveAspectFit
                                asynchronous: true
                                source: "search.png"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                opacity: 0.15
                                height: 30 //parent.height - platformStyle.paddingMedium * 2
                                width: 30 //parent.height - platformStyle.paddingMedium * 2
                            }
                            ColorOverlay {
                                anchors.fill: iconSearchtext
                                source: iconSearchtext
                                color: theme.mainTextColor
                                opacity: 0.15
                            }
                        }
                        Item {
                            width: 600
                            //color:"green"
                            Layout.preferredHeight: parent.height
                            TextField {
                                id: searchText
                                placeholderText: qsTr("Rechercher...")
                                color: theme.mainTextColor
                                opacity: 0.3
                                font.pointSize: 30
                                anchors.verticalCenter: parent.verticalCenter
                                font.bold: true
                                font.family: font3.name
                                property var timerUpdate: null
                                background: Item {
                                    opacity: 0
                                }

                                onTextChanged: {
                                    timerText.restart()
                                }
                                Timer {
                                    id: timerText
                                    interval: 150
                                    repeat: false
                                    onTriggered: {
                                        console.log("ede")
                                        tr.animations = animationN
                                        sortFilterModel.update()
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Item {

                id: actionsLayout
                width: parent.width
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width

                RowLayout {
                    width: parent.width
                    height: parent.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: parent.width * (1/24)


                    // LEFT SIDEBAR
                    Item {

                        id: novacolumn
                        objectName: "novacolumn"
                        width: parent.width * (1/24)
                        Layout.leftMargin: parent.width * (1/24)
                        Layout.fillHeight: true
                        Layout.maximumHeight: parent.height * (7/10)

                        Rectangle {
                            radius: 50
                            color: "white"
                            opacity: 0.5
                            width: parent.width
                            height: parent.height
                        }

                        ColumnLayout {
                            width: parent.width
                            height: parent.height
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 0

                            Item {
                                id: menu
                                Layout.preferredHeight: parent.height / 5
                                width: parent.width
                                Rectangle {
                                    id: menuBack
                                    color: "transparent"
                                    width: 50
                                    height: 50
                                    radius: 25
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                    MouseArea {
                                        anchors.fill: parent
                                        //cursorShape: Qt.PointingHandCursor
                                        hoverEnabled: true
                                        onEntered: {
                                            menuBack.color = "lightgrey"
                                            //menuBack.color = "#518fdf"
                                            menuText.visible = true
                                            menuTextComingSoon.visible = true
                                        }
                                        onExited: {
                                            menuBack.color = "transparent"
                                            menuText.visible = false
                                            menuTextComingSoon.visible = false
                                        }
                                        onClicked:
                                        {
                                            //execution.disconnectScreen();
                                        }
                                    }
                                }
                                Image {
                                    fillMode: Image.PreserveAspectFit
                                    source: "burgerMenuIcon.svg"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                    opacity: 1
                                    height: 30 //parent.height - platformStyle.paddingMedium * 2
                                    width: 30 //parent.height - platformStyle.paddingMedium * 2
                                }
                                Rectangle {
                                    id: menuTextComingSoon
                                    width: childrenRect.width + 8
                                    height: childrenRect.height + 8
                                    color: "lightyellow"
                                    border.color: "black"
                                    border.width: 1
                                    anchors.bottom: menuBack.top
                                    anchors.bottomMargin: 4
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    visible: false
                                    Text {
                                        font.pointSize: 10
                                        color: "black"
                                        text: qsTr("Bientôt disponible")
                                        anchors.horizontalCenter : parent.horizontalCenter
                                        anchors.verticalCenter : parent.verticalCenter
                                    }
                                }
                                Rectangle {
                                    id: menuText
                                    width: childrenRect.width
                                    height: childrenRect.height
                                    anchors.top: menuBack.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    visible: false
                                    Text {
                                        font.pointSize: 10
                                        color: "black"
                                        text: qsTr("Menu")
                                    }
                                }
                            }
                            Item {
                                id: notifications
                                Layout.preferredHeight: parent.height / 5
                                width: parent.width
                                Rectangle {
                                    id: notificationsBack
                                    color: "transparent"
                                    width: 50
                                    height: 50
                                    radius: 25
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                    MouseArea {
                                        anchors.fill: parent
                                        //cursorShape: Qt.PointingHandCursor
                                        hoverEnabled: true
                                        onEntered: {
                                            notificationsBack.color = "lightgrey"
                                            //notificationsBack.color = "#518fdf"
                                            notificationsText.visible = true
                                            notificationsTextComingSoon.visible = true
                                        }
                                        onExited: {
                                            notificationsBack.color = "transparent"
                                            notificationsText.visible = false
                                            notificationsTextComingSoon.visible = false
                                        }
                                        onClicked:
                                        {
                                            //execution.disconnectScreen();
                                        }
                                    }
                                }
                                Image {
                                    fillMode: Image.PreserveAspectFit
                                    source: "notification.png"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                    opacity: 1
                                    height: 30 //parent.height - platformStyle.paddingMedium * 2
                                    width: 30 //parent.height - platformStyle.paddingMedium * 2
                                }
                                Rectangle {
                                    id: notificationsTextComingSoon
                                    width: childrenRect.width + 8
                                    height: childrenRect.height + 8
                                    color: "lightyellow"
                                    border.color: "black"
                                    border.width: 1
                                    anchors.bottom: notificationsBack.top
                                    anchors.bottomMargin: 4
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    visible: false
                                    Text {
                                        font.pointSize: 10
                                        color: "black"
                                        text: qsTr("Bientôt disponible")
                                        anchors.horizontalCenter : parent.horizontalCenter
                                        anchors.verticalCenter : parent.verticalCenter
                                    }
                                }
                                Rectangle {
                                    id: notificationsText
                                    width: childrenRect.width
                                    height: childrenRect.height
                                    anchors.top: notificationsBack.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    visible: false
                                    Text {
                                        font.pointSize: 10
                                        color: "black"
                                        text: qsTr("Notifications")
                                    }
                                }
                            }
                            Item {
                                id: webpage
                                Layout.preferredHeight: parent.height / 5
                                width: parent.width
                                Rectangle {
                                    id: webpageBack
                                    color: "transparent"
                                    width: 50
                                    height: 50
                                    radius: 25
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                    MouseArea {
                                        anchors.fill: parent
                                        //cursorShape: Qt.PointingHandCursor
                                        hoverEnabled: true
                                        onEntered: {
                                            webpageBack.color = "lightgrey"
                                            //webpageBack.color = "#518fdf"
                                            webpageText.visible = true
                                            webpageTextComingSoon.visible = true
                                        }
                                        onExited: {
                                            webpageBack.color = "transparent"
                                            webpageText.visible = false
                                            webpageTextComingSoon.visible = false
                                        }
                                        onClicked:
                                        {
                                            //execution.disconnectScreen();
                                        }
                                    }
                                }
                                Image {
                                    fillMode: Image.PreserveAspectFit
                                    source: "linternet-2.png"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                    opacity: 1
                                    height: 30 //parent.height - platformStyle.paddingMedium * 2
                                    width: 30 //parent.height - platformStyle.paddingMedium * 2
                                }
                                Rectangle {
                                    id: webpageTextComingSoon
                                    width: childrenRect.width + 8
                                    height: childrenRect.height + 8
                                    color: "lightyellow"
                                    border.color: "black"
                                    border.width: 1
                                    anchors.bottom: webpageBack.top
                                    anchors.bottomMargin: 4
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    visible: false
                                    Text {
                                        font.pointSize: 10
                                        color: "black"
                                        text: qsTr("Bientôt disponible")
                                        anchors.horizontalCenter : parent.horizontalCenter
                                        anchors.verticalCenter : parent.verticalCenter
                                    }
                                }
                                Rectangle {
                                    id: webpageText
                                    width: childrenRect.width
                                    height: childrenRect.height
                                    anchors.top: webpageBack.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    visible: false
                                    Text {
                                        font.pointSize: 10
                                        color: "black"
                                        text: qsTr("Navigateur")
                                    }
                                }
                            }
                            Item {
                                id: novaAppsIcon
                                Layout.preferredHeight: parent.height / 5
                                width: parent.width
                                Rectangle {
                                    id: novaAppsIconBack
                                    color: "transparent"
                                    width: 50
                                    height: 50
                                    radius: 25
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        hoverEnabled: true
                                        onEntered: {
                                            novaAppsIconBack.color = "#518fdf"
                                            novaAppsIconText.visible = true
                                        }
                                        onExited: {
                                            novaAppsIconBack.color = "transparent"
                                            novaAppsIconText.visible = false
                                        }
                                        onClicked:
                                        {
                                            applications.visible = true
                                            files.visible = true
                                            logoffWindow.visible = false
                                            //execution.disconnectScreen();
                                        }
                                    }
                                }
                                Image {
                                    fillMode: Image.PreserveAspectFit
                                    source: "app2_ew.png"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                    opacity: 1
                                    height: 30 //parent.height - platformStyle.paddingMedium * 2
                                    width: 30 //parent.height - platformStyle.paddingMedium * 2
                                }
                                Rectangle {
                                    id: novaAppsIconText
                                    width: childrenRect.width
                                    height: childrenRect.height
                                    anchors.top: novaAppsIconBack.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    visible: false
                                    Text {
                                        font.pointSize: 10
                                        color: "black"
                                        text: qsTr("Applications")
                                    }
                                }
                            }
                            Item {
                                id: novatice
                                Layout.preferredHeight: parent.height / 5
                                width: parent.width
                                Rectangle {
                                    id: novaticeBack
                                    color: "transparent"
                                    width: 50
                                    height: 50
                                    radius: 25
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                    MouseArea {
                                        anchors.fill: parent
                                        //cursorShape: Qt.PointingHandCursor
                                        hoverEnabled: true
                                        onEntered: {
                                            novaticeBack.color = "lightgrey"
                                            //novaticeBack.color = "#518fdf"
                                            novaticeText.visible = true
                                            novaticeTextComingSoon.visible = true
                                        }
                                        onExited: {
                                            novaticeBack.color = "transparent"
                                            novaticeText.visible = false
                                            novaticeTextComingSoon.visible = false
                                        }
                                        onClicked:
                                        {
                                            //execution.disconnectScreen();
                                        }
                                    }
                                }
                                Image {
                                    fillMode: Image.PreserveAspectFit
                                    source: "miniatureinfra_ex.png"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                    opacity: 1
                                    height: 30 //parent.height - platformStyle.paddingMedium * 2
                                    width: 30 //parent.height - platformStyle.paddingMedium * 2
                                }
                                Rectangle {
                                    id: novaticeTextComingSoon
                                    width: childrenRect.width + 8
                                    height: childrenRect.height + 8
                                    color: "lightyellow"
                                    border.color: "black"
                                    border.width: 1
                                    anchors.bottom: novaticeBack.top
                                    anchors.bottomMargin: 4
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    visible: false
                                    Text {
                                        font.pointSize: 10
                                        color: "black"
                                        text: qsTr("Bientôt disponible")
                                        anchors.horizontalCenter : parent.horizontalCenter
                                        anchors.verticalCenter : parent.verticalCenter
                                    }
                                }
                                Rectangle {
                                    id: novaticeText
                                    width: childrenRect.width
                                    height: childrenRect.height
                                    anchors.top: novaticeBack.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    visible: false
                                    Text {
                                        font.pointSize: 10
                                        color: "black"
                                        text: qsTr("Portail edutice")
                                    }
                                }
                            }
                        }

                    }

                    // APPLICATIONS
                    Item {
                            id: applications
                            objectName: "page"
                            width: parent.parent.width * (8/24)
                            Layout.leftMargin: parent.parent.width * (1/24)
                            Layout.rightMargin: parent.parent.width * (1/24)
                            Layout.fillHeight: true

                            Rectangle {
                                radius: 50
                                color: "white"
                                opacity: 0.5
                                width: parent.width
                                height: parent.height
                            }

                            ColumnLayout {
                                width: parent.width * (9/10)
                                height: parent.height * (9/10)

                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter

                                spacing: 40
                                // Conteneur titre "Applications"
                                Rectangle {
                                    color: "steelblue"
                                    width: 80
                                    height: 80
                                    radius: 5
                                    Layout.leftMargin: 50
                                    Image {
                                        source: "app2_ew.png"
                                        width: 50
                                        height: 50
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                    }
                                }
                                Item {
                                    width: parent.width
                                    Layout.leftMargin: 50
                                    height: 30
                                    Text {
                                        id: appTitle
                                        text: "APPLICATIONS"
                                        font.pointSize: 20
                                        font.family: font1.name
                                        anchors.bottom: parent.bottom
                                        color: theme.mainTitleColor
                                    }
                                    Text {
                                        anchors.top: appTitle.bottom
                                        font.pointSize: 10
                                        font.family: font1.name
                                        text: qsTr(modelApplication.rowCount() + " applications disponibles")
                                        color: "grey"
                                    }
                                }

                                // Conteneur liste d'Applications
                                Rectangle {
                                    id: content
                                    width: parent.width
                                    Layout.alignment: Qt.AlignHCenter
                                    Layout.fillHeight: true
                                    color: "transparent"

                                    Item {
                                        width: parent.width
                                        height: parent.height
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        anchors.top: parent.top

                                        ScrollView {
                                            id: scrollV
                                            anchors.fill: parent
                                            contentHeight: (applicationsList.childrenRect.height > parent.height) ? applicationsList.childrenRect.height : parent.height
                                            ScrollBar.vertical: ScrollBar {
                                                id: scrollBar
                                                parent: scrollV.parent
                                                policy: ScrollBar.SnapOnRelease
                                                height: scrollV.availableHeight
                                                x: scrollV.mirrored ? 0 : scrollV.width - width
                                                y: scrollV.topPadding
                                                active: false
                                                snapMode: ScrollBar.SnapAlways
                                                visible: scrollV.contentHeight
                                                         > scrollV.height ? true : false
                                                //stepSize: 0.5
                                                //active: scrollV.ScrollBar.horizontal.active
                                                contentItem: Rectangle {
                                                    implicitWidth: 6
                                                    implicitHeight: 100
                                                    opacity: 0.5
                                                    radius: width / 2
                                                    color: scrollBar.pressed ? "#0092CC" : "grey"
                                                }
                                            }

                                            clip: true
                                            MouseArea {
                                                onWheel: {
                                                    if (wheel.angleDelta.y > 0) {
                                                        scroller.decrease()
                                                    } else {
                                                        scroller.increase()
                                                    }
                                                }
                                            }

                                            Component {
                                                id: applicationDelegate

                                                Item {
                                                    height: 80
                                                    width: parent.parent.width

                                                    Rectangle {
                                                        id: applicationBack
                                                        height: parent.height
                                                        width: parent.width
                                                        radius: 5
                                                        color: "lightsteelblue"
                                                        visible: false
                                                    }

                                                    Item {
                                                        id: applicationIcon
                                                        height: parent.height
                                                        width: parent.height

                                                        Image {
                                                            source: icon
                                                            fillMode: Image.PreserveAspectFit
                                                            width: parent.height * (2/3)
                                                            height: parent.height * (2/3)
                                                            anchors.verticalCenter: parent.verticalCenter
                                                            anchors.horizontalCenter: parent.horizontalCenter
                                                        }
                                                    }

                                                    Item {
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        height: parent.height / 2
                                                        Layout.fillWidth: parent
                                                        Layout.leftMargin: 10
                                                        anchors.left: applicationIcon.right
                                                        Rectangle {
                                                            border.width: 1
                                                            border.color: "black"
                                                            color: "transparent"
                                                            height: parent.height
                                                            width: parent.width
                                                        }

                                                        Text {
                                                            id: applicationName
                                                            font.pointSize: 12
                                                            font.family: font1.name
                                                            text: qsTr(name)
                                                        }
                                                        Text {
                                                            anchors.bottom: parent.bottom
                                                            text: qsTr("Description")
                                                            font.pointSize: 8
                                                            font.family: font1.name
                                                            color: "grey"
                                                        }
                                                    }

                                                    MouseArea {
                                                        id: applicationMouseArea
                                                        anchors.fill: parent
                                                        cursorShape: Qt.PointingHandCursor
                                                        hoverEnabled: true

                                                        onClicked: {
                                                            if (mouse.button === Qt.LeftButton) {
                                                                execution.launch(src)
                                                            }
                                                        }
                                                        onEntered: {
                                                            //backg.color = theme.mainBorderColor //"a9a9a9" //"lightsteelblue"
                                                            applicationBack.visible = true
                                                        }
                                                        onExited: {
                                                            //backg.color = "transparent"
                                                            applicationBack.visible = false
                                                        }
                                                    }
                                                }
                                            }

                                            ListView {
                                                id: applicationsList
                                                anchors.fill: parent
                                                property bool first: true
                                                delegate: applicationDelegate

                                                model: modelApplication
                                            }
                                        }
                                    }

                                }
                            }
                        }

                    // FICHIERS
                    Item {
                            id: files
                            width: parent.parent.width * (6/24)
                            Layout.fillHeight: true
                            anchors.leftMargin: parent.parent.width * (2/24)

                            Rectangle {
                                radius: 50
                                color: "white"
                                opacity: 0.7
                                width: parent.width
                                height: parent.height
                            }


                            ColumnLayout {
                                width: parent.width * (9/10)
                                height: parent.height * (9/10)

                                spacing: 0

                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter

                                // Conteneur titre "FICHIERS"
                                Rectangle {
                                    id: fileIcon
                                    color: "steelblue"
                                    width: 80
                                    height: 80
                                    radius: 5
                                    Layout.leftMargin: 50
                                    Layout.bottomMargin: 40
                                    Image {
                                        source: "partage-de-fichiers@2x.png"
                                        width: 50
                                        height: 50
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                    }
                                }


                                Item {
                                    width: parent.width
                                    Layout.leftMargin: 50
                                    Layout.bottomMargin: 40
                                    height: 30
                                    Text {
                                        id: fileTitle
                                        text: "FICHIERS"
                                        font.pointSize: 20
                                        font.family: font1.name
                                        anchors.bottom: parent.bottom
                                        color: theme.mainTitleColor
                                    }
                                    Text {
                                        anchors.top: fileTitle.bottom
                                        font.pointSize: 10
                                        font.family: font1.name
                                        text: qsTr((defaultDirectoriesModel.rowCount() + mountedDirectoriesModel.rowCount()) + " dossiers accessibles")
                                        color: "grey"
                                    }
                                }

                                // Mounted directories
                                Rectangle {
                                    height: mountedDirectoriesModel.rowCount() > 0 ? childrenRect.height + 40 : 0
                                    width: parent.width
                                    color: "transparent"

                                    Text {
                                        id: mountedDirectoriesTitle
                                        text: qsTr("SERVEUR")
                                        font.pointSize: 17
                                        color: theme.mainTitleColor
                                        font.family: font1.name
                                        anchors.horizontalCenter: parent.horizontalCenter
                                    }

                                    Item {
                                        width: parent.width
                                        height: mountedDirectoriesList.childrenRect.height
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        anchors.topMargin: 20
                                        anchors.top: mountedDirectoriesTitle.bottom


                                        ScrollView {
                                            id: mountedDirectoriesScrollView
                                            anchors.fill: parent
                                            contentHeight: (mountedDirectoriesList.childrenRect.height > parent.height) ? mountedDirectoriesList.childrenRect.height : parent.height
                                            ScrollBar.vertical: ScrollBar {
                                                id: mountedDirectoriesScrollBar
                                                parent: mountedDirectoriesScrollView.parent
                                                policy: ScrollBar.SnapOnRelease
                                                height: mountedDirectoriesScrollView.availableHeight
                                                x: mountedDirectoriesScrollView.mirrored ? 0 : mountedDirectoriesScrollView.width - width
                                                y: mountedDirectoriesScrollView.topPadding
                                                active: false
                                                snapMode: ScrollBar.SnapAlways
                                                visible: mountedDirectoriesScrollView.contentHeight
                                                         > mountedDirectoriesScrollView.height ? true : false
                                                //stepSize: 0.5
                                                //active: scrollV.ScrollBar.horizontal.active
                                                contentItem: Rectangle {
                                                    implicitWidth: 6
                                                    implicitHeight: 100
                                                    opacity: 0.5
                                                    radius: width / 2
                                                    color: mountedDirectoriesScrollBar.pressed ? "#0092CC" : "grey"
                                                }
                                            }

                                            clip: true
                                            MouseArea {
                                                onWheel: {
                                                    if (wheel.angleDelta.y > 0) {
                                                        scroller.decrease()
                                                    } else {
                                                        scroller.increase()
                                                    }
                                                }
                                            }

                                            Component {
                                                id: mountedDirectoriesDelegate

                                                Item {
                                                    height: 80
                                                    width: parent.parent.width

                                                    Rectangle {
                                                        id: mountedDirectoriesBack
                                                        height: parent.height
                                                        width: parent.width
                                                        radius: 5
                                                        color: "lightsteelblue"
                                                        visible: false
                                                    }

                                                    Item {
                                                        id: mountedDirectoriesIcon
                                                        height: parent.height
                                                        width: parent.height

                                                        Image {
                                                            source: icon
                                                            fillMode: Image.PreserveAspectFit
                                                            width: parent.height * (2/3)
                                                            height: parent.height * (2/3)
                                                            anchors.verticalCenter: parent.verticalCenter
                                                            anchors.horizontalCenter: parent.horizontalCenter
                                                        }
                                                    }

                                                    Item {
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        height: parent.height / 2
                                                        Layout.fillWidth: parent
                                                        Layout.leftMargin: 10
                                                        anchors.left: mountedDirectoriesIcon.right
                                                        Rectangle {
                                                            border.width: 1
                                                            border.color: "black"
                                                            color: "transparent"
                                                            height: parent.height
                                                            width: parent.width
                                                        }

                                                        Text {
                                                            id: mountedDirectoriessName
                                                            font.pointSize: 12
                                                            font.family: font1.name
                                                            text: qsTr(name)
                                                        }
                                                        Text {
                                                            anchors.bottom: parent.bottom
                                                            text: qsTr(description)
                                                            font.pointSize: 8
                                                            font.family: font1.name
                                                            color: "grey"
                                                        }
                                                    }

                                                    MouseArea {
                                                        id: mountedDirectoriesMouseArea
                                                        anchors.fill: parent
                                                        cursorShape: Qt.PointingHandCursor
                                                        hoverEnabled: true

                                                        onClicked: {
                                                            if (mouse.button === Qt.LeftButton) {
                                                                execution.open(path)
                                                            }
                                                        }
                                                        onEntered: {
                                                            //backg.color = theme.mainBorderColor //"a9a9a9" //"lightsteelblue"
                                                            mountedDirectoriesBack.visible = true
                                                        }
                                                        onExited: {
                                                            //backg.color = "transparent"
                                                            mountedDirectoriesBack.visible = false
                                                        }
                                                    }
                                                }
                                            }

                                            ListView {
                                                id: mountedDirectoriesList
                                                anchors.fill: parent
                                                property bool first: true
                                                delegate: mountedDirectoriesDelegate

                                                model: mountedDirectoriesModel
                                            }
                                        }
                                    }

                                }

                                // Default directories: fills the ColumnLayout
                                Rectangle {
                                    Layout.fillHeight: true
                                    width: parent.width
                                    color: "transparent"


                                    Text {
                                        id: defaultDirectoriesTitle
                                        text: qsTr("LOCAUX")
                                        font.pointSize: 17
                                        color: theme.mainTitleColor
                                        font.family: font1.name
                                        anchors.horizontalCenter: parent.horizontalCenter
                                    }

                                    Item {
                                        width: parent.width
                                        height: parent.height
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        anchors.top: defaultDirectoriesTitle.bottom
                                        anchors.topMargin: 20

                                        ScrollView {
                                            id: defaultFilesScrollView
                                            anchors.fill: parent
                                            contentHeight: (defaultFilesList.childrenRect.height > parent.height) ? defaultFilesList.childrenRect.height : parent.height
                                            ScrollBar.vertical: ScrollBar {
                                                id: defaultFilesScrollBar
                                                parent: defaultFilesScrollView.parent
                                                policy: ScrollBar.SnapOnRelease
                                                height: defaultFilesScrollView.availableHeight
                                                x: defaultFilesScrollView.mirrored ? 0 : defaultFilesScrollView.width - width
                                                y: defaultFilesScrollView.topPadding
                                                active: false
                                                snapMode: ScrollBar.SnapAlways
                                                visible: defaultFilesScrollView.contentHeight
                                                         > defaultFilesScrollView.height ? true : false
                                                //stepSize: 0.5
                                                //active: scrollV.ScrollBar.horizontal.active
                                                contentItem: Rectangle {
                                                    implicitWidth: 6
                                                    implicitHeight: 100
                                                    opacity: 0.5
                                                    radius: width / 2
                                                    color: defaultFilesScrollBar.pressed ? "#0092CC" : "grey"
                                                }
                                            }

                                            clip: true
                                            MouseArea {
                                                onWheel: {
                                                    if (wheel.angleDelta.y > 0) {
                                                        scroller.decrease()
                                                    } else {
                                                        scroller.increase()
                                                    }
                                                }
                                            }

                                            Component {
                                                id: defaultFilesDelegate

                                                Item {
                                                    height: 80
                                                    width: parent.parent.width

                                                    Rectangle {
                                                        id: defaultFilesBack
                                                        height: parent.height
                                                        width: parent.width
                                                        radius: 5
                                                        color: "lightsteelblue"
                                                        visible: false
                                                    }

                                                    Item {
                                                        id: defaultFilesIcon
                                                        height: parent.height
                                                        width: parent.height

                                                        Image {
                                                            source: icon
                                                            fillMode: Image.PreserveAspectFit
                                                            width: parent.height * (2/3)
                                                            height: parent.height * (2/3)
                                                            anchors.verticalCenter: parent.verticalCenter
                                                            anchors.horizontalCenter: parent.horizontalCenter
                                                        }
                                                    }

                                                    Item {
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        height: parent.height / 2
                                                        Layout.fillWidth: parent
                                                        Layout.leftMargin: 10
                                                        anchors.left: defaultFilesIcon.right
                                                        Rectangle {
                                                            border.width: 1
                                                            border.color: "black"
                                                            color: "transparent"
                                                            height: parent.height
                                                            width: parent.width
                                                        }

                                                        Text {
                                                            id: defaultFilesName
                                                            font.pointSize: 12
                                                            font.family: font1.name
                                                            text: qsTr(name)
                                                        }
                                                        Text {
                                                            anchors.bottom: parent.bottom
                                                            text: qsTr(description)
                                                            font.pointSize: 8
                                                            font.family: font1.name
                                                            color: "grey"
                                                        }
                                                    }

                                                    MouseArea {
                                                        id: defaultFilesMouseArea
                                                        anchors.fill: parent
                                                        cursorShape: Qt.PointingHandCursor
                                                        hoverEnabled: true

                                                        onClicked: {
                                                            if (mouse.button === Qt.LeftButton) {
                                                                execution.open(path)
                                                            }
                                                        }
                                                        onEntered: {
                                                            //backg.color = theme.mainBorderColor //"a9a9a9" //"lightsteelblue"
                                                            defaultFilesBack.visible = true
                                                        }
                                                        onExited: {
                                                            //backg.color = "transparent"
                                                            defaultFilesBack.visible = false
                                                        }
                                                    }
                                                }
                                            }

                                            ListView {
                                                id: defaultFilesList
                                                anchors.fill: parent
                                                property bool first: true
                                                delegate: defaultFilesDelegate

                                                model: defaultDirectoriesModel
                                            }
                                        }
                                    }

                                }


                            }
                        }


                    // RIGHT SIDEBAR
                    Item {
                        id: sessionColumn
                        width: parent.width * (1/24)
                        Layout.alignment: Qt.AlignRight
                        Layout.fillHeight: true
                        Layout.maximumHeight: parent.height * (1/2)
                        Layout.leftMargin: parent.width * (1/24)
                        Layout.rightMargin: parent.width * (1/24)

                        Rectangle {
                            radius: 50
                            color: "white"
                            opacity: 0.7
                            width: parent.width
                            height: parent.height
                        }

                        ColumnLayout {
                            width: parent.width
                            height: parent.height
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 0

                            Item {
                                id: avatar
                                Layout.preferredHeight: parent.height / 3
                                width: parent.width
                                Rectangle {
                                    id: avatarBack
                                    color: "transparent"
                                    width: 50
                                    height: 50
                                    radius: 25
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter

                                    MouseArea {
                                        id: avatarMouse
                                        anchors.fill: parent
                                        //cursorShape: Qt.PointingHandCursor
                                        hoverEnabled: true
                                        onEntered: {
                                            avatarBack.color = "lightgrey"
                                            //avatarBack.color = "#518fdf"
                                            avatarText.visible = true
                                            avatarTextComingSoon.visible = true
                                        }
                                        onExited: {
                                            avatarBack.color = "transparent"
                                            avatarText.visible = false
                                            avatarTextComingSoon.visible = false
                                        }
                                        onClicked:
                                        {
                                            //execution.disconnectScreen();
                                        }
                                    }
                                }
                                Image {
                                    fillMode: Image.PreserveAspectFit
                                    source: "profile-user_dp.png"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                    opacity: 1
                                    height: 30 //parent.height - platformStyle.paddingMedium * 2
                                    width: 30 //parent.height - platformStyle.paddingMedium * 2
                                }
                                Rectangle {
                                    id: avatarTextComingSoon
                                    width: childrenRect.width + 8
                                    height: childrenRect.height + 8
                                    color: "lightyellow"
                                    border.color: "black"
                                    border.width: 1
                                    anchors.bottom: avatarBack.top
                                    anchors.bottomMargin: 4
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    visible: false
                                    Text {
                                        font.pointSize: 10
                                        text: qsTr("Bientôt disponible")
                                        anchors.horizontalCenter : parent.horizontalCenter
                                        anchors.verticalCenter : parent.verticalCenter
                                    }
                                }
                                Text {
                                    id: avatarText
                                    font.pointSize: 10
                                    visible: false
                                    text: qsTr("Mon profil")
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.top: avatarBack.bottom
                                }
                            }

                            Item {
                                id: lock
                                Layout.preferredHeight: parent.height / 3
                                width: parent.width
                                Rectangle {
                                    id: lockBack
                                    color: "transparent"
                                    width: 50
                                    height: 50
                                    radius: 25
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        hoverEnabled: true
                                        onEntered: {
                                            lockBack.color = "#518fdf"
                                            lockText.color = "black"
                                        }
                                        onExited: {
                                            lockBack.color = "transparent"
                                            lockText.color = "transparent"
                                        }
                                        onClicked:
                                        {
                                            execution.lockScreen();
                                        }
                                    }
                                }
                                Image {
                                    fillMode: Image.PreserveAspectFit
                                    source: "cadenas-verrouille_dn.png"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                    opacity: 1
                                    height: 30 //parent.height - platformStyle.paddingMedium * 2
                                    width: 30 //parent.height - platformStyle.paddingMedium * 2
                                }
                                Text {
                                    id: lockText
                                    font.pointSize: 10
                                    color: "transparent"
                                    text: qsTr("Verrouiller")
                                    anchors.top: lockBack.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
                                }
                            }
                            Item {
                                id: logoff
                                Layout.preferredHeight: parent.height / 3
                                width: parent.width
                                Rectangle {
                                    id: logoffBack
                                    color: "transparent"
                                    width: 50
                                    height: 50
                                    radius: 25
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        hoverEnabled: true
                                        onEntered: {
                                            logoffBack.color = "#518fdf"
                                            logoffText.visible = true
                                        }
                                        onExited: {
                                            logoffBack.color = "transparent"
                                            logoffText.visible = false
                                        }
                                        onClicked:
                                        {
                                            applications.visible = false
                                            files.visible = false
                                            logoffWindow.visible = true
                                            //execution.disconnectScreen();
                                        }
                                    }
                                }

                                Image {
                                    fillMode: Image.PreserveAspectFit
                                    source: "deconnexion.png"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                    opacity: 1
                                    height: 30 //parent.height - platformStyle.paddingMedium * 2
                                    width: 30 //parent.height - platformStyle.paddingMedium * 2
                                }
                                Text {
                                    id: logoffText
                                    font.pointSize: 10
                                    visible: false
                                    text: qsTr("Se déconnecter")
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.top: logoffBack.bottom
                                }
                            }
                        }
                    }

                }
            }

            Item {
                id: footer
                height: 50
                width: parent.width

                Item {
                    id: launcherVersion
                    anchors.bottom: parent.bottom
                    width: parent.width

                    Text {
                        id: version
                        anchors.centerIn: parent
                        text: qsTr("Version 2.0")
                    }
                }
            }
        }


        // LOGOFF
        Item {
            id: logoffWindow

            height: parent.height
            width: parent.width * (18/24)
            anchors.left: parent.left
            anchors.leftMargin: parent.width * (3/24)
            visible: false

            Rectangle {
                height: parent.height / 3
                width: parent.width / 2
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 25
                gradient: Gradient {
                    GradientStop { position: 0; color: theme.mainTitleColor }
                    GradientStop { position: 0.2; color: theme.mainTitleColor }
                    GradientStop { position: 0.2001; color: "white" }
                    GradientStop { position: 1; color: "white" }
                }

                Item {
                    id: logoffWindowTitle
                    height: parent.height / 5
                    width: logoffWindowTitle.childrenRect.width
                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        id: logoffWindowTitleIcon
                        fillMode: Image.PreserveAspectFit
                        source: "deconnexion.png"
                        anchors.verticalCenter: parent.verticalCenter
                        opacity: 1
                        height: 30 //parent.height - platformStyle.paddingMedium * 2
                        width: 30 //parent.height - platformStyle.paddingMedium * 2
                    }

                    Text {
                        anchors.left: logoffWindowTitleIcon.right
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("Déconnexion")
                        font.pointSize: 20
                        color: "white"
                    }
                }

                Item {
                    id: logoffWindowContent
                    height: parent.height * (4/5)
                    width: parent.width
                    anchors.top: logoffWindowTitle.bottom


                    Item {
                        width: parent.width * (7/10)
                        height: parent.height * (7/10)
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter

                        Text {
                            text: qsTr("Avez-vous pensé à enregristrer votre travail ?")
                            font.pointSize: 15
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Item {
                            id: cancelLogoff
                            width: parent.width / 4
                            height: parent.height / 6
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left

                            Rectangle {
                                id: cancelLogoffButton
                                radius: height / 2
                                width: parent.width
                                height: parent.height
                                border.color: "grey"
                                border.width: 1

                                // These are changing when hovered
                                color: "transparent"

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    hoverEnabled: true
                                    onEntered: {
                                        cancelLogoffButton.color = "lightgrey"
                                    }
                                    onExited: {
                                        cancelLogoffButton.color = "transparent"
                                    }
                                    onClicked: {
                                        logoffWindow.visible = false
                                        applications.visible = true
                                        files.visible = true
                                    }
                                }
                            }
                            Text {
                                text: qsTr("Annuler")
                                color: "grey"
                                font.pointSize: 20
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }

                        Item {
                            id: confirmLogoff
                            width: parent.width / 4
                            height: parent.height / 6
                            anchors.bottom: parent.bottom
                            anchors.right: parent.right

                            Rectangle {
                                id: confirmLogoffButton
                                radius: height / 2
                                width: parent.width
                                height: parent.height

                                // These are changing when hovered
                                color: theme.mainTitleColor

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    hoverEnabled: true
                                    onEntered: {
                                        confirmLogoffButton.color = "#002a80"
                                    }
                                    onExited: {
                                        confirmLogoffButton.color = theme.mainTitleColor
                                    }
                                    onClicked: {
                                        execution.disconnectScreen()
                                    }
                                }
                            }
                            Text {
                                text: qsTr("Se déconnecter")
                                color: "white"
                                font.pointSize: 20
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }
                }
            }
        }
    }
}
