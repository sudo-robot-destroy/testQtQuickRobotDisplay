import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 1200
    height: 720
    visible: true
    title: qsTr("Robot Model")
    Loader {
        id: mainscreen
        source: "MainScreen.qml"
        anchors.fill: parent
    }

//    MainScreen {
//        anchors.fill: parent
//    }
}
