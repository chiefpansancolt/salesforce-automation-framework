/**
 * Query Factory for Test Classes for common queries run in test classes.
 * @author Christopher Pezza (@chiefpansancolt)
 * @since 2024-11-24
 * @group Test Utilities
 */
@IsTest
public with sharing class TriggerFrameworkTestQueryFactory {
	/**
	 * Query all Error Logs created
	 * @return  `List<Error_Log__c>`
	 */
    public static List<Error_Log__c> getErrorLogs() {
		return [
			SELECT
				Id,
				Name,
				Class_Name__c,
				Error_Cause__c,
				Error_Message__c,
				Error_Severity__c,
				Error_Type__c,
				Execution_Context__c,
				Inaccessible_Fields__c,
				Line_Number__c,
				Related_Record__c,
				Stack_Trace__c,
				Status__c,
				Timestamp__c,
				User__c
			FROM Error_Log__c
		];
	}

	/**
	 * Get list of all Accounts.
	 * @return  `List<Account>`
	 */	
	public static List<Account> getAccounts() {
		return [SELECT Id, Name FROM Account];
	}

	/**
	 * Method to return Count of Test Objects
	 * @return  `Decimal`
	 */	
	public static Decimal getTestObjectCount() {
		return [SELECT COUNT() FROM Test_Object__c];
	}


	/**
	 * Method to return Name of Test Object
	 * @return  `String`
	 */
	public static String getTestObjectName() {
		return [SELECT Name FROM Test_Object__c][0].Name;
	}
}
