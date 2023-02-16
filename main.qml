import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12


Window {
    id: window


    visible: true//可视化属性
    width: Screen.width !== 1024 ? 1024 :Screen.width * DevicePixelRatio//根据屏幕宽度设置，默认1024
    height: Screen.height !== 600 ? 600 : Screen.height * DevicePixelRatio//根据屏幕高度设置，默认600

    title: qsTr("my_debug_tool")


    Image {
        id: image
        anchors.fill: parent
        fillMode: Image.Stretch
        source: "images/bg_deepin.png"



    }

    SwipeView {
        id: app_list
        x: 244
        y: 117
        width: parent.width/3
        height: parent.height/2
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: width/6






        Button {
            id: termnial_load
            text: qsTr("")

            background: Rectangle {

                color: "#ffffff"
                radius: width*0.1
                opacity: 0.6
            }

        onClicked: {
        myLoader.source= "qrc:/app/app_terminal.qml"
        }

            Text {
                id: element2
                x: 133
                y: 248
                text: qsTr("APP1")
                anchors.bottomMargin: 10
                font.pixelSize: 30
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Image {
                id: image2
                x: 63
                y: 38
                width: 200
                height: 200
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                opacity: 1
                source: "images/ioc_terminal.png"
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Button {
            id: button3
            text: qsTr("")
            background: Rectangle {

                color: "#ffffff"
                radius: width*0.1
                opacity: 0.6
            }

            Text {
                id: element1
                x: 133
                y: 248
                text: qsTr("APP2")
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 30

                Image {
                    id: image1
                    x: 68
                    y: 52
                    width: 200
                    height: 200
                    opacity: 1
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    fillMode: Image.PreserveAspectFit
                    source: "images/ioc_terminal.png"
                }
            }
        }





    }

    Rectangle {
        id: rectangle3
        x: 0
        y: 570
        height: 30
        color: "#80000000"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0

        PageIndicator {
            id: pageIndicator
            x: 441
            y: 2
            width: 40
            height: 20
            anchors.horizontalCenter: parent.horizontalCenter
            padding: 0
            font.bold: true
            font.pointSize: 8
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            count: app_list.count
            currentIndex:app_list.currentIndex

            delegate: Rectangle {
                implicitWidth: 8
                implicitHeight: 8

                radius: width / 2
                border.width: 2
                border.color: "#ffffff"
                color: "#3758ff"



                opacity: index === pageIndicator.currentIndex ? 0.95 : pressed ? 0.7 : 0.45

                //                required property int index

                Behavior on opacity {
                    OpacityAnimator {
                        duration: 100
                    }
                }

            }

        }
    }

    Button {
        id: btn_prev
        x: 10
        y: 270
        width: parent.height/5
        height: parent.height/5
        text: qsTr("<")
        font.bold: true
        font.pointSize: 30
        flat: false
        checkable: false
        checked: false
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        background: Rectangle{
            color: "#ffffff"
            opacity: 0.6
            radius: 5
        }
        onClicked: {
            if( app_list.currentIndex>0)
                app_list.setCurrentIndex(app_list.currentIndex-1);;
        }

    }

    Button {
        id: btn_next
        x: 912
        y: 270
        width: parent.height/5
        height: parent.height/5
        text: qsTr(">")
        font.bold: true
        font.pointSize: 30
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        background: Rectangle{
            color: "#ffffff"
            opacity: 0.6
            radius: 5
        }
        onClicked: {
            if( app_list.currentIndex<app_list.count)
                app_list.setCurrentIndex(app_list.currentIndex+1);
        }
    }








    //窗口标题：我的开源调试应用




    Loader{
        id:myLoader
        // 1. Loader加载不同组件，实现切换页面的功能
        anchors.centerIn: parent // 弹出的界面都居中显示
        anchors.fill: parent
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}D{i:17;anchors_x:27}D{i:16;anchors_x:27}
}
##^##*/
