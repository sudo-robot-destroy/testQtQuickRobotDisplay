
/****************************************************************************
**
** Copyright (C) 2022 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Design Studio.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.15


/****************************************************************************
**
** Copyright (C) 2022 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Design Studio.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/
import QtQuick3D 1.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import backend 1.0
import QtQml 2.15

// This is a beast of a file but it was easier to make one large one rather than messing with all the qt creator import mess
Pane {
    id: root
    Material.theme: Material.Light

    property real sliderWidth: width * 0.15
    property real buttonRowWidth: width * 0.12
    property real buttonMinWidth: 65

    leftPadding: 60
    rightPadding: 60
    topPadding: 50
    bottomPadding: 50

    width: 800
    height: 600


    Backend {
        id: backend
    }

    MouseArea {
        id: mouseArea
        property real mouseXprev: 0
        property real rotationY: 135
        anchors.fill: parent
        hoverEnabled: true
        onDoubleClicked: rotationY = 135
        Connections {
            target: mouseArea
            onMouseXChanged: {
                if (mouseArea.pressed) {
                    mouseArea.rotationY += (mouseArea.mouseX - mouseArea.mouseXprev) / 5
                }
                mouseArea.mouseXprev = mouseArea.mouseX
            }
        }
    }

    View3D {
        anchors.fill: parent

        camera: camera
        Node {
            id: scene
            PerspectiveCamera {
                id: camera
                fieldOfView: 60
                clipNear: 1
                position: Qt.vector3d(0,10,10)
                eulerRotation.x: -45
            }

            Node {
                id: dummyNode
                eulerRotation.y: mouseArea.rotationY

                PointLight {
                    x: 10
                    z: 10
                    y: 10
                    brightness: 200
                }
                PointLight {
                    x: -10
                    z: -15
                    y: 10
                    brightness: 50
                }
                PointLight {
                    x: -20
                    z: 20
                    y: -10
                    brightness: 150
                }

                // The robot model:
                Node {
                    opacity: 1 // Useful for troubleshooting the model
                    id: rootNode
                    rotation: Qt.quaternion(0.707107, -0.707107, 0, 0) //in blender Z is up

                    Model {
                        id: compass
                        source: "meshes/cylinder.mesh"
                        materials: [ DefaultMaterial {diffuseColor: "green"}]
                        eulerRotation.z: backend.rotation1Angle
                    }
                    Model {
                        id: robot_base
                        position: Qt.vector3d(0, 0, 1.5)
                        source: "meshes/cube.mesh"
                        materials: [ DefaultMaterial {diffuseColor: "red"}]
                        eulerRotation.x: backend.rotation2Angle
                        eulerRotation.y: backend.rotation3Angle

                        Model {
                            id: tail_link_1
                            position: Qt.vector3d(1.8, 0.8, 1.2)
                            source: "meshes/cube_003.mesh"
                            materials: [ DefaultMaterial {diffuseColor: "blue"}]
                            eulerRotation.y: backend.rotation4Angle

                            Model {
                                id: tail_link_2
                                position: Qt.vector3d(-3, 0, 0)
                                source: "meshes/cube_004.mesh"
                                materials: [ DefaultMaterial {diffuseColor: "orange"}]
                                x: backend.extensionDistance / 100
                            }
                        }
                    }
                }
                }//dummyNode
            }//scene

        environment: sceneEnvironment

        SceneEnvironment {
            id: sceneEnvironment
            antialiasingQuality: SceneEnvironment.VeryHigh
            antialiasingMode: SceneEnvironment.MSAA
        }
    }

    ColumnLayout {
        id: slidersColumn
        spacing: 6
        anchors.bottom: parent.bottom

        Loader {
            source: "LabeledSlider.qml"
            id: rotation1Slider
            Layout.preferredWidth: root.sliderWidth
            Layout.minimumWidth: 160
            onLoaded: {
                item.value = 0
                item.from = -180
                item.to = 180
                item.labelText = "Rotation 1"
            }
        }
        Binding {
            target: backend
            property: "rotation1Angle"
            value: rotation1Slider.item.value
        }

        Loader {
            source: "LabeledSlider.qml"
            id: rotation2Slider
            Layout.preferredWidth: root.sliderWidth
            Layout.minimumWidth: 160
            onLoaded: {
                item.value = 0
                item.from = -180
                item.to = 180
                item.labelText = "Rotation 2"
            }
        }
        Binding {
            target: backend
            property: "rotation2Angle"
            value: rotation2Slider.item.value
        }

        Loader {
            source: "LabeledSlider.qml"
            id: rotation3Slider
            Layout.preferredWidth: root.sliderWidth
            Layout.minimumWidth: 160
            onLoaded: {
                item.value = 0
                item.from = -180
                item.to = 180
                item.labelText = "Rotation 3"
            }
        }
        Binding {
            target: backend
            property: "rotation3Angle"
            value: rotation3Slider.item.value
        }

        Loader {
            source: "LabeledSlider.qml"
            id: rotation4Slider
            Layout.preferredWidth: root.sliderWidth
            Layout.minimumWidth: 160
            onLoaded: {
                item.value = -25
                item.from = -25
                item.to = 210
                item.labelText = "Rotation 4"
            }
        }
        Binding {
            target: backend
            property: "rotation4Angle"
            value: rotation4Slider.item.value
        }

        Loader {
            source: "LabeledSlider.qml"
            id: extensionSlider
            Layout.preferredWidth: root.sliderWidth
            Layout.minimumWidth: 160
            onLoaded: {
                item.value = -300
                item.from = -450
                item.to = -300
                item.labelText = "Tail Extension"
            }
        }
        Binding {
            target: backend
            property: "extensionDistance"
            value: extensionSlider.item.value
        }
    }

    transitions: Transition {
        PropertyAnimation {
            properties: "sliderWidth, scale.x, scale.y, scale.z, y, z"
        }
        AnchorAnimation {}
    }
}
