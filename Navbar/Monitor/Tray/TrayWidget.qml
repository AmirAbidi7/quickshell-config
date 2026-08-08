import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import "../../.."
import "../../../Components"

Slice {
  id: trayRoot
  Layout.preferredWidth: row.implicitWidth + 24
  Layout.fillHeight: true
  fillColor: "transparent"
  visible: repeater.count > 0
  mode: "lean"

  HoverReveal {
    anchors.fill: parent
    skew: trayRoot.skew
    hovered: bgMa.containsMouse
  }

  Row {
    id: row
    anchors.centerIn: parent
    anchors.horizontalCenterOffset: trayRoot.skew / 2
    spacing: 8

    Repeater {
      id: repeater
      model: SystemTray.items

      Slice {
        id: appContainer
        required property var modelData
        width: 16
        height: 16
        fillColor: "transparent"
        skew: trayRoot.skew
        mode: "lean"

        Image {
          anchors.centerIn: parent
          anchors.horizontalCenterOffset: - trayRoot.skew / 2
          source: modelData.icon
          sourceSize.width: 18
          sourceSize.height: 18
        }

        QsMenuAnchor {
          id: secondaryMenu
          menu: modelData.hasMenu ? modelData.menu : null
          anchor.window: trayRoot
          anchor.item: appContainer
        }

        MouseArea {
          id: ma
          hoverEnabled: true
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

          onClicked: mouse => {
            if (mouse.button === Qt.RightButton && modelData.hasMenu) {
              var pos = ma.mapToItem(null, 0, 0);
              secondaryMenu.open();
            } else if (mouse.button === Qt.LeftButton) {
              if (modelData.onlyMenu && modelData.hasMenu) {
                var pos = ma.mapToItem(null, 0, 0);
                modelData.activate();
              } else {
                modelData.activate();
              }
            } else if (mouse.button === Qt.MiddleButton) {
              modelData.secondaryActivate();
            }
          }
        }
      }
    }
  }

  MouseArea {
    id: bgMa
    hoverEnabled: true
    acceptedButtons: Qt.NoButton
    anchors.fill: parent
  }
}
