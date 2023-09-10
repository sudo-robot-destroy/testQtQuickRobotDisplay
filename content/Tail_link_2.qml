import QtQuick
import QtQuick3D

Node {
    id: node

    // Resources
    PrincipledMaterial {
        id: defaultMaterial_material
        baseColor: "#ff999999"
    }

    // Nodes:
    Node {
        id: scene
        rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
        Model {
            id: cube_004
            position: Qt.vector3d(-1.2, 0.8, 2.7)
            scale: Qt.vector3d(1, 0.1, 0.1)
            source: "meshes/cube_006.mesh"
            materials: defaultMaterial_material
        }
    }

    // Animations:
}
