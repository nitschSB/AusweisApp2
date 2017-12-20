/*!
 * \copyright Copyright (c) 2014-2017 Governikus GmbH & Co. KG, Germany
 */

#include "ConnectionHandle.h"

using namespace governikus;


bool ConnectionHandle::isValid() const
{
	return !mSlotHandle.isEmpty() && !mCardApplication.isEmpty() && !mContextHandle.isEmpty() && !mIfdName.isEmpty()
		   && !mSlotIndex.isEmpty();
}


const QString& ConnectionHandle::getSlotHandle() const
{
	return mSlotHandle;
}


void ConnectionHandle::setSlotHandle(const QString& pSlotHandle)
{
	mSlotHandle = pSlotHandle;
}


const QString& ConnectionHandle::getCardApplication() const
{
	return mCardApplication;
}


void ConnectionHandle::setCardApplication(const QString& pCardApplication)
{
	mCardApplication = pCardApplication;
}


const QString& ConnectionHandle::getSlotIndex() const
{
	return mSlotIndex;
}


void ConnectionHandle::setSlotIndex(const QString& pSlotIndex)
{
	mSlotIndex = pSlotIndex;
}


const QString& ConnectionHandle::getIfdName() const
{
	return mIfdName;
}


void ConnectionHandle::setIfdName(const QString& pIfdName)
{
	mIfdName = pIfdName;
}


const QString& ConnectionHandle::getContextHandle() const
{
	return mContextHandle;
}


void ConnectionHandle::setContextHandle(const QString& pContextHandle)
{
	mContextHandle = pContextHandle;
}
