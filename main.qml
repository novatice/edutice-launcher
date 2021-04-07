import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtQml.Models 2.3
import QtGraphicalEffects 1.12
import Eexecution 1.0

ApplicationWindow {
    id: mainAppliWindow

    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.Tool
    color: "transparent"
    screen: screenNumberId
    width: screenWidth
    height: screenHeight
    x: screenNumberId.virtualX + ((screenNumberId.width - width) / 2)
    y: screenNumberId.virtualY + ((screenNumberId.height - height) / 2)

    Timer {
        id: timer
    }

    function delay(delayTime, cb) {
        timer.interval = delayTime
        timer.repeat = false
        timer.triggered.connect(cb)
        timer.start()
    }

    Connections {
        target: Qt.application
        onStateChanged: {
            if (Qt.application.state === Qt.ApplicationInactive) {
                mainAppliWindow.visible = false
            } else if (Qt.application.state === Qt.ApplicationActive) {
                mainAppliWindow.visible = true
            }
        }
    }

    Item {
        id: theme
        property var actualTheme: theme2

        property var mainTextColor: "black"
        property var mainBorderColor: mainTextColor
        property var mainLineColor: mainTextColor
        property var backgroundColor: "white"
        property var mainOpacity: 0

        property var appliBackgroundG1
        property var appliBackgroundG2

        Component.onCompleted: {
            mainTextColor = actualTheme.mainTextColor
            mainBorderColor = actualTheme.mainBorderColor
            mainLineColor = actualTheme.mainLineColor
            backgroundColor = actualTheme.backgroundColor

            mainOpacity = actualTheme.mainOpacity

            appliBackgroundG1 = actualTheme.appliBackgroundG1
            appliBackgroundG2 = actualTheme.appliBackgroundG2
        }

        Item {
            id: theme1
            property var mainTextColor: "white"
            property var mainBorderColor: mainTextColor
            property var mainLineColor: mainTextColor
            property var backgroundColor: "black"
            property var mainOpacity: 1

            property var appliBackgroundG1: "#7a7a7a"
            property var appliBackgroundG2: "#212421"
        }

        Item {
            id: theme2
            property var mainTextColor: "black"
            property var mainBorderColor: mainTextColor
            property var mainLineColor: mainTextColor
            property var backgroundColor: "white"
            property var mainOpacity: 0.65

            property var appliBackgroundG1: "#7a7a7a"
            property var appliBackgroundG2: "#212421"
        }
    }

    FontLoader {
        id: titleFont
        source: "SFCompactText-SemiBoldItalic.ttf"
    }

    FontLoader {
        id: font1
        source: "SFProDisplay-Semibold.ttf"
    }

    FontLoader {
        id: font2
        source: "SFProDisplay-Ultralight.ttf"
    }

    FontLoader {
        id: font3
        source: "SFProText-Medium.ttf"
    }
    MouseArea {
        anchors.fill: parent
        onClicked: forceActiveFocus()
    }

    Execution {
        id: execution
        objectName: "execution"
        //onSignalExit: mainAppliWindow.close()
    }

    Dialog {
        id: popup
        width: parent.width / 4
        height: 200

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
        title: "Fermeture de session"
        Text {
            text: "Vous vous appretez à fermer votre session. Etes vous sur ?"
        }

        standardButtons: Dialog.Ok | Dialog.Cancel
        onAccepted: execution.disconnectScreen()
        //onRejected: console.log("Cancel clicked")
    }

    Item {
        id: rectA
        anchors.fill: parent

        Rectangle {
            anchors.fill: parent

            color: theme.backgroundColor
            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: "white"
                }
                GradientStop {
                    position: 0.5
                    color: "#f8f8fb"
                }
                GradientStop {
                    position: 0.8
                    color: "#d1d1d4"
                }
                GradientStop {
                    position: 1.0
                    color: "#adacaf"
                }
            }
        }
    }
    DropShadow {
        anchors.fill: rectA
        cached: true
        horizontalOffset: 0
        verticalOffset: 0
        radius: 60
        samples: 32
        color: "red"
        smooth: true
        source: rectA
    }

    Item {
        width: mainAppliWindow.width
        height: mainAppliWindow.height - 50
        anchors.horizontalCenter: parent.horizontalCenter
        //Component.onCompleted: console.log("topLevelItem width: " + width)
        ColumnLayout {
            width: parent.width
            height: parent.height

            Item {
                id: search
                width: parent.width
                Layout.alignment: Qt.AlignHCenter
                height: 50
                Layout.topMargin: 50
                Layout.bottomMargin: 60
                Item {
                    width: parent.width * (1 / 4)
                    //color:"blue"
                    height: parent.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    RowLayout {
                        height: parent.height
                        anchors.horizontalCenter: parent.horizontalCenter

                        Item {
                            Layout.preferredHeight: parent.height
                            width: 50
                            //color:"red"
                            Image {
                                id: iconSearchtext
                                smooth: true
                                fillMode: Image.PreserveAspectFit
                                asynchronous: true
                                source: "search.png"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                opacity: 0.15
                                height: 30 //parent.height - platformStyle.paddingMedium * 2
                                width: 30 //parent.height - platformStyle.paddingMedium * 2
                            }
                            ColorOverlay {
                                anchors.fill: iconSearchtext
                                source: iconSearchtext
                                color: theme.mainTextColor
                                opacity: 0.15
                            }
                        }
                        Item {
                            width: 300
                            //color:"green"
                            Layout.preferredHeight: parent.height
                            TextField {
                                id: searchText
                                placeholderText: qsTr("Rechercher...")
                                color: theme.mainTextColor
                                opacity: 0.3
                                font.pointSize: 30
                                anchors.verticalCenter: parent.verticalCenter
                                font.bold: true
                                font.family: font3.name
                                property var timerUpdate: null
                                background: Item {
                                    opacity: 0
                                }

                                onTextChanged: {
                                    timerText.restart()
                                }
                                Timer {
                                    id: timerText
                                    interval: 150
                                    repeat: false
                                    onTriggered: {
                                        console.log("ede")
                                        tr.animations = animationN
                                        sortFilterModel.update()
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Item {
                // Layout.alignment: Qt.AlignBottom
                width: parent.width
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width
                Layout.leftMargin: 40
                Layout.rightMargin: 40
                RowLayout {
                    width: parent.width
                    height: parent.height
                    anchors.horizontalCenter: parent.horizontalCenter

                    Item {
                        width: parent.width * (1 / 5)
                        height: parent.height
                        Layout.fillHeight: true
                        Loader {
                            id: categoriesLoader
                            asynchronous: true
                            anchors.fill: parent
                            source: "Categories.qml"
                        }
                    }
                    Item {
                        id: page
                        objectName: "page"
                        width: parent.width * (2 / 5)
                        Layout.fillHeight: true

                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 40
                            Item {
                                id: nameApplications
                                width: parent.width
                                Layout.alignment: Qt.AlignHCenter
                                height: 35
                                clip: true
                                opacity: theme.mainOpacity
                                //visible : false
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
                                Item {
                                    width: parent.width
                                    anchors.top: parent.top
                                    height: 30

                                    Text {
                                        text: "Applications"
                                        font.pointSize: 20
                                        font.family: titleFont.name
                                        anchors.left: parent.left
                                        color: theme.mainTextColor
                                    }
                                }
                            }
                            Rectangle {
                                id: content
                                width: parent.width
                                Layout.alignment: Qt.AlignHCenter
                                Layout.fillHeight: true
                                color: "transparent"
                                ListModel {
                                    id: appModel
                                }
                                SortFilterModel {
                                    id: sortFilterModel
                                    model: myModel
                                    property string actualCategorie: ""
                                    modelCategories: modelCategorie

                                    filterAcceptsItem: function (item) {
                                        var itemName = item.name.toLowerCase()
                                        var itemCategorie = item.categorie.toLowerCase()
                                        var actualCategorie = (String)(
                                                    sortFilterModel.actualCategorie).toLowerCase()
                                        if (actualCategorie !== ""
                                                && itemCategorie !== actualCategorie)
                                            return false
                                        var itemSearch = searchText.text.toLowerCase()
                                        return itemName.includes(itemSearch)
                                    }

                                    lessThan: function (left, right) {
                                        var leftVal = left.name.toLowerCase()
                                        var rightVal = right.name.toLowerCase()
                                        //return leftVal.localeCompare(rightVal);
                                        return leftVal < rightVal ? -1 : 1
                                    }

                                    updateCategorie: function () {
                                        /*
                            var item;
                            for (var i = 0; i < items.count; ++i) {
                                item = items.get(i).model;
                                  var itemCategorie = item.categorie.toLowerCase();
                                for (var j=0 ; j< listCategorie.count ; ++j)
                                {
                                    var categorieItem = listCategorie.itemAtIndex(j);

                                    if (categorieItem.name.toLowerCase() === itemCategorie)
                                    {
                                        categorieItem.apps.push_back(i);
                                    }
                                }
                            }
                            /**/
                                    }

                                    delegate: //maingrid.state = "down";
                                              Item {
                                        Component.onCompleted: {

                                        }

                                        //width: parent.width/6; height:parent.width/6
                                        width: maingrid.cellWidth
                                        height: maingrid.cellHeight
                                        //PropertyAnimation on x { from : -100 ; to: x; duration: 1000; loops: Animation.Infinite }
                                        //PropertyAnimation on y { from : 100 ; to: y; duration: 1000; loops: Animation.Infinite }
                                        Rectangle {
                                            id: apps
                                            width: parent.width - parent.width / 5
                                            height: parent.height - parent.width / 6
                                            clip: true
                                            color: "transparent" //"blue"
                                            state: "mouseOut"

                                            states: State {
                                                name: "mouseIn"
                                            }
                                            State {
                                                name: "mouseOn"
                                            }
                                            State {
                                                name: "pressed"
                                            }
                                            transitions: [
                                                Transition {
                                                    from: "*"
                                                    to: "pressed"
                                                    NumberAnimation {
                                                        target: backg
                                                        properties: "scale"
                                                        from: 1
                                                        to: 0.8
                                                        duration: 400
                                                        easing.type: Easing.OutBounce
                                                    }
                                                },
                                                Transition {
                                                    from: "*"
                                                    to: "mouseIn"
                                                    SequentialAnimation {
                                                        NumberAnimation {
                                                            target: apps
                                                            properties: "scale"
                                                            from: 0.95
                                                            to: 1
                                                            duration: 400
                                                        }
                                                        NumberAnimation {
                                                            target: apps
                                                            properties: "scale"
                                                            from: 1
                                                            to: 0.95
                                                            duration: 400
                                                        }
                                                        loops: Animation.Infinite
                                                    }
                                                }
                                            ]

                                            Rectangle {
                                                id: backg
                                                color: "transparent"
                                                width: parent.width
                                                height: parent.height
                                                radius: 20

                                                RectangularGlow {
                                                    id: effect
                                                    anchors.fill: parent
                                                    glowRadius: 10
                                                    spread: 0.2
                                                    color: "#61c2ff"
                                                    cornerRadius: 30
                                                    visible: false
                                                }
                                            }
                                            ColumnLayout {
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                anchors.verticalCenter: parent.verticalCenter
                                                spacing: 8

                                                Item {
                                                    width: parent.parent.width / 2
                                                    height: parent.parent.width / 2
                                                    Image {
                                                        id: myIcon
                                                        asynchronous: true
                                                        width: parent.width
                                                        height: parent.width
                                                        source: icon
                                                    }
                                                }
                                                Item {

                                                    Layout.fillWidth: true
                                                    Layout.fillHeight: true
                                                    height: 20
                                                    width: parent.width

                                                    Text {
                                                        FontLoader {
                                                            id: appliFont
                                                            source: "SFCompactText-Medium.ttf"
                                                        }
                                                        text: name
                                                        width: parent.width * 1.5
                                                        anchors.horizontalCenter: parent.horizontalCenter
                                                        font.family: appliFont.name
                                                        fontSizeMode: Text.Fit
                                                        horizontalAlignment: Text.AlignHCenter
                                                        verticalAlignment: Text.AlignBottom
                                                        color: theme.mainTextColor
                                                        maximumLineCount: 2
                                                        elide: Text.ElideRight
                                                        wrapMode: Text.WordWrap


                                                    }
                                                }
                                            }

                                            MouseArea {
                                                id: applicationMouseArea
                                                anchors.fill: parent
                                                cursorShape: Qt.PointingHandCursor

                                                onClicked: {
                                                    backg.color = "lightsteelblue"
                                                    backg.opacity = 0.1
                                                    parent.state = "pressed"
                                                    if (mouse.button === Qt.LeftButton) {
                                                        execution.launch(src)
                                                    }
                                                }

                                                hoverEnabled: true
                                                onEntered: {
                                                    parent.state = "mouseIn"
                                                    //backg.color = theme.mainBorderColor //"a9a9a9" //"lightsteelblue"
                                                    backg.visible = true
                                                    effect.visible = true
                                                    backg.opacity = 0.2
                                                }
                                                onExited: {
                                                    parent.state = "mouseOut"
                                                    //backg.color = "transparent"
                                                    backg.visible = false
                                                    effect.visible = false
                                                }
                                                onDoubleClicked: {

                                                }
                                            }
                                        }
                                    }
                                }
                                Item {
                                    width: parent.width
                                    height: parent.height
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.top: parent.top

                                    ScrollView {
                                        id: scrollV
                                        anchors.fill: parent
                                        contentHeight: (maingrid.childrenRect.height > parent.height) ? maingrid.childrenRect.height : parent.height

                                        ScrollBar.vertical: ScrollBar {
                                            id: scrollBar
                                            parent: scrollV.parent
                                            policy: ScrollBar.AlwaysOn
                                            height: scrollV.availableHeight
                                            x: scrollV.mirrored ? 0 : scrollV.width - width
                                            y: scrollV.topPadding
                                            active: false
                                            snapMode: ScrollBar.SnapAlways
                                            visible: scrollV.contentHeight
                                                     > scrollV.height ? true : false
                                            //stepSize: 0.5
                                            //active: scrollV.ScrollBar.horizontal.active
                                            contentItem: Rectangle {
                                                implicitWidth: 6
                                                implicitHeight: 100
                                                opacity: 0.05
                                                radius: width / 2
                                                color: scrollBar.pressed ? "#0092CC" : theme.mainBorderColor
                                            }
                                        }

                                        //contentHeight: maingrid.height
                                        //contentWidth: width
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
                                        GridView {
                                            id: maingrid
                                            //width: parent.width-100
                                            //height: parent.width-100
                                            anchors.fill: parent

                                            //anchors.horizontalCenter: parent.horizontalCenter
                                            //anchors.verticalCenter: parent.verticalCenter
                                            property bool first: true
                                            property var cellSize: width / 6

                                            Component.onCompleted: {
                                                cellSize = width / 6
                                                for (var i = 0; cellSize < 150; i++) {
                                                    cellSize = width / (6 - i)
                                                }
                                            }

                                            cellWidth: cellSize
                                            cellHeight: cellSize

                                            focus: true
                                            state: "deb"
                                            opacity: 1
                                            property int viewIndex: 0
                                            model: sortFilterModel

                                            //highlight: Rectangle { width: 80; height: 80; color: "lightsteelblue" }
                                            interactive: false
                                            states: State {
                                                name: "down"
                                            }
                                            State {
                                                name: "debut"
                                            }
                                            add: Transition {
                                                id: tr
                                                enabled: true
                                                SequentialAnimation {
                                                    id: animationX

                                                    ParallelAnimation {
                                                        NumberAnimation {
                                                            property: "opacity"
                                                            from: 0
                                                            to: 1
                                                            duration: 2000
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }

                                }
                                ParallelAnimation {
                                    id: animationN
                                    NumberAnimation {
                                        property: "scale"
                                        easing.type: Easing.OutBounce
                                        from: 0
                                        to: 1.0
                                        duration: 400
                                    }
                                    NumberAnimation {
                                        property: "opacity"
                                        from: 0
                                        to: 1.0
                                        duration: 300
                                    }
                                }


                            }
                        }
                    }
                    Item {
                        width: parent.width * (1 / 5)
                        Layout.fillHeight: true
                        ColumnLayout {
                            width: parent.width
                            spacing: parent.height / 10

                            Item {
                                width: parent.width
                                Layout.alignment: Qt.AlignHCenter
                                height: 35
                                clip: true
                                opacity: theme.mainOpacity
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
                                Item {
                                    width: parent.width
                                    anchors.top: parent.top
                                    height: 30

                                    Text {
                                        text: "Informations"
                                        font.pointSize: 20
                                        font.family: titleFont.name
                                        anchors.left: parent.left
                                        color: theme.mainTextColor
                                    }
                                }
                            }

                            Item {
                                width: parent.width
                                Layout.fillHeight: true
                                Rectangle {
                                    width: parent.width
                                    height: parent.height
                                    anchors.centerIn: parent
                                    color: "transparent"
                                    ColumnLayout {
                                        width: parent.width
                                        /*Info {
                                            title: "Espace de travail"
                                            value: workspace
                                            icon: "icon_espacetravail.png"
                                        }*/

                                        Info {
                                            title: "Utilisateur"
                                            value: username
                                            icon: "user.png"
                                        }

                                        /*Info {
                                            title: "Groupe"
                                            value: group
                                            icon: "icon_group.png"
                                        }*/

                                        Info {
                                            title: "Appareil"
                                            value:  machine
                                            icon: "pc.png"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
