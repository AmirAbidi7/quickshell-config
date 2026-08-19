import QtQuick
import QtQuick.Shapes
import "../"

Shape {
    id: root

    property alias fillColor: path.fillColor
    property real skew: 8
    property string mode: "box" // "box" | "lean" | "flare" | "cut"

    property bool shadowEnabled: false
    property real shadowOffsetX: 0
    property real shadowOffsetY: 0
    property color shadowColor: Style.bgHover

    // Per-corner overrides. Leave NaN to fall back to the mode's default.
    // positive = cuts inward, negative = flares outward
    property real topLeftX: NaN
    property real topLeftY: NaN
    property real topRightX: NaN
    property real topRightY: NaN
    property real bottomLeftX: NaN
    property real bottomLeftY: NaN
    property real bottomRightX: NaN
    property real bottomRightY: NaN

    readonly property real tlX: isNaN(topLeftX) ? modeX(false, false) : topLeftX
    readonly property real tlY: isNaN(topLeftY) ? modeY(false, false) : topLeftY
    readonly property real trX: isNaN(topRightX) ? modeX(false, true) : topRightX
    readonly property real trY: isNaN(topRightY) ? modeY(false, true) : topRightY
    readonly property real blX: isNaN(bottomLeftX) ? modeX(true, false) : bottomLeftX
    readonly property real blY: isNaN(bottomLeftY) ? modeY(true, false) : bottomLeftY
    readonly property real brX: isNaN(bottomRightX) ? modeX(true, true) : bottomRightX
    readonly property real brY: isNaN(bottomRightY) ? modeY(true, true) : bottomRightY

    preferredRendererType: Shape.CurveRenderer

    function modeX(bottom, right) {
        switch (root.mode) {
        case "lean":
            return bottom === right ? root.skew / 2 : -root.skew / 2;
        case "flare":
            return bottom ? -root.skew : 0;
        case "cut":
            return root.skew;
        default:
            return 0;
        }
    }

    function modeY(bottom, right) {
        switch (root.mode) {
        case "lean":
            return root.height / 2;
        case "flare":
            return bottom ? root.height : 0;
        case "cut":
            return root.skew;
        default:
            return 0;
        }
    }

    ShapePath {
        id: shadowPath
        strokeWidth: -1
        fillColor: root.shadowEnabled ? root.shadowColor : "transparent"

        startX: root.tlX + root.shadowOffsetX
        startY: root.shadowOffsetY
        PathLine {
            x: root.width - root.trX + root.shadowOffsetX
            y: root.shadowOffsetY
        }                    // top edge
        PathLine {
            x: root.width + root.shadowOffsetX
            y: root.trY + root.shadowOffsetY
        }                        // top-right cut
        PathLine {
            x: root.width + root.shadowOffsetX
            y: root.height - root.brY + root.shadowOffsetY
        }          // right edge
        PathLine {
            x: root.width - root.brX + root.shadowOffsetX
            y: root.height + root.shadowOffsetY
        }          // bottom-right cut
        PathLine {
            x: root.blX + root.shadowOffsetX
            y: root.height + root.shadowOffsetY
        }                       // bottom edge
        PathLine {
            x: root.shadowOffsetX
            y: root.height - root.blY + root.shadowOffsetY
        }                   // bottom-left cut
        PathLine {
            x: root.shadowOffsetX
            y: root.tlY + root.shadowOffsetY
        }                                 // left edge
        PathLine {
            x: root.tlX + root.shadowOffsetX
            y: root.shadowOffsetY
        }                                 // top-left cut
    }

    ShapePath {
        id: path
        strokeWidth: -1

        startX: root.tlX
        startY: 0
        PathLine {
            x: root.width - root.trX
            y: 0
        }                    // top edge
        PathLine {
            x: root.width
            y: root.trY
        }                        // top-right cut
        PathLine {
            x: root.width
            y: root.height - root.brY
        }          // right edge
        PathLine {
            x: root.width - root.brX
            y: root.height
        }          // bottom-right cut
        PathLine {
            x: root.blX
            y: root.height
        }                       // bottom edge
        PathLine {
            x: 0
            y: root.height - root.blY
        }                   // bottom-left cut
        PathLine {
            x: 0
            y: root.tlY
        }                                 // left edge
        PathLine {
            x: root.tlX
            y: 0
        }                                 // top-left cut
    }
}
