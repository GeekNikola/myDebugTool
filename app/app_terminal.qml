import QtQuick 2.0
import QtQuick.Dialogs 1.0
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.0

import QtQuick.Layouts 1.3

Item {

    id: termnial

    width: Screen.width !== 1024 ? 1024 :Screen.width * DevicePixelRatio//根据屏幕宽度设置，默认1024
    height: Screen.height !== 600 ? 600 : Screen.height * DevicePixelRatio//根据屏幕高度设置，默认600


    Rectangle {
        id: rectangle2
        anchors.fill: parent
        color: "#fafaff"
        //        radius: width*0.1
        //        opacity: 0.6


        Rectangle {
            id: title_block
            x: 0
            height: parent.height*0.1

            LinearGradient {            ///--[Mark]
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(width, 0)        ///1、横向渐变
                //        end: Qt.point(0, height)     ///2、竖向渐变
                //        end: Qt.point(width, height) ///3、横向渐变
                gradient: Gradient {
                    GradientStop {  position: 0.0;    color: "#21d4fd" }
                    GradientStop {  position: 1;    color: "#b721ff" }

                }
            }

            Text {
                id: element
                color: "#ffffff"
                text: qsTr("terminal_elog")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 30
            }
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
        }





        Button {
            id: button
            x: 972
            y: 8
            text: qsTr("exit")
            background: Rectangle {

                color: "#ff0000"
                radius: width*0.1
                opacity: 0.6
            }
            onClicked:
            {
                myLoader.source= ""
                console.info("exit terminal！")
            }

        }

        ScrollView {
            id: scrollView
            x: 0
            y: 84
            width: parent.width*0.70
            height: parent.height*0.7
            anchors.top: title_block.bottom
            anchors.topMargin: 0


            ListView {
                id: listView
                x: 26
                y: 139
                clip: true
                width: parent.width*0.90
                height: parent.height*0.90
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter


                spacing :0

                //                highlight: Rectangle {
                //                    width: listView.width
                //                    height: 40
                //                    color: "#ffffff"
                //                    radius: 5
                //                    Behavior on y {
                //                        SpringAnimation {
                //                            spring: 3
                //                            damping: 0.2
                //                        }
                //                    }
                //                }

                //                highlightFollowsCurrentItem: true
                //                focus: true

                delegate: Rectangle {
                    property color tempcolor: "#050505"
                    width: listView.width
                    height: 40
                    //                    color: tempcolor
                    //                    opacity: 0
                    radius: width*0.1
                    Row {
                        id: row1
                        anchors.fill: parent
                        spacing: 10
                        anchors.leftMargin: 10
                        Rectangle {
                            width: 30
                            height: 30
                            color: colorCode
                            radius: width/2;
                            anchors.verticalCenter: parent.verticalCenter

                        }



                        Rectangle {
                            id: rectangle1

                            width: listView.width
                            height: 40
                            color: tempcolor
                            opacity: 0.8

                            Text {
                                text: name
                                anchors.left: parent.left
                                anchors.leftMargin: 8
                                anchors.verticalCenter: parent.verticalCenter
                                font.bold: true
                                font.pointSize: listView.currentIndex == index ? 14 : 11
                                color: "white"
                            }
                        }




                    }

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            listView.currentIndex = index;
                        }
                        onEntered: {
                            tempcolor = "#3c3c3c"
                        }

                        onExited: {
                            tempcolor =  "#050505"
                        }
                    }

                }
                model: ListModel {
                    ListElement {
                        name: "i信息"
                        colorCode: "bule"
                    }

                    ListElement {
                        name: "d调试"
                        colorCode: "green"
                    }

                    ListElement {
                        name: "w警告"
                        colorCode: "yellow"
                    }

                    ListElement {
                        name: "e错误"
                        colorCode: "red"
                    }


                }
            }
        }

        Rectangle {
            id: rectangle
            x: 768
            y: 0
            width: parent.width/4
            height: parent.height*0.9



            color: "#ffffff"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0

            ScrollView {
                id: scrollView1
                anchors.rightMargin: 10
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 30
                anchors.margins: 5

                Column{
                    id:leftColumn
                    x: 30
                    y: 30
                    anchors.rightMargin: 10
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    anchors.margins: 5
                    spacing: 0

                    //串口设置
                    Label{
                        text: qsTr("串口设置")
                        color: "#000000"
                    }

                    GridLayout {
                        id: grid
                        columns: 2
                        rowSpacing: 0
                        Label {
                            text: qsTr("串  口")
                        }
                        ComboBox {
                            id:serialName
                            model: serial.querySerialInfo()// [ "Banana", "Apple", "Coconut" ]
                            onActivated: {
                                serial.setPortName(currentText)
                            }
                        }

                        Label {
                            text: qsTr("波特率")

                        }
                        ComboBox {
                            id:baud
                            model: [ "9600", "19200", "38400", "57600","115200"]
                            onActivated: {
                                serial.setBaud(currentText)
                            }
                        }
                    }
                    Label{
                        text: qsTr("接收设置")
                        color: "#000000"
                    }
                    RowLayout{
                        RadioButton { text: qsTr("ASCII"); checked: true }
                        RadioButton {
                            text: qsTr("Hex")
                            onCheckedChanged: {
                                if(checked)
                                    serial.setReceiveHex(true)
                                else
                                    serial.setReceiveHex(false)
                            }
                        }
                    }
                    CheckBox {
                        checked: false
                        text: qsTr("显示发送")
                        onCheckedChanged: {
                            showSend=checked
                        }
                    }
                    Label{
                        text: qsTr("发送设置")
                        color: "#000000"
                    }
                    RowLayout{
                        RadioButton { text: qsTr("ASCII"); checked: true }
                        RadioButton {
                            text: qsTr("Hex")
                            onCheckedChanged: {
                                if(checked)
                                    serial.setSedHex(true)
                                else
                                    serial.setSedHex(false)
                            }
                        }
                    }
                    CheckBox {
                        id:repeatSend
                        checked: false
                        text: qsTr("重复发送(ms)")
                        onCheckedChanged: {
                            showSend=checked
                        }
                    }
                    SpinBox {
                        id: spinbox
                        width: 150
                        from: 0
                        to:100000
                        value: 1000
                        editable: true
                        visible: repeatSend.checked
                    }
                }
            }
        }
    }








}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437}D{i:2;anchors_width:879;anchors_x:19;anchors_y:18}
D{i:10;anchors_y:84}
}
##^##*/
