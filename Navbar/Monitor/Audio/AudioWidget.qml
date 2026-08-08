import Quickshell
import QtQuick
import QtQuick.Layouts
import "../../.."
import "../../../Components"

Slice {
  id: root
  mode: "lean"
  Layout.preferredWidth: label.implicitWidth + 24
  fillColor:  "transparent"
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
    text: AudioInfo.icon() + "  " + Math.round(AudioInfo.volume * 100) + "%"
    color: hoverEffect.progress > 0.5 ?  Style.textHover :AudioInfo.muted ? Style.inactive : Style.text
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
    onClicked: AudioInfo.openMixer()
  }
}
