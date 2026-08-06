pragma Singleton
import Quickshell
import Quickshell.Networking
import QtQuick

Singleton {
  id: wifiData
  property var netDevice: Networking.device
  property real signalStrength: netDevice.type.toString() == "Wifi" ? wifiDevice.signalStrength * 100 : 0
  property bool isConnected: netDevice.connected

  Component.onCompleted: {
    console.log("initial wifiEnabled:", Networking.wifiEnabled)
  }

  Connections {
    target: Networking
    function onWifiEnabledChanged() {
      console.log("wifiEnabled changed to:", Networking.wifiEnabled)
    }
  }

}
