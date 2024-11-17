public without sharing class TriggerPipeline extends ADMLDataProvider {
	private Set<String> executedHandlers = new Set<String>();
    private List<ATriggerHandler> triggerHandlers = null;
	private TriggerData triggerData;
    private List<Trigger_Pipeline__mdt> pipeline;

    public TriggerPipeline(sObjectType objectType) {
		this.triggerData = new TriggerData(Trigger.new, Trigger.old, Trigger.newMap, Trigger.oldMap);
        this.pipeline = getPipeline(objectType);

        if (this.pipeline.size() > 0 && this.pipeline[0].Trigger_Handlers__r.size() > 0) {
            executePipeline();
        }
    }

	private void executePipeline() {
        preProcessing();

		if (this.triggerHandlers.size() > 0) {
			processing();
			postProcessing();
		}
    }

	private void preProcessing() {
        List<ATriggerHandler> validHandlers = new List<ATriggerHandler>();

		for (Trigger_Handler__mdt handler : this.pipeline[0].Trigger_Handlers__r) {
			try {
				Type handlerType = Type.forName(handler.Class_Name__c);
				if (handlerType != null) {
					ATriggerHandler handlerInstance = (ATriggerHandler) handlerType.newInstance();

					if (handlerInstance.shouldExecute()) {
						validHandlers.add(handlerInstance);
					}
				}
			} catch (Exception e) {
				ErrorLogger.logError(e, handler.Class_Name__c);
			}
		}

        this.triggerHandlers = validHandlers;
    }

	private void processing() {
        for (ATriggerHandler handler : this.triggerHandlers) {
            String contextKey = getContextKey(handler);

            if (handler.isDoubleFireSafe() && this.executedHandlers.contains(contextKey)) {
                continue;
            }

			try {
            	handler.process(this.triggerData);
			} catch(Exception e) {
				ErrorLogger.logError(e, handler.getType().getName());
			}

            if (handler.isDoubleFireSafe()) {
                this.executedHandlers.add(contextKey);
            }
        }
    }

	private void postProcessing() {
		for (ATriggerHandler handler : this.triggerHandlers) {
			mergeProviders(handler);
		}

		try {
			new DMLUtility(this).performAllDml();
		} catch(Exception e) {
			ErrorLogger.logError(e);
		}
	}

	private static String getContextKey(ITriggerHandler handler) {
        return handler.getType().getName() + '_' + Trigger.operationType.name();
    }

	private static List<Trigger_Pipeline__mdt> getPipeline(sObjectType objectType) {
		String objectName = objectType.getDescribe().getName();
		String pipelineFieldName = getSequenceIndicator() + '_' + getOperation() + '_Enabled__c';
		String handlerFieldName = 'Use_' + getSequenceIndicator() + '_' + getOperation() + '__c';
		String query =
			'SELECT Id, DeveloperName, (SELECT Id, Class_Name__c FROM Trigger_Handlers__r WHERE Is_Active__c = TRUE AND ' +
			handlerFieldName +
			' = TRUE ORDER BY Order__c ASC) FROM Trigger_Pipeline__mdt WHERE Is_Active__c = TRUE AND ' +
			pipelineFieldName +
			' = TRUE AND Object_Name__c = :objectName';

		return Database.query(query, AccessLevel.SYSTEM_MODE);
	}

	private static String getOperation() {
		if (Trigger.isInsert) {
			return INSERT_OPERATION;
		} else if (Trigger.isUpdate) {
			return UPDATE_OPERATION;
		} else if (Trigger.isDelete) {
			return DELETE_OPERATION;
		}

		return UNDELETE_OPERATION;
	}

	private static String getSequenceIndicator() {
		if (Trigger.isBefore) {
			return BEFORE;
		}

		return AFTER;
	}

	private static final String INSERT_OPERATION = 'Insert',
		UPDATE_OPERATION = 'Update',
		DELETE_OPERATION = 'Delete',
		UNDELETE_OPERATION = 'Undelete',
		BEFORE = 'Before',
		AFTER = 'After';
}
