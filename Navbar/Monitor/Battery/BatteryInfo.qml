pragma Singleton

import Quickshell
import Quickshell.Services.UPower
import QtQuick

Singleton {
    id: batteryInfo
    property real percentage: 0
    property bool isCharging: false
    property bool isPresent: false
    property string iconName: ""

    function update() {
        var dev = UPower.displayDevice;
        if (dev && dev.isLaptopBattery && dev.isPresent) {
            percentage = dev.percentage * 100;
            isPresent = true;
            var state = dev.state;
            isCharging = state === UPowerDeviceState.Charging
                || state === UPowerDeviceState.FullyCharged;
            if (state === UPowerDeviceState.FullyCharged) {
                iconName = "";
            } else if (state === UPowerDeviceState.Charging) {
                iconName = "";
            } else if (percentage > 75) {
                iconName = "";
            } else if (percentage > 50) {
                iconName = "";
            } else if (percentage > 25) {
                iconName = "";
            } else if (percentage > 10) {
                iconName = "";
            } else {
                iconName = "";
            }
        } else {
            percentage = 0;
            isPresent = false;
            isCharging = false;
            iconName = "";
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: batteryInfo.update()
    }

    Component.onCompleted: batteryInfo.update()
}
