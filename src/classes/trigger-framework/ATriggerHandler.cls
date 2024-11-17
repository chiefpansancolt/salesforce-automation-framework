/**
 * This class serves as a base implementation for trigger handler logic, 
 * providing default behavior for the various trigger events (before insert, update, delete, etc.).
 * It implements the ITriggerHandler interface and extends ADMLDataProvider to process trigger actions.
 * Subclasses should override specific methods to implement custom behavior.
 * 
 * @author Christopher Pezza (@chiefpansancolt)
 * @since 2024-11-17
 * @group Trigger Framework
 */
@SuppressWarnings('PMD.StdCyclomaticComplexity')
public abstract inherited sharing class ATriggerHandler extends ADMLDataProvider implements ITriggerHandler {

    /**
     * Determines if the handler should execute. Default is always true.
     * @return `Boolean`
     */
    public virtual Boolean shouldExecute() {
        return true;
    }

    /**
     * Checks if the handler is safe for double firing. Default is always true.
     * @return `Boolean`
     */
    public virtual Boolean isDoubleFireSafe() {
        return true;
    }

    /**
     * Returns the type of the handler. Subclasses should return the appropriate type.
     * @return `Type`
     */
    public virtual Type getType() {
        return null;
    }

    /**
     * Placeholder method for handling before insert trigger logic.
     * @param triggerData <code>TriggerData</code> The data for the trigger event.
     */
    public virtual void beforeInsert(TriggerData triggerData) {}

    /**
     * Placeholder method for handling after insert trigger logic.
     * @param triggerData <code>TriggerData</code> The data for the trigger event.
     */
    public virtual void afterInsert(TriggerData triggerData) {}

    /**
     * Placeholder method for handling before update trigger logic.
     * @param triggerData <code>TriggerData</code> The data for the trigger event.
     */
    public virtual void beforeUpdate(TriggerData triggerData) {}

    /**
     * Placeholder method for handling after update trigger logic.
     * @param triggerData <code>TriggerData</code> The data for the trigger event.
     */
    public virtual void afterUpdate(TriggerData triggerData) {}

    /**
     * Placeholder method for handling before delete trigger logic.
     * @param triggerData <code>TriggerData</code> The data for the trigger event.
     */
    public virtual void beforeDelete(TriggerData triggerData) {}

    /**
     * Placeholder method for handling after delete trigger logic.
     * @param triggerData <code>TriggerData</code> The data for the trigger event.
     */
    public virtual void afterDelete(TriggerData triggerData) {}

    /**
     * Placeholder method for handling after undelete trigger logic.
     * @param triggerData <code>TriggerData</code> The data for the trigger event.
     */
    public virtual void afterUndelete(TriggerData triggerData) {}

    /**
     * Processes the trigger actions based on the current trigger context.
     * It determines whether to call before or after methods based on the trigger context.
     * 
     * @param triggerData <code>TriggerData</code> The data for the trigger event.
     */
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