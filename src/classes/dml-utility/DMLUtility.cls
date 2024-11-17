public inherited sharing virtual class DMLUtility {
	private ADMLDataProvider provider;

	public DMLUtility(ADMLDataProvider provider) {
		this.provider = provider;
	}

	public virtual void performAllDml() {
		performInsertDml();
		performUpdateDml();
		performDeleteDml();
	}

	public virtual void performUpdateDml() {
		for (String key : provider.getToUpdate()) {
			Database.update(provider.getToUpdateChunks().get(key), true);
		}
		provider.clearUpdate();
	}

	public virtual void performInsertDml() {
		for (String key : provider.getToInsert()) {
			Database.insert(provider.getToInsertChunks().get(key), true);
		}
		provider.clearInsert();
	}

	public virtual void performDeleteDml() {
		for (String key : provider.getToDelete()) {
            Database.delete(provider.getToDeleteChunks().get(key), true);
		}
		provider.clearDelete();
	}
}
