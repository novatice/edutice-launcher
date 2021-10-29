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
        property var actualTheme: theme2

        property var mainTextColor: "black"
        property var mainBorderColor: mainTextColor
        property var mainLineColor: mainTextColor
        property var backgroundColor: "white"
        property var mainOpacity: 0

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

        Item {
            id: theme1
            property var mainTextColor: "white"
            property var mainBorderColor: mainTextColor
            property var mainLineColor: mainTextColor
            property var backgroundColor: "black"
            property var mainOpacity: 1

            property var appliBackgroundG1: "#7a7a7a"
            property var appliBackgroundG2: "#212421"
        }

        Item {
            id: theme2
            property var mainTextColor: "black"
            property var mainBorderColor: mainTextColor
            property var mainLineColor: mainTextColor
            property var backgroundColor: "white"
            property var mainOpacity: 0.65

            property var appliBackgroundG1: "#7a7a7a"
            property var appliBackgroundG2: "#212421"
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


        Item {
            height: parent.height * (1/12)
            width: parent.height * (1/12)
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: parent.width * (1/24)
            anchors.topMargin: parent.width * (1/24)
            Image {
                id: novaticeIcon
                source: "miniatureinfra_ep.png"
                width: parent.width
                height: parent.height
            }
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
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                            onEntered: {
                                informationsBack.color = "#518fdf"
                                informationsText.color = "black"
                            }
                            onExited: {
                                informationsBack.color = "transparent"
                                informationsText.color = "transparent"
                            }
                        }

                    }
                    Text {
                        id: informationsText
                        font.pointSize: 10
                        color: "transparent"
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
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                            onEntered: {
                                assistanceBack.color = "#518fdf"
                                assistanceText.color = "black"
                            }
                            onExited: {
                                assistanceBack.color = "transparent"
                                assistanceText.color = "transparent"
                            }
                        }

                    }
                    Text {
                        id: assistanceText
                        font.pointSize: 10
                        color: "transparent"
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
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                            onEntered: {
                                clockBack.color = "#518fdf"
                                clockText.color = "black"
                            }
                            onExited: {
                                clockBack.color = "transparent"
                                clockText.color = "transparent"
                            }
                        }

                    }
                    Text {
                        id: clockText
                        font.pointSize: 10
                        color: "transparent"
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
                            border.color: "grey"
                            border.width: 2
                            radius: 50
                            color: "white"
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
                                        cursorShape: Qt.PointingHandCursor
                                        hoverEnabled: true
                                        onEntered: {
                                            menuBack.color = "#518fdf"
                                        }
                                        onExited: {
                                            menuBack.color = "transparent"
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
                                        cursorShape: Qt.PointingHandCursor
                                        hoverEnabled: true
                                        onEntered: {
                                            notificationsBack.color = "#518fdf"
                                        }
                                        onExited: {
                                            notificationsBack.color = "transparent"
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
                                        cursorShape: Qt.PointingHandCursor
                                        hoverEnabled: true
                                        onEntered: {
                                            webpageBack.color = "#518fdf"
                                        }
                                        onExited: {
                                            webpageBack.color = "transparent"
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
                            }
                            Item {
                                id: appsIcon
                                Layout.preferredHeight: parent.height / 5
                                width: parent.width
                                Rectangle {
                                    id: appsIconBack
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
                                            appsIconBack.color = "#518fdf"
                                        }
                                        onExited: {
                                            appsIconBack.color = "transparent"
                                        }
                                        onClicked:
                                        {
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
                                        cursorShape: Qt.PointingHandCursor
                                        hoverEnabled: true
                                        onEntered: {
                                            novaticeBack.color = "#518fdf"
                                        }
                                        onExited: {
                                            novaticeBack.color = "transparent"
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
                                border.color: "grey"
                                border.width: 3
                                radius: 50
                                color: "white"
                                width: parent.width
                                height: parent.height
                                gradient: Gradient {
                                    GradientStop { position: 0.0; color: "white" }
                                    GradientStop { position: 0.95; color: "white" }
                                    GradientStop { position: 0.951; color: "blue" }
                                    GradientStop { position: 1.0; color: "blue" }
                                }
                            }

                            ColumnLayout {
                                width: parent.width * (9/10)
                                height: parent.height * (9/10)

                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter

                                spacing: 40
                                // Conteneur titre "Applications"
                                Rectangle {
                                    color: "lightsteelblue"
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
                                        color: "blue"
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
                                    ListModel {
                                        id: appModel
                                    }

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
                                                policy: ScrollBar.AlwaysOn
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
                                                    color: scrollBar.pressed ? "#0092CC" : theme.mainBorderColor
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
                                                    height: 100
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
                                                        id: applicationName
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        Layout.fillWidth: parent
                                                        Layout.leftMargin: 10
                                                        anchors.left: applicationIcon.right
                                                        Text {
                                                            text: qsTr(name)
                                                            horizontalAlignment: Text.AlignHCenter
                                                            fontSizeMode: Text.Fit
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
                                border.color: "grey"
                                border.width: 3
                                radius: 50
                                color: "white"
                                width: parent.width
                                height: parent.height
                                gradient: Gradient {
                                    GradientStop { position: 0.0; color: "white" }
                                    GradientStop { position: 0.95; color: "white" }
                                    GradientStop { position: 0.951; color: "blue" }
                                    GradientStop { position: 1.0; color: "blue" }
                                }
                            }


                            ColumnLayout {
                                width: parent.width * (9/10)
                                height: parent.height * (9/10)

                                spacing: 40

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
                                    height: 30
                                    Text {
                                        id: fileTitle
                                        text: "FICHIERS"
                                        font.pointSize: 20
                                        font.family: font1.name
                                        anchors.bottom: parent.bottom
                                        color: "blue"
                                    }
                                    Text {
                                        anchors.top: fileTitle.bottom
                                        font.pointSize: 10
                                        font.family: font1.name
                                        text: qsTr(" dossiers accessibles")
                                        color: "grey"
                                    }
                                }

                                // Simulation pour remplir le layout Fichiers
                                Rectangle {
                                    Layout.fillHeight: true
                                    width: parent.width
                                    color: "transparent"
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
                            border.color: "grey"
                            border.width: 2
                            radius: 50
                            color: "white"
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
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        hoverEnabled: true
                                        onEntered: {
                                            avatarBack.color = "#518fdf"
                                            avatarText.color = "black"
                                        }
                                        onExited: {
                                            avatarBack.color = "transparent"
                                            avatarText.color = "transparent"
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
                                Text {
                                    id: avatarText
                                    font.pointSize: 10
                                    color: "transparent"
                                    text: qsTr("Mon profil")
                                    anchors.top: avatarBack.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
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
                                            logoffText.color = "black"
                                        }
                                        onExited: {
                                            logoffBack.color = "transparent"
                                            logoffText.color = "transparent"
                                        }
                                        onClicked:
                                        {
                                            execution.disconnectScreen();
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
                                    width: parent.width
                                    font.pointSize: 10
                                    color: "transparent"
                                    text: "Se déconnecter de la session"
                                    anchors.top: logoffBack.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    elide: Text.ElideRight
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
    }
}
