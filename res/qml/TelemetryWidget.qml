import QtQuick
import QtPositioning
import QtQuick.Layouts

Rectangle {
	id: control
	visible: true
	width: 150
	height: {
		if (mainWindow.isWinOS)
			return 390
		else
			return 360
	}
	color: backColor
	border.width: 2
	border.color: "#ffffff"
	radius: 10

	property int fontSize: 11
	property color backColor: "#172839"

	Component.onCompleted: {
		update()
		proxy.onTelemetryChanged.connect(function() {
			update()
		})
	}

	MouseArea {
		id: mouseArea
		anchors.fill: parent
		drag.target: parent
	}

	GridLayout {
		id: grid
		anchors.fill: parent
		rows: 15
		columns: 2
		rowSpacing: 0
		columnSpacing: 0
		anchors.margins: 10

		Text {
			id: text1
			text: qsTr("Alt")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: textAlt
			text: qsTr("Text")
			color: "#ffffff"
			font.pointSize: fontSize
			Layout.alignment: Qt.AlignRight
		}

		Text {
			id: text3
			text: qsTr("Roll")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: textRoll
			text: qsTr("Text")
			color: "#ffffff"
			font.pointSize: fontSize
			Layout.alignment: Qt.AlignRight
		}

		Text {
			id: text5
			text: qsTr("Pitch")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: textPitch
			text: qsTr("Text")
			color: "#ffffff"
			font.pointSize: fontSize
			Layout.alignment: Qt.AlignRight
		}

		Text {
			id: text7
			text: qsTr("Yaw")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: textYaw
			text: qsTr("Text")
			color: "#ffffff"
			font.pointSize: fontSize
			Layout.alignment: Qt.AlignRight
		}

		Text {
			id: text9
			text: qsTr("GrSpeed")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: textGrSpeed
			text: qsTr("Text")
			color: "#ffffff"
			font.pointSize: fontSize
			Layout.alignment: Qt.AlignRight
		}

		Text {
			id: text11
			text: qsTr("AirSpeed")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: textAirSpeed
			text: qsTr("Text")
			color: "#ffffff"
			font.pointSize: fontSize
			Layout.alignment: Qt.AlignRight
		}

		Text {
			id: text13
			text: qsTr("Gps")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: textGps
			text: qsTr("Text")
			color: "#ffffff"
			font.pointSize: fontSize
			Layout.alignment: Qt.AlignRight
		}

		Text {
			id: text15
			text: qsTr("GpsHdop")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: textGpsHdop
			text: qsTr("Text")
			color: "#ffffff"
			font.pointSize: fontSize
			Layout.alignment: Qt.AlignRight
		}

		Text {
			id: text17
			text: qsTr("Satellites")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: textSatellites
			text: qsTr("Text")
			color: "#ffffff"
			font.pointSize: fontSize
			Layout.alignment: Qt.AlignRight
		}

		Text {
			id: text19
			text: qsTr("Heading")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: textHeading
			text: qsTr("Text")
			color: "#ffffff"
			font.pointSize: fontSize
			Layout.alignment: Qt.AlignRight
		}

		Text {
			id: text21
			text: qsTr("BatRem")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: textBatteryRem
			text: qsTr("Text")
			color: "#ffffff"
			font.pointSize: fontSize
			Layout.alignment: Qt.AlignRight
		}

		Text {
			id: text23
			text: qsTr("BatVolt")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: textBatteryVolt
			text: qsTr("Text")
			color: "#ffffff"
			font.pointSize: fontSize
			Layout.alignment: Qt.AlignRight
		}

		Text {
			id: text25
			text: qsTr("BatAmp")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: textBatteryAmp
			text: qsTr("Text")
			color: "#ffffff"
			font.pointSize: fontSize
			Layout.alignment: Qt.AlignRight
		}

		Text {
			id: text27
			text: qsTr("Link")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: textLink
			text: qsTr("Text")
			color: "#ffffff"
			font.pointSize: fontSize
			Layout.alignment: Qt.AlignRight
		}

		Text {
			id: text29
			text: qsTr("Mode")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: textMode
			text: qsTr("Text")
			color: "#ffffff"
			font.pointSize: fontSize
			Layout.alignment: Qt.AlignRight
		}
	}

	function update() {
		textAlt.text = proxy.telemetry["alt"].toFixed(1) + "m"
		textRoll.text = proxy.telemetry["roll"].toFixed(1) + "^"
		textPitch.text = proxy.telemetry["pitch"].toFixed(1) + "^"
		textYaw.text = proxy.telemetry["yaw"].toFixed(1) + "^"
		textGrSpeed.text = proxy.telemetry["grSpeed"].toFixed(1) + "ms"
		textAirSpeed.text = proxy.telemetry["airSpeed"].toFixed(1) + "ms"
		textGps.text = proxy.telemetry["gps"]
		textGpsHdop.text = "v" + proxy.telemetry["gpsHdop"].toFixed(1)
		textSatellites.text = proxy.telemetry["satellites"]
		textHeading.text = proxy.telemetry["heading"] + "^"
		textBatteryRem.text = proxy.telemetry["batteryRem"] + "%"
		textBatteryVolt.text = proxy.telemetry["batteryVolt"] + "mV"
		textBatteryAmp.text = proxy.telemetry["batteryAmp"] + "mA"
		textLink.text = proxy.telemetry["link"] + "%"
		textMode.text = proxy.telemetry["mode"]
		hudWidget.update(proxy.telemetry["roll"], proxy.telemetry["pitch"])

		// Update quadrocopter
		if (proxy.telemetry["status"] > 0)
		{
			var quadro = mapId.createQuadro(proxy.telemetry["number"])
			quadro.name = proxy.telemetry["name"]
			quadro.coordinate = QtPositioning.coordinate(proxy.telemetry["lat"], proxy.telemetry["lon"])
			quadro.update(proxy.telemetry["yaw"])
		}
	}
}
