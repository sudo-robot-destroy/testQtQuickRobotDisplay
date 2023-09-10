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
            id: cylinder
            scale: Qt.vector3d(5, 5, 0.01)
            source: "meshes/cylinder.mesh"
            materials: defaultMaterial_material
        }
    }

    // Animations:
}
