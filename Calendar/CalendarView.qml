import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import ".."
import "../Components"

PopupWindow {
    id: root

    property bool open: false
    property real progress: 0
    implicitHeight: 280
    grabFocus: false
    color: "transparent"
    required property real bottomCutHeight

    onOpenChanged: () => {
        if (open) {
            closeTimer.stop();
            visible = true;
            progress = 1;
        } else if (visible) {
            progress = 0;
            closeTimer.restart();
            calendarWidget.monthShift = 0;
        }
    }

    onClosed: () => {
        progress = 0;
    }

    HyprlandFocusGrab {
        id: focusGrab
        active: root.visible
        windows: [root]

        onCleared: () => {
            if (root.visible)
                root.open = false;
        }
    }

    Timer {
        id: closeTimer
        interval: 260
        onTriggered: root.visible = false
    }

    mask: Region {
        item: revealClipper
    }

    Behavior on progress {
        NumberAnimation {
            duration: 250
            easing.type: Easing.OutCubic
        }
    }

    Item {
        id: revealClipper
        width: parent.width
        height: calendarWidget.implicitHeight * root.progress
        clip: true

        Slice {
            id: slice
            width: parent.width
            height: calendarWidget.implicitHeight
            fillColor: Style.bg
            mode: "cut"
            skew: 24
            topLeftX: 0
            topLeftY: 0
            topRightX: 0
            topRightY: 0
            bottomRightY: root.bottomCutHeight
            bottomLeftY: root.bottomCutHeight

            CalendarWidget {
                id: calendarWidget
                anchors.fill: parent
            }
        }
    }
}
