import Quickshell
import QtQuick
import QtQuick.Layouts
import ".."
import "../../Components"

TrapezeContainer {

  skew: 24
  width: text.implicitWidth + 16
  fillColor: Style.bg

  Text {
    id: text
    anchors {
      leftMargin: 8
      rightMargin: 8
    }
    anchors.centerIn: parent
    text: Time.time

    font {
      family: Style.fontFamily
      pixelSize: Style.textSize
    }
    color: Style.text
  }
}
