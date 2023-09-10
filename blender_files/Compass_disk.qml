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
            source: "meshes/cylinder.mesh"
            materials: defaultMaterial_material
        }
    }

    // Animations:
}
