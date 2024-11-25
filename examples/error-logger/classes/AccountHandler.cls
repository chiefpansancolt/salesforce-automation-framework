public with sharing class AccountHandler extends ATriggerHandler {
	public override Type getType() {
		return AccountHandler.class;
	}

	public override Boolean shouldExecute() {
		return !FeatureManagement.checkPermission('Exclude_Trigger');
	}

	public override Boolean isDoubleFireSafe() {
		return true;
	}

	public override void beforeInsert(TriggerData triggerData) {
		performFieldUpdate(triggerData);
	}

	public override void beforeUpdate(TriggerData triggerData) {
		performFieldUpdate(triggerData);
	}

	private void performFieldUpdate(TriggerData triggerData) {
		for (Account account : (List<Account>) triggerData.newObjects) {
			try {
				account.Sample_Checkbox__c = true;
			} catch (Exception ex) {
				ErrorLogger.logError(ex, 'AccountHandler');
			}
		}
	}
}
