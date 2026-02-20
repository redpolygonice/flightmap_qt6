import QtQuick
import QtQuick.Dialogs
import QtQuick.Layouts
import QtQuick.Controls
import QtQml.Models
import QtLocation

Dialog {
	visible: false
	title: "Maps"
	width: 370
	height: 450
	font.pixelSize: 14

	standardButtons: Dialog.Ok | Dialog.Cancel

	Plugin {
		id: mapPlugin
	}

	Component.onCompleted: {
		for (var i = 0; i < mapPlugin.availableServiceProviders.length; i++) {
			var provider = mapPlugin.availableServiceProviders[i]
			var plugin = Qt.createQmlObject('import QtLocation; Plugin { name:"' + provider + '"}', mainWindow)
			var theMap = Qt.createQmlObject('import QtLocation; Map { }', mainWindow)
			theMap.plugin = plugin

			for (var j = 0; j < theMap.supportedMapTypes.length; j++) {
				listModel.append({ provider: provider, type: theMap.supportedMapTypes[j].name })
			}

			theMap.destroy()
			plugin.destroy()
		}
	}

	Rectangle {
		anchors.fill: parent
		color: "#ffffff"
		border.width: 2
		border.color: "#aaaaaa"
		radius: 3


		ListModel {
			id: listModel
		}

		Component {
			id: mapDelegate

			Item {
				width: listView.width
				height: 22

				RowLayout {
					//anchors.fill: parent
					Layout.alignment: Qt.AlignVCenter

					Text {
						text: '<b> ' + provider + '</b>:';
						color: "black";
						horizontalAlignment: Text.AlignLeft
						verticalAlignment: Text.AlignVCenter
						font.pointSize: 12
					}

					Text {
						text: type;
						color: "dimgrey";
						horizontalAlignment: Text.AlignLeft
						verticalAlignment: Text.AlignVCenter
						font.pointSize: 12
					}
				}

				MouseArea {
					anchors.fill: parent
					onClicked: listView.currentIndex = model.index

					onDoubleClicked: {
						accept()
						select(model.index)
					}
				}
			}
		}

		ScrollView {
			anchors.fill: parent

			ListView {
				id: listView
				anchors.fill: parent
				anchors.margins: 1
				spacing: 5
				clip: true
				model: listModel
				delegate: mapDelegate
				highlight: Rectangle { color: "lightsteelblue"; radius: 3 }
				highlightFollowsCurrentItem: true
				highlightMoveDuration: 100
				highlightMoveVelocity: -1
				focus: true
			}
		}
	}

	onAccepted: {
		select(listView.currentIndex)
	}

	function select(index)
	{
		var provider = listModel.get(index).provider
		var type = listModel.get(index).type
		var parameters = { "provider": provider, "mapType": type }
		mainWindow.createMap(parameters)
	}
}
