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
    Item{
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
                text : "Categories"
                font.pointSize: 20
                font.family: titleFont.name
                anchors.left : parent.left
                color : theme.mainTextColor
            }
        }

    }

    Item{
        id:categories
        Layout.fillWidth: true

        Layout.fillHeight: true
        Layout.alignment : Qt.AlignHCenter
        Item {
            width: parent.width-100;

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
                width: parent.width; height: 60

                id:buttonCategorie
                property bool enabledd;
                Item {
                    anchors.fill:parent
                        property bool control;
                        Text {
                                id :textCategorie
                                text: name
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

                                    /*
                                    onEntered: {
                                        parent.color = "orange"
                                    }
                                    onExited: {
                                        parent.color = (listCategorie.currentIndex == index) ? "#17a81a" :  "black"
                                    */
                                }
                            }
                        anchors.centerIn: parent
                      //model.submit()
                    }
            }

            add: Transition {
                    id: addTrans
                    SequentialAnimation{
                        NumberAnimation { property: "x"; to: addTrans.ViewTransition.destination.x-1000; duration: 0}
                    PauseAnimation {
                                    duration: (addTrans.ViewTransition.index -
                                            addTrans.ViewTransition.targetIndexes[0]) * 100

                                }
                    NumberAnimation { property: "x"; from: addTrans.ViewTransition.destination.x-1000; to: addTrans.ViewTransition.destination.x; duration: 700 }
                    }
                    /*
                    PauseAnimation {
                        duration: (addTrans.ViewTransition.index -
                                addTrans.ViewTransition.targetIndexes[0]) * 100

                    }
                    PathAnimation {
                        duration: 1000

                        path: Path {
                            startX: addTrans.ViewTransition.destination.x + 200
                            startY: addTrans.ViewTransition.destination.y + 200
                            PathCurve { relativeX: -100; relativeY: -50 }
                            PathCurve { relativeX: 50; relativeY: -150 }
                            PathCurve {
                                x: addTrans.ViewTransition.destination.x
                                y: addTrans.ViewTransition.destination.y
                            }
                        }
                    }
                    */
                }
            focus: true
            //Keys.onSpacePressed: model.insert(0, { "name": "Item " + model.count })
        }
        }
}
Item
{
id:menuButtons
Layout.fillWidth: true
height:200
Item{

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    width: parent.width
    height : parent.height
RowLayout{
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    Item{
                implicitWidth: 110
                implicitHeight:110
                opacity:0.8
           Rectangle
           {
               id:backButtonL
               anchors.fill: parent;
               color: "transparent"
               opacity :1
               border.color:theme.mainBorderColor//control.down ? "#17a81a" : "#21be2b"
               border.width: 2
               radius: 5

           }
           InnerShadow {
               anchors.fill: parent
               horizontalOffset:1
               verticalOffset: 1
               source: backButtonL
               radius: 20
               color: "black"
               opacity:0.45
               spread: 0.2
               samples: 32
           }
           Item{
               width:parent.width-10
               height:parent.height-20
               anchors.verticalCenter: parent.verticalCenter
               anchors.horizontalCenter: parent.horizontalCenter
               ColumnLayout{
                    anchors.fill : parent
                    Item {
                        width : parent.width
                        implicitHeight: 50
                        Image {
                            id:lockButtonImage
                            asynchronous: true
                            anchors {  horizontalCenter: parent.horizontalCenter; }
                            //width : parent.width/2-20
                            height : parent.height
                            fillMode: Image.PreserveAspectFit
                            source: "lockButtonWhite.png"

                        }
                        ColorOverlay {
                                anchors.fill: lockButtonImage
                                source: lockButtonImage
                                color: theme.mainTextColor
                            }

                    }
                    Item{
                        Layout.fillHeight: true;
                        Layout.preferredWidth: parent.width
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            font.family : font1.name
                            anchors.horizontalCenter: parent.horizontalCenter
                            text : "Verrouiller"
                            color : theme.mainTextColor
                        }
                    }

               }
           }
           transitions: [
               Transition {
                   to: "pressed"
                   SequentialAnimation{

                   NumberAnimation {
                       target: backButtonL.parent
                       properties: "scale"
                       from: 1
                       to: 0.9
                       duration: 100
                   }
                   NumberAnimation {
                       target: backButtonL.parent
                       properties: "scale"
                       from: 0.9
                       to: 1
                       duration: 100
                   }
                   }
                   onRunningChanged:{
                       if( running === false )
                       {
                           backButtonL.parent.state = ""
                       }
                   }
               }
           ]

           MouseArea {
               anchors.fill: parent
               cursorShape: Qt.PointingHandCursor
               hoverEnabled: true

               onEntered: {
                    backButtonL.color = "#518fdf"
                   backButtonL.opacity =0.3
               }
               onExited: {
                   backButtonL.color = "transparent"
                   backButtonL.opacity = 0.3
               }

           onClicked:{ parent.state = "pressed";console.log("dess");execution.lockScreen();
           }
           }
            }
    Item{
                implicitWidth: 110
                implicitHeight:110
                state : "nothing"
                opacity:0.8
           Rectangle
           {
               id:backButtonL2
               anchors.fill: parent;
               color: "transparent"
               opacity : 1
               border.color: theme.mainBorderColor//control.down ? "#17a81a" : "#21be2b"
               border.width: 2
               radius: 5
           }

           InnerShadow {
               anchors.fill: parent
               horizontalOffset:1
               verticalOffset: 1
               source: backButtonL2
               radius: 20
               color: "black"
               opacity:0.45
               spread: 0.2
               samples: 32
           }

           Item{
               width:parent.width-10
               height:parent.height-20
               anchors.verticalCenter: parent.verticalCenter
               anchors.horizontalCenter: parent.horizontalCenter
               ColumnLayout{
                    anchors.fill : parent
                    Item {
                        width : parent.width
                        implicitHeight:50
                        Image {
                            id : logOffButtonImage
                            asynchronous: true
                            anchors {  horizontalCenter: parent.horizontalCenter; }
                            //width : parent.width/2-20
                            height : parent.height
                            fillMode: Image.PreserveAspectFit
                            source: "windows_log_off.png"

                        }
                        ColorOverlay {
                                anchors.fill:  logOffButtonImage
                                source:  logOffButtonImage
                                color: theme.mainTextColor
                            }
                    }

                   Label {
                       Layout.fillHeight: true;
                       Layout.alignment : Qt.AlignHCenter
                       text : "Fermer la session"
                       Layout.preferredWidth: Math.min(100, contentWidth)
                       wrapMode: Text.WordWrap
                       font.family : font1.name
                       horizontalAlignment: Text.AlignHCenter
                       color : theme.mainTextColor
                   }
               }
           }
           transitions: [
               Transition {
                   to: "pressed"
                   SequentialAnimation{

                   NumberAnimation {
                       target: backButtonL2.parent
                       properties: "scale"
                       from: 1
                       to: 0.9
                       duration: 100
                   }
                   NumberAnimation {
                       target: backButtonL2.parent
                       properties: "scale"
                       from: 0.9
                       to: 1
                       duration: 100
                   }
                   }
                   onRunningChanged:{
                       if( running === false )
                       {
                           backButtonL2.parent.state = ""
                       }
                   }
               }
           ]

           MouseArea {
               anchors.fill: parent
               cursorShape: Qt.PointingHandCursor
               hoverEnabled: true

               onEntered: {
                   backButtonL2.color = "#518fdf"
                  backButtonL2.opacity =0.3
               }
               onExited: {
                   backButtonL2.color = "transparent"
                   backButtonL2.opacity = 0.1
               }

           onClicked:
           {
               parent.state = "pressed";
               execution.disconnectScreen();
           }

           }
            }
}
}
}
}}
    Rectangle{
        width: 5
        height : 900
        radius: 10

        color : "transparent"
        opacity : 0.2
    }
}
