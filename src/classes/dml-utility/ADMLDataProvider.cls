public abstract inherited sharing class ADMLDataProvider {
	transient DMLAction insertAction;
	transient DMLAction updateAction;
	transient DMLAction deleteAction;

    public virtual void clear() {
		clearInsert();
		clearUpdate();
		clearDelete();
	}

	public virtual void addInsert(SObject obj) {
		addInsert(obj, false);
	}

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

	public virtual void addAllInsert(List<SObject> objs) {
		if (objs != null && objs.size() > 0) {
			getInsertAction().addOperation(objs);
		}
	}

	public virtual void addUpdate(SObject obj) {
		if (obj != null) {
			getUpdateAction().addOperation(obj);
		}
	}

	public virtual void addAllUpdate(List<SObject> objs) {
		if (objs != null && objs.size() > 0) {
			getUpdateAction().addOperation(objs);
		}
	}

	public virtual void addDelete(SObject obj) {
		if (obj != null) {
			getDeleteAction().addOperation(obj);
		}
	}

	public virtual void addAllDelete(List<SObject> objs) {
		if (objs != null && objs.size() > 0) {
			getDeleteAction().addOperation(objs);
		}
	}
	
	public virtual List<String> getToInsert() {
		return getInsertAction().getObjectNames();
	}

	public virtual List<String> getToUpdate() {
		return getUpdateAction().getObjectNames();
	}

	public virtual List<String> getToDelete() {
		return getDeleteAction().getObjectNames();
	}

	public virtual Map<String, List<SObject>> getToInsertChunks() {
		return getInsertAction().getObjectChunks();
	}

	public virtual Map<String, List<SObject>> getToUpdateChunks() {
		return getUpdateAction().getObjectChunks();
	}

	public virtual Map<String, List<SObject>> getToDeleteChunks() {
		return getDeleteAction().getObjectChunks();
	}

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

	public void clearInsert() {
		if (insertAction != null) {
			insertAction.clear();
		}
	}

	public void clearUpdate() {
		if (updateAction != null) {
			updateAction.clear();
		}
	}

	public void clearDelete() {
		if (deleteAction != null) {
			deleteAction.clear();
		}
	}

	private DMLAction getInsertAction() {
		if (insertAction == null) {
			insertAction = new DMLAction();
		}
		return insertAction;
	}

	private DMLAction getUpdateAction() {
		if (updateAction == null) {
			updateAction = new DMLAction();
		}
		return updateAction;
	}

	private DMLAction getDeleteAction() {
		if (deleteAction == null) {
			deleteAction = new DMLAction();
		}
		return deleteAction;
	}

	private virtual class DMLAction {
		protected List<Object> operations = new List<Object>();
		protected Map<String, List<SObject>> objectChunkMap = new Map<String, List<SObject>>();
		protected List<String> chunkObjectName = new List<String>();

		public void addOperation(Object obj) {
			operations.add(obj);
		}

		public void addOperations(List<Object> objs) {
			operations.addAll(objs);
		}

		public List<Object> getOperations() {
			return operations;
		}

		public List<String> getObjectNames() {
			calculate();
			return chunkObjectName;
		}

		public Map<String, List<SObject>> getObjectChunks() {
			calculate();
			return objectChunkMap;
		}

		public void clear() {
			operations.clear();
			chunkObjectName.clear();
			objectChunkMap.clear();
		}

		private void calculate() {
			if (objectChunkMap.size() == 0 && operations.size() > 0) {
				calculateChunks();
			}
		}

		private String getObjectName(SObjectType tp) {
			String key = tp.getDescribe().getName();
			if (objectChunkMap.containsKey(key)) {
				key += objectChunkMap.size();
			}
			return key;
		}

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