import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtLocation
import QtPositioning

Rectangle {
	id: control
	visible: true
	width: {
		if (mainWindow.isWinOS)
			return 645
		else
			return 625
	}
	height: 28
	color: backColor
	border.width: 2
	border.color: "#ffffff"
	radius: 10

	property int fontSize: 11
	property color backColor: "#172839"

	property real homeDistance: 0.0
	property real missionDistance: 0.0
	property real goalDistance: 0.0
	property real latitude: 0.0
	property real longitude: 0.0
	property real altitude: 0.0

	MouseArea {
		id: mouseArea
		anchors.fill: parent
		drag.target: parent
	}

	RowLayout {
		anchors.fill: parent
		spacing: 0

		Text {
			id: text1
			Layout.leftMargin: 5
			horizontalAlignment: Text.AlignHCenter
			text: qsTr("Home:")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: textHome
			horizontalAlignment: Text.AlignHCenter
			text: qsTr("0.00 km")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: text2
			text: qsTr(" | ")
			horizontalAlignment: Text.AlignHCenter
			color: "yellow"
			font.pointSize: 12
			font.bold: true
		}

		Text {
			id: text3
			horizontalAlignment: Text.AlignHCenter
			text: qsTr("Mission:")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: textMission
			horizontalAlignment: Text.AlignHCenter
			text: qsTr("0.00 km")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: text4
			horizontalAlignment: Text.AlignHCenter
			text: qsTr(" | ")
			color: "yellow"
			font.pointSize: fontSize
			font.bold: true
		}

		Text {
			id: text5
			horizontalAlignment: Text.AlignHCenter
			text: qsTr("Goal:")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: textGoal
			horizontalAlignment: Text.AlignHCenter
			text: qsTr("0.00 km")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: text6
			horizontalAlignment: Text.AlignHCenter
			text: qsTr(" | ")
			color: "yellow"
			font.pointSize: fontSize
			font.bold: true
		}

		Text {
			id: text7
			horizontalAlignment: Text.AlignHCenter
			text: qsTr("Lat:")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: textLat
			horizontalAlignment: Text.AlignHCenter
			text: qsTr("0.00000")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: text8
			horizontalAlignment: Text.AlignHCenter
			text: qsTr(" | ")
			color: "yellow"
			font.pointSize: fontSize
			font.bold: true
		}

		Text {
			id: text9
			horizontalAlignment: Text.AlignHCenter
			text: qsTr("Lon:")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: textLon
			horizontalAlignment: Text.AlignHCenter
			text: qsTr("0.00000")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: text10
			horizontalAlignment: Text.AlignHCenter
			text: qsTr(" | ")
			color: "yellow"
			font.pointSize: fontSize
			font.bold: true
		}

		Text {
			id: text11
			horizontalAlignment: Text.AlignHCenter
			text: qsTr("Alt:")
			color: "#ffffff"
			font.pointSize: fontSize
		}

		Text {
			id: textAlt
			horizontalAlignment: Text.AlignHCenter
			Layout.rightMargin: 5
			text: qsTr("0.0 m")
			color: "#ffffff"
			font.pointSize: fontSize
		}
	}

	function setCoordinate(coord)
	{
		var distance = (coord.distanceTo(mapId.homePoint) / 1000).toFixed(2)
		textHome.text = distance + " km"
		textLat.text = coord.latitude.toFixed(5)
		textLon.text = coord.longitude.toFixed(5)
		textAlt.text = proxy.getAltitude(coord.latitude, coord.longitude).toFixed(1) + " m";
	}

	function setMissionDistance(points)
	{
		if (points === null)
			textMission.text = "0.00 km"
		else
		{
			var distance = 0.0
			for (var i = 0; i < points.length - 1; i++)
			{
				if (points[i]['base'])
					continue

				var startPoint = QtPositioning.coordinate(points[i]['lat'], points[i]['lon'], points[i]['alt'])
				var endPoint = QtPositioning.coordinate(points[i + 1]['lat'], points[i + 1]['lon'], points[i + 1]['alt'])
				distance = distance + startPoint.distanceTo(endPoint)
			}

			textMission.text = (distance / 1000).toFixed(2) + " km"
		}
	}
}
