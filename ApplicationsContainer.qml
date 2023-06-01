import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.12
import QtQuick.Controls 2.3
import QtQml.Models 2.3

ColumnLayout {
    id: applicationsContainer
    height: parent.height - parent.width / 10
    width: parent.width * (8 / 10)
    spacing: parent.width / 20
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    visible: true

    // Search
    Rectangle {
        height: 50
        width: parent.width * (3 / 4)
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
        height: favoritesModel.rowCount() === 0 ? 0 : parent.width * (1 / 5)
        width: favoritesModel.rowCount() * height
        Layout.alignment: Qt.AlignHCenter

        DelegateModel {
            id: favoritesApplications
            model: favoritesModel
            delegate: ZoomableIcon {
                Layout.alignment: Qt.AlignVCenter
                width: parent.height
                height: parent.height
                backgroundColor: installed ? "lightblue" : "lightslategrey"
                textColor: installed ? "black" : "grey"
                iconSrc: qsTr(icon)
                label: qsTr(name)
                active: installed
                onAction: {
                    execution.launch(src, args)
                    mainAppliWindow.hide()
                }
            }
        }
        ListView {
            model: favoritesApplications
            anchors.fill: parent
            orientation: ListView.Horizontal
        }
    }

    Text {
        text: qsTr("Toutes les applications (" + modelApplication.rowCount(
                       ) + ")")
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
                contentHeight: (applicationsList.childrenRect.height
                                > parent.height) ? applicationsList.childrenRect.height : parent.height
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

                    lessThan: function (left, right) {
                        // Left name has pattern
                        var lnhp = left.name.toLowerCase().includes(
                                    searchText.text.toLowerCase())
                        // Right name has pattern
                        var rnhp = left.name.toLowerCase().includes(
                                    searchText.text.toLowerCase())

                        // Left description has pattern
                        //var ldhp = left.description.toLowerCase().includes(searchText.text.toLowerCase());
                        // Right description has pattern
                        //var rdhp = left.description.toLowerCase().includes(searchText.text.toLowerCase());

                        // This is useless for now but will be used when we'll display applications description
                        if (lnhp && !rnhp)
                            return -1
                        if (rnhp && !lnhp)
                            return 1

                        return left.name < right.name ? -1 : 1
                    }

                    filterAcceptsItem: function (item) {
                        return item.name.toLowerCase().includes(
                                    searchText.text.toLowerCase())
                    }

                    delegate: Item {

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
                            anchors.left: applicationIcon.right

                            Text {
                                id: applicationName
                                font.pointSize: parent.parent.height * (1 / 5)
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
                                if (mouse.button === Qt.LeftButton
                                        && installed) {
                                    execution.launch(src, args)
                                    mainAppliWindow.visible = false
                                }
                            }
                            onEntered: {
                                if (installed)
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
