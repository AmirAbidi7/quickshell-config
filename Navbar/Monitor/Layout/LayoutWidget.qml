import Quickshell
import QtQuick
import QtQuick.Layouts
import "../../.."
import "../../../Components"

Slice {
  id: root
  mode: "lean"
  Layout.preferredWidth: label.implicitWidth + 24
  fillColor: "transparent"
  Layout.fillHeight: true

  HoverReveal {
    id: hoverEffect
    anchors.fill: parent
    skew: root.skew
    hovered: ma.containsMouse
  }

  Text {
    id: label
    anchors.centerIn: parent
    text: LayoutInfo.isFrench ? "FR" : "EN"
    color: hoverEffect.progress > 0.5 ? Style.textHover : Style.text
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
  }
}