/**
 * Test Class used to Testing in a Trigger for mocking a pipeline
 * @author Christopher Pezza (@chiefpansancolt)
 * @since 2024-11-24
 * @group Test Utilities
 */
public with sharing class TestObjectPipelineHandler extends ATriggerHandler {
	public override Type getType() {
		return TestObjectPipelineHandler.class;
	}
}