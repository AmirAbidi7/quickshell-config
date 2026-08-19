import Quickshell
import QtQuick
import QtQuick.Layouts
import "../../.."
import "../../../Components"

Slice {
    id: powerButton
    mode: "lean"
    Layout.fillHeight: true
    Layout.preferredWidth: icon.implicitWidth + 24
    fillColor: "transparent"

    HoverReveal {
        id: hoverReveal
        anchors.fill: parent
        skew: powerButton.skew
        hovered: ma.containsMouse
    }

    Text {
        id: icon
        anchors.centerIn: parent
        // anchors.horizontalCenterOffset: powerButton.skew / 2
        text: ""
        color: hoverReveal.progress > 0.2 ? Style.textHover : Style.text

        font {
            pixelSize: Style.textSize
            family: Style.fontFamily
            bold: true
        }
    }

    MouseArea {
        id: ma
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onClicked: () => {
            powerMenu.visible = !powerMenu.visible;
            powerMenu.popupScale = 1;
            powerMenu.popupOpacity = 1;
        }
    }

    PowerMenu {
        id: powerMenu
        anchor.item: powerButton
        anchor.rect.x: 0
        anchor.rect.y: powerButton.height
    }
}
