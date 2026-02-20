import QtQuick
import QtQuick.Controls

Rectangle {
	color: "#ffffff"
	border.width: 2
	border.color: "#aaaaaa"

	Component.onCompleted: {
		proxy.onLogChanged.connect(function(text) {
			logText.append(text)
		})
	}

	ScrollView {
		id: textView
		anchors.fill: parent

		TextArea {
			id: logText
			anchors.fill: parent
			textFormat: TextEdit.RichText
			font.family: "Helvetica"
			font.pointSize: 12
			selectionColor: "#aaaaaa"
			selectByKeyboard: true
			selectByMouse: true
			renderType: Text.NativeRendering
		}
	}

	function setText(str)
	{
		logText.append(str)
	}
}
