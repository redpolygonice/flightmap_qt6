import QtQuick
import QtQuick.Dialogs
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Window

Window {
	id: cameraWindow
	visible: false
	title: "Camera"
	width: 600
	height: 500
	flags: Qt.Tool

	property string imagePath: "file:///" + proxy.imageLocation()

	onVisibleChanged: {
		if (visible)
			startCamera()
		else
			stopCamera()
	}

	Rectangle {
		id: imageRect
		width: parent.width
		height: parent.height - 40

		Image {
			id: imageId
			visible: true
			anchors.fill: parent
			fillMode: Image.PreserveAspectFit
			antialiasing: true
			cache: false
			source: ""
		}

		Timer {
			id: timerId
			interval: 50
			repeat: true
			running: false
			onTriggered: {
				if (proxy.imageExists())
				{
					imageId.source = "";
					imageId.source = imagePath
				}
			}
		}
	}

	Button {
		id: buttonClose
		x: parent.width - 110
		y: parent.height - 37
		width: 100
		height: 27
		text: "Close"

		onClicked: {
			cameraWindow.close()
		}
	}

	function startCamera()
	{
		timerId.start()
		proxy.startCamera()
	}

	function stopCamera()
	{
		timerId.stop()
		proxy.stopCamera()
	}
}
