/**
 * Interface for managing DML operations (insert, update, delete) on SObjects.
 * This interface provides methods for adding single or multiple operations
 * and retrieving chunks of operations for each DML action.
 *
 * @author Christopher Pezza (@chiefpansancolt)
 * @since 2024-11-17
 * @group DML Utility
 */
public interface IDMLDataProvider {
	/**
	 * Clears all DML operations (insert, update, delete).
	 */
	void clear();

	/**
	 * Adds a single SObject to the insert operations list.
	 * @param obj The SObject to be inserted.
	 */
	void addInsert(SObject obj);

	/**
	 * Adds a single SObject to the insert operations list, with an option to execute immediately.
	 * @param obj The SObject to be inserted.
	 * @param immediate If true, performs the insert immediately; otherwise, adds it to the list for later execution.
	 */
	void addInsert(SObject obj, Boolean immediate);

	/**
	 * Adds multiple SObjects to the insert operations list.
	 * @param objs The list of SObjects to be inserted.
	 */
	void addAllInsert(List<SObject> objs);

	/**
	 * Adds a single SObject to the update operations list.
	 * @param obj The SObject to be updated.
	 */
	void addUpdate(SObject obj);

	/**
	 * Adds multiple SObjects to the update operations list.
	 * @param objs The list of SObjects to be updated.
	 */
	void addAllUpdate(List<SObject> objs);

	/**
	 * Adds a single SObject to the delete operations list.
	 * @param obj The SObject to be deleted.
	 */
	void addDelete(SObject obj);

	/**
	 * Adds multiple SObjects to the delete operations list.
	 * @param objs The list of SObjects to be deleted.
	 */
	void addAllDelete(List<SObject> objs);

	/**
	 * Retrieves a list of object names scheduled for insert.
	 * @return `List<String>`
	 */
	List<String> getToInsert();

	/**
	 * Retrieves a list of object names scheduled for update.
	 * @return `List<String>`
	 */
	List<String> getToUpdate();

	/**
	 * Retrieves a list of object names scheduled for delete.
	 * @return `List<String>`
	 */
	List<String> getToDelete();

	/**
	 * Retrieves a map of chunks of SObjects scheduled for insert, grouped by object name.
	 * @return `Map<String, List<SObject>>`
	 */
	Map<String, List<SObject>> getToInsertChunks();

	/**
	 * Retrieves a map of chunks of SObjects scheduled for update, grouped by object name.
	 * @return `Map<String, List<SObject>>`
	 */
	Map<String, List<SObject>> getToUpdateChunks();

	/**
	 * Retrieves a map of chunks of SObjects scheduled for delete, grouped by object name.
	 * @return `Map<String, List<SObject>>`
	 */
	Map<String, List<SObject>> getToDeleteChunks();
}
