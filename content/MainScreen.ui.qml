
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


/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick


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
import QtQuick3D
import QtQuick3D.Helpers
import QtQuick.Controls.Material
import QtQuick.Controls
import QtQuick.Layouts
import RobotArm
import backend
import QtQml

Pane {
    id: root
    Material.theme: Material.Light

    readonly property bool mobile: Qt.platform.os === "android"
    readonly property bool horizontal: width > height
    property real sliderWidth: width * 0.15
    property real buttonRowWidth: width * 0.12
    property real buttonMinWidth: 65

    leftPadding: 60
    rightPadding: 60
    topPadding: 50
    bottomPadding: 50

    width: 800
    height: 600
    state: "mobileHorizontal"

    Backend {
        id: backend
        rotation1Angle: rotation1Slider.value
        rotation2Angle: rotation2Slider.value
        rotation3Angle: rotation3Slider.value
        rotation4Angle: rotation4Slider.value
    }


    View3D {
        anchors.fill: parent

        camera: camera
        Node {
            id: scene

            PointLight {
                x: 760
                z: 770
                quadraticFade: 0
                brightness: 1
            }

            DirectionalLight {
                eulerRotation.z: 30
                eulerRotation.y: -165
            }

            DirectionalLight {
                y: 1000
                brightness: 0.4
                eulerRotation.z: -180
                eulerRotation.y: 90
                eulerRotation.x: -90
            }

            PerspectiveCamera {
                id: camera
                x: 1050
                y: 375
                z: -40
                pivot.x: 200
                eulerRotation.y: 85
            }
            RoboticArm {
                id: roboArm
                rotation1: backend.rotation1Angle
                rotation2: backend.rotation2Angle
                rotation3: backend.rotation3Angle
                rotation4: backend.rotation4Angle
                clawsAngle: backend.clawsAngle
            }
        }

//        OrbitCameraController {
//            anchors.fill: parent
//            mouseEnabled: true
//            panEnabled: false
//            origin: scene
//            camera: camera
//        }

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

        LabeledSlider {
            id: rotation1Slider
            Layout.preferredWidth: root.sliderWidth
            Layout.minimumWidth: 160
            labelText: "Rotation 1"
            from: -90
            to: 90
            value: 60
        }

        LabeledSlider {
            id: rotation2Slider
            Layout.preferredWidth: root.sliderWidth
            Layout.minimumWidth: 160
            labelText: "Rotation 2"
            from: -135
            to: 135
            value: 45
        }

        LabeledSlider {
            id: rotation3Slider
            Layout.preferredWidth: root.sliderWidth
            Layout.minimumWidth: 160
            labelText: "Rotation 3"
            from: -90
            to: 90
            value: 45
        }

        LabeledSlider {
            id: rotation4Slider
            Layout.preferredWidth: root.sliderWidth
            Layout.minimumWidth: 160
            labelText: "Rotation 4"
            from: -180
            to: 180
        }
    }
    states: [
        State {
            name: "mobileHorizontal"
            when: root.mobile && root.horizontal

            PropertyChanges {
                target: root
                leftPadding: 45
                topPadding: 15
                bottomPadding: 0
                sliderWidth: width * 0.4
                buttonRowWidth: width * 0.2
                buttonMinWidth: 75
            }

            PropertyChanges {
                target: roboArm
                z: -200
            }
        },
        State {
            name: "desktopVertical"
            when: !root.mobile && !root.horizontal

            PropertyChanges {
                target: root
                sliderWidth: width * 0.4
                buttonRowWidth: width * 0.2
                bottomPadding: 20
            }
            AnchorChanges {
                target: slidersColumn
                anchors.right: parent.right
            }
            PropertyChanges {
                target: slidersColumn
                anchors.rightMargin: 20
            }

            PropertyChanges {
                target: roboArm
                scale.x: 0.7
                scale.y: 0.7
                scale.z: 0.7
                y: 250
                z: 150
            }
        },
        State {
            name: "mobileVertical"
            when: root.mobile && !root.horizontal

            PropertyChanges {
                target: root
                sliderWidth: width * 0.85
                topPadding: 15
                leftPadding: 45
                bottomPadding: 0
                buttonRowWidth: width * 0.2
                buttonMinWidth: 75
            }

            AnchorChanges {
                target: slidersColumn
                anchors.left: undefined
                anchors.horizontalCenter: parent.horizontalCenter
            }

            AnchorChanges {
                target: buttonsRow
                anchors.bottom: slidersColumn.top
                anchors.left: slidersColumn.left
            }

            PropertyChanges {
                target: roboArm
                scale.x: 0.7
                scale.y: 0.7
                scale.z: 0.7
                y: 280
                z: 100
            }
        }
    ]

    transitions: Transition {
        PropertyAnimation {
            properties: "sliderWidth, scale.x, scale.y, scale.z, y, z"
        }
        AnchorAnimation {}
    }
}
