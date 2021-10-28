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
            width: parent.width * (3/24)
            Rectangle {
                width: parent.width
                height: parent.height
                color: "transparent"
                border.color: "grey"
                border.width: 2
            }
        }

        //Component.onCompleted: console.log("topLevelItem width: " + width)
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

                // Layout.alignment: Qt.AlignBottom
                id: actionsLayout
                width: parent.width
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width

                RowLayout {
                    width: parent.width
                    height: parent.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 0

                    Item {
                        width: 0
                        height: parent.height
                        Layout.fillHeight: true
                        Rectangle {
                            color: "transparent"
                            border.color: "black"
                            border.width: 1
                            height: parent.height
                            width: parent.width
                        }
                        Loader {
                            id: categoriesLoader
                            asynchronous: true
                            anchors.fill: parent
                            source: "Categories.qml"
                        }
                    }

                    Item {

                        Rectangle {
                            color: "transparent"
                            border.color: "black"
                            border.width: 1
                            height: parent.height
                            width: parent.width
                        }
                        id: novacolumn
                        objectName: "novacolumn"
                        width: parent.width * (1/24)
                        Layout.leftMargin: parent.width * (1/24)
                        Layout.rightMargin: parent.width * (1/24)
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
                        id: page
                        objectName: "page"
                        width: parent.width * (8/24)
                        Layout.leftMargin: parent.width * (1/24)
                        Layout.rightMargin: parent.width * (1/24)
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

                            spacing: 40
                            // Conteneur titre "Applications"
                            Item {
                                id: nameApplications
                                width: parent.width * (9/10)
                                Layout.alignment: Qt.AlignHCenter
                                height: 50

                                Text {
                                    text: "APPLICATIONS"
                                    font.pointSize: 20
                                    font.family: titleFont.name
                                    anchors.left: parent.left
                                    color: theme.mainTextColor
                                    horizontalAlignment: Qt.AlignHCenter
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
                                ListView {

                                }

                                SortFilterModel {
                                    id: sortFilterModel
                                    model: myModel
                                    property string actualCategorie: ""
                                    modelCategories: modelCategorie

                                    filterAcceptsItem: function (item) {
                                        var itemName = item.name.toLowerCase()
                                        var itemCategorie = item.categorie.toLowerCase()
                                        var actualCategorie = (String)(
                                                    sortFilterModel.actualCategorie).toLowerCase()
                                        if (actualCategorie !== ""
                                                && itemCategorie !== actualCategorie)
                                            return false
                                        var itemSearch = searchText.text.toLowerCase()
                                        return itemName.includes(itemSearch)
                                    }

                                    lessThan: function (left, right) {
                                        var leftVal = left.name.toLowerCase()
                                        var rightVal = right.name.toLowerCase()
                                        //return leftVal.localeCompare(rightVal);
                                        return leftVal < rightVal ? -1 : 1
                                    }

                                    delegate: //maingrid.state = "down";
                                              Item {
                                        Component.onCompleted: {

                                        }

                                        //width: parent.width/6; height:parent.width/6
                                        width: maingrid.cellWidth
                                        height: maingrid.cellHeight
                                        Rectangle {
                                            id: apps
                                            width: parent.width - parent.width / 5
                                            height: parent.height - parent.width / 6
                                            clip: true
                                            color: "transparent" //"blue"
                                            state: "mouseOut"


                                            Rectangle {
                                                id: backg
                                                color: "transparent"
                                                width: parent.width
                                                height: parent.height
                                                radius: 20

                                                RectangularGlow {
                                                    id: effect
                                                    anchors.fill: parent
                                                    glowRadius: 10
                                                    spread: 0.2
                                                    color: "#61c2ff"
                                                    cornerRadius: 30
                                                    visible: false
                                                }
                                            }
                                            ColumnLayout {
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                anchors.verticalCenter: parent.verticalCenter
                                                spacing: 8

                                                Item {
                                                    width: parent.parent.width / 2
                                                    height: parent.parent.width / 2
                                                    Image {
                                                        id: myIcon
                                                        asynchronous: true
                                                        width: parent.width
                                                        height: parent.width
                                                        source: icon
                                                    }
                                                }
                                                Item {

                                                    Layout.fillWidth: true
                                                    Layout.fillHeight: true
                                                    height: 20
                                                    width: parent.width

                                                    Text {
                                                        FontLoader {
                                                            id: appliFont
                                                            source: "SFCompactText-Medium.ttf"
                                                        }
                                                        text: name
                                                        width: parent.width * 1.5
                                                        anchors.horizontalCenter: parent.horizontalCenter
                                                        font.family: appliFont.name
                                                        fontSizeMode: Text.Fit
                                                        horizontalAlignment: Text.AlignHCenter
                                                        verticalAlignment: Text.AlignBottom
                                                        color: theme.mainTextColor
                                                        maximumLineCount: 2
                                                        elide: Text.ElideRight
                                                        wrapMode: Text.WordWrap


                                                    }
                                                }
                                            }

                                            MouseArea {
                                                id: applicationMouseArea
                                                anchors.fill: parent
                                                cursorShape: Qt.PointingHandCursor

                                                onClicked: {
                                                    backg.color = "lightsteelblue"
                                                    backg.opacity = 0.1
                                                    parent.state = "pressed"
                                                    if (mouse.button === Qt.LeftButton) {
                                                        execution.launch(src)
                                                    }
                                                }

                                                hoverEnabled: true
                                                onEntered: {
                                                    parent.state = "mouseIn"
                                                    //backg.color = theme.mainBorderColor //"a9a9a9" //"lightsteelblue"
                                                    backg.visible = true
                                                    effect.visible = true
                                                    backg.opacity = 0.2
                                                }
                                                onExited: {
                                                    parent.state = "mouseOut"
                                                    //backg.color = "transparent"
                                                    backg.visible = false
                                                    effect.visible = false
                                                }
                                            }
                                        }
                                    }
                                }
                                Item {
                                    width: parent.width
                                    height: parent.height
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.top: parent.top

                                    ScrollView {
                                        id: scrollV
                                        anchors.fill: parent
                                        contentHeight: (maingrid.childrenRect.height > parent.height) ? maingrid.childrenRect.height : parent.height

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
                                                opacity: 0.05
                                                radius: width / 2
                                                color: scrollBar.pressed ? "#0092CC" : theme.mainBorderColor
                                            }
                                        }

                                        //contentHeight: maingrid.height
                                        //contentWidth: width
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
                                        GridView {
                                            id: maingrid
                                            anchors.fill: parent
                                            property bool first: true
                                            property var cellSize: width / 6

                                            Component.onCompleted: {
                                                cellSize = width / 6
                                                for (var i = 0; cellSize < 150; i++) {
                                                    cellSize = width / (6 - i)
                                                }
                                            }

                                            cellWidth: cellSize
                                            cellHeight: cellSize

                                            focus: true
                                            state: "deb"
                                            opacity: 1
                                            property int viewIndex: 0
                                            model: sortFilterModel
                                            interactive: false
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Item {
                        id: files
                        width: parent.width * (6/24)
                        Layout.fillHeight: true
                        anchors.left: page.right
                        anchors.leftMargin: parent.width * (2/24)

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
                            anchors.fill: parent
                            spacing: 40
                            // Conteneur titre "FICHIERS"
                            Item {
                                id: nameFiles
                                width: parent.width * (9/10)
                                Layout.alignment: Qt.AlignHCenter
                                height: 100
                                clip: true
                                opacity: theme.mainOpacity
                                //visible : false

                                Rectangle {
                                    color: "transparent"
                                    border.color: "black"
                                    border.width: 1
                                    height: parent.height
                                    width: parent.width
                                }

                                RowLayout {
                                    height: parent.height
                                    Layout.fillWidth: true

                                    Rectangle {
                                        color: "steelblue"
                                        width: 80
                                        height: 80
                                        anchors.left: parent.left
                                        anchors.leftMargin: 50
                                        Image {
                                            id: fileIcon
                                            source: "partage-de-fichiers@2x.png"
                                            width: 50
                                            height: 50
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.horizontalCenter: parent.horizontalCenter
                                        }
                                    }


                                    Item {
                                        width: parent.width
                                        anchors.bottom: parent.bottom
                                        height: 30


                                        Text {
                                            text: "FICHIERS"
                                            font.pointSize: 20
                                            font.family: titleFont.name
                                            anchors.left: parent.left
                                            color: theme.mainTextColor
                                        }
                                    }
                                }

                            }

                            // Simulation pour remplir le layout Fichiers
                            Rectangle {
                                Layout.fillHeight: true
                                anchors.top: nameFiles.bottom
                                width: parent.width
                                color: "transparent"
                            }
                        }
                    }

                    Item {
                        id: sessionColumn
                        width: parent.width * (1/24)
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
                                id: lock
                                Layout.preferredHeight: parent.height / 3
                                width: parent.width
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
                                id: logoff
                                Layout.preferredHeight: parent.height / 3
                                width: parent.width
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
                        }

                    }

//                    Item {
//                        width: parent.width * (1 / 5)
//                        height: parent.height / 2
//                        ColumnLayout {
//                            width: parent.width
//                            spacing: parent.height / 10
//                            Item {
//                                width: parent.width
//                                Layout.alignment: Qt.AlignHCenter
//                                height: 35
//                                clip: true
//                                opacity: theme.mainOpacity
//                                Rectangle {
//                                    anchors.fill: parent
//                                    anchors.rightMargin: -border.width
//                                    anchors.topMargin: -border.width
//                                    anchors.leftMargin: -border.width
//                                    border.width: 2
//                                    color: "transparent"
//                                    border.color: theme.mainBorderColor
//                                    opacity: 0.2
//                                }
//                                Item {
//                                    width: parent.width
//                                    anchors.top: parent.top
//                                    height: 30

//                                    Text {
//                                        text: "Informations"
//                                        font.pointSize: 20
//                                        font.family: titleFont.name
//                                        anchors.left: parent.left
//                                        color: theme.mainTextColor
//                                    }
//                                }
//                            }

//                            Item {
//                                width: parent.width
//                                Layout.fillHeight: true
//                                Rectangle {
//                                    width: parent.width
//                                    height: parent.height
//                                    anchors.centerIn: parent
//                                    color: "transparent"
//                                    ColumnLayout {
//                                        width: parent.width
//                                        Info {
//                                            title: "Espace de travail"
//                                            value: workspace
//                                            icon: "icon_espacetravail.png"
//                                        }

//                                        Info {
//                                            title: "Utilisateur"
//                                            value: username
//                                            icon: "user.png"
//                                        }

//                                        Info {
//                                            title: "Groupe"
//                                            value: group
//                                            icon: "icon_group.png"
//                                        }

//                                        Info {
//                                            title: "Machine"
//                                            value:  machine
//                                            icon: "pc.png"
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }

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
