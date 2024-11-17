/**
 * Interface defining the methods for a trigger handler,
 * including execution conditions and processing methods for various trigger events.
 * This interface allows for pre-processing and post-processing logic to be applied
 * during insert, update, delete, and undelete operations.
 *
 * @author Christopher Pezza (@chiefpansancolt)
 * @since 2024-11-17
 * @group Trigger Framework
 */
public interface ITriggerHandler {
	/**
	 * Determines if the trigger handler should be executed.
	 * @return Boolean indicating whether the handler should execute.
	 */
	Boolean shouldExecute();

	/**
	 * Checks if the handler is safe from being triggered multiple times
	 * within the same context.
	 * @return Boolean indicating if the handler is double fire safe.
	 */
	Boolean isDoubleFireSafe();

	/**
	 * Retrieves the Type of the trigger handler class.
	 * @return Type representing the handler's class type.
	 */
	Type getType();

	/**
	 * Executes logic before an insert operation.
	 * @param triggerData <code>TriggerData</code> The data for the current trigger context.
	 */
	void beforeInsert(TriggerData triggerData);

	/**
	 * Executes logic after an insert operation.
	 * @param triggerData <code>TriggerData</code> The data for the current trigger context.
	 */
	void afterInsert(TriggerData triggerData);

	/**
	 * Executes logic before an update operation.
	 * @param triggerData <code>TriggerData</code> The data for the current trigger context.
	 */
	void beforeUpdate(TriggerData triggerData);

	/**
	 * Executes logic after an update operation.
	 * @param triggerData <code>TriggerData</code> The data for the current trigger context.
	 */
	void afterUpdate(TriggerData triggerData);

	/**
	 * Executes logic before a delete operation.
	 * @param triggerData <code>TriggerData</code> The data for the current trigger context.
	 */
	void beforeDelete(TriggerData triggerData);

	/**
	 * Executes logic after a delete operation.
	 * @param triggerData <code>TriggerData</code> The data for the current trigger context.
	 */
	void afterDelete(TriggerData triggerData);

	/**
	 * Executes logic after an undelete operation.
	 * @param triggerData <code>TriggerData</code> The data for the current trigger context.
	 */
	void afterUndelete(TriggerData triggerData);
}
