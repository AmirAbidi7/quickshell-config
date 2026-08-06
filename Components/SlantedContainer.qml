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

    startX: - skew / 2; startY: root.height;
    PathLine{ x: root.width - skew /2 ; y:root.height  }
    PathLine{ x: root.width + skew /2; y: 0  }
    PathLine{ x: skew / 2; y: 0 }

  }
}
