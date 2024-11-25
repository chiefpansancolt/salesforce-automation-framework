/**
 * Test class for ADMLDataProvider Class
 * @author Christopher Pezza (@chiefpansancolt)
 * @since 2024-24-11
 * @group Tests
 */
@IsTest(IsParallel=true)
private with sharing class ADMLDataProviderTest {
	/**
	 * A Test DML Data Provider extending ADMLDataProvider
	 */
	private class TestDMLDataProvider extends ADMLDataProvider {
		/* No implementation needed */
	}

	@IsTest
	private static void shouldAddInsert() {
		TestDMLDataProvider provider = new TestDMLDataProvider();

		Test.startTest();
		Account testAccount = TriggerFrameworkTestDataFactory.createAccount('Test Account', true);
		provider.addInsert(testAccount);
		Test.stopTest();

		Assert.areEqual(1, provider.getToInsert().size(), 'Expected one SObject in the insert list');
	}

	@IsTest
	private static void shouldNotAddInsert() {
		TestDMLDataProvider provider = new TestDMLDataProvider();

		Test.startTest();
		provider.addInsert(null);
		Test.stopTest();

		Assert.areEqual(0, provider.getToInsert().size(), 'Expected one SObject in the insert list');
	}

	@IsTest
	private static void shouldAddInsertImmediate() {
		TestDMLDataProvider provider = new TestDMLDataProvider();

		Test.startTest();
		Account testAccount = TriggerFrameworkTestDataFactory.createAccount('Test Account', false);
		provider.addInsert(testAccount, true);
		Test.stopTest();

		Assert.areEqual(0, provider.getToInsert().size(), 'Expected one SObject to be inserted already');
	}

	@IsTest
	private static void shouldAddAllInsert() {
		TestDMLDataProvider provider = new TestDMLDataProvider();

		Test.startTest();
		List<Account> accounts = new List<Account>{
			TriggerFrameworkTestDataFactory.createAccount('Test Account 1', false),
			TriggerFrameworkTestDataFactory.createAccount('Test Account 2', false)
		};
		provider.addAllInsert(accounts);
		Test.stopTest();

		Assert.areEqual(1, provider.getToInsert().size(), 'Expected one chunk in the insert list');
		Assert.areEqual(2, provider.getToInsertChunks().get(provider.getToInsert()[0]).size(), 'Expected two SObjects in the chunk');
	}

	@IsTest
	private static void shouldAddUpdate() {
		TestDMLDataProvider provider = new TestDMLDataProvider();

		Test.startTest();
		Account testAccount = TriggerFrameworkTestDataFactory.createAccount('Test Account', true);
		provider.addUpdate(testAccount);
		Test.stopTest();

		Assert.areEqual(1, provider.getToUpdate().size(), 'Expected one SObject in the update list');
	}

	@IsTest
	private static void shouldAddAllUpdate() {
		TestDMLDataProvider provider = new TestDMLDataProvider();

		Test.startTest();
		List<Account> accounts = new List<Account>{
			TriggerFrameworkTestDataFactory.createAccount('Test Account 1', true),
			TriggerFrameworkTestDataFactory.createAccount('Test Account 2', true)
		};
		provider.addAllUpdate(accounts);
		Test.stopTest();

		Assert.areEqual(1, provider.getToUpdate().size(), 'Expected one chunk in the update list');
		Assert.areEqual(2, provider.getToUpdateChunks().get(provider.getToUpdate()[0]).size(), 'Expected two SObjects in the chunk');
	}

	@IsTest
	private static void shouldAddDelete() {
		TestDMLDataProvider provider = new TestDMLDataProvider();

		Test.startTest();
		Account testAccount = TriggerFrameworkTestDataFactory.createAccount('Test Account', true);
		provider.addDelete(testAccount);
		Test.stopTest();

		Assert.areEqual(1, provider.getToDelete().size(), 'Expected one SObject in the delete list');
	}

	@IsTest
	private static void shouldAddAllDelete() {
		TestDMLDataProvider provider = new TestDMLDataProvider();

		Test.startTest();
		List<Account> accounts = new List<Account>{
			TriggerFrameworkTestDataFactory.createAccount('Test Account 1', true),
			TriggerFrameworkTestDataFactory.createAccount('Test Account 2', true)
		};
		provider.addAllDelete(accounts);
		Test.stopTest();

		Assert.areEqual(1, provider.getToDelete().size(), 'Expected one SObject in the delete list');
		Assert.areEqual(2, provider.getToDeleteChunks().get(provider.getToDelete()[0]).size(), 'Expected two SObjects in the chunk');
	}

	@IsTest
	private static void shouldClearOperations() {
		TestDMLDataProvider provider = new TestDMLDataProvider();

		Test.startTest();
		Account testAccount1 = TriggerFrameworkTestDataFactory.createAccount('Test Account 1', false);
		Account testAccount2 = TriggerFrameworkTestDataFactory.createAccount('Test Account 2', true);
		List<Account> accounts = new List<Account>{
			TriggerFrameworkTestDataFactory.createAccount('Test Account 3', true),
			TriggerFrameworkTestDataFactory.createAccount('Test Account 4', true)
		};
		provider.addInsert(testAccount1);
		provider.addAllUpdate(accounts);
		provider.addDelete(testAccount2);
		provider.clear();
		Test.stopTest();

		Assert.areEqual(0, provider.getToInsert().size(), 'Expected no inserts after clearing');
		Assert.areEqual(0, provider.getToUpdate().size(), 'Expected no updates after clearing');
		Assert.areEqual(0, provider.getToDelete().size(), 'Expected no deletes after clearing');
	}

	@IsTest
	private static void shouldMergeProviders() {
		TestDMLDataProvider provider1 = new TestDMLDataProvider();
		TestDMLDataProvider provider2 = new TestDMLDataProvider();

		Test.startTest();
		provider1.addInsert(TriggerFrameworkTestDataFactory.createAccount('Test Account 1', false));
		provider1.addUpdate(TriggerFrameworkTestDataFactory.createAccount('Test Account 2', true));
		provider2.addInsert(TriggerFrameworkTestDataFactory.createAccount('Test Account 3', false));
		provider2.addUpdate(TriggerFrameworkTestDataFactory.createAccount('Test Account 4', true));
		provider2.addDelete(TriggerFrameworkTestDataFactory.createAccount('Test Account 5', true));
		provider1.mergeProviders(provider2);
		Test.stopTest();

		List<String> toInsert = provider1.getToInsert();
		List<String> toUpdate = provider1.getToUpdate();
		List<String> toDelete = provider1.getToDelete();
		Assert.areEqual(2, provider1.getToInsertChunks().get(toInsert[0]).size(), 'Expected two inserts after merging providers');
		Assert.areEqual(2, provider1.getToUpdateChunks().get(toUpdate[0]).size(), 'Expected one update after merging providers');
		Assert.areEqual(1, provider1.getToDeleteChunks().get(toDelete[0]).size(), 'Expected one delete after merging providers');
	}

	@IsTest
	private static void shouldMergeWithEmptyProvider() {
		TestDMLDataProvider provider1 = new TestDMLDataProvider();
		TestDMLDataProvider provider2 = new TestDMLDataProvider();

		Test.startTest();
		provider1.addInsert(TriggerFrameworkTestDataFactory.createAccount('Test Account 1', false));
		provider1.mergeProviders(provider2);
		Test.stopTest();

		List<String> toInsert = provider1.getToInsert();
		Assert.areEqual(1, provider1.getToInsertChunks().get(toInsert[0]).size(), 'Expected no changes after merging with empty provider');
	}

	@IsTest
	private static void shouldHandleEmptyLists() {
		TestDMLDataProvider provider = new TestDMLDataProvider();

		Test.startTest();
		provider.addAllInsert(new List<Account>());
		provider.addAllUpdate(new List<Account>());
		provider.addAllDelete(new List<Account>());
		Test.stopTest();

		Assert.areEqual(0, provider.getToInsert().size(), 'Expected no inserts for empty list');
		Assert.areEqual(0, provider.getToUpdate().size(), 'Expected no updates for empty list');
		Assert.areEqual(0, provider.getToDelete().size(), 'Expected no deletes for empty list');
	}
}
