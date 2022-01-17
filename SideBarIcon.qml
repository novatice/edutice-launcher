import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.12

Item {
    function indexOfChild (item, child) {
        var ret = -1;
        if (item && child && "children" in item) {
            for (var idx = 0; ret < 0 && idx < item.children.length; idx++) {
                if (item.children [idx] === child) {
                    ret = idx;
                }
            }
        }
        return ret;
    }

    function prevSibling (item, child) {
        return (item.children [indexOfChild (item, child) -1] || null);
    }

    function nextSibling (item, child) {
        return (item.children [indexOfChild (item, child) +1] || null);
    }

    property string label
    property string icon

    signal action();
    // Override this function to make your Item useful !
    function onAction() {
    }

    width: parent.width
    height: parent.width

    Rectangle {
        color: "transparent"
        width: parent.width
        height: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Image {
            fillMode: Image.PreserveAspectFit
            source: icon
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            opacity: 1
            height: parent.height / 2
            width: parent.height / 2
        }
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onEntered: {
                // Should be a reference to the Text element below
                nextSibling(parent.parent, parent).visible = true
                parent.color = "#222222"
            }
            onExited: {
                // Should be a reference to the Text element below
                nextSibling(parent.parent, parent).visible = false
                parent.color = "transparent"
            }
            onClicked: parent.parent.action()
        }
    }
    Text {
        font.pointSize: 10
        visible: false
        text: qsTr(label)
        anchors.top: prevSibling(parent, this).bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
