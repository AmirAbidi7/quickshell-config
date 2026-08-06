pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Networking
import QtQuick

Singleton {
  id: wifiInfo
  property real signalStrength: 0
  property string ssid: ""
  property bool isConnected: false

  Process {
    id: wifiProc
    command: ["nmcli", "-t", "-f", "SSID,SIGNAL,IN-USE", "device", "wifi", "list"]
    running: true

    stdout: SplitParser {
      onRead: data => {
        if (!data)
        return;
        var line = data.trim();
        var parts = line.split(':');
        if (parts.length >= 3 && parts[2] === '*') {
          wifiInfo.ssid = parts[0];
          wifiInfo.signalStrength = parseInt(parts[1]) || 0;
          wifiInfo.isConnected = true;
        }
      }
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: {
      wifiProc.running = true;
    }
  }
}
