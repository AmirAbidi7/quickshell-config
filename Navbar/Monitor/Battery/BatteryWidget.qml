import Quickshell
import QtQuick
import QtQuick.Layouts
import "../.."
import "../../../Components"

SlantedContainer {
  id: root
  Layout.preferredWidth: label.implicitWidth + 24
  Layout.fillHeight: true
  fillColor: "transparent"

  HoverReveal{
    id: hoverReveal
    anchors.fill: parent
    skew: root.skew
    hovered: ma.containsMouse

  }

  Text {
    id: label
    anchors.centerIn: parent
    anchors.horizontalCenterOffset: root.skew / 2
    text: BatteryInfo.isPresent
    ? BatteryInfo.iconName + " " + Math.round(BatteryInfo.percentage) + "%"
    : ""
    color: hoverReveal.progress > 0.2 ? Style.textHover : (BatteryInfo.isCharging ? Style.titleText : Style.text)
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
    onClicked: {}
  }
}
