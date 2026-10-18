pragma Singleton
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

Singleton {
  id: layoutInfo
  property string activeKeymap: ""
  property bool isFrench: false

  function setKeymap(name) {
    activeKeymap = name;
    isFrench = name.toLowerCase().includes("french");
  }

  Process {
    id: initProc
    command: ["hyprctl", "devices", "-j"]
    running: true

    stdout: StdioCollector {
      waitForEnd: true

      onStreamFinished: {
        try {
          var parsed = JSON.parse(text);
          for (var i = 0; i < parsed.keyboards.length; i++) {
            var kb = parsed.keyboards[i];
            if (kb.main) {
              layoutInfo.setKeymap(kb.active_keymap || "");
              return;
            }
          }
        } catch (e) {
          console.warn("LayoutInfo: failed to parse hyprctl devices:", e);
        }
      }
    }
  }

  Connections {
    target: Hyprland
    function onRawEvent(event) {
      if (event.name === "activelayout") {
        var idx = event.data.indexOf(",");
        if (idx >= 0) layoutInfo.setKeymap(event.data.substring(idx + 1));
      }
    }
  }
}