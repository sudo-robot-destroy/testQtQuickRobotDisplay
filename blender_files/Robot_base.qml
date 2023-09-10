import QtQuick
import QtQuick3D

Node {
    id: node

    // Resources
    PrincipledMaterial {
        id: material_001_material
        baseColor: "#ff020703"
        indexOfRefraction: 1.4500000476837158
    }

    // Nodes:
    Node {
        id: scene
        rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
        Model {
            id: cube
            position: Qt.vector3d(0, 0, 1.5)
            source: "meshes/cube_002.mesh"
            materials: material_001_material
        }
    }

    // Animations:
}
