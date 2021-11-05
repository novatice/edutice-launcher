import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtQml.Models 2.3
import QtGraphicalEffects 1.12
import Eexecution 1.0

RowLayout
{
    width : parent.width
    height : parent.height
    Item {
        Layout.fillWidth: true
        Layout.fillHeight: true
            ColumnLayout
            {
                width : parent.width
                Layout.fillHeight: true
                anchors.verticalCenter: parent.verticalCenter
                height : parent.height
                Item{
                    id :nameCategories
                    Layout.fillWidth: true
                    height:35
                    clip: true
                    opacity: theme.mainOpacity

                    //visible : false
                    Rectangle {
                        anchors.fill: parent
                        anchors.rightMargin: -border.width
                        anchors.topMargin:  -border.width
                        anchors.leftMargin: -border.width
                        border.width: 2
                        color : "transparent"
                        border.color: theme.mainLineColor
                        opacity:0.2
                    }
                    Item{
                        width: parent.width
                        anchors.top:parent.top
                        height:30

                        Text{
                            text : "Catégories"
                            font.pointSize: 20
                            font.family: titleFont.name
                            anchors.left : parent.left
                            color : theme.mainTextColor
                        }
                    }

                }

                Item {
                    id:categories
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.alignment : Qt.AlignLeft

                    Item {
                        width: parent.width;

                        anchors.horizontalCenter: parent.horizontalCenter

                        anchors.verticalCenter: parent.verticalCenter
                        height : parent.height-100

                        ListView {
                            id:listCategorie
                            clip: true
                            model: modelCategorie

                            anchors.horizontalCenter: parent.horizontalCenter
                            currentIndex: -1
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.fill : parent
                            orientation: ListView.Vertical
                            delegate: Item {
                                width: parent.width;
                                height: 60

                                id:buttonCategorie
                                property bool enabledd;
                                Item {
                                    anchors.fill:parent
                                    property bool control;
                                    Text {
                                            id: textCategorie
                                            text: name
                                            width: parent.width
                                            //font: control.font
                                            font.pixelSize : 23
                                            font.family: font2.name
                                            //x : (listCategorie.currentIndex === index) ? parent.parent.x+1000 : parent.parent.x
                                            opacity: (listCategorie.currentIndex == index) ? theme.mainOpacity : 0.5//0.3
                                            color: (listCategorie.currentIndex == index) ? "#00BFFF" /*"#17a81a"*/ :  theme.mainTextColor
                                            //anchors.horizontalCenter: parent.horizontalCenter
                                            elide: Text.ElideRight

                                            states: [ "mouseIn", "mouseOut" ]
                                                state: "mouseOut"

                                            transitions: [
                                                Transition {
                                                    from: "*"
                                                    to: "mouseIn"
                                                    NumberAnimation {
                                                        target: textCategorie
                                                        properties: "font.pixelSize"
                                                        from: 23
                                                        to: 28
                                                        duration: 250
                                                    }
                                                },
                                                Transition {
                                                    from: "mouseIn"
                                                    to: "mouseOut"
                                                    NumberAnimation {
                                                        target: textCategorie
                                                        properties: "font.pixelSize"
                                                        from: 28
                                                        to: 23
                                                        duration: 250
                                                    }
                                                }
                                            ]

                                            MouseArea {
                                                anchors.fill: parent
                                                cursorShape: Qt.PointingHandCursor
                                                hoverEnabled: true
                                                onClicked: {

                                                    if (listCategorie.currentIndex != index)
                                                    {
                                                        listCategorie.currentIndex = index;
                                                        sortFilterModel.actualCategorie = name;
                                                    }
                                                    else
                                                    {
                                                        listCategorie.currentIndex = -1;
                                                        sortFilterModel.actualCategorie = "";
                                                    }
                                                    tr.animations = animationX;
                                                    sortFilterModel.update();
                                                }
                                                onContainsMouseChanged: {
                                                    parent.state = containsMouse ? "mouseIn" : "mouseOut"
                                                }
                                            }
                                        }
                                        anchors.centerIn: parent
                                    }
                            }

                            add: Transition {
                                id: addTrans
                                SequentialAnimation {
                                    NumberAnimation {
                                        property: "x";
                                        to: addTrans.ViewTransition.destination.x-1000;
                                        duration: 0
                                    }
                                    PauseAnimation {
                                        duration: (addTrans.ViewTransition.index - addTrans.ViewTransition.targetIndexes[0]) * 100
                                    }
                                NumberAnimation {
                                    property: "x";
                                    from: addTrans.ViewTransition.destination.x-1000;
                                    to: addTrans.ViewTransition.destination.x;
                                    duration: 700 }
                                }
                            }
                            focus: true
                        }
                    }
                }
            }
    }
}
