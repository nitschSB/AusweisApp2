/*
 * \copyright Copyright (c) 2015-2019 Governikus GmbH & Co. KG, Germany
 */

import QtQuick 2.10
import QtQuick.Controls 2.3

import Governikus.Global 1.0
import Governikus.TitleBar 1.0
import Governikus.Navigation 1.0
import Governikus.SplashScreen 1.0
import Governikus.View 1.0
import Governikus.FeedbackView 1.0
import Governikus.Type.ApplicationModel 1.0
import Governikus.Type.SettingsModel 1.0
import Governikus.Style 1.0

ApplicationWindow {
	id: appWindow

	visible: true
	width: 750 / 2 //Screen.desktopAvailableWidth
	height: 1334 / 2

	title: "Governikus AusweisApp2"
	color: Style.color.background
	Component.onCompleted: {
		flags |= Qt.MaximizeUsingFullscreenGeometryHint
	}

	menuBar: TitleBar {
		id: titleBar

		property var currentSectionPage: if (contentArea) contentArea.currentSectionPage

		visible: !splashScreen.visible && (!currentSectionPage || currentSectionPage.titleBarVisible)

		navigationAction: currentSectionPage ? currentSectionPage.navigationAction : null
		title: currentSectionPage ? currentSectionPage.title : ""
		rightAction: currentSectionPage ?  currentSectionPage.rightTitleBarAction : null
		subTitleBarAction: currentSectionPage ?  currentSectionPage.subTitleBarAction : null
		color: currentSectionPage ? currentSectionPage.titleBarColor : null
		titleBarOpacity: contentArea.visibleItem && contentArea.visibleItem.stack.currentItem ? contentArea.visibleItem.stack.currentItem.titleBarOpacity : 1
	}

	onClosing: { // back button pressed
		if (contentArea.visibleItem)
		{
			var activeStackView = contentArea.visibleItem.stack
			var navigationAction = activeStackView.currentItem.navigationAction

			if (activeStackView.depth <= 1
				&& (!navigationAction || navigationAction.state === "")) {
				if (contentArea.state === "identify"
					|| SettingsModel.showSetupAssistantOnStart) { // Don't go back to "identify" section page when setup tutorial is active
					var currentTime = new Date().getTime();
					if( currentTime - d.lastCloseInvocation < 1000 ) {
						plugin.fireQuitApplicationRequest()
						return
					}

					d.lastCloseInvocation = currentTime
					//: INFO ANDROID IOS Hint that is shown if the users pressed the "back" button on the top-most navigation level for the first time (a second press closes the app).
					ApplicationModel.showFeedback(qsTr("To close the app, quickly press the back button twice."))
				} else {
					navBar.state = "identify"
					navBar.currentIndex = 0
					navBar.lockedAndHidden = false
				}
			}
			else if (navigationAction) {
				if (navBar.isOpen) {
					navBar.close()
				}
				else if (navigationAction.state !== "hidden") {
					navigationAction.clicked(undefined)
				}
			}
		}

		close.accepted = false
	}

	QtObject {
		id: d

		property var lastCloseInvocation: 0
	}

	Action {
		shortcut: "Ctrl+Alt+R"
		onTriggered: plugin.developerBuild ? plugin.doRefresh() : ""
	}

	Action {
		shortcut: "Escape"
		onTriggered: appWindow.close()
	}

	Connections {
		target: plugin
		enabled: contentArea.ready
		onFireApplicationActivated: feedback.showIfNecessary()
	}

	ContentAreaLoader {
		id: contentArea

		anchors {
			left: Constants.leftNavigation ? navBar.right : parent.left
			top: parent.top
			right: parent.right
			bottom: Constants.bottomNavigation ? navBar.top : parent.bottom
			bottomMargin: (
				currentSectionPage && currentSectionPage.automaticSafeAreaMarginHandling &&
				(!Constants.bottomNavigation || navBar.lockedAndHidden)
			) ? plugin.safeAreaMargins.bottom : 0

			Behavior on bottomMargin {
				NumberAnimation {duration: Constants.animation_duration}
			}
		}

		state: navBar.state
		onReadyChanged: {
			splashScreen.hide()
			if (!ApplicationModel.currentWorkflow && !SettingsModel.showSetupAssistantOnStart) {
				navBar.lockedAndHidden = false
			}

			feedback.showIfNecessary()
		}
	}

	SplashScreen {
		id: splashScreen

		color: appWindow.color
	}

	Navigation {
		id: navBar

		visible: !splashScreen.visible
		anchors.left: parent.left
		anchors.top: Constants.leftNavigation ? parent.top : undefined
		anchors.right: Constants.bottomNavigation ? parent.right : undefined
		anchors.bottom: parent.bottom

		onReselectedState: contentArea.reselectedState()
	}

	ConfirmationPopup {
		id: toast

		visible: ApplicationModel.feedback !== ""

		style: ApplicationModel.isScreenReaderRunning() ? ConfirmationPopup.PopupStyle.OkButton : ConfirmationPopup.PopupStyle.NoButtons
		closePolicy: Popup.NoAutoClose
		modal: ApplicationModel.isScreenReaderRunning()
		dim: true

		text: ApplicationModel.feedback

		onConfirmed: ApplicationModel.onShowNextFeedback()
	}

	StoreFeedbackPopup {
		id: feedback

		function showIfNecessary() {
			if (!ApplicationModel.currentWorkflow && SettingsModel.requestStoreFeedback()) {
				SettingsModel.hideFutureStoreFeedbackDialogs()
				feedback.open()
			}
		}
	}
}
