import QtQuick 2.0

Item {
    property string iconSrc
    property string label
    property string backgroundColor
    property string textColor

    signal action();
    // Override this function to make your Item useful !
    function onAction() {
    }

    width: parent.height
    height: parent.height
    Rectangle {
        id: backgroundExample
        width: parent.height * (2/3)
        height: parent.height * (2/3)
        color: backgroundColor
        state: "EXITED"
        radius: width / 10
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        states : [
            State {
                name : "HOVERED"
                PropertyChanges {
                    target: backgroundExample
                    width: parent.width * (4/5)
                    height: parent.height * (4/5)
                }
            },
            State {
                name : "EXITED"
                PropertyChanges {
                    target: backgroundExample
                    width: parent.height * (2/3)
                    height: parent.height * (2/3)
                }
            }
        ]
        transitions: [
            Transition {
                from: "EXITED"
                to: "HOVERED"
                NumberAnimation { target: backgroundExample; property: "width"; duration: 150}
                NumberAnimation { target: backgroundExample; property: "height"; duration: 150}
            },
            Transition {
                from: "HOVERED"
                to: "EXITED"
                NumberAnimation { target: backgroundExample; property: "width"; duration: 150}
                NumberAnimation { target: backgroundExample; property: "height"; duration: 150}
            }
        ]
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onEntered: {
            frenchCaption.state = "HOVERED"
            backgroundExample.state = "HOVERED"
            frenchIcon.state = "HOVERED"
        }
        onExited: {
            frenchCaption.state = "EXITED"
            backgroundExample.state = "EXITED"
            frenchIcon.state = "EXITED"
        }
        onClicked: parent.action()
    }
    Text {
        id: frenchCaption
        anchors.top: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        state: "EXITED"
        text: label
        states : [
            State {
                name : "HOVERED"
                PropertyChanges {
                    target: frenchCaption
                    color: textColor
                }
            },
            State {
                name : "EXITED"
                PropertyChanges {
                    target: frenchCaption
                    color: "transparent"
                }
            }
        ]
        transitions: [
            Transition {
                from: "EXITED"
                to: "HOVERED"
                ColorAnimation { target: frenchCaption; duration: 150}
            },
            Transition {
                from: "HOVERED"
                to: "EXITED"
                ColorAnimation { target: frenchCaption; duration: 150}
            }
        ]
    }
    Image {
        id: frenchIcon
        smooth: true
        asynchronous: true
        source: iconSrc
        state: "EXITED"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        states : [
            State {
                name : "HOVERED"
                PropertyChanges {
                    target: frenchIcon
                    width: parent.width * (4/10)
                    height: parent.height * (4/10)
                }
            },
            State {
                name : "EXITED"
                PropertyChanges {
                    target: frenchIcon
                    height: parent.height * (1/3)
                    width: parent.height * (1/3)
                }
            }
        ]
        transitions: [
            Transition {
                from: "EXITED"
                to: "HOVERED"
                NumberAnimation { target: frenchIcon; property: "width"; duration: 150}
                NumberAnimation { target: frenchIcon; property: "height"; duration: 150}
            },
            Transition {
                from: "HOVERED"
                to: "EXITED"
                NumberAnimation { target: frenchIcon; property: "width"; duration: 150}
                NumberAnimation { target: frenchIcon; property: "height"; duration: 150}
            }
        ]
    }
}
