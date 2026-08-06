pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: memMonitor
    property int memUsage

    Process {
        id: memProc

        command: ["sh", "-c", "free | grep Mem"]

        running: true

        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                var parts = data.trim().split(/\s+/);
                var total = parseInt(parts[1]) || 1;
                var used = parseInt(parts[2]) || 2;
                memMonitor.memUsage = Math.round(100 * used / total);
            }
        }
    }
    Timer {
        interval: 10000
        running: true
        repeat: true
        onTriggered: {
            memProc.running = true;
        }
    }
}
