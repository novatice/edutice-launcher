import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtQml.Models 2.3
import Eexecution 1.0


ApplicationWindow {
    visible: true
    width: Screen.width
    height: Screen.height
    flags: Qt.Window | Qt.FramelessWindowHint
    visibility: Window.FullScreen
    color : "#f4f4f4"

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
    }
    ColumnLayout
    {
        width: Screen.width
        height : Screen.height
        Rectangle
        {
            width : parent.width;
            height: childrenRect.height +20 ;
            Text {

                anchors.centerIn : parent
                text: "Applications"
            }
        }


    ToolBar {
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        height:150
        Layout.topMargin : 60
        Layout.bottomMargin :300

        /*
        signal doSearch(string search_name)
        signal searchTextChanged(string searchText)
        signal showCategories()
        signal goBack()
        signal showMap()

        onSearchTextChanged: {
            console.log("d");
        }

        onSearchBarVisbileChanged: {
            searchBar.opacity = searchBarVisbile ? 1 : 0
            backBar.opacity = searchBarVisbile ? 0 : 1
        }
        onDoSearch: {
        }

        function showSearch(text) {
            if (text !== null) {
                searchText.ignoreTextChange = true
                searchText.text = text
                searchText.ignoreTextChange = false
            }
        }
        RowLayout {
            id: searchBar
            width: parent.width
            height: parent.height
            Behavior on opacity { NumberAnimation{} }
            visible: opacity ? true : false

        */
            TextField {
                id: searchText
                width : Screen.width*(1/3)
                anchors.horizontalCenter: parent.horizontalCenter
                Behavior on opacity { NumberAnimation{} }
                property bool ignoreTextChange: false
                placeholderText: qsTr("Rechercher...")
                Layout.fillWidth: true
                onTextChanged: {
                    if (!ignoreTextChange)
                        sortFilterModel.update()
                }
                Rectangle{
                    height: parent.height-10
                    width : 20

                    anchors { left: (parent.left); verticalCenter: parent.verticalCenter }
                    Image {
                        id: iconSearchtext
                        height: parent.height-10
                        anchors { verticalCenter: parent.verticalCenter }
                        width : 20
                        source: "search.png"
                    }
                }


            /*
            ToolButton {
                id: searchButton
                onClicked: //doSearch(searchText.text)
                {

                    execution.addRow();
                    /*
                    var search_name = "Contacts" //searchText.text;
                    console.log(maingrid.model.count);
                    for(var i = 0; i < maingrid.model.count; i++)
                    {
                        var a = maingrid.model.get(i);
                        console.log(i);
                        console.log(a.name);
                        if (a.name === search_name)
                        {
                            console.log("bon");
                            //maingrid.childAt(i).visible = true;
                             a.visible =  true;
                        }
                        else
                        {
                            console.log("false");
                            maingrid.model.remove(i);
                            i--;
                        }

                    }
                      return null
                }
            }
            ToolButton {
                id: categoryButton
            }
            */
        }
        /*
        RowLayout {
            id: backBar
            width: parent.width
            height: parent.height
            opacity: 0
            Behavior on opacity { NumberAnimation{} }
            visible: opacity ? true : false
            ToolButton {
                id: backButton
                onClicked: goBack()
            }
            ToolButton {
                id: mapButton
                onClicked: showMap()
            }
            Item {
                 Layout.fillWidth: true
            }
        }
        */
    }
    Rectangle {
        id: page
        objectName: "page"
        width : parent.width -300
        anchors.centerIn: parent
        Layout.fillHeight: true
        color : "transparent"
        ListModel {
              id: appModel
          }
        SortFilterModel {
                id: sortFilterModel
                model: myModel

                filterAcceptsItem: function(item) {
                    var itemName = item.name.toLowerCase();
                    var itemSearch = searchText.text.toLowerCase();
                    return itemName.includes(itemSearch);
                }

                lessThan: function(left, right) {
                        var leftVal = left.name.toLowerCase();
                        var rightVal = right.name.toLowerCase();

                    console.log(leftVal.localeCompare(rightVal));
                    return leftVal.localeCompare(rightVal);
                    //return leftVal <rightVal ? -1 : 1;
                }
                delegate: Item {
                    width: maingrid.cellWidth; height: maingrid.cellHeight

                    Rectangle
                    {
                        id : backg
                        color : "transparent"
                        width: parent.width
                        height: parent.height
                    }
                        Image {
                            id: myIcon
                            width: parent.width/2
                            height: parent.width/2
                            y: 20;
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            source: icon
                        }

                        Text {
                            anchors { bottom: (parent.bottom); horizontalCenter: parent.horizontalCenter }

                            text: name
                        }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: { parent.GridView.view.currentIndex = index;
                        }
                        hoverEnabled: true;
                        onEntered: {
                            console.log("l"+src);
                           backg.color = "lightsteelblue"
                        }

                        onExited: {
                            console.log("l2"+src);
                            backg.color = "transparent"
                        }
                        onDoubleClicked: {

                            if(mouse.button === Qt.LeftButton) {

                                console.log("Double Click");
                                execution.launch(src);
                            }
                        }
                    }
                }
            }

        GridView {
            id:maingrid
            anchors.fill: parent

               cellWidth: 150; cellHeight: 150
               focus: true
               model : sortFilterModel

               //highlight: Rectangle { width: 80; height: 80; color: "lightsteelblue" }
                interactive : false

               onWidthChanged: {
                       }
           }
    }
    }
}
