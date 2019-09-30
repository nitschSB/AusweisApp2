/*
 * \copyright Copyright (c) 2018-2019 Governikus GmbH & Co. KG, Germany
 */

import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import Governikus.Global 1.0
import Governikus.Style 1.0


BaseConfirmationPopup {
	id: root

	buttons: Row {
		width: parent.width

		layoutDirection: Qt.RightToLeft
		spacing: Constants.component_spacing
		bottomPadding: Constants.pane_padding
		rightPadding: Constants.pane_padding

		GButton {
			visible: style & ConfirmationPopup.PopupStyle.OkButton

			text: root.okButtonText

			onClicked: root.accept()
		}

		GButton {
			visible: style & ConfirmationPopup.PopupStyle.CancelButton

			text: root.cancelButtonText

			onClicked: root.cancel()
		}
	}
}

