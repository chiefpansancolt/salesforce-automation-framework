/**
 * Test Class for TriggerData Class
 * @author Christopher Pezza (@chiefpansancolt)
 * @since 2024-11-24
 * @group Tests
 */
@IsTest(IsParallel=true)
private with sharing class TriggerDataTest {
    @IsTest
    private static void shouldInitializeTriggerData() {
        List<Account> newAccounts = new List<Account>{
            TriggerFrameworkTestDataFactory.createAccount('Test Account 1', false),
            TriggerFrameworkTestDataFactory.createAccount('Test Account 2', false)
        };
        Database.insert(newAccounts);

        List<Account> oldAccounts = TriggerFrameworkTestQueryFactory.getAccounts();

        for (Account acc : newAccounts) {
            acc.Name = acc.Name + ' - Updated';
        }

        Map<Id, SObject> newAccountMap = new Map<Id, SObject>();
        for (Account acc : newAccounts) {
            newAccountMap.put(acc.Id, acc);
        }

        Map<Id, SObject> oldAccountMap = new Map<Id, SObject>();
        for (Account acc : oldAccounts) {
            oldAccountMap.put(acc.Id, acc);
        }

        TriggerData triggerData = new TriggerData(
            newAccounts, 
            oldAccounts, 
            newAccountMap, 
            oldAccountMap
        );

        Assert.areEqual(newAccounts, triggerData.newObjects, 'Expected New objects should match.');
        Assert.areEqual(oldAccounts, triggerData.oldObjects, 'Expected Old objects should match.');
        Assert.areEqual(newAccountMap, triggerData.newObjectsMap, 'Expected New objects map should match.');
        Assert.areEqual(oldAccountMap, triggerData.oldObjectsMap, 'Expected Old objects map should match.');
        Assert.areEqual(newAccountMap.keySet(), triggerData.objectIds, 'Expected Object IDs should match new object keys.');
    }
}
