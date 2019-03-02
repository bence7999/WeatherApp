import QtQuick 2.9
import "CommonData.js" as Data

Item {
    id: root

    anchors.fill: parent

    // Auto update weather state
    property bool updateState: true

    // Properties for Date and TimeTimer
    property date currentDate: new Date()
    property string dateTimeString

    Component.onCompleted: {
        // Load the list into the screen
        for(var i = 0; i < Data.list_location.length; i+=2){
            id_leftLocation.append({ "name": Data.list_location[i], "index": i })
            id_rightLocation.append({ "name": Data.list_location[i+1], "index": i+2 })
        }
    }

    // Global Tieme to update weather and Date
    Timer {
        interval: 2000
        repeat: true
        running: true
        onTriggered: {
            currentDate = new Date()
            dateTimeString = currentDate.toLocaleDateString() + "\n" + currentDate.getHours() + ":" + currentDate.getMinutes()
        }
    }

    // Backraound
    Rectangle {
        anchors.fill: parent


        gradient: Gradient {
            GradientStop { position: 0.0; color: "#E8F5E9" }
            GradientStop { position: 0.1; color: "#C8E6C9" }
            GradientStop { position: 0.2; color: "#A5D6A7" }
            GradientStop { position: 0.3; color: "#81C784" }
            GradientStop { position: 0.4; color: "#66BB6A" }
            GradientStop { position: 0.5; color: "#4CAF50" }
            GradientStop { position: 0.6; color: "#43A047" }
            GradientStop { position: 0.7; color: "#388E3C" }
            GradientStop { position: 0.8; color: "#2E7D32" }
            GradientStop { position: 0.9; color: "#1B5E20" }
            GradientStop { position: 1.0; color: "#B9F6CA" }
        }
    }

    // Top area
    Rectangle {
        id: topArea
        anchors {
            top: root.top
            left: root.left
            right: root.right
        }
        height: root.height * 0.15
        color: "transparent"

        Text {
            anchors.centerIn: parent
            text: "Weather Information"
            font.pixelSize: root.height * 0.06
            font.bold: true
        }

        Text {
            anchors {
                top: parent.top
                right: parent.right
            }
            text: dateTimeString
            font.pixelSize: root.height * 0.05
        }
    }

    // Bottom Area
    Rectangle {
        id: bottomArea
        anchors {
            left: root.left
            right: root.right
            bottom: root.bottom
        }
        height: root.height * 0.1
        color: "transparent"

        Image {
            anchors {
                right: parent.right
                bottom: parent.bottom
                top: parent.top
            }
            fillMode: Image.PreserveAspectFit
            source: 'http://poweredby.yahoo.com/purple.png'
        }
    }

    // List of location on left
    ListModel {
        id: id_leftLocation
    }

    // List of location on right
    ListModel {
        id: id_rightLocation
    }

    // Display items on left
    Component {
        id: id_leftDelegate

        Item {
            height: id_container.height / (Data.list_location / 2)
            width: root.width / 2

            property int isUpdate: root.updateState

            Rectangle {
                anchors {
                    right: parent.right
                    rightMargin: parent.width * 0.05
                    top: parent.top
                    topMargin: parent.height * 0.1
                    bottom: parent.bottom
                    bottomMargin: parent.height * 0.1
                }
                width: parent.width * 0.6

                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#FFF59D" }
                    GradientStop { position: 0.0; color: "#FFEE58" }
                    GradientStop { position: 0.0; color: "#FDD835" }
                    GradientStop { position: 0.0; color: "#F9A825" }
                }

                // Name of location
                Text {
                    anchors.centerIn: parent
                    text: name
                    font.pixelSize: root.height * 0.05
                }
            }

            Image {
                id: id_leftState
                source: "images/3200.png"
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                width: parent.width * 0.3
                fillMode: Image.PreserveAspectFit
            }

            // Changes images when weather state changes
            onIsUpdateChanged: {
                id_leftState.source = "images/" + codeList[index] + ".png"
            }
        }
    }

    // Display items on right
    Component {
        id: id_rightDelegate

        Item {
            height: id_container.height / (Data.list_location.lenght / 2)
            width: root.width / 2

            property int isUpdate: root.updateState

            Rectangle {
                anchors {
                    left: parent.left
                    rightMargin: parent.width * 0.05
                    top: parent.top
                    topMargin: parent.height * 0.1
                    bottom: parent.bottom
                    bottomMargin: parent.height * 0.1
                }
                width: parent.width * 0.6

                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#FFF59D" }
                    GradientStop { position: 0.0; color: "#FFEE58" }
                    GradientStop { position: 0.0; color: "#FDD835" }
                    GradientStop { position: 0.0; color: "#F9A825" }
                }

                // Name of location
                Text {
                    anchors.centerIn: parent
                    text: name
                    font.pixelSize: root.height * 0.05
                }
            }

            // Weather state of location
            Image {
                id: id_leftState
                source: "images/3200.png"
                anchors {
                    left: parent.right
                    top: parent.top
                    bottom: parent.bottom
                }
                width: parent.width * 0.3
                fillMode: Image.PreserveAspectFit
            }

            // Changes images when weather state changes
            onIsUpdateChanged: {
                id_leftState.source = "images/" + codeList[index] + ".png"
            }
        }
    }

    // Container to store left and right list
    Flickable {
        id: id_container
        anchors {
            left: root.left
            top: topArea.bottom
            right: root.right
            bottom: bottomArea.top
        }

        // 2 columns in 1 row
        Row {
            anchors.fill: parent
            Column {
                Repeater {
                    model: id_leftLocation
                    delegate: id_leftDelegate
                }
            }

            Column {
                Repeater {
                    model: id_rightLocation
                    delegate: id_rightDelegate
                }
            }
        }
    }
}
