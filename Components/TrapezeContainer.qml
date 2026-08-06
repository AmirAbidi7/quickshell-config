import QtQuick
import QtQuick.Shapes

Shape {
  id: root
  property alias fillColor: path.fillColor
  property real skew: 8

  preferredRendererType: Shape.CurveRenderer

  ShapePath {
    id: path
    strokeWidth: -1

    startX: - skew; startY: root.height
    PathLine{ x: root.width + skew; y: root.height}
    PathLine{ x: root.width; y: 0}
    PathLine{ x: 0; y: 0}

  }
}
