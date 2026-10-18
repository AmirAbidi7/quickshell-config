import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "Memory"
import "../.."
import "Power"
import "Layout"
import "Wifi"
import "Battery"
import "Bluetooth"
import "Audio"
import "Tray"
import "../../Components/"

Slice {
    id: root
    Layout.preferredWidth: flexboxLayout.implicitWidth - 2
    fillColor: Style.bg
    mode: "lean"
    skew: -Style.navbarSkew

    FlexboxLayout {
        id: flexboxLayout
        anchors.centerIn: parent
        height: parent.height
        gap: -1

        TrayWidget {
            Layout.fillWidth: true
            skew: root.skew
        }
        LayoutWidget {
            Layout.fillWidth: true
            skew: root.skew
        }
        AudioWidget {
            Layout.fillWidth: true
            skew: root.skew
        }

        BluetoothWidget {
            Layout.fillWidth: true
            skew: root.skew
        }

        MemWidget {
            Layout.fillWidth: true
            skew: root.skew
        }

        WifiWidget {
            Layout.fillWidth: true
            skew: root.skew
        }

        BatteryWidget {
            Layout.fillWidth: true
            skew: root.skew
        }

        PowerWidget {
            Layout.fillWidth: true
            skew: root.skew
        }
    }
}
