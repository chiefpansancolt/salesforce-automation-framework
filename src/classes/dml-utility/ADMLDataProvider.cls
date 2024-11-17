/**
 * Abstract class that provides functionality for managing DML operations (insert, update, delete).
 * This class supports adding operations, performing chunked DML actions, and clearing operations.
 *
 * @author Christopher Pezza (@chiefpansancolt)
 * @since 2024-11-17
 * @group DML Utility
 */
@SuppressWarnings('PMD.CognitiveComplexity')
public abstract inherited sharing class ADMLDataProvider implements IDMLDataProvider {
	transient DMLAction insertAction;
	transient DMLAction updateAction;
	transient DMLAction deleteAction;

	/**
	 * Clears all DML operations (insert, update, delete).
	 */
	public virtual void clear() {
		clearInsert();
		clearUpdate();
		clearDelete();
	}

	/**
	 * Adds a single SObject to the insert action list.
	 * @param obj The SObject to be inserted.
	 */
	public virtual void addInsert(SObject obj) {
		addInsert(obj, false);
	}

	/**
	 * Adds a single SObject to the insert action list.
	 * Optionally performs immediate insert if specified.
	 * @param obj The SObject to be inserted.
	 * @param immediate If true, performs the insert immediately; otherwise, adds to the action list.
	 */
	public virtual void addInsert(SObject obj, Boolean immediate) {
		if (obj == null) {
			return;
		}
		if (immediate) {
			Database.insert(obj);
		} else {
			getInsertAction().addOperation(obj);
		}
	}

	/**
	 * Adds multiple SObjects to the insert action list.
	 * @param objs The list of SObjects to be inserted.
	 */
	public virtual void addAllInsert(List<SObject> objs) {
		if (objs != null && objs.size() > 0) {
			getInsertAction().addOperation(objs);
		}
	}

	/**
	 * Adds a single SObject to the update action list.
	 * @param obj The SObject to be updated.
	 */
	public virtual void addUpdate(SObject obj) {
		if (obj != null) {
			getUpdateAction().addOperation(obj);
		}
	}

	/**
	 * Adds multiple SObjects to the update action list.
	 * @param objs The list of SObjects to be updated.
	 */
	public virtual void addAllUpdate(List<SObject> objs) {
		if (objs != null && objs.size() > 0) {
			getUpdateAction().addOperation(objs);
		}
	}

	/**
	 * Adds a single SObject to the delete action list.
	 * @param obj The SObject to be deleted.
	 */
	public virtual void addDelete(SObject obj) {
		if (obj != null) {
			getDeleteAction().addOperation(obj);
		}
	}

	/**
	 * Adds multiple SObjects to the delete action list.
	 * @param objs The list of SObjects to be deleted.
	 */
	public virtual void addAllDelete(List<SObject> objs) {
		if (objs != null && objs.size() > 0) {
			getDeleteAction().addOperation(objs);
		}
	}

	/**
	 * Returns a list of SObject names scheduled for insert.
	 * @return `List<String>`
	 */
	public virtual List<String> getToInsert() {
		return getInsertAction().getObjectNames();
	}

	/**
	 * Returns a list of SObject names scheduled for update.
	 * @return `List<String>`
	 */
	public virtual List<String> getToUpdate() {
		return getUpdateAction().getObjectNames();
	}

	/**
	 * Returns a list of SObject names scheduled for delete.
	 * @return `List<String>`
	 */
	public virtual List<String> getToDelete() {
		return getDeleteAction().getObjectNames();
	}

	/**
	 * Returns a map of SObject chunks scheduled for insert.
	 * @return `Map<String, List<SObject>>`
	 */
	public virtual Map<String, List<SObject>> getToInsertChunks() {
		return getInsertAction().getObjectChunks();
	}

	/**
	 * Returns a map of SObject chunks scheduled for update.
	 * @return `Map<String, List<SObject>>`
	 */
	public virtual Map<String, List<SObject>> getToUpdateChunks() {
		return getUpdateAction().getObjectChunks();
	}

	/**
	 * Returns a map of SObject chunks scheduled for delete.
	 * @return `Map<String, List<SObject>>`
	 */
	public virtual Map<String, List<SObject>> getToDeleteChunks() {
		return getDeleteAction().getObjectChunks();
	}

	/**
	 * Merges the operations from another ADMLDataProvider into this one.
	 * @param additionalProvider The provider whose operations will be merged.
	 */
	public virtual void mergeProviders(ADMLDataProvider additionalProvider) {
		if (additionalProvider.insertAction != null) {
			getInsertAction().operations.addAll(additionalProvider.insertAction.operations);
			additionalProvider.insertAction.clear();
		}
		if (additionalProvider.updateAction != null) {
			getUpdateAction().operations.addAll(additionalProvider.updateAction.operations);
			additionalProvider.updateAction.clear();
		}
		if (additionalProvider.deleteAction != null) {
			getDeleteAction().operations.addAll(additionalProvider.deleteAction.operations);
			additionalProvider.deleteAction.clear();
		}
	}

	/**
	 * Clears insert operations.
	 */
	public void clearInsert() {
		if (insertAction != null) {
			insertAction.clear();
		}
	}

	/**
	 * Clears update operations.
	 */
	public void clearUpdate() {
		if (updateAction != null) {
			updateAction.clear();
		}
	}

	/**
	 * Clears delete operations.
	 */
	public void clearDelete() {
		if (deleteAction != null) {
			deleteAction.clear();
		}
	}

	/**
	 * Retrieves the insert action, initializing it if necessary.
	 * @return `DMLAction`
	 */
	private DMLAction getInsertAction() {
		if (insertAction == null) {
			insertAction = new DMLAction();
		}
		return insertAction;
	}

	/**
	 * Retrieves the update action, initializing it if necessary.
	 * @return `DMLAction`
	 */
	private DMLAction getUpdateAction() {
		if (updateAction == null) {
			updateAction = new DMLAction();
		}
		return updateAction;
	}

	/**
	 * Retrieves the delete action, initializing it if necessary.
	 * @return `DMLAction`
	 */
	private DMLAction getDeleteAction() {
		if (deleteAction == null) {
			deleteAction = new DMLAction();
		}
		return deleteAction;
	}

	/**
	 * Inner class to handle DML operations for objects, including adding operations,
	 * calculating chunks, and clearing operations.
	 */
	private virtual class DMLAction {
		protected List<Object> operations = new List<Object>();
		protected Map<String, List<SObject>> objectChunkMap = new Map<String, List<SObject>>();
		protected List<String> chunkObjectName = new List<String>();

		/**
		 * Adds a single operation to the list of operations.
		 * @param obj The object to be added.
		 */
		public void addOperation(Object obj) {
			operations.add(obj);
		}

		/**
		 * Adds multiple operations to the list of operations.
		 * @param objs The list of objects to be added.
		 */
		public void addOperations(List<Object> objs) {
			operations.addAll(objs);
		}

		/**
		 * Returns a list of operations.
		 * @return `List<Object>`
		 */
		public List<Object> getOperations() {
			return operations;
		}

		/**
		 * Returns the object names for the chunks of operations.
		 * @return `List<String>`
		 */
		public List<String> getObjectNames() {
			calculate();
			return chunkObjectName;
		}

		/**
		 * Returns a map of chunks for each object.
		 * @return `Map<String, List<SObject>>`
		 */
		public Map<String, List<SObject>> getObjectChunks() {
			calculate();
			return objectChunkMap;
		}

		/**
		 * Clears all operations and chunk data.
		 */
		public void clear() {
			operations.clear();
			chunkObjectName.clear();
			objectChunkMap.clear();
		}

		/**
		 * Calculates the object chunks based on the current operations.
		 */
		private void calculate() {
			if (objectChunkMap.size() == 0 && operations.size() > 0) {
				calculateChunks();
			}
		}

		/**
		 * Generates the object name for a given SObject type.
		 * @param tp The SObject type.
		 * @return `String`
		 */
		private String getObjectName(SObjectType tp) {
			String key = tp.getDescribe().getName();
			if (objectChunkMap.containsKey(key)) {
				key += objectChunkMap.size();
			}
			return key;
		}

		/**
		 * Calculates the chunks for operations by grouping SObjects by their type.
		 */
		private virtual void calculateChunks() {
			Map<SObjectType, List<SObject>> tpMap = new Map<SObjectType, List<SObject>>();
			for (Object obj : operations) {
				if (obj instanceof List<SObject>) {
					List<SObject> lst = (List<SObject>) obj;
					objectChunkMap.put(getObjectName(lst[0].getSObjectType()), lst);
				} else {
					SObject sob = (SObject) obj;
					SObjectType tp = sob.getSObjectType();
					List<SObject> tpl = tpMap.get(tp);
					if (tpl == null) {
						tpl = new List<SObject>();
						tpMap.put(tp, tpl);
						objectChunkMap.put(getObjectName(tp), tpl);
					}
					tpl.add(sob);
				}
			}
			chunkObjectName.addAll(objectChunkMap.keySet());
		}
	}
}
