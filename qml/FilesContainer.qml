import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
import AvenirFonts 1.0

//import QtQml.Models 2.3
ColumnLayout {
    //id: filesContainer
    height: parent.height - parent.width / 10
    width: parent.width * (8 / 10)
    spacing: parent.width / 20
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    visible: false

    Text {
        text: qsTr("Mes documents")
        font.pointSize: 20
        font.family: AvenirFonts.bold.name
        color: theme.mainTitleColor
        Layout.alignment: Qt.AlignHCenter
    }

    Text {
        text: qsTr("Mes dossiers partagés")
        font.pointSize: 15
        font.family: AvenirFonts.bold.name
        color: theme.mainTitleColor
        visible: defaultValues.mountedDirectoriesModel.rowCount() > 0
    }

    // Mounted directories
    Rectangle {
        id: mountedDirectories
        height: defaultValues.mountedDirectoriesModel.rowCount() > 0 ? childrenRect.height : 0
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
                contentHeight: (mountedDirectoriesList.childrenRect.height
                                > parent.height) ? mountedDirectoriesList.childrenRect.height : parent.height
                ScrollBar.vertical: ScrollBar {
                    id: mountedDirectoriesScrollBar
                    policy: ScrollBar.AsNeeded
                    height: mountedDirectoriesScrollView.availableHeight
                    x: mountedDirectoriesScrollView.mirrored ? 0 : mountedDirectoriesScrollView.width - width
                    y: mountedDirectoriesScrollView.topPadding
                    active: false
                    snapMode: ScrollBar.SnapOnRelease
                    visible: mountedDirectoriesScrollView.contentHeight
                             > mountedDirectoriesScrollView.height ? true : false
                    stepSize: 0.05
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
                                source: "qrc:/icons/" + icon
                                fillMode: Image.PreserveAspectFit
                                //fillMode: Image.PreserveAspectFit
                                width: parent.height * (2 / 3)
                                height: parent.height * (2 / 3)
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
                                font.pointSize: parent.parent.height * (1 / 5)
                                font.family: AvenirFonts.regular.name
                                text: qsTr(name)
                            }
                        }

                        MouseArea {
                            id: mountedDirectoriesMouseArea
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true

                            onClicked: (mouse) => {
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
                            onWheel: (wheel) =>{
                                if (wheel.angleDelta.y > 0) {
                                    mountedDirectoriesScrollBar.decrease()
                                } else {
                                    mountedDirectoriesScrollBar.increase()
                                }
                            }
                        }
                    }
                }

                ListView {
                    id: mountedDirectoriesList
                    anchors.fill: parent
                    property bool first: true
                    delegate: mountedDirectoriesDelegate

                    model: defaultValues.mountedDirectoriesModel
                }
            }
        }
    }

    Text {
        text: qsTr("Mes dossiers personnels")
        font.pointSize: 15
        font.family: AvenirFonts.bold.name
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
            contentHeight: (defaultFilesList.childrenRect.height
                            > parent.height) ? defaultFilesList.childrenRect.height : parent.parent.height
            ScrollBar.vertical: ScrollBar {
                id: defaultFilesScrollBar
                policy: ScrollBar.AsNeeded
                height: defaultFilesScrollView.height
                x: defaultFilesScrollView.mirrored ? 0 : defaultFilesScrollView.width - width
                y: defaultFilesScrollView.topPadding
                active: false
                visible: defaultFilesList.contentHeight
                         > defaultFilesScrollView.height ? true : false
                snapMode: ScrollBar.SnapOnRelease
                stepSize: 0.05
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
                            source: "qrc:/icons/" + icon
                            fillMode: Image.PreserveAspectFit
                            width: parent.height * (2 / 3)
                            height: parent.height * (2 / 3)
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
                            font.pointSize: parent.parent.height * (1 / 5)
                            font.family: AvenirFonts.regular.name
                            text: qsTr(name)
                            color: "black"
                        }
                    }

                    MouseArea {
                        id: defaultFilesMouseArea
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onClicked: (mouse) =>{
                            if (mouse.button === Qt.LeftButton) {
                                execution.openFolder(path)
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
                        onWheel: (wheel) => {
                            if (wheel.angleDelta.y > 0) {
                                defaultFilesScrollBar.decrease()
                            } else {
                                defaultFilesScrollBar.increase()
                            }
                        }
                    }
                }
            }

            ListView {
                id: defaultFilesList
                anchors.fill: parent
                property bool first: true
                delegate: defaultFilesDelegate

                model: defaultValues.defaultDirectoriesModel
            }
        }
    }
}
