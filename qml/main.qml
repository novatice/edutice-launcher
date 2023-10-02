import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtQml.Models 2.3
import QtGraphicalEffects 1.12
import AvenirFonts 1.0
import Execution 1.0

ApplicationWindow {
    id: mainAppliWindow
    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.Tool
    color: "transparent"
    screen: defaultValues.mouseScreen
    width: 750
    height: 560
    x: 0
    y: Screen.desktopAvailableHeight - height
    onVisibleChanged: {
        if (visible) {
            requestActivate()
        }
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
            if (Qt.application.state === Qt.ApplicationActive) {
                mainAppliWindow.raise()
                // Forces UI to be active on Windows, freezes after first use otherwise.
                mainAppliWindow.visible = true
            } else {
                delay(100, function () {
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

    Execution {
        id: execution
        objectName: "execution"
    }

    AssistanceDialog {
        id: confirmationDialog
        title: "Demande d'aide"
        withCancelButton: true
        text: "Souhaitez-vous obtenir l'aide d'un gestionnaire ?"
        acceptText: "Obtenir de l'aide"
        onAccepted: {
            if(config.token !== ""){
                execution.open(
                            "http://" + config.serverAddress + "/neos-digital-space/service/assistance-talk?token="+config.token)
                mainAppliWindow.hide()
            }else{
                execution.open(
                            "http://" + config.serverAddress + "/neos-digital-space/service/assistance-talk")
                mainAppliWindow.hide()
            }
        }
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
                    SideBarIcon {
                        label: "Assistance"
                        icon: "assistance.png"
                        visible: config.assistance
                        onAction: {
                            confirmationDialog.open()
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
                            if(config.token !== ""){
                                execution.open(
                                            "http://" + config.serverAddress + "/neos?token="+ config.token +"#mon-compte")
                                mainAppliWindow.hide()
                            }else{
                                execution.open(
                                            "http://" + config.serverAddress + "/neos#mon-compte")
                                mainAppliWindow.hide()
                            }
                        }
                    }
                    SideBarIcon {
                        label: "Gérer les mots de passe"
                        visible: config.workspace.userIsTeacher
                        icon: "password.svg"
                        onAction: {
                            if(config.token !==""){
                                execution.open(
                                            "http://" + config.serverAddress + "/neos?token="+ config.token +"#mot-de-passe-eleves")
                                mainAppliWindow.hide()
                            }else{
                                execution.open(
                                            "http://" + config.serverAddress + "/neos#mot-de-passe-eleves")
                                mainAppliWindow.hide()
                            }
                        }
                    }
                    SideBarIcon {
                        label: "Ma classe virtuelle"
                        icon: "virtualclass.png"
                        visible: config.workspace.userIsTeacher
                        onAction: {
                            if(config.token !==""){
                                execution.open(
                                            "http://" + config.serverAddress + "/neos?token=" + config.token + "#classe-virtuelle")
                                mainAppliWindow.hide()
                            }else{
                                execution.open(
                                            "http://" + config.serverAddress + "/neos#classe-virtuelle")
                                mainAppliWindow.hide()
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
                        width: parent.width * (6 / 10)
                        color: "grey"
                        Layout.alignment: Qt.AlignHCenter
                    }
                    SideBarIcon {
                        label: "Verrouiller"
                        icon: "lock.png"
                        visible: config.workspace.lockScreenEnable
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
                        visible: false
                        opacity: 0.1
                        onAction: {
                            execution.shutdown()
                        }
                    }
                }
            }

            // Menu
            Item {
                id: menu
                width: (parent.width - sideBar.width) * (4 / 10)
                height: parent.height

                Rectangle {
                    color: "#222222"
                    width: parent.width
                    height: parent.height
                }

                ColumnLayout {
                    width: parent.width * (9 / 10)
                    height: parent.height
                    spacing: 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter

                    Item {
                        height: parent.height / 7
                        width: parent.width
                        Image {
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/icons/novatice.png"
                            height: parent.height * (2 / 5)
                            width: parent.height * (2 / 5)
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    Item {
                        width: parent.width
                        height: parent.height * (4 / 7)

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
                                    font.pointSize: parent.height * (1 / 4)
                                    font.family: AvenirFonts.regular.name
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: parent.left
                                    anchors.leftMargin: 20
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    hoverEnabled: true
                                    onEntered: {
                                        applicationsMenuBack.color = applicationsMenuBack.color
                                                == "#066198" ? "#066198" : "#444444"
                                    }
                                    onExited: {
                                        applicationsMenuBack.color = applicationsMenuBack.color
                                                == "#066198" ? "#066198" : "transparent"
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
                                    font.pointSize: parent.height * (1 / 4)
                                    font.family: AvenirFonts.regular.name
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: parent.left
                                    anchors.leftMargin: 20
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    hoverEnabled: true
                                    onEntered: {
                                        filesMenuBack.color = filesMenuBack.color
                                                == "#066198" ? "#066198" : "#444444"
                                    }
                                    onExited: {
                                        filesMenuBack.color = filesMenuBack.color
                                                == "#066198" ? "#066198" : "transparent"
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
                        height: parent.height * (2 / 7)
                        visible: !config.workspace.missingDefaultBrowser

                        ColumnLayout {
                            width: parent.width
                            height: parent.height * (2 / 7)
                            spacing: 10
                            anchors.horizontalCenter: parent.horizontalCenter

                            Rectangle {
                                visible: config.workspace.links.rowCount() !== 0
                                height: 2
                                width: parent.width
                                color: "grey"
                            }
                            Text {
                                visible: config.workspace.links.rowCount() !== 0
                                text: qsTr("Ressources en ligne")
                                color: "white"
                                font.pointSize: parent.height * (1 / 4)
                                font.family: AvenirFonts.italic.name
                                Layout.alignment: Qt.AlignVCenter
                                Layout.leftMargin: 20
                            }
                            Item {
                                height: config.workspace.links.rowCount(
                                            ) === 0 ? 0 : parent.width * (1 / 5)
                                width: config.workspace.links.rowCount() * height
                                Layout.alignment: Qt.AlignHCenter

                                DelegateModel {
                                    id: linksModelDelegate
                                    model: config.workspace.links
                                    delegate: ZoomableIcon {
                                        Layout.alignment: Qt.AlignVCenter
                                        width: parent.height
                                        height: parent.height
                                        backgroundColor: "white"
                                        textColor: "white"
                                        iconSrc: qsTr(icon)
                                        label: qsTr(name)
                                        active: true
                                        onAction: {
                                            execution.open(path)
                                            mainAppliWindow.hide()
                                        }
                                    }
                                }
                                ListView {
                                    model: linksModelDelegate
                                    anchors.fill: parent
                                    orientation: ListView.Horizontal
                                }
                            }
                        }
                    }

                    Item {
                        width: parent.width
                        height: parent.height * (2 / 7)
                        visible: config.workspace.missingDefaultBrowser

                        ColumnLayout {
                            width: parent.width
                            height: parent.height * (2 / 7)
                            spacing: 10
                            anchors.horizontalCenter: parent.horizontalCenter

                            Rectangle {
                                visible: config.workspace.missingDefaultBrowser
                                height: 2
                                width: parent.width
                                color: "grey"
                            }
                            Text {
                                visible: config.workspace.missingDefaultBrowser
                                text: qsTr("Navigateur par défaut non autorisé \nContactez un administrateur")
                                color: "orange"
                                font.pointSize: parent.height * (1 / 4)
                                font.family: AvenirFonts.italic.name
                                Layout.alignment: Qt.AlignVCenter
                                Layout.leftMargin: 20
                            }
                        }
                    }
                }
            }

            // Content
            Item {
                id: content
                width: (parent.width - sideBar.width) * (6 / 10)
                height: parent.height

                Rectangle {
                    color: "white"
                    width: parent.width
                    height: parent.height
                }

                // Files container
                FilesContainer {
                    id: filesContainer
                }

                // Applications container
                ApplicationsContainer {
                    id: applicationsContainer
                }
            }
        }
    }
}
