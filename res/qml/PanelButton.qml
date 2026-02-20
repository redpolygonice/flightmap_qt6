import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ToolButton {
	id: control
	Layout.preferredHeight: 30
	Layout.preferredWidth: 30
	ToolTip.visible: hovered
	ToolTip.delay: Qt.styleHints.mousePressAndHoldInterval
	padding: 0

	background: Rectangle {

		color: {
			if (mouseArea.containsMouse)
				return "#aaaaaa"
			else if (control.checked || control.down)
				return "#aaaaaa"
			else
				return "transparent"
		}

		MouseArea {
			id: mouseArea
			anchors.fill: parent
			hoverEnabled: true
			cursorShape: Qt.PointingHandCursor
			onClicked: control.clicked()
		}
	}
}
