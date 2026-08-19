import Quickshell
import QtQuick
import QtQuick.Layouts
import ".."
import "Workspaces"
import "Clock"
import "Monitor"

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            color: "transparent"
            anchors {
                top: true
                left: true
                right: true
            }
            screen: modelData
            implicitHeight: Style.height
            margins {
                top: 5
                left: 12
                right: 12
            }

            FlexboxLayout {
                anchors.fill: parent
                alignContent: FlexboxLayout.AlignCenter

                Item {
                    Layout.preferredWidth: 16
                }
                Workspace {
                    Layout.fillHeight: true
                }
                Item {
                    Layout.fillWidth: true
                }
                Monitor {
                    Layout.fillHeight: true
                }
                Item {
                    Layout.preferredWidth: 16
                }
            }
            ClockWidget {
                anchors.centerIn: parent
                implicitHeight: Style.height
            }
        }
    }
}
