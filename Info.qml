import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.12

Item {
    Layout.fillWidth: true
    height: 100
    opacity: 0.8
    property string title
    property string value
    property string icon
    ColumnLayout {
        anchors.fill: parent
        Item {
            Layout.fillWidth: true
            height: 50
            clip: true

            Rectangle {
                anchors.fill: parent
                anchors.rightMargin: -border.width
                anchors.topMargin: -border.width
                anchors.leftMargin: -border.width
                border.width: 2
                color: "transparent"
                border.color: theme.mainBorderColor
                opacity: 0.2
            }
            RowLayout {
                anchors.fill: parent
                Item {
                    width: 50
                    Layout.fillHeight: true
                    Rectangle {
                        anchors.fill: parent
                        radius: 2
                        opacity: 0.3
                        color: "transparent"
                    }

                    Item {
                        width: parent.width - 20
                        height: parent.width - 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        opacity: 0.4
                        Image {
                            id: typeIcon
                            asynchronous: true
                            source: icon
                            smooth: true
                            anchors.fill: parent
                            Layout.preferredHeight: parent.width //parent.height - platformStyle.paddingMedium * 2
                            Layout.preferredWidth: parent.height //parent.height - platformStyle.paddingMedium * 2
                        }
                        ColorOverlay {
                            anchors.fill: typeIcon
                            source: typeIcon
                            color: theme.mainTextColor
                        }
                    }
                }
                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Text {
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pointSize: 15
                        opacity: 0.9
                        font.family: font3.name
                        text: title
                        color: theme.mainTextColor
                    }
                }
            }
        }
        Item {
            Layout.fillWidth: parent.width
            height: 50

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 15
                opacity: 0.7
                font.family: font1.name
                text: value
                color: theme.mainTextColor
            }
        }
    }
}
