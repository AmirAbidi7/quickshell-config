pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
    id: audioInfo

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    property var sink: Pipewire.defaultAudioSink
    property var audio: sink ? sink.audio : null
    property real volume: audio ? audio.volume : 0
    property bool muted: audio ? audio.muted : false

    function icon() {
        if (muted || volume === 0) return "󰝟";
        if (volume > 0.5) return "󰕾";
        return "󰖀";
    }

    function openMixer() {
        Quickshell.execDetached(["pavucontrol"]);
    }
}
