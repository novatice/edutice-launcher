import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtQml.Models 2.3
import QtGraphicalEffects 1.12
import Eexecution 1.0


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
