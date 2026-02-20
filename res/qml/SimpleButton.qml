import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Basic

Button {
	id: control
	ToolTip.visible: hovered
	ToolTip.delay: Qt.styleHints.mousePressAndHoldInterval
	padding: 0
	font.pointSize: 10

	Timer
	{
		id: timer
		triggeredOnStart: true
		repeat: true
	}

	function startTimer(delayTime, cb)
	{
		timer.interval = delayTime;
		timer.triggered.connect(cb);
		timer.start();
	}

	function stopTimer() {
		timer.stop()
	}

	contentItem: Text {
		text: control.text
		font: control.font
		color: {
			return control.checked ? "red" : "black"
		}
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
		elide: Text.ElideRight
	}

	background: Rectangle {

		color: {
			if (mouseArea.containsMouse)
				return "#aaaaaa"
			else if (control.checked || control.down)
				return "#aaaaaa"
			else
				return "#e0e0e0"
		}

		MouseArea {
			id: mouseArea
			anchors.fill: parent
			hoverEnabled: true
			cursorShape: Qt.PointingHandCursor
			onClicked: control.clicked()
			onPressed: control.onPressed()
			onReleased: control.onReleased()
			onPressAndHold: control.onPressAndHold()
		}
	}
}
