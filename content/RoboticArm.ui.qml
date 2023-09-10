

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
import QtQuick
import QtQuick3D

Node {
    opacity: 1 // Useful for troubleshooting the model
    id: rootNode
    property int rotation1
    property int rotation2
    property int rotation3
    property int rotation4
    property int extension

    PrincipledMaterial {
        id: default_material
        baseColor: "#FF999999"
    }

    rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)

    Model {
        id: compass
        source: "meshes/cylinder.mesh"
        materials: default_material
        eulerRotation.z: rotation1
    }
    Model {
        id: robot_base
        position: Qt.vector3d(0, 0, 1.5)
        source: "meshes/cube_002.mesh"
        materials: default_material
        eulerRotation.x: rotation2
        eulerRotation.y: rotation3

        Model {
            id: tail_link_1
            position: Qt.vector3d(1.8, 0.8, 1.2)
            source: "meshes/cube_005.mesh"
            materials: default_material
            eulerRotation.y: rotation4

            Model {
                id: tail_link_2
                position: Qt.vector3d(-3, 0, 0)
                source: "meshes/cube_006.mesh"
                materials: default_material
                x: extension / 100
            }
        }

        PointLight {
            id: frontOvert
            castsShadow: true
            ambientColor: Qt.rgba(0.1, 0.1, 0.1, 1.0)
            position: Qt.vector3d(-2.2, 0, 1.5)
            brightness: 1
            visible: true
        }
    }
}
