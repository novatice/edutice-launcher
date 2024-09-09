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
        id: documentsText
        text: qsTr("Mes documents")
        font.pointSize: 20
        font.family: AvenirFonts.bold.name
        color: theme.mainTitleColor
        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
    }
    Rectangle {
        id: personnalDirectories
        visible: true
        width: parent.width
        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        height: childrenRect.height
        Text {
            id: personnalText
            text: qsTr("Mes dossiers personnels")
            font.pointSize: 15
            font.family: AvenirFonts.bold.name
            color: theme.mainTitleColor
        }

        ScrollView {
            id: defaultFilesScrollView
            anchors.topMargin: 8
            anchors.top: personnalText.bottom
            height: defaultFilesList.height
            width: parent.width
            contentHeight: defaultFilesList.contentHeight

            //Scrollbar
            ScrollBar.vertical: ScrollBar {
                id: defaultFilesScrollBar
                policy: ScrollBar.AsNeeded
                height: defaultFilesScrollView.availableHeight
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
                    width: parent.width

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

                        onClicked: mouse => {
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
                        onWheel: wheel => {
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
                property bool first: true
                delegate: defaultFilesDelegate
                height: contentHeight
                width: parent.width
                model: defaultValues.defaultDirectoriesModel
            }
        }
    }

    Rectangle {
        id: mountedDirectories
        visible: defaultValues.mountedDirectoriesModel.rowCount() > 0
        Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
        Layout.fillHeight: true
        width: parent.width
        Connections {
            target: defaultValues
            function mountedDirectoriesChanged() {
                visible = defaultValues.mountedDirectoriesModel.rowCount() > 0
            }
        }

        Text {
            id: sharedText
            text: qsTr("Mes dossiers partagés")
            font.pointSize: 15
            font.family: AvenirFonts.bold.name
            color: theme.mainTitleColor
        }

        ScrollView {
            id: mountedDirectoriesScrollView
            anchors.topMargin: 8
            anchors.top: sharedText.anchors.bottom
            height: mountedDirectoriesList.height
            width: parent.width
            contentHeight: mountedDirectoriesList.height
            contentWidth: parent.width

            //Scrollbar
            ScrollBar.vertical: ScrollBar {
                id: mountedDirectoriesScrollBar
                policy: ScrollBar.AsNeeded
                height: mountedDirectoriesScrollView.availableHeight
                x: mountedDirectoriesScrollView.mirrored ? 0 : mountedDirectoriesScrollView.width
                                                           - width
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

                        onClicked: mouse => {
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
                        onWheel: wheel => {
                                     if (wheel.angleDelta.y > 0) {
                                         mountedDirectoriesScrollBar.decrease()
                                     } else {
                                         mountedDirectoriesScrollBar.increase()
                                     }
                                 }
                    }
                }
            }
        }

        ListView {
            anchors.top: sharedText.bottom
            anchors.topMargin: 8
            id: mountedDirectoriesList
            property bool first: true
            delegate: mountedDirectoriesDelegate
            height: contentHeight
            width: parent.width
            model: defaultValues.mountedDirectoriesModel
        }
    }
}
