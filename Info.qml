import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.12

Item {
    property string label
    property string value
    width: parent.width
    height: parent.parent.parent.height * (1/6)
    Text {
        font.pointSize: parent.height / 4
        anchors.right: parent.horizontalCenter
        anchors.rightMargin: 10
        text: qsTr(label)
    }
    Text {
        font.pointSize: parent.height / 4
        anchors.left: parent.horizontalCenter
        anchors.leftMargin: 10
        color: "grey"
        text: qsTr(value)
    }
}
