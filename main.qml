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
    width: screenWidth / 2 < 700 ? 700 : screenWidth / 2
    height: screenHeight * (3/5) < 500 ? 500 : screenHeight * (3/5)
    x: 0
    y: screenHeight - height
    onVisibleChanged: {
        if (visible){
            requestActivate();
        }
    }

    Timer {
        id: timer
    }
    function delay(delayTime, cb) {
        timer.interval = delayTime;
        timer.repeat = false;
        timer.triggered.connect(cb);
        timer.start();
    }

    Connections {
        target: Qt.application
        onStateChanged: {
            if (Qt.application.state === Qt.ApplicationActive) {
                mainAppliWindow.raise();
                // Forces UI to be active on Windows, freezes after first use otherwise.
                mainAppliWindow.visible = true
            }
            else
            {
                delay(100, function() {
                    mainAppliWindow.hide()
                })
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
    }

    FontLoader {
        id: normalFont
        source: "AvenirNextLTPro.ttf"
    }

    FontLoader {
        id: boldFont
        source: "AvenirNextLTProBold.ttf"
    }

    FontLoader {
        id: italicFont
        source: "AvenirNextLTProIt.ttf"
    }

    Execution {
        id: execution
        objectName: "execution"
        //onSignalExit: mainAppliWindow.close()
    }

    Item {
        width: mainAppliWindow.width
        height: mainAppliWindow.height
        anchors.horizontalCenter: parent.horizontalCenter

        Item {
            id: sizeUnit
            property real widthUnit: parent.width / 20
            property real heightUnit: parent.height / 20
        }

        RowLayout {
            width: parent.width
            height: parent.height
            spacing: 0

            // SideBar
            Item {
                id: sideBar
                width: 48
                Layout.fillHeight: true
                z: 1

                Rectangle {
                    color: "black"
                    width: parent.width
                    height: parent.height
                }

                ColumnLayout {
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    spacing: 0

                    SideBarIcon {
                        label: "Ecrans multiples"
                        icon: "duplicate.png"
                        onAction: {
                            execution.openScreenDisplaySettings()
                        }
                    }
                }

                ColumnLayout {
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    spacing: 0

                    SideBarIcon {
                        label: "Mon profil"
                        icon: "profile.png"
                        onAction: {
                            execution.open("http://" + serverAddress + "/edutice/#mon-compte");
                            mainAppliWindow.hide();
                        }
                    }
                    SideBarIcon {
                        label: "Gérer les mots de passe"
                        visible: user_is_teacher
                        icon: "password.svg"
                        onAction: {
                            execution.open("http://" + serverAddress + "/edutice-oversight/reset-password/reset-password.jsp");
                            mainAppliWindow.hide();
                        }
                    }
                    SideBarIcon {
                        label: "Ma classe virtuelle"
                        icon: "virtualclass.png"
                        onAction: {
                            if (user_is_teacher){
                                execution.open("http://" + serverAddress + "/edutice/#classe-virtuelle");
                                mainAppliWindow.hide();
                            } else {
                                execution.open("http://" + serverAddress + "/edutice/");
                                mainAppliWindow.hide();
                            }
                        }
                    }
                    SideBarIcon {
                        label: "Mes documents"
                        icon: "directories.png"
                        onAction: {
                            applicationsContainer.visible = false
                            applicationsMenuBack.color = "transparent"
                            filesMenuBack.color = "#066198"
                            filesContainer.visible = true
                        }
                    }
                    SideBarIcon {
                        label: "Applications"
                        icon: "applications.png"
                        onAction: {
                            filesContainer.visible = false
                            filesMenuBack.color = "transparent"
                            applicationsMenuBack.color = "#066198"
                            applicationsContainer.visible = true
                        }
                    }
                    Rectangle {
                        height: 1
                        width: parent.width * (6/10)
                        color: "grey"
                        Layout.alignment: Qt.AlignHCenter
                    }
                    SideBarIcon {
                        label: "Verrouiller"
                        icon: "lock.png"
                        visible: lock_screen_enable
                        onAction: {
                            execution.lockScreen()
                        }
                    }
                    SideBarIcon {
                        label: "Se déconnecter"
                        icon: "logout.png"
                        onAction: {
                            execution.disconnectScreen()
                        }
                    }
                    SideBarIcon {
                        label: "Arrêter"
                        icon: "shutdown.png"
                        onAction: {
                            execution.shutdown();
                        }
                    }
                }
            }

            // Menu
            Item {
                id: menu
                width: (parent.width - sideBar.width) * (4/10)
                height: parent.height

                Rectangle {
                    color: "#222222"
                    width: parent.width
                    height: parent.height
                }

                ColumnLayout {
                    width: parent.width * (9/10)
                    height: parent.height
                    spacing: 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter

                    Item {
                        height: parent.height / 7
                        width: parent.width
                        Image {
                            fillMode: Image.PreserveAspectFit
                            source: "novatice.png"
                            height: parent.height * (2/5)
                            width: parent.height * (2/5)
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    Item {
                        width: parent.width
                        height: parent.height * (4/7)

                        ColumnLayout {
                            width: parent.width
                            height: 122
                            spacing: 0
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter

                            Item {
                                id: applicationsButton
                                width: parent.width
                                height: 50
                                Rectangle {
                                    id: applicationsMenuBack
                                    width: parent.width
                                    height: parent.height
                                    color: "#066198"
                                    radius: height / 2
                                    visible: true
                                }
                                Text {
                                    text: qsTr("Applications")
                                    color: "white"
                                    font.pointSize: parent.height * (1/4)
                                    font.family: normalFont.name
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: parent.left
                                    anchors.leftMargin: 20
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    hoverEnabled: true
                                    onEntered: {
                                        applicationsMenuBack.color = applicationsMenuBack.color == "#066198" ? "#066198" : "#444444"
                                    }
                                    onExited: {
                                        applicationsMenuBack.color = applicationsMenuBack.color == "#066198" ? "#066198" : "transparent"
                                    }
                                    onClicked: {
                                        filesContainer.visible = false
                                        filesMenuBack.color = "transparent"
                                        applicationsMenuBack.color = "#066198"
                                        applicationsContainer.visible = true
                                    }
                                }
                            }
                            Rectangle {
                                height: 2
                                width: parent.width
                                color: "grey"
                                Layout.alignment: Qt.AlignVCenter
                            }
                            Item {
                                id: filesButton
                                width: parent.width
                                height: 50
                                Rectangle {
                                    id: filesMenuBack
                                    width: parent.width
                                    height: parent.height
                                    color: "transparent"
                                    radius: height / 2
                                }
                                Text {
                                    text: qsTr("Mes documents")
                                    color: "white"
                                    font.pointSize: parent.height * (1/4)
                                    font.family: normalFont.name
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: parent.left
                                    anchors.leftMargin: 20
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    hoverEnabled: true
                                    onEntered: {
                                        filesMenuBack.color = filesMenuBack.color == "#066198" ? "#066198" : "#444444"
                                    }
                                    onExited: {
                                        filesMenuBack.color = filesMenuBack.color == "#066198" ? "#066198" : "transparent"
                                    }
                                    onClicked: {
                                        applicationsContainer.visible = false
                                        applicationsMenuBack.color = "transparent"
                                        filesMenuBack.color = "#066198"
                                        filesContainer.visible = true
                                    }
                                }
                            }
                        }
                    }

                    Item {
                        width: parent.width
                        height: parent.height * (2/7)

                        ColumnLayout {
                            width: parent.width
                            height: parent.height * (2/7)
                            spacing: 10
                            anchors.horizontalCenter: parent.horizontalCenter

                            Rectangle {
                                visible: linksModel.rowCount() !== 0
                                height: 2
                                width: parent.width
                                color: "grey"
                            }
                            Text {
                                visible: linksModel.rowCount() !== 0
                                text: qsTr("Ressources en ligne")
                                color: "white"
                                font.pointSize: parent.height * (1/4)
                                font.family: italicFont.name
                                Layout.alignment: Qt.AlignVCenter
                                Layout.leftMargin: 20
                            }
                            Item {
                                height: linksModel.rowCount() === 0 ? 0 : parent.width * (1/5)
                                width: linksModel.rowCount() * height
                                Layout.alignment: Qt.AlignHCenter


                                DelegateModel {
                                    id: linksModelDelegate
                                    model: linksModel
                                    delegate: ZoomableIcon {
                                        Layout.alignment: Qt.AlignVCenter
                                        width: parent.height
                                        height: parent.height
                                        backgroundColor: "white"
                                        textColor: "white"
                                        iconSrc: qsTr(icon)
                                        label: qsTr(name)
                                        onAction: {
                                            execution.open(path)
                                            mainAppliWindow.hide()
                                        }
                                    }
                                }
                                ListView {
                                    model: linksModelDelegate
                                    anchors.fill : parent
                                    orientation: ListView.Horizontal
                                }
                            }
                        }
                    }
                }
            }

            // Content
            Item {
                    id: content
                    width: (parent.width - sideBar.width) * (6/10)
                    height: parent.height

                    Rectangle {
                        color: "white"
                        width: parent.width
                        height: parent.height
                    }

                    // Files container
                    ColumnLayout {
                        id: filesContainer
                        height: parent.height - parent.width/10
                        width: parent.width * (8/10)
                        spacing: parent.width / 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        visible: false

                        Text {
                            text: qsTr("Mes documents")
                            font.pointSize: 20
                            font.family: boldFont.name
                            color: theme.mainTitleColor
                            Layout.alignment: Qt.AlignHCenter
                        }


                        Text {
                            text: qsTr("Mes dossiers partagés")
                            font.pointSize: 15
                            font.family: boldFont.name
                            color: theme.mainTitleColor
                            visible: mountedDirectoriesModel.rowCount() > 0
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


                                ScrollView {
                                    id: mountedDirectoriesScrollView
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
                                            height: sizeUnit.heightUnit * 2
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
                                                    //fillMode: Image.PreserveAspectFit
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
                                                anchors.left: mountedDirectoriesIcon.right

                                                Text {
                                                    id: mountedDirectoriessName
                                                    font.pointSize: parent.parent.height * (1/5)
                                                    font.family: normalFont.name
                                                    text: qsTr(name)
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

                        Text {
                            text: qsTr("Mes dossiers personnels")
                            font.pointSize: 15
                            font.family: boldFont.name
                            color: theme.mainTitleColor
                        }
                        // Default directories: fills the ColumnLayout
                        Item {
                            width: parent.width
                            height: parent.height
                            Layout.alignment: Qt.AlignHCenter

                            ScrollView {
                                id: defaultFilesScrollView
                                height: parent.height
                                width: parent.width
                                contentHeight: (defaultFilesList.childrenRect.height > parent.height) ? defaultFilesList.childrenRect.height : parent.parent.height
                                ScrollBar.vertical: ScrollBar {
                                    id: defaultFilesScrollBar
                                    policy: ScrollBar.SnapOnRelease
                                    height: defaultFilesScrollView.height
                                    x: defaultFilesScrollView.mirrored ? 0 : defaultFilesScrollView.width - width
                                    y: defaultFilesScrollView.topPadding
                                    active: false
                                    snapMode: ScrollBar.SnapAlways
                                    visible: false
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
                                    onEntered: {
                                        defaultFilesScrollBar.visible = defaultFilesScrollView.contentHeight
                                                > defaultFilesScrollView.height
                                    }
                                    onExited: {
                                        defaultFilesScrollBar.visible = false
                                    }
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
                                        height: sizeUnit.heightUnit * 2
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
                                            height: childrenRect.height
                                            Layout.fillWidth: parent
                                            Layout.leftMargin: 10
                                            anchors.left: defaultFilesIcon.right

                                            Text {
                                                id: defaultFilesName
                                                font.pointSize: parent.parent.height * (1/5)
                                                font.family: normalFont.name
                                                text: qsTr(name)
                                                color: "black"
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

                    // Applications container
                    ColumnLayout {
                        id: applicationsContainer
                        height: parent.height - parent.width/10
                        width: parent.width * (8/10)
                        spacing: parent.width / 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        visible: true

                        // Search
                        Rectangle {
                            height: 50
                            width: parent.width * (3/4)
                            radius: height / 2
                            color: "lightgrey"
                            Layout.alignment: Qt.AlignHCenter
                            RowLayout {
                                height: parent.height
                                width: parent.width

                                Item {
                                    Layout.preferredHeight: parent.height
                                    width: parent.height
                                    //color:"red"
                                    Image {
                                        id: iconSearchtext
                                        smooth: true
                                        fillMode: Image.PreserveAspectFit
                                        asynchronous: true
                                        source: "magnifying-glass-solid.svg"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        anchors.verticalCenter: parent.verticalCenter
                                        height: parent.height / 2
                                        width: parent.height / 2
                                    }
                                    ColorOverlay {
                                        anchors.fill: iconSearchtext
                                        source: iconSearchtext
                                        color: "#888888"
                                    }
                                }
                                TextField {
                                    width: parent.width
                                    id: searchText
                                    placeholderText: qsTr("Rechercher")
                                    color: "black"
                                    font.pointSize: parent.height / 3
                                    Layout.alignment: Qt.AlignVCenter
                                    font.bold: true
                                    font.family: boldFont.name
                                    onTextChanged: {
                                        delegateModel.update()
                                    }
                                    background: Item {
                                        opacity: 0
                                    }
                                }
                            }
                        }

                        Text {
                            // Try to find a better way of displaying it if there are no recommended apps
                            visible: favoritesModel.rowCount() !== 0
                            text: qsTr("Applications recommandées")
                            font.pointSize: 15
                            font.family: boldFont.name
                            color: theme.mainTitleColor
                        }

                        Item {
                            height: favoritesModel.rowCount() === 0 ? 0 : parent.width * (1/5)
                            width: favoritesModel.rowCount() * height
                            Layout.alignment: Qt.AlignHCenter

                            DelegateModel {
                                id: favoritesApplications
                                model: favoritesModel
                                delegate: ZoomableIcon {
                                    Layout.alignment: Qt.AlignVCenter
                                    width: parent.height
                                    height: parent.height
                                    backgroundColor: "lightblue"
                                    textColor: "black"
                                    iconSrc: qsTr(icon)
                                    label: qsTr(name)
                                    onAction: {
                                        execution.launch(src)
                                        mainAppliWindow.close()
                                    }
                                }
                            }
                            ListView {
                                model: favoritesApplications
                                anchors.fill : parent
                                orientation: ListView.Horizontal
                            }
                        }

                        Text {
                            text: qsTr("Toutes les applications (" + modelApplication.rowCount() + ")")
                            font.pointSize: 15
                            font.family: boldFont.name
                            color: theme.mainTitleColor
                        }
                        // Conteneur liste d'Applications
                        Rectangle {
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
                                        visible: scrollV.contentHeight > scrollV.height
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

                                            // This is useless for now but will be used when we'll display applications description
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
                                            height: sizeUnit.heightUnit * 2
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
                                                    font.family: installed ? normalFont.name : italicFont.name
                                                    color: installed ? "black" : "grey"
                                                    text: qsTr(name)
                                                }
                                            }

                                            MouseArea {
                                                id: applicationMouseArea
                                                anchors.fill: parent
                                                cursorShape: installed ? Qt.PointingHandCursor : Qt.ArrowCursor
                                                hoverEnabled: installed

                                                onClicked: {
                                                    if (mouse.button === Qt.LeftButton && installed) {
                                                        execution.launch(src)
                                                        mainAppliWindow.visible = false
                                                    }
                                                }
                                                onEntered: {
                                                    if(installed)
                                                        applicationBack.visible = true
                                                }
                                                onExited: {
                                                    if (installed)
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
        }
    }
}
