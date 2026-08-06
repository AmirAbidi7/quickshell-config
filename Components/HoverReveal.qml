import QtQuick
import "../Navbar"

Item {
  id: hoverReveal

  property bool hovered: false
  property real skew: 8
  property color fillColor: Style.bgHover
  property real progress: 0
  readonly property real over: Math.abs(skew) / 2 + 2

  Behavior on progress {
    NumberAnimation { duration: 250; easing.type: Easing.OutCubic}
  }

  onHoveredChanged: progress = hovered ? 1 : 0

  Item {
    anchors {
      top: parent.top
      left: parent.left
      right: parent.right
      leftMargin: -hoverReveal.over
      rightMargin: - hoverReveal.over
    }
    height: hoverReveal.height * hoverReveal.progress
    clip: true

    SlantedContainer {
      x: over
      width: hoverReveal.width
      height: hoverReveal.height
      skew: hoverReveal.skew
      fillColor: hoverReveal.fillColor
    }
  }
}
