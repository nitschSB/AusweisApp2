/*!
 * \brief UIPlugIn implementation of the Json API.
 *
 * \copyright Copyright (c) 2016-2022 Governikus GmbH & Co. KG, Germany
 */

#pragma once

#include "context/WorkflowContext.h"
#include "MessageDispatcher.h"
#include "UIPlugIn.h"

namespace governikus
{

class UIPlugInJson
	: public UIPlugIn
{
	Q_OBJECT
	Q_PLUGIN_METADATA(IID "governikus.UIPlugIn" FILE "metadata.json")
	Q_INTERFACES(governikus::UIPlugIn)

	private:
		MessageDispatcher mMessageDispatcher;
		bool mEnabled;

		inline void callFireMessage(const QByteArray& pMsg, bool pLogging = true);

	public:
		UIPlugInJson();
		~UIPlugInJson() override = default;

		void setEnabled(bool pEnable = true);
		[[nodiscard]] bool isEnabled() const;

	private Q_SLOTS:
		void doShutdown() override;
		void onWorkflowStarted(QSharedPointer<WorkflowContext> pContext) override;
		void onWorkflowFinished(QSharedPointer<WorkflowContext> pContext) override;
		void onReaderEvent(const ReaderInfo& pInfo);
		void onStateChanged(const QString& pNewState);

	public Q_SLOTS:
		void doMessageProcessing(const QByteArray& pMsg);

	Q_SIGNALS:
		void fireMessage(const QByteArray& pMsg);
};

} // namespace governikus
