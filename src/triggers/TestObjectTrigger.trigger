trigger TestObjectTrigger on Test_Object__c(
	before insert,
	after insert,
	before update,
	after update,
	before delete,
	after delete,
	after undelete
) {
	if (Test.isRunningTest()) {
		if (ATriggerHandlerTest.runTriggerHandler) {
			if (TestObjectHandler.mockHandler != null) {
				TriggerData triggerData = new TriggerData(Trigger.new, Trigger.old, Trigger.newMap, Trigger.oldMap);
				TestObjectHandler.mockHandler.process(triggerData);
			}
		} else if (TriggerPipelineTest.runTriggerPipeline) {
			new TriggerPipeline(Schema.Test_Object__c.sObjectType);
		}
	}
}
