/*!
 * \brief Class to provide information about available card readers.
 *
 * \copyright Copyright (c) 2015-2017 Governikus GmbH & Co. KG, Germany
 */

#pragma once

#include "UpdatableFile.h"

#include <QCoreApplication>
#include <QSharedData>
#include <QString>


namespace governikus
{
class ReaderConfigurationInfo
{
	Q_DECLARE_TR_FUNCTIONS(ReaderConfigurationInfo)

	private:
		class InternalInfo
			: public QSharedData
		{
			public:
				const bool mKnown;
				const uint mVendorId;
				const uint mProductId;
				const QString mName;
				const QString mUrl;
				const QString mPattern;
				const QString mIcon;
				const QString mIconWithNPA;


				InternalInfo(bool pKnown, uint pVendorId, uint pProductId, const QString& pName, const QString& pUrl,
						const QString& pPattern, const QString& pIcon, const QString& pIconWithNPA)
					: mKnown(pKnown)
					, mVendorId(pVendorId)
					, mProductId(pProductId)
					, mName(pName)
					, mUrl(pUrl)
					, mPattern(pPattern)
					, mIcon(pIcon)
					, mIconWithNPA(pIconWithNPA)
				{

				}


				bool operator ==(const InternalInfo& pOther) const
				{
					return !(mKnown != pOther.mKnown ||
						   mVendorId != pOther.mVendorId ||
						   mProductId != pOther.mProductId ||
						   mName != pOther.mName ||
						   mUrl != pOther.mUrl ||
						   mPattern != pOther.mPattern ||
						   mIcon != pOther.mIcon ||
						   mIconWithNPA != pOther.mIconWithNPA);
				}


		};

		QSharedDataPointer<InternalInfo> d;

	public:
		ReaderConfigurationInfo();
		ReaderConfigurationInfo(const QString& pReaderName);
		ReaderConfigurationInfo(uint pVendorId, uint pProductId,
				const QString& pName, const QString& pUrl, const QString& pPattern,
				const QString& pIcon, const QString& pIconWithNPA);

		virtual ~ReaderConfigurationInfo();

		bool operator ==(const ReaderConfigurationInfo& pOther) const;

		bool isKnownReader() const;
		uint getVendorId() const;
		uint getProductId() const;
		const QString& getName() const;
		const QString& getUrl() const;
		const QString& getPattern() const;
		QSharedPointer<UpdatableFile> getIcon() const;
		QSharedPointer<UpdatableFile> getIconWithNPA() const;
};


inline uint qHash(const ReaderConfigurationInfo& info)
{
	return qHash(info.getName());
}


} /* namespace governikus */
