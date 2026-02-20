import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtLocation
import QtPositioning

MapQuickItem {
	id: homePoint
	property int number: 0

	Component.onCompleted: {
		canvas.requestPaint()
	}

	sourceItem: Item {
		id: control
		visible: true
		width: 30
		height: 30

		ToolTip.delay: 300
		ToolTip.visible: mouseArea.containsMouse
		ToolTip.text: "Home, Alt: " + coordinate.altitude.toFixed(1)

		MouseArea {
			id: mouseArea
			anchors.fill: parent
			hoverEnabled: true
			cursorShape: Qt.PointingHandCursor
		}

		Canvas {
			id: canvas
			anchors.fill: parent

			onPaint: {
				var context = getContext("2d");
				context.strokeStyle = "red"
				context.fillStyle = "red";
				context.lineWidth = 3;
				context.beginPath();
				context.ellipse(3, 3, 23, 23)
				context.stroke();
				context.fill();
				context.closePath();

				context.beginPath();
				context.font = '10px sans-serif';
				context.lineWidth = 1;
				context.strokeStyle = "white"
				if (number < 10)
					context.strokeText(number, 11, 18);
				else if (number < 100)
					context.strokeText(number, 8, 18);
				else
					context.strokeText(number, 5, 18);
				context.stroke();
				context.closePath();
			}
		}
	}
}
