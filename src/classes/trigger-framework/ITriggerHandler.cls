public interface ITriggerHandler {
    Boolean shouldExecute();
    Boolean isDoubleFireSafe();
    Type getType();
    
    void beforeInsert(TriggerData triggerData);
    void afterInsert(TriggerData triggerData);
    void beforeUpdate(TriggerData triggerData);
    void afterUpdate(TriggerData triggerData);
    void beforeDelete(TriggerData triggerData);
    void afterDelete(TriggerData triggerData);
    void afterUndelete(TriggerData triggerData);
}