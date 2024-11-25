/**
 * Test Class  for TriggerPipeline Class. Uses mocked Handlers in class to test.
 * @author Christopher Pezza (@chiefpansancolt)
 * @since 2024-11-24
 * @group Tests
 */
@IsTest
public with sharing class TriggerPipelineTest {
	public static Boolean runTriggerPipeline = false;
	/**
	 * A Mock ATriggerHandler to test against
	 */
	private class TestTriggerHandler extends ATriggerHandler {
		/* No implementation needed */
	}

	@IsTest
	private static void shouldExecuteInsertPipeline() {
		runTriggerPipeline = true;

		Test.startTest();
		TriggerFrameworkTestDataFactory.createTestObject('Test Trigger Pipeline', true);
		Test.stopTest();

		Assert.areEqual(1, TriggerFrameworkTestQueryFactory.getTestObjectCount(), 'Insert pipeline should have executed and created a record.');
	}

	@IsTest
	private static void shouldExecuteUpdatePipeline() {
		runTriggerPipeline = true;

		Test.startTest();
		Test_Object__c testObject = TriggerFrameworkTestDataFactory.createTestObject('Test Trigger Pipeline', true);
		update testObject;
		Test.stopTest();

		Assert.areEqual(
			'Test Trigger Pipeline',
			TriggerFrameworkTestQueryFactory.getTestObjectName(),
			'Update pipeline should have executed and updated the record.'
		);
	}

	@IsTest
	private static void shouldExecuteDeletePipeline() {
		runTriggerPipeline = true;

		Test.startTest();
		Test_Object__c testObject = TriggerFrameworkTestDataFactory.createTestObject('Test Trigger Pipeline', true);
		delete testObject;
		Test.stopTest();

		Assert.areEqual(0, TriggerFrameworkTestQueryFactory.getTestObjectCount(), 'Delete pipeline should have executed and removed the record.');
	}

	@IsTest
	private static void shouldExecuteUndeletePipeline() {
		runTriggerPipeline = true;

		Test.startTest();
		Test_Object__c testObject = TriggerFrameworkTestDataFactory.createTestObject('Test Trigger Pipeline', true);
		delete testObject;
		undelete testObject;
		Test.stopTest();

		Assert.areEqual(1, TriggerFrameworkTestQueryFactory.getTestObjectCount(), 'Undelete pipeline should have executed and re-created the record.');
	}
}
