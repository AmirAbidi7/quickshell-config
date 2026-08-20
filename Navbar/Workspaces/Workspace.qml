import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "../.."
import "../../Components"

Slice {
    id: root
    Layout.preferredWidth: flexboxLayout.implicitWidth - 2
    skew: Style.navbarSkew
    mode: "lean"

    fillColor: Style.bg

    readonly property int activeIndex: {
        const id = Hyprland.focusedWorkspace?.id ?? -1
        return id >= 1 && id <= 5 ? id - 1 : -1
    }

    readonly property real indicatorX: {
        if (root.activeIndex < 0) return 0
        const children = flexboxLayout.children
        for (let i = 0; i < children.length; i++) {
            const child = children[i]
            if (typeof child.index === "number" && child.index === root.activeIndex) {
                return child.mapToItem(root, 0, 0).x
            }
        }
        return 0
    }

    Slice {
        id: indicator
        skew: root.skew
        mode: "lean"

        width: 32
        height: parent.height
        x: root.indicatorX
        opacity: root.activeIndex >= 0 ? 1 : 0

        fillColor: Style.buttonActiveBg

        Behavior on x {
            NumberAnimation {
                duration: 180
                easing.type: Easing.OutCubic
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 100
            }
        }
    }

    FlexboxLayout {
        id: flexboxLayout
        anchors.fill: parent
        gap: -1

        Repeater {
            model: 5

            Slice {
                id: button
                required property int index
                skew: root.skew
                mode: "lean"

                property var ws: Hyprland.workspaces.values.find(w => w.id == (index + 1))
                property bool isActive: Hyprland.focusedWorkspace?.id == (index + 1)

                Layout.preferredWidth: 32
                Layout.fillHeight: true
                fillColor: !button.isActive && ma.containsMouse ? Style.buttonHoverBg : "transparent"

                Text {
                    anchors.centerIn: parent
                    text: button.index + 1

                    color: button.isActive ? Style.bg : (ws ? Style.text : Style.inactive)
                    font {
                        pixelSize: 14
                        bold: true
                        family: Style.fontFamily
                    }
                }

                MouseArea {
                    id: ma
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: Hyprland.usingLua ? Hyprland.dispatch(`hl.dsp.focus({ workspace = ${button.index + 1} })`) : Hyprland.dispatch(`workspace ${index + 1}`)
                }
            }
        }
    }
}
