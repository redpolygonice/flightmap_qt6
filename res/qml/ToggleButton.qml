import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

RadioButton {
	id: control
	Layout.leftMargin: 5

	indicator: Rectangle {
		implicitWidth: 16
		implicitHeight: 16
		radius: 9
		border.color: control.activeFocus ? "black" : "gray"
		border.width: 1

		Rectangle {
			anchors.fill: parent
			visible: control.checked
			color: "#555"
			radius: 9
			anchors.margins: 4
		}
	}

	contentItem: Text {
		text: control.text
		color: "white"
		verticalAlignment: Text.AlignVCenter
		leftPadding: 20
		font.pointSize: 10
	}
}
