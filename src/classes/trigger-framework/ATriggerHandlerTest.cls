/**
 * Test Class for ATriggerHandler Class. Uses mocked Handlers in class to test.
 * @author Christopher Pezza (@chiefpansancolt)
 * @since 2024-11-24
 * @group Tests
 */
@IsTest(isParallel=true)
public with sharing class ATriggerHandlerTest {
	public static Boolean runTriggerHandler = false;

	/**
	 * A Non Overriden Extention of ATriggerHandler to test all base methods in ATriggerHandler
	 */	
	private class NonOverridingHandler extends ATriggerHandler {}

	/**
	 * A Overridden Extention of ATriggerHandler to Test process in live usage
	 */	
	private class TestTriggerHandler extends ATriggerHandler {
		public Boolean beforeInsertCalled = false;
		public Boolean afterInsertCalled = false;
		public Boolean beforeUpdateCalled = false;
		public Boolean afterUpdateCalled = false;
		public Boolean beforeDeleteCalled = false;
		public Boolean afterDeleteCalled = false;
		public Boolean afterUndeleteCalled = false;

		public override Boolean shouldExecute() {
			return false;
		}

		public override Type getType() {
			return TestTriggerHandler.class;
		}

		public override Boolean isDoubleFireSafe() {
			return false;
		}

		public override void beforeInsert(TriggerData triggerData) {
			beforeInsertCalled = true;
		}

		public override void afterInsert(TriggerData triggerData) {
			afterInsertCalled = true;
		}

		public override void beforeUpdate(TriggerData triggerData) {
			beforeUpdateCalled = true;
		}

		public override void afterUpdate(TriggerData triggerData) {
			afterUpdateCalled = true;
		}

		public override void beforeDelete(TriggerData triggerData) {
			beforeDeleteCalled = true;
		}

		public override void afterDelete(TriggerData triggerData) {
			afterDeleteCalled = true;
		}

		public override void afterUndelete(TriggerData triggerData) {
			afterUndeleteCalled = true;
		}
	}

	@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
	@IsTest
	private static void testDefaultBehaviorBeforeInsert() {
		runTriggerHandler = true;

		NonOverridingHandler handler = new NonOverridingHandler();
		TestObjectHandler.mockHandler = handler;

		Test.startTest();
		TriggerFrameworkTestDataFactory.createTestObject('Before Insert Test', true);
		Test.stopTest();
	}

	@IsTest
	private static void testOverriddenBeforeInsert() {
		runTriggerHandler = true;

		TestTriggerHandler handler = new TestTriggerHandler();
		TestObjectHandler.mockHandler = handler;

		Test.startTest();
		TriggerFrameworkTestDataFactory.createTestObject('Before Insert Test', true);
		Test.stopTest();

		Assert.isTrue(handler.beforeInsertCalled, 'beforeInsert should be called in the overridden handler.');
	}

	@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
	@IsTest
	private static void testDefaultBehaviorAfterInsert() {
		runTriggerHandler = true;

		NonOverridingHandler handler = new NonOverridingHandler();
		TestObjectHandler.mockHandler = handler;

		Test.startTest();
		TriggerFrameworkTestDataFactory.createTestObject('After Insert Test', true);
		Test.stopTest();
	}

	@IsTest
	private static void testOverriddenAfterInsert() {
		runTriggerHandler = true;

		TestTriggerHandler handler = new TestTriggerHandler();
		TestObjectHandler.mockHandler = handler;

		Test.startTest();
		TriggerFrameworkTestDataFactory.createTestObject('After Insert Test', true);
		Test.stopTest();

		Assert.isTrue(handler.afterInsertCalled, 'afterInsert should be called in the overridden handler.');
	}

	@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
	@IsTest
	private static void testDefaultBehaviorBeforeUpdate() {
		runTriggerHandler = true;

		NonOverridingHandler handler = new NonOverridingHandler();
		TestObjectHandler.mockHandler = handler;

		Test.startTest();
		Test_Object__c testObject = TriggerFrameworkTestDataFactory.createTestObject('Before Update Test', true);
		update testObject;
		Test.stopTest();
	}

	@IsTest
	private static void testOverriddenBeforeUpdate() {
		runTriggerHandler = true;

		TestTriggerHandler handler = new TestTriggerHandler();
		TestObjectHandler.mockHandler = handler;

		Test.startTest();
		Test_Object__c testObject = TriggerFrameworkTestDataFactory.createTestObject('Before Update Test', true);
		update testObject;
		Test.stopTest();

		Assert.isTrue(handler.beforeUpdateCalled, 'beforeUpdate should be called in the overridden handler.');
	}

	@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
	@IsTest
	private static void testDefaultBehaviorAfterUpdate() {
		runTriggerHandler = true;

		NonOverridingHandler handler = new NonOverridingHandler();
		TestObjectHandler.mockHandler = handler;

		Test.startTest();
		Test_Object__c testObject = TriggerFrameworkTestDataFactory.createTestObject('After Update Test', true);
		update testObject;
		Test.stopTest();
	}

	@IsTest
	private static void testOverriddenAfterUpdate() {
		runTriggerHandler = true;

		TestTriggerHandler handler = new TestTriggerHandler();
		TestObjectHandler.mockHandler = handler;

		Test.startTest();
		Test_Object__c testObject = TriggerFrameworkTestDataFactory.createTestObject('After Update Test', true);
		update testObject;
		Test.stopTest();

		Assert.isTrue(handler.afterUpdateCalled, 'afterUpdate should be called in the overridden handler.');
	}

	@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
	@IsTest
	private static void testDefaultBehaviorBeforeDelete() {
		runTriggerHandler = true;

		NonOverridingHandler handler = new NonOverridingHandler();
		TestObjectHandler.mockHandler = handler;

		Test.startTest();
		Test_Object__c testObject = TriggerFrameworkTestDataFactory.createTestObject('Before Delete Test', true);
		delete testObject;
		Test.stopTest();
	}

	@IsTest
	private static void testOverriddenBeforeDelete() {
		runTriggerHandler = true;

		TestTriggerHandler handler = new TestTriggerHandler();
		TestObjectHandler.mockHandler = handler;

		Test.startTest();
		Test_Object__c testObject = TriggerFrameworkTestDataFactory.createTestObject('Before Delete Test', true);
		delete testObject;
		Test.stopTest();

		Assert.isTrue(handler.beforeDeleteCalled, 'beforeDelete should be called in the overridden handler.');
	}

	@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
	@IsTest
	private static void testDefaultBehaviorAfterDelete() {
		runTriggerHandler = true;

		NonOverridingHandler handler = new NonOverridingHandler();
		TestObjectHandler.mockHandler = handler;

		Test.startTest();
		Test_Object__c testObject = TriggerFrameworkTestDataFactory.createTestObject('After Delete Test', true);
		delete testObject;
		Test.stopTest();
	}

	@IsTest
	private static void testOverriddenAfterDelete() {
		runTriggerHandler = true;

		TestTriggerHandler handler = new TestTriggerHandler();
		TestObjectHandler.mockHandler = handler;

		Test.startTest();
		Test_Object__c testObject = TriggerFrameworkTestDataFactory.createTestObject('After Delete Test', true);
		delete testObject;
		Test.stopTest();

		Assert.isTrue(handler.afterDeleteCalled, 'afterDelete should be called in the overridden handler.');
	}

	@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
	@IsTest
	private static void testDefaultBehaviorAfterUndelete() {
		runTriggerHandler = true;

		NonOverridingHandler handler = new NonOverridingHandler();
		TestObjectHandler.mockHandler = handler;

		Test.startTest();
		Test_Object__c testObject = TriggerFrameworkTestDataFactory.createTestObject('After Undelete Test', true);
		delete testObject;
		undelete testObject;
		Test.stopTest();
	}

	@IsTest
	private static void testOverriddenAfterUndelete() {
		runTriggerHandler = true;

		TestTriggerHandler handler = new TestTriggerHandler();
		TestObjectHandler.mockHandler = handler;

		Test.startTest();
		Test_Object__c testObject = TriggerFrameworkTestDataFactory.createTestObject('After Undelete Test', true);
		delete testObject;
		undelete testObject;
		Test.stopTest();

		Assert.isTrue(handler.afterUndeleteCalled, 'afterUndelete should be called in the overridden handler.');
	}

	@IsTest
	private static void testDefaultShouldExecute() {
		NonOverridingHandler handler = new NonOverridingHandler();
		Boolean result = handler.shouldExecute();
		Assert.isTrue(result, 'Default implementation of shouldExecute should return true.');
	}

	@IsTest
	private static void testOverriddenShouldExecute() {
		TestTriggerHandler handler = new TestTriggerHandler();
		Boolean result = handler.shouldExecute();
		Assert.isFalse(result, 'Overridden shouldExecute should return false.');
	}

	@IsTest
	private static void testDefaultIsDoubleFireSafe() {
		NonOverridingHandler handler = new NonOverridingHandler();
		Boolean result = handler.isDoubleFireSafe();
		Assert.isTrue(result, 'Default implementation of isDoubleFireSafe should return true.');
	}

	@IsTest
	private static void testOverriddenIsDoubleFireSafe() {
		TestTriggerHandler handler = new TestTriggerHandler();
		Boolean result = handler.isDoubleFireSafe();
		Assert.isFalse(result, 'Overridden isDoubleFireSafe should return false.');
	}

	@IsTest
	private static void testDefaultGetType() {
		NonOverridingHandler handler = new NonOverridingHandler();
		Type result = handler.getType();
		Assert.isNull(result, 'Default implementation of getType should return null.');
	}

	@IsTest
	private static void testOverriddenGetType() {
		TestTriggerHandler handler = new TestTriggerHandler();
		Type result = handler.getType();
		Assert.areEqual(TestTriggerHandler.class, result, 'Overridden getType should return Schema.SObjectType.Account.');
	}
}
