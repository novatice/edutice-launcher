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

    Connections {
        target: Qt.application
        onStateChanged: {
            if (Qt.application.state === Qt.ApplicationActive) {
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
    }

    FontLoader {
        id: titleFont
        source: "SFCompactText-SemiBoldItalic.ttf"
    }

    FontLoader {
        id: mainFont
        source: "SFProDisplay-Semibold.ttf"
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

    Item {
        width: mainAppliWindow.width
        height: mainAppliWindow.height - 50
        anchors.horizontalCenter: parent.horizontalCenter


        Item {
            id: sizeUnit
            property real widthUnit: parent.width / 24
            property real heightUnit: parent.height / 24
        }

        Image {
            id: novaticeIcon
            fillMode: Image.PreserveAspectFit
            source: "miniatureinfra_ep.png"
            height: parent.height * (2/24)
            width: parent.height * (2/24)
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: sizeUnit.widthUnit
            anchors.topMargin: sizeUnit.widthUnit
        }

        ColumnLayout {
            width: parent.width
            height: parent.height
            spacing: sizeUnit.heightUnit

            Item {
                id: search
                width: parent.width
                Layout.alignment: Qt.AlignHCenter
                height: parent.height / 20
                Layout.topMargin: parent.height / 20

                RowLayout {
                    height: parent.height
                    anchors.horizontalCenter: parent.horizontalCenter

                    Item {
                        Layout.preferredHeight: parent.height
                        width: parent.height
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
                            height: parent.height / 2
                            width: parent.height / 2
                        }
                        ColorOverlay {
                            anchors.fill: iconSearchtext
                            source: iconSearchtext
                            color: theme.mainTextColor
                            opacity: 0.15
                        }
                    }
                    TextField {
                        id: searchText
                        placeholderText: qsTr("Rechercher une application...")
                        color: theme.mainTextColor
                        opacity: 0.3
                        font.pointSize: parent.height / 2
                        Layout.alignment: Qt.AlignVCenter
                        font.bold: true
                        font.family: mainFont.name
                        onTextChanged: {
                            delegateModel.update()
                        }

                        background: Item {
                            opacity: 0
                        }
                    }
                }

            }

            Item {
                id: actionsLayout
                width: parent.width
                height: parent.height * (15/20)

                RowLayout {
                    width: parent.width
                    height: parent.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: sizeUnit.widthUnit


                    // LEFT SIDEBAR
                    Item {

                        id: novacolumn
                        objectName: "novacolumn"
                        width: sizeUnit.widthUnit
                        Layout.leftMargin: sizeUnit.widthUnit
                        Layout.fillHeight: true
                        Layout.maximumHeight: parent.height * (5/10)

                        Rectangle {
                            radius: sizeUnit.widthUnit / 2
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


                            SideBarIcon {
                                label: "Navigateur"
                                icon: "linternet-2.png"
                                siblings: 3
                                onAction: {
                                    execution.open("http://");
                                }
                            }
                            SideBarIcon {
                                label: "Applications"
                                icon: "app2_ew.png"
                                siblings: 3
                                onAction: {
                                    applications.visible = true
                                    files.visible = true
                                    logoffWindow.visible = false
                                    informationsWindow.visible = false
                                }
                            }
                            SideBarIcon {
                                label: "Portail Edutice"
                                icon: "miniatureinfra_ex.png"
                                siblings: 3
                                onAction: {
                                    execution.open("http://" + serverAddress + ":8080/edutice");
                                }
                            }
                        }

                    }

                    // APPLICATIONS
                    Item {
                            id: applications
                            width: sizeUnit.widthUnit * 8
                            Layout.leftMargin: sizeUnit.widthUnit
                            Layout.rightMargin: sizeUnit.widthUnit
                            height: parent.height

                            Rectangle {
                                radius: sizeUnit.widthUnit / 2
                                color: "white"
                                opacity: 0.5
                                width: parent.width
                                height: parent.height
                            }

                            ColumnLayout {
                                height: parent.height - parent.height / 15
                                width: parent.width - parent.height / 15

                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter

                                spacing: parent.height * (1/30)

                                // Conteneur titre "Applications"
                                Item {
                                    width: parent.width
                                    height: parent.height * (2/30) < 50 ? 50 : parent.height * (2/30)
                                    Rectangle {
                                        id: applicationsColumnIcon
                                        color: "steelblue"
                                        width: parent.height
                                        height: parent.height
                                        radius: 5
                                        Image {
                                            source: "app2_ew.png"
                                            width: parent.width * (6/10)
                                            height: parent.height * (6/10)
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.horizontalCenter: parent.horizontalCenter
                                        }
                                    }
                                    Item {
                                        height: childrenRect.height
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.left: applicationsColumnIcon.right
                                        anchors.leftMargin: 20

                                        Text {
                                            id: appTitle
                                            text: "APPLICATIONS"
                                            font.pointSize: parent.parent.height * (1/3)
                                            font.family: mainFont.name
                                            color: theme.mainTitleColor
                                        }
                                        Text {
                                            anchors.top: appTitle.bottom
                                            font.pointSize: parent.parent.height * (1/6)
                                            font.family: mainFont.name
                                            text: qsTr(modelApplication.rowCount() + " applications disponibles")
                                            color: "grey"
                                        }
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

                                            SortFilterModel {
                                                id: delegateModel
                                                model: modelApplication

                                                lessThan: function(left, right) {
                                                    // Left name has pattern
                                                    var lnhp = left.name.toLowerCase().includes(searchText.text.toLowerCase());
                                                    // Right name has pattern
                                                    var rnhp = left.name.toLowerCase().includes(searchText.text.toLowerCase());

                                                    // Left description has pattern
                                                    //var ldhp = left.description.toLowerCase().includes(searchText.text.toLowerCase());
                                                    // Right description has pattern
                                                    //var rdhp = left.description.toLowerCase().includes(searchText.text.toLowerCase());

                                                    if (lnhp && !rnhp)
                                                        return -1;
                                                    if (rnhp && !lnhp)
                                                        return 1;

                                                    return left.name < right.name ? -1 : 1;
                                                }

                                                filterAcceptsItem: function(item) {
                                                    return item.name.toLowerCase().includes(searchText.text.toLowerCase());
                                                }

                                                delegate : Item {
                                                    height: sizeUnit.heightUnit
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
                                                        height: childrenRect.height
                                                        Layout.fillWidth: parent
                                                        Layout.leftMargin: 10
                                                        anchors.left: applicationIcon.right

                                                        Text {
                                                            id: applicationName
                                                            font.pointSize: parent.parent.height * (1/5)
                                                            font.family: mainFont.name
                                                            text: qsTr(name)
                                                        }
                                                        // Coming soon ?
//                                                        Text {
//                                                            anchors.bottom: parent.bottom
//                                                            text: qsTr("Description")
//                                                            font.pointSize: 8
//                                                            font.family: mainFont.name
//                                                            color: "grey"
//                                                        }
                                                    }

                                                    MouseArea {
                                                        id: applicationMouseArea
                                                        anchors.fill: parent
                                                        cursorShape: Qt.PointingHandCursor
                                                        hoverEnabled: true

                                                        onClicked: {
                                                            if (mouse.button === Qt.LeftButton) {
                                                                execution.launch(src)
                                                                mainAppliWindow.visible = false
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
                                                model: delegateModel
                                            }
                                        }
                                    }

                                }
                            }
                        }

                    // FICHIERS
                    Item {
                            id: files
                            width: sizeUnit.widthUnit * 6
                            height: parent.height
                            anchors.leftMargin: sizeUnit.widthUnit * 2

                            Rectangle {
                                radius: sizeUnit.widthUnit / 2
                                color: "white"
                                opacity: 0.7
                                width: parent.width
                                height: parent.height
                            }

                            ColumnLayout {
                                width: parent.width - parent.height / 15
                                height: parent.height - parent.height / 15
                                spacing: parent.height * (1/30)
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter

                                // Conteneur titre "FICHIERS"
                                Item {
                                    height: parent.height * (2/30) < 50 ? 50 : parent.height * (2/30)
                                    width: parent.width
                                    Rectangle {
                                        id: fileIcon
                                        color: "steelblue"
                                        width: parent.height
                                        height: parent.height
                                        radius: 5
                                        Image {
                                            source: "partage-de-fichiers@2x.png"
                                            width: parent.height * (6/10)
                                            height: parent.height * (6/10)
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.horizontalCenter: parent.horizontalCenter
                                        }
                                    }
                                    Item {
                                        height: childrenRect.height
                                        anchors.left: fileIcon.right
                                        anchors.leftMargin: 20
                                        anchors.verticalCenter: parent.verticalCenter

                                        Text {
                                            id: fileText
                                            text: "FICHIERS"
                                            font.pointSize: parent.parent.height * (1/3)
                                            font.family: mainFont.name
                                            color: theme.mainTitleColor
                                        }
                                        Text {
                                            anchors.top: fileText.bottom
                                            font.pointSize: parent.parent.height * (1/6)
                                            font.family: mainFont.name
                                            text: qsTr((defaultDirectoriesModel.rowCount() + mountedDirectoriesModel.rowCount()) + " dossiers accessibles")
                                            color: "grey"
                                        }
                                    }
                                }

                                // Mounted directories
                                Rectangle {
                                    id: mountedDirectories
                                    height: mountedDirectoriesModel.rowCount() > 0 ? childrenRect.height : 0
                                    width: parent.width
                                    color: "transparent"


                                    Item {
                                        width: parent.width
                                        height: mountedDirectoriesList.childrenRect.height
                                        anchors.horizontalCenter: parent.horizontalCenter

                                        Text {
                                            id: mountedDirectoriesTitle
                                            text: qsTr("SERVEUR")
                                            font.pointSize: 17
                                            color: theme.mainTitleColor
                                            font.family: mainFont.name
                                            visible: mountedDirectoriesModel.rowCount() > 0
                                            anchors.horizontalCenter: parent.horizontalCenter
                                        }

                                        ScrollView {
                                            id: mountedDirectoriesScrollView
                                            anchors.top: mountedDirectoriesTitle.bottom
                                            height: parent.height
                                            width: parent.width
                                            contentHeight: (mountedDirectoriesList.childrenRect.height > parent.height) ? mountedDirectoriesList.childrenRect.height : parent.height
                                            ScrollBar.vertical: ScrollBar {
                                                id: mountedDirectoriesScrollBar
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
                                                    height: mainAppliWindow.height / 20
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
                                                            font.pointSize: parent.parent.height * (1/5)
                                                            font.family: mainFont.name
                                                            text: qsTr(name)
                                                        }
                                                        Text {
                                                            anchors.bottom: parent.bottom
                                                            text: qsTr(description)
                                                            font.pointSize: parent.parent.height * (1/7)
                                                            font.family: mainFont.name
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
                                                                mainAppliWindow.visible = false
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
                                    //height: parent.height - mountedDirectories.height - fileTitle.height - 40
                                    Layout.alignment: Qt.AlignHCenter
                                    width: parent.width
                                    color: "transparent"
                                    Item {
                                        width: parent.width
                                        height: parent.height
                                        anchors.horizontalCenter: parent.horizontalCenter


                                        Text {
                                            id: defaultDirectoriesTitle
                                            text: qsTr("LOCAUX")
                                            font.pointSize: 17
                                            color: theme.mainTitleColor
                                            font.family: mainFont.name
                                            anchors.horizontalCenter: parent.horizontalCenter
                                        }

                                        ScrollView {
                                            id: defaultFilesScrollView
                                            height: parent.height - defaultDirectoriesTitle.height
                                            width: parent.width
                                            anchors.top: defaultDirectoriesTitle.bottom
                                            contentHeight: (defaultFilesList.childrenRect.height > parent.height) ? defaultFilesList.childrenRect.height : parent.parent.height + - defaultDirectoriesTitle.height
                                            ScrollBar.vertical: ScrollBar {
                                                id: defaultFilesScrollBar
                                                policy: ScrollBar.SnapOnRelease
                                                height: defaultFilesScrollView.height
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
                                                    height: mainAppliWindow.height / 20
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
                                                            font.pointSize: parent.parent.height * (1/5)
                                                            font.family: mainFont.name
                                                            text: qsTr(name)
                                                        }
                                                        Text {
                                                            anchors.bottom: parent.bottom
                                                            text: qsTr(description)
                                                            font.pointSize: parent.parent.height * (1/7)
                                                            font.family: mainFont.name
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
                                                                mainAppliWindow.visible = false
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
                        width: sizeUnit.widthUnit
                        Layout.alignment: Qt.AlignRight
                        Layout.fillHeight: true
                        Layout.maximumHeight: parent.height * (4/10)
                        Layout.leftMargin: sizeUnit.widthUnit
                        Layout.rightMargin: sizeUnit.widthUnit

                        Rectangle {
                            radius: sizeUnit.widthUnit / 2
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

                            SideBarIcon {
                                label: "Informations"
                                icon: "informations.png"
                                siblings: 2
                                onAction: {
                                    applications.visible = false
                                    files.visible = false
                                    logoffWindow.visible = false
                                    informationsWindow.visible = true
                                }
                            }
                            SideBarIcon {
                                label: "Se déconnecter"
                                icon: "deconnexion.png"
                                siblings: 2
                                onAction: {
                                    applications.visible = false
                                    files.visible = false
                                    logoffWindow.visible = true
                                    informationsWindow.visible = false
                                }
                            }
                        }
                    }

                }
            }

            Item {
                id: footer
                width: parent.width
                Layout.alignment: Qt.AlignHCenter
                height: parent.height / 20

                Text {
                    anchors.centerIn: parent
                    text: qsTr("Version " + launcherVersion)
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
                        height: parent.height * (1/2) //parent.height - platformStyle.paddingMedium * 2
                        width: parent.height * (1/2) //parent.height - platformStyle.paddingMedium * 2
                    }
                    ColorOverlay {
                        anchors.fill: logoffWindowTitleIcon
                        source: logoffWindowTitleIcon
                        color: "white"
                    }

                    Text {
                        anchors.left: logoffWindowTitleIcon.right
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("Déconnexion")
                        font.pointSize: parent.height * (3/7)
                        font.family: mainFont.name
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
                            text: qsTr("Avez-vous pensé à enregistrer votre travail ?")
                            font.pointSize: parent.height / 10
                            anchors.top: parent.top
                            anchors.topMargin: (parent.height * (4/5) - height) / 2
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        Item {
                            id: cancelLogoff
                            width: parent.width * (2/5)
                            height: parent.height * (1/5)
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left

                            Rectangle {
                                id: cancelLogoffButton
                                radius: height / 2
                                width: parent.width
                                height: parent.height
                                border.color: "grey"
                                border.width: 1

                                // the following properties are changed when hovered
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
                                font.pointSize: parent.height / 3
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }

                        Item {
                            id: confirmLogoff
                            width: parent.width * (2/5)
                            height: parent.height * (1/5)
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
                                font.pointSize: parent.height / 3
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }
                }
            }
        }

        // Informations window
        Item {
            id: informationsWindow

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
                    id: informationsWindowTitle
                    height: parent.height / 5
                    width: logoffWindowTitle.childrenRect.width
                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        id: informationsWindowTitleIcon
                        fillMode: Image.PreserveAspectFit
                        source: "informations.png"
                        anchors.verticalCenter: parent.verticalCenter
                        opacity: 1
                        height: parent.height * (1/2) //parent.height - platformStyle.paddingMedium * 2
                        width: parent.height * (1/2) //parent.height - platformStyle.paddingMedium * 2
                    }
                    ColorOverlay {
                        anchors.fill: informationsWindowTitleIcon
                        source: informationsWindowTitleIcon
                        color: "white"
                    }

                    Text {
                        anchors.left: informationsWindowTitleIcon.right
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("Informations")
                        font.pointSize: parent.height * (3/7)
                        font.family: mainFont.name
                        color: "white"
                    }
                }

                Item {
                    id: informationsWindowContent
                    height: parent.height * (4/5)
                    width: parent.width
                    anchors.top: informationsWindowTitle.bottom

                    Item {
                        width: parent.width * (7/10)
                        height: childrenRect.height
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter

                        ColumnLayout {
                            spacing: 0
                            width: parent.width

                            Info {
                                label: "Poste"
                                value: qsTr(machine)
                            }
                            Info {
                                label: "Espace de travail"
                                value: qsTr(workspace)
                            }
                            Info {
                                label: "Version de l'agent"
                                value: qsTr(agentVersion)
                            }
                            Info {
                                label: "Version de l'OS"
                                value: qsTr(OSVersion)
                            }
                            Info {
                                label: "Version du lanceur d'applications"
                                value: qsTr(launcherVersion)
                            }
                        }
                    }
                }
            }
        }

    }
}
