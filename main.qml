import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtQml.Models 2.3
import QtGraphicalEffects 1.12
import Eexecution 1.0

ApplicationWindow {
    id :mainAppliWindow

    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.Tool //| Qt.WindowMinimized|
    //visibility: Window.FullScreen
    /**/
    //color : "#f4f4f4"
    color : "transparent"
    screen: screenNumberId
    width: screenWidth
    height : screenHeight
    x: screenNumberId.virtualX + ((screenNumberId.width - width) / 2)
    y: screenNumberId.virtualY + ((screenNumberId.height - height) / 2)

    Component.onCompleted: {
        /*
        var width = Qt.application.screens[0].desktopAvailableWidth;
        var height = Qt.application.screens[0].desktopAvailableHeight;
        var currentScreen =0;
        for (var i = 0; i < Qt.application.screens.length ; i++)
       {
            console.log(width);
            if (i !== currentScreen)
                width = width - Qt.application.screens[i].width;
        }
        console.log(width);
        for (var i = 0; i < Qt.application.screens.length ; i++)
       {
            if (i !== currentScreen)
                height = height - Qt.application.screens[i].height;
        }
        mainAppliWindow.width = width;
        mainAppliWindow.height =  Screen.height*/

    }
        //console.log("mdlrp : "+ Qt.application.screens[0].desktopAvailableWidth + " "+ Qt.application.screens[0].width);

    Item{
        id:theme
        property var actualTheme : theme2

        property var mainTextColor : "black"
        property var mainBorderColor : mainTextColor
        property var mainLineColor : mainTextColor
        property var backgroundColor : "white"
        property var mainOpacity : 0

        property var appliBackgroundG1
        property var appliBackgroundG2

        Component.onCompleted: {
            mainTextColor = actualTheme.mainTextColor;
            mainBorderColor = actualTheme.mainBorderColor;
            mainLineColor = actualTheme.mainLineColor;
            backgroundColor = actualTheme.backgroundColor;

            mainOpacity = actualTheme.mainOpacity;

            appliBackgroundG1 = actualTheme.appliBackgroundG1
            appliBackgroundG2 = actualTheme.appliBackgroundG2

        }

        Item{
            id:theme1
            property var mainTextColor : "white"
            property var mainBorderColor : mainTextColor
            property var mainLineColor : mainTextColor
            property var backgroundColor : "black"
            property var mainOpacity: 1

            property var appliBackgroundG1 : "#7a7a7a"
            property var appliBackgroundG2 : "#212421"
        }

        Item{
            id:theme2
            property var mainTextColor : "black"
            property var mainBorderColor : mainTextColor
            property var mainLineColor : mainTextColor
            property var backgroundColor : "white"
            property var mainOpacity : 0.65

            property var appliBackgroundG1 : "#7a7a7a"
            property var appliBackgroundG2 : "#212421"
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
    /*
    NumberAnimation on width {
            from: 0
            to: Screen.width
            duration: 1000
            running: true
        }
    NumberAnimation on height {
            from: 0
            to: Screen.height
            duration: 1000
            running: true
        }
    */
    /*
    Image {
        id : image
        anchors.fill: parent
        source: "https://image.freepik.com/free-vector/abstract-realistic-technology-particle-background_23-2148433468.jpg"
        width: parent.width
        height : parent.height
    }
    */
    Execution {
            id:execution
            objectName: "execution"
            onSignalExit: mainAppliWindow.close()
    }

    Dialog {
            id: popup
            width: parent.width/4
            height: 200

            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            modal: true
            focus: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
            title: "Fermeture de session"
            Text {
                text : "Vous vous appretez à fermer votre session. Etes vous sur ?"
            }

            standardButtons: Dialog.Ok | Dialog.Cancel
            onAccepted: execution.disconnectScreen()
            //onRejected: console.log("Cancel clicked")
        }

    Item{
        id:rectA
        anchors.fill:parent

        Rectangle {
            anchors.fill:parent

            color : theme.backgroundColor
            gradient: Gradient {
                    GradientStop { position: 0.0; color: "white" }
                    GradientStop { position: 0.5; color: "#f8f8fb" }
                    GradientStop { position: 0.8; color: "#d1d1d4" }
                    GradientStop { position: 1.0; color: "#adacaf" }
                }
        }


   }
    DropShadow {
            anchors.fill: rectA
            cached:true
            horizontalOffset: 0
            verticalOffset: 0
            radius: 60
            samples: 32
            color: "red"
            smooth: true
            source: rectA
        }
    /*
    FastBlur {

        width: mainAppliWindow.width
        height : mainAppliWindow.height
        radius: 10
                opacity: 0.2
        source: ShaderEffectSource {
                    sourceItem: rectA
                    sourceRect: Qt.rect(0, 0, mainAppliWindow.width, mainAppliWindow.height)
                }
        }

*/
    Item {
        width: mainAppliWindow.width - 250
        height : mainAppliWindow.height - 50
        anchors.horizontalCenter: parent.horizontalCenter
        //Component.onCompleted: console.log("topLevelItem width: " + width)
    ColumnLayout
    {
        width : parent.width;
        height : parent.height;
        Item
        {
            id:title
            width : parent.width;
            height: 30 ;
            /*
            Text {

                anchors.centerIn : parent
                text: Date()
                font.family: "DeLaFuente.ttf"
            }
            */
        }


    Item{
        id:search
        width: parent.width
        Layout.alignment : Qt.AlignHCenter
        height:50
        Layout.topMargin : 50
        Layout.bottomMargin :60
        Item{
            width : parent.width*(1/4)
            //color:"blue"
            height :parent.height
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            RowLayout{
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter

               Item{
                    Layout.preferredHeight: parent.height
                    width:50
                    //color:"red"
                   Image {
                            id: iconSearchtext
                            smooth: true
                            fillMode: Image.PreserveAspectFit
                            asynchronous: true
                            source: "search.png"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            opacity:0.15
                            height: 30 //parent.height - platformStyle.paddingMedium * 2
                            width:30 //parent.height - platformStyle.paddingMedium * 2


                        }
                   ColorOverlay {
                           anchors.fill:iconSearchtext
                           source: iconSearchtext
                           color: theme.mainTextColor
                           opacity:0.15
                       }
               }
            Item{
                width: 300
                //color:"green"
                Layout.preferredHeight: parent.height
                TextField {
                    id: searchText
                    placeholderText: qsTr("Rechercher...")
                    color : theme.mainTextColor
                    opacity:0.3
                    font.pointSize: 30
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                    font.family: font3.name
                    property var timerUpdate : null;
                    background: Item {
                                        opacity: 0
                            }
                    /**/

                    onTextChanged: {
                        timerText.restart();
                    }
                    Timer {
                        id: timerText
                        interval: 150
                        repeat: false
                        onTriggered: {
                            console.log("ede");
                           tr.animations = animationN;
                          sortFilterModel.update()
                        }

                    }

                    /*
                    Image {
                             id: iconSearchtext
                             anchors { top: parent.top; left: parent.left; margins: platformStyle.paddingMedium }
                             smooth: true
                             fillMode: Image.PreserveAspectFit
                             source: "search.png"
                             height: 30 //parent.height - platformStyle.paddingMedium * 2
                             width:30 //parent.height - platformStyle.paddingMedium * 2
                         }
                     */


            }
            }

        }
        }

    }

    Item{
       // Layout.alignment: Qt.AlignBottom
        width: parent.width
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width
    RowLayout{
        width : parent.width
        height : parent.height-100
        anchors.horizontalCenter: parent.horizontalCenter

        Item {
            width : parent.width* (1/5)
            height : parent.height
            Layout.fillHeight: true
            Loader {
                id: categoriesLoader
                asynchronous: true
                anchors.fill: parent
                source : "Categories.qml"

            }
        }

   /**/
        Item {
            id: page
            objectName: "page"
            //width : parent.width -300
            width : parent.width* (3/5)
            //anchors.horizontalCenter: parent.horizontalCenter
            //anchors.verticalCenter: parent.verticalCenter
            Layout.fillHeight: true
            /*
            Loader {
                id: pageLoader
                asynchronous: true
                anchors.fill: parent
                source : "Apps.qml"
                focus: true;
                active: true;

            }
            */
                ColumnLayout{
                    anchors.fill:parent
                    spacing:40
                    Item{
                        id :nameApplications
                        width: parent.width -200
                        Layout.alignment : Qt.AlignHCenter
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
                            border.color: theme.mainBorderColor
                            opacity: 0.2
                        }
                        Item{
                            width: parent.width
                            anchors.top:parent.top
                            height:30

                            Text{
                                text : "Applications"
                                font.pointSize: 20
                                font.family: titleFont.name
                                anchors.left : parent.left
                                color : theme.mainTextColor
                            }
                        }

                    }
                    Rectangle{
                        width:parent.width-parent.width/6
                        Layout.alignment : Qt.AlignHCenter
                        Layout.fillHeight: true
                        color :"transparent" //color : "blue"
                        ListModel {
                              id: appModel
                          }
                        SortFilterModel {
                        id: sortFilterModel
                        model: myModel
                        property string actualCategorie : ""
                        modelCategories : modelCategorie

                        filterAcceptsItem: function(item) {
                            var itemName = item.name.toLowerCase();
                            var itemCategorie = item.categorie.toLowerCase();
                            var actualCategorie = (String)(sortFilterModel.actualCategorie).toLowerCase();
                            if (actualCategorie !== "" && itemCategorie !== actualCategorie)
                                return false;
                            var itemSearch = searchText.text.toLowerCase();
                            return itemName.includes(itemSearch) ;
                        }

                        lessThan: function(left, right) {
                                var leftVal = left.name.toLowerCase();
                                var rightVal = right.name.toLowerCase();
                            //return leftVal.localeCompare(rightVal);
                            return leftVal < rightVal ? -1 : 1;
                        }

                        updateCategorie: function(){
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

                        delegate:
                            //maingrid.state = "down";

                            Item {
                                Component.onCompleted: {
                                }

                            //width: parent.width/6; height:parent.width/6
                            width: maingrid.cellWidth
                            height: maingrid.cellHeight
                            //PropertyAnimation on x { from : -100 ; to: x; duration: 1000; loops: Animation.Infinite }
                            //PropertyAnimation on y { from : 100 ; to: y; duration: 1000; loops: Animation.Infinite }
                            Rectangle
                            {
                                   id : apps
                                   width: parent.width-parent.width/5; height: parent.height-parent.width/6
                                   clip:true
                                   color: "transparent"//"blue"
                                   state: "mouseOut"

                                   states: State {
                                               name: "mouseIn";
                                           }
                                           State {
                                           name: "mouseOn";

                                       }
                                           State {
                                           name: "pressed";}
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
                                              }},
                                       Transition {
                                           from: "*"
                                           to: "mouseIn"
                                           SequentialAnimation{
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
                                                   from:1
                                                   to: 0.95
                                                   duration: 400
                                               }
                                               loops: Animation.Infinite
                                           }
                                           }

                                   ]

                            Rectangle
                            {
                                id : backg
                                color : "transparent"
                                width: parent.width
                                height: parent.height
                                radius:20

                                RectangularGlow {
                                        id: effect
                                        anchors.fill: parent
                                        glowRadius: 10
                                        spread: 0.2
                                        color: "#61c2ff"
                                        cornerRadius:  30
                                        visible: false
                                    }
                                /*
                                LinearGradient {
                                    id:mask
                                    anchors.fill:parent

                                    start: Qt.point(0, 0)
                                    end: Qt.point(parent.width, 0)
                                    gradient: Gradient {
                                        GradientStop { position: 0.0; color: theme.appliBackgroundG1 }
                                        GradientStop { position: 1.0; color: theme.appliBackgroundG2 }
                                    }

                                    visible: false
                                }
                                OpacityMask {
                                        anchors.fill: parent
                                        source: parent
                                        maskSource: mask
                                    }
                                */
                            }
                            ColumnLayout{
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter : parent.verticalCenter
                                spacing : 8
                                Item{
                                    width: parent.parent.width/2
                                    height: parent.parent.width/2
                                    Image {
                                        id: myIcon
                                        asynchronous: true
                                        width: parent.width
                                        height: parent.width
                                        source: icon
                                    }
                                }
                                Item{

                                    Layout.fillWidth: true
                                    height:20
                                    Text {
                                        FontLoader {
                                            id: appliFont
                                            source: "SFCompactText-Medium.ttf"
                                        }
                                        text: name
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.family: appliFont.name
                                         fontSizeMode: Text.Fit
                                        horizontalAlignment: Text.AlignHCenter
                                        color : theme.mainTextColor
                                    }
                                }


                             }

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor

                                onClicked: {
                                    backg.color = "lightsteelblue"
                                    backg.opacity = 0.1
                                    parent.state ="pressed"
                                    if(mouse.button === Qt.LeftButton) {

                                        //console.log("Double Click");
                                        execution.launch(src);
                                    }
                                }

                                hoverEnabled: true;
                                onEntered: {
                                   parent.state = "mouseIn"
                                   //backg.color = theme.mainBorderColor //"a9a9a9" //"lightsteelblue"
                                    backg.visible = true
                                    effect.visible = true
                                   backg.opacity = 0.2
                                }
                                onExited: {
                                    parent.state ="mouseOut"
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
                                    Item{
                                        width:parent.width -100
                                        height: parent.width - 300
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        anchors.top: parent.top

                                        ScrollView {
                                                id:scrollV
                                                anchors.fill:parent
                                                contentHeight: (maingrid.childrenRect.height > parent.height) ?maingrid.childrenRect.height : parent.height

                                                ScrollBar.vertical: ScrollBar {
                                                    id: scrollBar
                                                    parent: scrollV.parent
                                                    policy: ScrollBar.AlwaysOn
                                                    height: scrollV.availableHeight
                                                    x: scrollV.mirrored ? 0 : scrollV.width - width
                                                    y: scrollV.topPadding
                                                    active:false
                                                    snapMode : ScrollBar.SnapAlways
                                                    visible: scrollV.contentHeight > scrollV.height ? true : false
                                                    //stepSize: 0.5
                                                    //active: scrollV.ScrollBar.horizontal.active
                                                    contentItem: Rectangle {
                                                        implicitWidth: 6
                                                        implicitHeight: 100
                                                        opacity:0.05
                                                        radius: width/2
                                                        color: scrollBar.pressed ? "#0092CC" : theme.mainBorderColor
                                                    }


                                                }

                                                //contentHeight: maingrid.height
                                                //contentWidth: width
                                                clip: true
                                                MouseArea{
                                                     onWheel: {
                                                    if(wheel.angleDelta.y > 0){
                                                      scroller.decrease()
                                                    }else{
                                                      scroller.increase()
                                                    }
                                                     }
                                                }
                                        GridView {
                                            id:maingrid
                                            //width: parent.width-100
                                            //height: parent.width-100
                                            anchors.fill: parent
                                            //anchors.horizontalCenter: parent.horizontalCenter
                                            //anchors.verticalCenter: parent.verticalCenter

                                            property bool first : true
                                            property var cellSize : width/6

                                            Component.onCompleted: {
                                                cellSize = width/6
                                                for (var i=0;cellSize < 150;i++)
                                                {
                                                    cellSize = width/(6-i)
                                                }
                                            }

                                           cellWidth: cellSize; cellHeight: cellSize

                                           focus: true
                                           state : "deb"
                                           opacity : 1
                                           property int viewIndex: 0
                                           model: sortFilterModel

                                           //highlight: Rectangle { width: 80; height: 80; color: "lightsteelblue" }
                                            interactive : false
                                            states: State {
                                                        name: "down";
                                                    }
                                                    State {
                                                    name: "debut";
                                                }
                                            add :
                                                Transition {
                                                id :tr
                                                enabled : true
                                                SequentialAnimation {
                                                    id :animationX
                                                    /*
                                                          ParallelAnimation {
                                                              NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 1000 }
                                                              ScaleAnimator{from: 0; to: 1.0; duration: 1000;easing.type: Easing.OutBounce}
                                                              NumberAnimation { property: "y"; from: tr.ViewTransition.destination.y-1000; to: tr.ViewTransition.destination.y; duration: 700;easing.type: Easing.OutBounce }
                                                          }
                                                          /**/
                                                          ///*
                                                            ParallelAnimation {
                                                           NumberAnimation {
                                                               property: "opacity"; from:0; to: 1 ; duration :2000;
                                                           }
                                                           //NumberAnimation { properties: "maingrid.width"; to : parent.width; duration: 500; easing.type: Easing.OutBounce }
                                                           //NumberAnimation { properties: "x,y"; duration: 100; easing.type: Easing.OutBounce}
                                                            }
                                                           /**/
                                                          }
                                                /**/
                                                }
                                            }
                                        }

                                        //NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 300 }
                                        //NumberAnimation { property: "x";  from : -1000; to : x;  duration: 5000 }
                                        //NumberAnimation { property: "y";  from : -1000; to : y;  duration: 5000 }
                                        //PropertyAnimation on y { from : 0 ; to: y; duration: 1000; loops: Animation.Infinite }
                                        //NumberAnimation { property: "scale"; easing.type: Easing.OutBounce; from: 0; to: 1.0; duration: 400 } /**/
                                    }
                                    ParallelAnimation {
                                        id : animationN;
                                        NumberAnimation { property: "scale"; easing.type: Easing.OutBounce; from: 0; to: 1.0; duration: 400 }
                                        NumberAnimation {  property: "opacity"; from: 0; to: 1.0; duration: 300 }
                                    }
            /*
                MouseArea {
                    anchors.fill:scrollV
                    hoverEnabled: true
                    onWheel: {
                        if (wheel.angleDelta.y > 0) {
                            scrollV.visualPosition -= scrollV.scrollSpeed;
                            if (scrollV.visualPosition < 0) {
                                scrollV.visualPosition = 0;
                            }
                        } else {
                            scrollV.visualPosition += scrollV.scrollSpeed;
                            if (scrollV.visualPosition + scrollV.maingrid.width > scrollV.maingrid.contentWidth) {
                                scrollV.visualPosition = scrollV.maingrid.contentWidth -  scrollV.maingrid.width;
                            }
                        }
                    }
                    onClicked: mouse.accepted = false;
                       onPressed: mouse.accepted = false;
                       onReleased: mouse.accepted = false;
                       onDoubleClicked: mouse.accepted = false;
                       onPositionChanged: mouse.accepted = false;
                       onPressAndHold: mouse.accepted = false;
                }
                */
            }}

        }
    Item {
        width : parent.width* (1/5)
        Layout.fillHeight: true
        ColumnLayout{
            width:parent.width
            spacing:parent.height/10


        Item {
            width:parent.width
            height: 200

            ColumnLayout{
                width:parent.width
                height:parent.height
                spacing:2

            Item{
                width: parent.width/2
                height: parent.width/2
                id:timeItem
                Layout.alignment : Qt.AlignHCenter | Qt.AlignVCenter
                opacity:1
                property bool started : false
                SequentialAnimation{
                    id:animationStartCircle
                    ParallelAnimation{

                        NumberAnimation {target: circleTime; property: "arcBegin"; from: 360; to: timeTimer.arcDest ; duration: 1500 }
                        NumberAnimation {target: timeText; property: "opacity"; from: 0; to: 0.7; duration: 1000 }
                       // ScriptAction { script:{ timerAnimationText.start()}} }

                    }
                /*
                Timer {
                    id: timerAnimationText
                    property var data : 0;
                        interval: 1
                        repeat: true
                        onTriggered: {
                            data+=10000;
                            time.text = msToTime(data);
                            if (data >=timeTimer.timeDataStart)
                             this.destroy();
                    }
                        function msToTime(duration) {
                          var milliseconds = parseInt((duration % 1000) / 100),
                            seconds = Math.floor((duration / 1000) % 60),
                            minutes = Math.floor((duration / (1000 * 60)) % 60),
                            hours = Math.floor((duration / (1000 * 60 * 60)) % 24);

                          hours = (hours < 10) ? "0" + hours : hours;
                          minutes = (minutes < 10) ? "0" + minutes : minutes;
                          seconds = (seconds < 10) ? "0" + seconds : seconds;

                          return hours + ":" + minutes + ":" + seconds; //+ "." + milliseconds;
                        }

                /**/
                }
                ProgressCircle {
                        id:circleTime
                        size: parent.width
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        colorCircle: "#0092CC" // "#00BFFF" //
                        colorBackground: "#E6E6E6"
                        arcBegin: 360
                        arcEnd: 360
                        lineWidth: 10
                        /*
                        states: State {
                                    name: "start";
                                }
                       transitions: [
                            Transition { from: "*"; to: "*"; NumberAnimation {  property: "opacity"; from: 0; to: 1.0; duration: 10000 } }
                        ]
                        */
                    }
                FontLoader {
                    id: hourFont
                    source: "digital-7.ttf"
                }
                Timer {
                    id:timeTimer
                    property date timeToBeConsumed : new Date(new Date().getTime()+300000);
                    property date timeDataStart : new Date(new Date().getTime()+300000);
                    property var arcDest : 0;
                    property var milliS : (new Date()).getTime();
                    interval: 500; running: true; repeat: true

                    onTriggered:{
                        timeToBeConsumed = new Date(timeToBeConsumed.getTime()-500);
                        time.text = msToTime(timeToBeConsumed.getTime()-milliS);
                        arcDest = -((((timeToBeConsumed.getTime()-milliS)*360)/(timeDataStart.getTime()-milliS))-360);
                        if(!timeItem.started)
                        {
                            animationStartCircle.start();
                            timeItem.started = true;
                            timeTimer.interval = 500
                            return;
                        }
                        if (animationStartCircle.running)
                            return;

                        circleTime.arcBegin = arcDest
                        if (arcDest > 324)
                        {
                            circleTime.colorCircle = "red";
                            circleTime.animate = true;

                            if(arcDest >360)
                                execution.quit();
                        }
                        else
                        {
                             circleTime.colorCircle = "#0092CC";
                        }



                    }


                    function msToTime(duration) {
                      var milliseconds = parseInt((duration % 1000) / 100),
                        seconds = Math.floor((duration / 1000) % 60),
                        minutes = Math.floor((duration / (1000 * 60)) % 60),
                        hours = Math.floor((duration / (1000 * 60 * 60)) % 24);

                      hours = (hours < 10) ? "0" + hours : hours;
                      minutes = (minutes < 10) ? "0" + minutes : minutes;
                      seconds = (seconds < 10) ? "0" + seconds : seconds;

                      return hours + ":" + minutes + ":" + seconds; //+ "." + milliseconds;
                    }

                }
               Rectangle
               {

                   width:parent.width
                   height:parent.height
                   color:"transparent"
                   //height: parent.height/3
                   anchors.horizontalCenter: parent.horizontalCenter
                   anchors.verticalCenter: parent.verticalCenter
                   Text
                   {
                       id: time

                       width:parent.width
                       height : 30
                       anchors.horizontalCenter: parent.horizontalCenter
                       anchors.verticalCenter: parent.verticalCenter
                       anchors.centerIn: parent
                       horizontalAlignment: TextInput.AlignHCenter
                       fontSizeMode: Text.Fit;
                       font.pointSize: 1000
                       font.family : hourFont.name
                       color : theme.mainTextColor
                       text: "00:00:00"
                   }

                }

                Text
                {
                    id: timeText
                    width:parent.width/3
                    height : parent.height/20
                    font.bold: true

                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: TextInput.AlignHCenter

                    fontSizeMode: Text.Fit;
                    font.pointSize: 1000
                    color : "#0092CC"
                    opacity:0
                    text: "Temps restant"
                    font.family:font2.name
                    anchors.top: circleTime.top
                    anchors.topMargin: parent.height/6
                }
            }
            }

        }
        Item{
            width: parent.width
            Layout.fillHeight: true
            Rectangle{
                width:parent.width-20
                height:parent.height
                anchors.centerIn: parent
                color :"transparent"
                ColumnLayout
                {
                    width:parent.width
                    Item{
                        Layout.fillWidth: true
                        height:100
                        opacity:0.8
                        ColumnLayout{
                            anchors.fill:parent
                            Item{
                                Layout.fillWidth: true
                                height:50
                                clip:true

                                Rectangle {
                                    anchors.fill: parent
                                    anchors.rightMargin: -border.width
                                    anchors.topMargin:  -border.width
                                    anchors.leftMargin: -border.width
                                    border.width: 2
                                    color : "transparent"
                                    border.color: theme.mainBorderColor
                                    opacity:0.2
                                }
                                RowLayout
                                {
                                    anchors.fill:parent
                                    Item{
                                        width:50
                                        Layout.fillHeight: true
                                        Rectangle
                                        {
                                            anchors.fill:parent
                                            radius: 2
                                            opacity:0.3
                                            color : "transparent"
                                        }

                                        Item{
                                            width:parent.width-20
                                            height:parent.width-20
                                            anchors.horizontalCenter : parent.horizontalCenter
                                            anchors.verticalCenter: parent.verticalCenter
                                            opacity:0.4
                                            Image {
                                                id : workspaceImage
                                                asynchronous: true
                                                source: "icon_espacetravial.png"
                                                anchors.fill:parent
                                               Layout.preferredHeight: parent.width//parent.height - platformStyle.paddingMedium * 2
                                                Layout.preferredWidth: parent.height //parent.height - platformStyle.paddingMedium * 2

                                            }
                                            ColorOverlay {
                                                    anchors.fill:  workspaceImage
                                                    source:  workspaceImage
                                                    color: theme.mainTextColor
                                                }
                                        }

                                    }
                                    Item{
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true

                                        Text
                                        {
                                            anchors.left:parent.left
                                            anchors.verticalCenter: parent.verticalCenter
                                            font.pointSize: 15
                                            opacity:0.9
                                            font.family : font3.name
                                            text: "Espace de travail"
                                            color : theme.mainTextColor
                                        }
                                    }

                                }
                            }
                            Item{
                                Layout.fillWidth: parent.width
                                height:50

                                Text
                                {
                                    font.pointSize: 15
                                    opacity:0.7
                                    font.family : font1.name
                                    text: "Config3"
                                    color : theme.mainTextColor
                                }
                            }
                        }

                    }

                    Item{
                        Layout.fillWidth: true
                        height:100
                        opacity:0.8
                        ColumnLayout{
                            anchors.fill:parent
                            Item{
                                Layout.fillWidth: true
                                height:50
                                clip:true

                                Rectangle {
                                    anchors.fill: parent
                                    anchors.rightMargin: -border.width
                                    anchors.topMargin:  -border.width
                                    anchors.leftMargin: -border.width
                                    border.width: 2
                                    color : "transparent"
                                    border.color: theme.mainBorderColor
                                    opacity:0.2
                                }
                                RowLayout
                                {
                                    anchors.fill:parent
                                    Item{
                                        width:50
                                        Layout.fillHeight: true
                                        Rectangle
                                        {
                                            anchors.fill:parent
                                            radius: 2
                                            opacity:0.3
                                            color : "transparent"
                                        }

                                        Item{
                                            width:parent.width-20
                                            height:parent.width-20
                                            anchors.horizontalCenter : parent.horizontalCenter
                                            anchors.verticalCenter: parent.verticalCenter
                                            opacity:0.5
                                            Image {
                                                id: userImage
                                                asynchronous: true
                                                source: "user.png"
                                                anchors.fill:parent
                                               Layout.preferredHeight: parent.width//parent.height - platformStyle.paddingMedium * 2
                                                Layout.preferredWidth: parent.height //parent.height - platformStyle.paddingMedium * 2

                                            }
                                            ColorOverlay {
                                                    anchors.fill: userImage
                                                    source: userImage
                                                    color: theme.mainTextColor
                                                }
                                        }

                                    }
                                    Item{
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                        Rectangle
                                        {
                                            anchors.fill:parent
                                            radius: 2
                                            opacity:0.3
                                            color : "transparent"
                                        }

                                        Text
                                        {
                                            anchors.left:parent.left
                                            anchors.verticalCenter: parent.verticalCenter
                                            font.pointSize: 15
                                            opacity:0.9
                                            font.family : font3.name
                                            text: "Utilisateur"
                                            color : theme.mainTextColor
                                        }
                                    }

                                }
                            }
                            Item{
                                Layout.fillWidth: true
                                height:50
                                Text
                                {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pointSize: 15
                                    opacity:0.7
                                    font.family : font1.name
                                    text: "User-923"
                                    color : theme.mainTextColor
                                }
                            }
                        }

                    }
                    Item{
                        Layout.fillWidth: true
                        height:100
                        opacity:0.8
                        ColumnLayout{
                            anchors.fill:parent
                            Item{
                                Layout.fillWidth: true
                                height:50
                                clip:true

                                Rectangle {
                                    anchors.fill: parent
                                    anchors.rightMargin: -border.width
                                    anchors.topMargin:  -border.width
                                    anchors.leftMargin: -border.width
                                    border.width: 2
                                    color : "transparent"
                                    border.color: theme.mainBorderColor
                                    opacity:0.2
                                }
                                RowLayout
                                {
                                    anchors.fill:parent
                                    Item{
                                        width:50
                                        Layout.fillHeight: true
                                        Rectangle
                                        {
                                            anchors.fill:parent
                                            radius: 2
                                            opacity:0.3
                                            color : "transparent"
                                        }

                                        Item{
                                            width:parent.width-20
                                            height:parent.width-20
                                            anchors.horizontalCenter : parent.horizontalCenter
                                            anchors.verticalCenter: parent.verticalCenter
                                            opacity:0.4
                                            Image {
                                                id: computerImage
                                                source: "pc.png"
                                                asynchronous: true
                                                anchors.fill:parent
                                               Layout.preferredHeight: parent.width//parent.height - platformStyle.paddingMedium * 2
                                                Layout.preferredWidth: parent.height //parent.height - platformStyle.paddingMedium * 2

                                            }
                                            ColorOverlay {
                                                    anchors.fill: computerImage
                                                    source: computerImage
                                                    color: theme.mainTextColor
                                                }
                                        }

                                    }
                                    Item{
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                        Rectangle
                                        {
                                            anchors.fill:parent
                                            radius: 2
                                            opacity:0.3
                                            color : "transparent"
                                        }

                                        Text
                                        {
                                            anchors.left:parent.left
                                            anchors.verticalCenter: parent.verticalCenter
                                            font.pointSize: 15
                                            opacity:0.9
                                            font.family : font3.name
                                            text: "Ordinateur"
                                            color : theme.mainTextColor
                                        }
                                    }

                                }
                            }
                            Item{
                                Layout.fillWidth: true
                                height:50
                                Text
                                {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pointSize: 15
                                    opacity:0.7
                                    font.family : font1.name
                                    text: "Machine-1924"
                                    color : theme.mainTextColor
                                }
                            }
                        }

                    }
                    Item{
                        Layout.fillWidth: true
                        height:100
                        opacity:0.8
                        ColumnLayout{
                            anchors.fill:parent
                            Item{
                                Layout.fillWidth: true
                                height:50
                                clip:true

                                Rectangle {
                                    anchors.fill: parent
                                    anchors.rightMargin: -border.width
                                    anchors.topMargin:  -border.width
                                    anchors.leftMargin: -border.width
                                    border.width: 2
                                    color : "transparent"
                                    border.color: theme.mainBorderColor
                                    opacity:0.2
                                }
                                RowLayout
                                {
                                    anchors.fill:parent
                                    Item{
                                        width:50
                                        Layout.fillHeight: true
                                        Rectangle
                                        {
                                            anchors.fill:parent
                                            radius: 2
                                            opacity:0.3
                                            color : "transparent"
                                        }

                                        Item{
                                            width:parent.width-20
                                            height:parent.width-20
                                            anchors.horizontalCenter : parent.horizontalCenter
                                            anchors.verticalCenter: parent.verticalCenter
                                            opacity:0.4
                                            Image {
                                                id : groupImage
                                                source: "icon_group.png"
                                                asynchronous: true
                                                anchors.fill:parent
                                               Layout.preferredHeight: parent.width//parent.height - platformStyle.paddingMedium * 2
                                                Layout.preferredWidth: parent.height //parent.height - platformStyle.paddingMedium * 2

                                            }
                                            ColorOverlay {
                                                    anchors.fill:  groupImage
                                                    source:  groupImage
                                                    color: theme.mainTextColor
                                                }
                                        }

                                    }
                                    Item{
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                        Rectangle
                                        {
                                            anchors.fill:parent
                                            border.color: "white"
                                            border.width: 1
                                            radius: 2
                                            opacity:0.3
                                            color : "transparent"
                                        }

                                        Text
                                        {
                                            anchors.left:parent.left
                                            anchors.verticalCenter: parent.verticalCenter
                                            font.pointSize: 15
                                            opacity:0.9
                                            font.family : font3.name
                                            text: "Groupe"
                                            color : theme.mainTextColor
                                        }
                                    }

                                }
                            }
                            Item{
                                Layout.fillWidth: true
                                height:50
                                Text
                                {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pointSize: 15
                                    opacity:0.7
                                    font.family : font1.name
                                    text: "G-923"
                                    color : theme.mainTextColor
                                }
                            }
                        }

                    }
                }

            }
        }
    }
    }
    }}
    }
}
}

