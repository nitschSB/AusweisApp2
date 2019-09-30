/*
 * \copyright Copyright (c) 2015-2019 Governikus GmbH & Co. KG, Germany
 */

import QtQuick 2.10
import QtQuick.Controls 2.3

import Governikus.Global 1.0
import Governikus.Style 1.0
import Governikus.Type.ApplicationModel 1.0


Button {
	id: control

	height: (1.5 * contentItem.font.pixelSize) / fontScale
	width: height

	padding: 0

	property real fontScale: 1
	property alias color: circle.color

	contentItem: GText {
		text: control.text
		textStyle: Style.text.header_inverse
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
		font.pixelSize: fontScale * ApplicationModel.scaleFactor * 50
		visible: control.enabled
	}

	background: Rectangle {
		id: circle

		border.color: Constants.black
		border.width: control.focus ? Math.max(1, ApplicationModel.scaleFactor * 2) : 0
		radius: control.height / 2
		color: Constants.white
		visible: control.enabled

		Rectangle {
			anchors.centerIn: parent
			radius: height / 2
			color: Constants.black
			opacity: 0.1

			SequentialAnimation on height {
				running: control.pressed
				alwaysRunToEnd: true

				NumberAnimation { from: 0; to: background.height }
				PauseAnimation { duration: 100 }
				PropertyAction { value: 0 }
			}

			SequentialAnimation on width {
				running: control.pressed
				alwaysRunToEnd: true

				NumberAnimation { from: 0; to: background.width }
				PauseAnimation { duration: 100 }
				PropertyAction { value: 0 }
			}
		}
	}
}
