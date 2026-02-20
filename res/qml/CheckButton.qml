import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

CheckBox {
	id: control
	Layout.leftMargin: 5

	indicator: Rectangle {
		implicitWidth: 16
		implicitHeight: 16
		x: control.leftPadding
		y: parent.height / 2 - height / 2
		border.color: control.down ? "dark" : "grey"

		Rectangle {
			anchors.fill: parent
			visible: control.checked
			color: enabled ? "#555" : "grey"
			anchors.margins: 4
		}
	}

	contentItem: Text {
		text: control.text
		color: enabled ? "white" : "grey"
		verticalAlignment: Text.AlignVCenter
		leftPadding: 22
		font.pointSize: 10
	}
}
