/*
 * \copyright Copyright (c) 2015-2019 Governikus GmbH & Co. KG, Germany
 */

import QtQuick 2.10
import QtQml 2.2
import QtGraphicalEffects 1.0

import Governikus.Global 1.0
import Governikus.Style 1.0

 Item {
	property real factor: 1.1

	id: busyIndicator
	anchors.centerIn: parent

	state: parent.running ? "running" : "notrunning"
	states: [
		State{ name: "running" },
		State{ name: "notrunning" }
	]

	transitions: [
		Transition { from: "notrunning"; to: "running"
			SequentialAnimation {
				PropertyAnimation { target: timer; property: "running"; to: true }
				PropertyAction { target: busyIndicator; property: "rotation"; value: 0 }
				PropertyAction { target: green; property: "rotation"; value: 0 }
				PropertyAction { target: blue; property: "rotation"; value: 0 }
				PropertyAnimation { target: rect; property: "opacity"; to: 1 }
			}
		},
		Transition { from: "running"; to: "notrunning"
			SequentialAnimation {
				PropertyAction { target: timer; property: "running"; value: false }
				PropertyAction { target: rect; property: "opacity"; value: 0 }
			}
		}
	]


	Behavior on rotation {
		NumberAnimation { duration: timer.interval; easing.type: Easing.Linear }
	}
	Rectangle {
		id: rect
		anchors.centerIn: parent
		height: parent.height * factor
		width: height
		radius: width / 2
		color: Style.color.background
		opacity: 0

		Behavior on opacity {
			NumberAnimation { duration: 200 }
		}
	}

	Timer {
		id: timer
		interval: 1000; repeat: true
		onTriggered: {
			green.rotation = green.rotation + Utils.getRandomInt(0, 135)
			blue.rotation = blue.rotation + Utils.getRandomInt(0, 195)
			busyIndicator.rotation = busyIndicator.rotation + 100
		}
	}

	ConicalGradient {
		id: green
		anchors.fill: rect
		source: rect
		angle: 0.0
		cached: true
		opacity: rect.opacity
		gradient: Gradient
		{
			GradientStop {color: Constants.green; position: 0.0}
			GradientStop {color: Constants.green; position: 0.50}
			GradientStop {color: Style.color.transparent; position: 0.5000000000000001}
			GradientStop {color: Style.color.transparent; position: 1.0}
		}
		Behavior on rotation {
			NumberAnimation { duration: timer.interval; easing.type: Easing.InOutQuad }
		}
	}
	ConicalGradient {
		id: blue
		anchors.fill: rect
		source: rect
		angle: 0.0
		cached: true
		opacity: rect.opacity
		gradient: Gradient
		{
			GradientStop {color: Style.color.transparent; position: 0.0}
			GradientStop {color: Style.color.transparent; position: 0.50}
			GradientStop {color: rect.color; position: 0.5000000000000001}
			GradientStop {color: Constants.blue; position: 1.0}
		}
		Behavior on rotation {
			NumberAnimation { duration: timer.interval; easing.type: Easing.InOutQuad }
		}
	}
}
