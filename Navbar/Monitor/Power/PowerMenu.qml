import Quickshell
import QtQuick
import QtQuick.Layouts
import "../../.."

PopupWindow {
  id: root
  implicitWidth: 150
  implicitHeight: columnLayout.implicitHeight + 28
  grabFocus: true
  color: "transparent"
  property int popupScale: 0
  property int popupOpacity: 0

  onClosed: () => {
    popupScale = 0;
    popupOpacity = 0;
  }

  property var menuItems: [
  {
    label: "  Shutdown",
    cmd: ["hyprshutdown", "-t", "Shutting down...", "--post-cmd", "shutdown -P 0"]
  },
  {
    label: "  Reboot",
    cmd: ["hyprshutdown", "-t", "Restarting...", "--post-cmd", "reboot"]
  },
  {
    label: "󰤄  Suspend",
    cmd: ["systemctl", "suspend"]
  },
  {
    label: "󰍃  Log Out",
    cmd: ["hyprshutdown", "-t", "Logging out..."]
  }
  ]

  Rectangle {
    anchors {
      fill: parent
      margins: 8
    }
    color: Style.bg
    radius: 12
    clip: true
    scale: root.popupScale
    opacity: root.popupOpacity

    transformOrigin: Item.Top

    Behavior on scale {
      ScaleAnimator {
        duration: 200
        easing.type: Easing.OutCubic
      }
    }
    Behavior on opacity {
      OpacityAnimator {
        duration: 200
        easing.type: Easing.OutCubic
      }
    }

    border {
      color: Style.buttonHoverBg
      width: 1
    }

    ColumnLayout {
      id: columnLayout
      anchors {
        fill: parent
        margins: 6
      }
      spacing: 4

      Repeater {
        model: root.menuItems

        Rectangle {
          id: container
          required property var modelData
          implicitHeight: 36
          Layout.fillWidth: true
          radius: 8
          color: ma.containsMouse ? Style.bgHover : "transparent"

          Text {
            id: label
            anchors.centerIn: parent
            text: container.modelData.label
            color: ma.containsMouse ? Style.textHover : Style.text
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
              root.visible = false;
              Quickshell.execDetached({
                  command: container.modelData.cmd
              });
            }
          }
        }
      }
    }
  }
}
