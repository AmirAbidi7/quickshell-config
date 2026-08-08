import Quickshell
import QtQuick
import QtQuick.Layouts
import "../.."
import "../../Components"
import "../../Calendar"

Slice {
    id: clockSlice

    mode: "flare"
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

    MouseArea {
        id: ma
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onClicked: () => {
            calendar.open = !calendar.open;
        }
    }

    CalendarView {
        id: calendar
        implicitWidth: clockSlice.width + 1 + skew * 2
        anchor.item: clockSlice
        anchor.rect.x: 0 - skew
        anchor.rect.y: clockSlice.height - 1
        bottomCutHeight: clockSlice.height
    }
}
