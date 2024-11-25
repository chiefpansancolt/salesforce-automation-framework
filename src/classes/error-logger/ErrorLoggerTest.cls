/**
 * Test class for ErrorLog Class.
 * @author Christopher Pezza (@chiefpansancolt)
 * @since 2024-11-24
 * @group Tests
 */
@IsTest(IsParallel=false)
private with sharing class ErrorLoggerTest {
	/**
	 * A Test Exception extending Exception
	 */
	private class TestException extends Exception {
		/* No implementation needed */
	}

	@IsTest
	private static void shouldNotRunInTestMode() {
		TestException testException = new TestException('Test Exception Message');

		Test.startTest();
		ErrorLogger.logError(testException);
		Test.stopTest();

		List<Error_Log__c> results = TriggerFrameworkTestQueryFactory.getErrorLogs();
		Assert.areEqual(0, results.size(), 'No error log should have been created.');
	}

	@IsTest
	private static void shouldLogErrorWithExceptionOnly() {
		ErrorLogger.isTestMode = true;
		TestException testException = new TestException('Test Exception Message');

		Test.startTest();
		ErrorLogger.logError(testException);
		Test.stopTest();

		List<Error_Log__c> results = TriggerFrameworkTestQueryFactory.getErrorLogs();
		Assert.areEqual(1, results.size(), 'One error log should have been created.');
		Assert.areEqual('ErrorLoggerTest.TestException', results[0].Error_Type__c, 'Error type should match the exception type.');
		Assert.areEqual('Test Exception Message', results[0].Error_Message__c, 'Error message should match.');
		Assert.isNotNull(results[0].Stack_Trace__c, 'Stack trace should not be null.');
		Assert.isNotNull(results[0].Execution_Context__c, 'Execution context should not be null.');
	}

	@IsTest
	private static void shouldLogErrorWithExceptionAndClassName() {
		ErrorLogger.isTestMode = true;
		TestException testException = new TestException('Another Test Exception');
		String className = 'MyTestClass';

		Test.startTest();
		ErrorLogger.logError(testException, className);
		Test.stopTest();

		List<Error_Log__c> results = TriggerFrameworkTestQueryFactory.getErrorLogs();
		Assert.areEqual(1, results.size(), 'One error log should have been created.');
		Assert.areEqual('MyTestClass', results[0].Class_Name__c, 'Class name should match the provided value.');
	}

	@SuppressWarnings('PMD.UnusedLocalVariable')
	@IsTest
	private static void shouldLogErrorWithQueryException() {
		ErrorLogger.isTestMode = true;
		User testUser = TriggerFrameworkTestDataFactory.createUser();
		TriggerFrameworkTestDataFactory.createAccount('Test Account', true);

		System.runAs(testUser) {
			Test.startTest();

			try {
				List<Lead> testLead = [SELECT GenderIdentity FROM Lead WITH USER_MODE LIMIT 1];
			} catch (Exception e) {
				ErrorLogger.logError(e);
			}
			Test.stopTest();

			List<Error_Log__c> results = TriggerFrameworkTestQueryFactory.getErrorLogs();
			Assert.areEqual(1, results.size(), 'One error log should have been created.');
			Assert.isNotNull(results[0].Inaccessible_Fields__c, 'Inaccessible fields should be logged for QueryException.');
		}
	}
}
