public virtual inherited sharing class ATriggerHandler extends ADMLDataProvider implements ITriggerHandler {
    public virtual Boolean shouldExecute() {
        return true;
    }

    public virtual Boolean isDoubleFireSafe() {
        return true;
    }

    public virtual Type getType() {
        return null;
    }

    public virtual void beforeInsert(TriggerData triggerData) {}
    public virtual void afterInsert(TriggerData triggerData) {}
    public virtual void beforeUpdate(TriggerData triggerData) {}
    public virtual void afterUpdate(TriggerData triggerData) {}
    public virtual void beforeDelete(TriggerData triggerData) {}
    public virtual void afterDelete(TriggerData triggerData) {}
    public virtual void afterUndelete(TriggerData triggerData) {}

    public void process(TriggerData triggerData) {
        if (Trigger.isBefore) {
            if (Trigger.isInsert) {
                beforeInsert(triggerData);
            } else if (Trigger.isUpdate) {
                beforeUpdate(triggerData);
            } else if (Trigger.isDelete) {
                beforeDelete(triggerData);
            }
        } else if (Trigger.isAfter) {
            if (Trigger.isInsert) {
                afterInsert(triggerData);
            } else if (Trigger.isUpdate) {
                afterUpdate(triggerData);
            } else if (Trigger.isDelete) {
                afterDelete(triggerData);
            } else if (Trigger.isUndelete) {
                afterUndelete(triggerData);
            }
        }
    }
}