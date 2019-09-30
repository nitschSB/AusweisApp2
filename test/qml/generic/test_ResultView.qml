/*
 * \copyright Copyright (c) 2017-2019 Governikus GmbH & Co. KG, Germany
 */

import QtTest 1.10

TestCase {
	name: "ModuleImportTest"
	id: parent

	function test_load_ResultView() {
		var item = createTemporaryQmlObject("
			import Governikus.ResultView 1.0;
			ResultView {}
			", parent);
		item.destroy();
	}
}
