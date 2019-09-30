/*
 * \copyright Copyright (c) 2016-2019 Governikus GmbH & Co. KG, Germany
 */

import QtQuick 2.10
import QtGraphicalEffects 1.10

import Governikus.Global 1.0
import Governikus.Style 1.0
import Governikus.Provider 1.0
import Governikus.TitleBar 1.0
import Governikus.View 1.0
import Governikus.Type.AuthModel 1.0
import Governikus.Type.SettingsModel 1.0
import Governikus.Type.NumberModel 1.0


SectionPage {
	id: baseItem

	navigationAction: NavigationAction {
		state: "cancel"
		onClicked: AuthModel.cancelWorkflow()
	}
	//: LABEL IOS_PHONE
	title: qsTr("Identify") + SettingsModel.translationTrigger

	content: Column {
		width: baseItem.width
		padding: Constants.pane_padding

		Column {
			width: parent.width - 2 * Constants.pane_padding

			spacing: Constants.component_spacing

			GText {
				width: parent.width

				//: LABEL IOS_PHONE
				text: qsTr("You are about to identify yourself towards the following service provider:") + SettingsModel.translationTrigger
				textStyle: Style.text.normal_secondary
			}

			Pane {

				Item {
					width: parent.width
					height: providerEntries.height

					Accessible.description: qsTr("Click for more information about the service provider") + SettingsModel.translationTrigger
					Accessible.onPressAction: mouseArea.clicked(null)

					Column {
						id: providerEntries
						anchors.top: parent.top
						anchors.left: parent.left
						anchors.right: forwardAction.left
						spacing: Constants.pane_spacing

						ProviderInfoSection {
							imageSource: "qrc:///images/provider/information.svg"
							//: LABEL IOS_PHONE
							title: qsTr("Service provider") + SettingsModel.translationTrigger
							name: certificateDescriptionModel.subjectName
						}
						ProviderInfoSection {
							imageSource: "qrc:///images/provider/purpose.svg"
							//: LABEL IOS_PHONE
							title: qsTr("Purpose for reading out requested data") + SettingsModel.translationTrigger
							name: certificateDescriptionModel.purpose
						}
					}

					Image {
						id: forwardAction
						anchors.right: parent.right
						anchors.verticalCenter: providerEntries.verticalCenter

						sourceSize.height: Style.dimens.small_icon_size
						fillMode: Image.PreserveAspectFit
						source: "qrc:///images/arrowRight.svg"

						ColorOverlay {
							anchors.fill: forwardAction
							source: forwardAction
							color: Style.color.secondary_text
						}
					}

					MouseArea {
						id: mouseArea

						anchors.fill: parent

						onClicked: firePush(certificateDescriptionPage)
					}

					CertificateDescriptionPage {
						id: certificateDescriptionPage
						name: certificateDescriptionModel.subjectName
						visible: false
					}
				}
			}

			GButton {
				iconSource: "qrc:///images/npa.svg"
				anchors.horizontalCenter: parent.horizontalCenter
				//: LABEL IOS_PHONE %1 can be CAN or PIN
				text: qsTr("Proceed to %1 entry").arg(NumberModel.isCanAllowedMode ? "CAN" : "PIN") + SettingsModel.translationTrigger
				onClicked: {
					chatModel.transferAccessRights()
					AuthModel.continueWorkflow()
				}
			}

			GText {
				width: parent.width

				//: LABEL IOS_PHONE
				text: qsTr("The following data will be transferred to the service provider when you enter the PIN:") + SettingsModel.translationTrigger
				textStyle: Style.text.normal_secondary
			}

			Pane {
				id: transactionInfo
				//: LABEL IOS_PHONE
				title: qsTr("Transactional information") + SettingsModel.translationTrigger
				visible: !!transactionInfoText.text

				GText {
					id: transactionInfoText

					width: parent.width

					text: AuthModel.transactionInfo
					textStyle: Style.text.normal_secondary
				}
			}

			DataGroup {
				onScrollPageDown: baseItem.scrollPageDown()
				onScrollPageUp: baseItem.scrollPageUp()

				//: LABEL IOS_PHONE
				title: qsTr("Required Data") + SettingsModel.translationTrigger
				chat: chatModel.required
			}

			DataGroup {
				onScrollPageDown: baseItem.scrollPageDown()
				onScrollPageUp: baseItem.scrollPageUp()

				//: LABEL IOS_PHONE
				title: qsTr("Optional Data") + SettingsModel.translationTrigger
				chat: chatModel.optional
			}
		}
	}
}
