/**
 * Data Factory for test Classes to create data for usage
 * @author Christopher Pezza (@chiefpansancolt)
 * @since 2024-11-24
 * @group Test Utilities
 */
@IsTest
public with sharing class TriggerFrameworkTestDataFactory {
	/**
	 * Method to create an Account for testing.
	 * @param name <code>String</code> Name of the account to create.
	 * @param performInsert <code>Boolean</code> Whether to insert the account into the database.
	 * @return `Account`
	 */
	public static Account createAccount(String name, Boolean performInsert) {
		Account testAccount = new Account(Name = name);

		if (performInsert) {
			Database.insert(testAccount);
		}

		return testAccount;
	}

	/**
	 * Method to create a Test Object for testing.
	 * @param name <code>String</code> Name of the test object to create.
	 * @param performInsert <code>Boolean</code> Whether to insert the account into the database.
	 * @return `Test_Object__c`
	 */
	public static Test_Object__c createTestObject(String name, Boolean performInsert) {
		Test_Object__c testObject = new Test_Object__c(Name = name);

		if (performInsert) {
			Database.insert(testObject);
		}

		return testObject;
	}

	/**
	 * Find Profile and Create a new User with a profile of Standard User.
	 * @return  `User`
	 */
	public static User createUser() {
		Profile profile = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];

		User testUser = new User(
			Username = 'exampleTest12341@example.com',
			Email = 'testuser@example.com',
			LastName = 'TestUser',
			EmailEncodingKey = 'UTF-8',
			Alias = 'testuser',
			ProfileId = profile.Id,
			TimeZoneSidKey = 'America/New_York',
			LocaleSidKey = 'en_US',
			LanguageLocaleKey = 'en_US'
		);
		Database.insert(testUser);

		return testUser;
	}
}
