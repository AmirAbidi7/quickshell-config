import Quickshell
import QtQuick
import QtQuick.Layouts
import "../../.."
import "../../../Components"

Slice {
  id: root
  mode: "lean"
  Layout.preferredWidth: label.implicitWidth + 24
  Layout.fillHeight: true
  fillColor:  "transparent"

  HoverReveal {
    id: hoverReveal
    anchors.fill: parent
    skew: root.skew
    hovered: ma.containsMouse
  }

  Text {
    id: label
    anchors.centerIn: parent
    text: "󰍛  " + MemUsage.memUsage + "%"
    color: hoverReveal.progress > 0.3 ? Style.textHover : Style.text
    font {
      pixelSize: Style.textSize
      family: Style.fontFamily
    }
  }

  MouseArea {
    id: ma
    hoverEnabled: true
    anchors.fill: parent

    cursorShape: Qt.PointingHandCursor
    onClicked: Quickshell.execDetached(["kitty", "-e", "btop"])
  }
}
