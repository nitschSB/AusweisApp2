/*!
 * \brief Unit tests for \DidAuthenticateEac1
 *
 * \copyright Copyright (c) 2014-2019 Governikus GmbH & Co. KG, Germany
 */

#include "paos/retrieve/DidAuthenticateEac1.h"
#include "paos/retrieve/DidAuthenticateEac1Parser.h"
#include "TestFileHelper.h"

#include <QtCore>
#include <QtTest>

using namespace governikus;

class test_DidAuthenticateEac1
	: public QObject
{
	Q_OBJECT

	private Q_SLOTS:
		void parseXml()
		{
			QByteArray content = TestFileHelper::readFile(":/paos/DIDAuthenticateEAC1.xml");
			QScopedPointer<DIDAuthenticateEAC1> eac1(static_cast<DIDAuthenticateEAC1*>(DidAuthenticateEac1Parser().parse(content)));
			QVERIFY(!eac1.isNull());

			QCOMPARE(eac1->getConnectionHandle().getCardApplication(), QString("4549445F49534F5F32343732375F42415345"));
			QCOMPARE(eac1->getConnectionHandle().getContextHandle(), QString("4549445F4946445F434F4E544558545F42415345"));
			QCOMPARE(eac1->getConnectionHandle().getIfdName(), QString("REINER SCT cyberJack RFID komfort USB 52"));
			QCOMPARE(eac1->getConnectionHandle().getSlotHandle(), QString("37343139303333612D616163352D343331352D386464392D656166393664636661653361"));
			QCOMPARE(eac1->getConnectionHandle().getSlotIndex(), QString("0"));

			QCOMPARE(eac1->getDidName(), QString("PIN"));

			QCOMPARE(eac1->getAuthenticatedAuxiliaryDataAsBinary(), QByteArray::fromHex("67447315060904007F000703010401530831393932313230367315060904007F000703010402530832303133313230367314060904007F000703010403530702760400110000"));
			QCOMPARE(eac1->getAuthenticatedAuxiliaryData()->getAgeVerificationDate(), QDate(1992, 12, 6));
			QCOMPARE(eac1->getCvCertificates().size(), 4);
			QCOMPARE(eac1->getCertificateDescriptionAsBinary(), QByteArray::fromHex("3082022F060A04007F00070301030101A12D0C2B446575747363686520506F737420436F6D2C204765736368C3A466747366656C64205369676E7472757374A2191317687474703A2F2F7777772E7369676E74727573742E6465A3080C06626F73204B47A429132768747470733A2F2F6465762D64656D6F2E676F7665726E696B75732D6569642E64653A38343433A58201580C820154416E736368726966743A0D0A6272656D656E206F6E6C696E6520736572766963657320476D6248202620436F2E204B470D0A416D2046616C6C7475726D20390D0A3238333539204272656D656E0D0A0D0A452D4D61696C2D416472657373653A0D0A686240626F732D6272656D656E2E64650D0A0D0A5A7765636B20646573204175736C657365766F7267616E67733A0D0A44656D6F6E7374726174696F6E20646573206549442D536572766963650D0A0D0A5A757374C3A46E6469676520446174656E73636875747A61756673696368743A0D0A446965204C616E64657362656175667472616774652066C3BC7220446174656E73636875747A20756E6420496E666F726D6174696F6E736672656968656974206465722046726569656E2048616E73657374616474204272656D656E0D0A41726E647473747261C39F6520310D0A3237353730204272656D6572686176656EA74631440420761099A58BFD5334E93A7A78E4F18B760FFCF8F513A4730C8AE9B59BCC0FE8C90420CEABB7E427174BCFFFB3499BF925A5D4A7887AD4FCF7747867912DEBB58D684C"));
			QCOMPARE(eac1->getCertificateDescription()->getIssuerName(), QStringLiteral("Deutsche Post Com, Gesch\u00E4ftsfeld Signtrust"));
			QVERIFY(eac1->getOptionalChat());
			QVERIFY(eac1->getRequiredChat());
			QCOMPARE(eac1->getTransactionInfo(), QString("this is a test for TransactionInfo"));
		}


		// Test data from Test TS_TA_2.1.1 from TR-03105-5.2
		void test_TS_TA_2_1_1()
		{
			QByteArray content = TestFileHelper::readFile(":/paos/DIDAuthenticateEAC1_TS_TA_2.1.1.xml");
			QScopedPointer<DIDAuthenticateEAC1> eac1(static_cast<DIDAuthenticateEAC1*>(DidAuthenticateEac1Parser().parse(content)));

			QVERIFY(eac1 == nullptr);
		}


};

QTEST_GUILESS_MAIN(test_DidAuthenticateEac1)
#include "test_DidAuthenticateEac1.moc"
