/**
 * Test class for DMLUtility Class
 * @author Christopher Pezza (@chiefpansancolt)
 * @since 2024-11-24
 * @group Tests
 */
@IsTest(isParallel=true)
private class DMLUtilityTest {
	/**
	 * A Test DML Data Provider extending ADMLDataProvider
	 */	
	private class TestDMLDataProvider extends ADMLDataProvider {}

	@IsTest
	private static void shouldPerformInsertDml() {
		TestDMLDataProvider provider = new TestDMLDataProvider();
		provider.addInsert(TriggerFrameworkTestDataFactory.createAccount('Test Account 1', false));

		Test.startTest();
		new DMLUtility(provider).performInsertDml();
		Test.stopTest();

		System.assertEquals(0, provider.getToInsert().size(), 'Insert chunks should be cleared after performing DML');
	}

	@IsTest
	private static void shouldPerformUpdateDml() {
		TestDMLDataProvider provider = new TestDMLDataProvider();
		provider.addUpdate(TriggerFrameworkTestDataFactory.createAccount('Updated Account', true));

		Test.startTest();
		new DMLUtility(provider).performUpdateDml();
		Test.stopTest();

		System.assertEquals(0, provider.getToUpdate().size(), 'Update chunks should be cleared after performing DML');
	}

	@IsTest
	private static void shouldPerformDeleteDml() {
		TestDMLDataProvider provider = new TestDMLDataProvider();
		provider.addDelete(TriggerFrameworkTestDataFactory.createAccount('Account to Delete', true));

		Test.startTest();
		new DMLUtility(provider).performDeleteDml();
		Test.stopTest();

		System.assertEquals(0, provider.getToDelete().size(), 'Delete chunks should be cleared after performing DML');
	}

	@IsTest
	private static void shouldPerformAllDml() {
		TestDMLDataProvider provider = new TestDMLDataProvider();
		provider.addInsert(TriggerFrameworkTestDataFactory.createAccount('Test Account 1', false));
		provider.addUpdate(TriggerFrameworkTestDataFactory.createAccount('Updated Account', true));
		provider.addDelete(TriggerFrameworkTestDataFactory.createAccount('Account to Delete', true));

		Test.startTest();
		new DMLUtility(provider).performAllDml();
		Test.stopTest();

		System.assertEquals(0, provider.getToInsert().size(), 'Insert chunks should be cleared after performing all DML');
		System.assertEquals(0, provider.getToUpdate().size(), 'Update chunks should be cleared after performing all DML');
		System.assertEquals(0, provider.getToDelete().size(), 'Delete chunks should be cleared after performing all DML');
	}
}
