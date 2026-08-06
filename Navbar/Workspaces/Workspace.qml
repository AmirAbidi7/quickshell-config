import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import ".."
import "../../Components"

SlantedContainer {
  id: root
  Layout.preferredWidth: flexboxLayout.implicitWidth - 2
  skew: 16

  fillColor: Style.bg

  FlexboxLayout {
    id: flexboxLayout
    anchors.fill: parent
    gap: -1

    Repeater {
      model: 5

      SlantedContainer {
        id: button
        required property int index
        skew: root.skew

        property var ws: Hyprland.workspaces.values.find(w => w.id == (index + 1))
        property bool isActive: Hyprland.focusedWorkspace?.id == (index + 1)

        Layout.preferredWidth: 32
        Layout.fillHeight:  true
        fillColor: isActive ? Style.buttonActiveBg : (ma.containsMouse ? Style.buttonHoverBg : Style.buttonBg)

        Behavior on fillColor {
          ColorAnimation {
            duration: 100
          }
        }

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
