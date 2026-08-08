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
    // anchors.horizontalCenterOffset: root.skew / 2
    text: WifiInfo.isConnected ? "󰤨   " + Math.round(WifiInfo.signalStrength) + "%" : "󰤭"
    color: hoverReveal.progress > 0.2 ? Style.textHover : (  WifiInfo.isConnected ? Style.text : Style.inactive)

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
    onClicked: {
      Quickshell.execDetached(["kitty", "-e", "wifitui"]);
    }
  }
}
