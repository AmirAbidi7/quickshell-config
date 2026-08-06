pragma Singleton

import Quickshell
import Quickshell.Bluetooth
import QtQuick

Singleton {
    id: bluetoothInfo
    property bool isEnabled: false
    property int connectedCount: 0

    function update() {
        var count = 0;
        for (var i = 0; i < Bluetooth.devices.count; i++) {
            var dev = Bluetooth.devices.get(i);
            if (dev.connected) count++;
        }
        connectedCount = count;
        isEnabled = Bluetooth.defaultAdapter
            ? Bluetooth.defaultAdapter.enabled
            : false;
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: bluetoothInfo.update()
    }

    Component.onCompleted: bluetoothInfo.update()
}
