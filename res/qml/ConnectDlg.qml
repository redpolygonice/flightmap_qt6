import QtQuick
import QtQuick.Dialogs
import QtQuick.Layouts
import QtQuick.Controls

Dialog {
	visible: false
	title: "Connection"
	width: 250
	height: 300
	font.pixelSize: 14

	standardButtons: Dialog.Ok | Dialog.Cancel

	property string protocol: ""
	property string device: ""
	property alias host: hostText.text
	property alias port: portText.text
	property alias baudrate: baudrateText.text

	Component.onCompleted: {
		load()
	}

	Grid {
		id: grid
		anchors.fill: parent
		rows: 5
		columns: 2
		spacing: 10
		anchors.margins: 10

		Text {
			text: "Protocol"
			font.pixelSize: 14
		}

		ComboBox {
			id: protocolComboBox
			width: 110
			font.pixelSize: 14
			implicitHeight: 25
			onCurrentIndexChanged: {
				if (currentIndex == 3)
				{
					deviceComboBox.enabled = false
					baudrateText.enabled = false
					hostText.enabled = false
					portText.enabled = false
				}
				else if (currentIndex <= 2)
				{
					deviceComboBox.enabled = true
					baudrateText.enabled = false
					hostText.enabled = true
					portText.enabled = true
				}
				else
				{
					deviceComboBox.enabled = true
					baudrateText.enabled = true
					hostText.enabled = false
					portText.enabled = false
				}
			}
		}

		Text {
			text: "Device"
			font.pixelSize: 14
		}

		ComboBox {
			id: deviceComboBox
			width: 110
			font.pixelSize: 14
			implicitHeight: 25
		}

		Text {
			text: "Host"
			font.pixelSize: 14
		}

		TextField {
			id: hostText
			text: host
			width: 110
			font.pixelSize: 14
			implicitHeight: 25
		}

		Text {
			text: "Port"
			font.pixelSize: 14
		}

		TextField {
			id: portText
			text: port
			width: 110
			font.pixelSize: 14
			implicitHeight: 25
		}

		Text {
			text: "Baudrate"
			font.pixelSize: 14
		}

		TextField {
			id: baudrateText
			text: baudrate
			width: 110
			font.pixelSize: 14
			implicitHeight: 25
		}
	}

	onAccepted: {
		connect()
	}

	function load()
	{
		protocolComboBox.model = proxy.protocols
		deviceComboBox.model = proxy.devices
		protocol = proxy.connection["protocol"]
		device = proxy.connection["device"]
		host = proxy.connection["host"]
		port = proxy.connection["port"]
		baudrate = proxy.connection["baudrate"]

		var index = protocolComboBox.find(protocol)
		protocolComboBox.currentIndex = index === -1 ? 0 : index
		index = deviceComboBox.find(device)
		deviceComboBox.currentIndex = index === -1 ? 0 : index
	}

	function connect()
	{
		protocol = protocolComboBox.currentText
		device = deviceComboBox.currentText

		proxy.connection = { "protocol": protocol, "device": device, "host": host,
							"port": port, "baudrate": baudrate }
		proxy.connect()
	}
}
