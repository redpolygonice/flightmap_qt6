import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtLocation
import QtPositioning

MapQuickItem {
	id: missionLine

	Component.onCompleted: {
		canvas.requestPaint()
	}

	sourceItem: Item {
		id: control
		visible: true
		width: 30
		height: 30

		Canvas {
			id: canvas
			anchors.fill: parent

			onPaint: {
				var context = getContext("2d");
				context.strokeStyle = "red"
				context.fillStyle = "green";
				context.lineWidth = 3;
				context.beginPath();
				context.ellipse(3, 3, 23, 23)
				context.stroke();
				context.fill();
				context.closePath();
			}
		}
	}
}
