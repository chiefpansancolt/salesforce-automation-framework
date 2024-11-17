public inherited sharing class TriggerData {
	public List<SObject> newObjects;
	public List<SObject> oldObjects;
	public Map<Id, SObject> newObjectsMap;
	public Map<Id, SObject> oldObjectsMap;
	public Set<Id> objectIds;

	public TriggerData(
		List<SObject> newObjects,
		List<SObject> oldObjects,
		Map<Id, SObject> newObjectsMap,
		Map<Id, SObject> oldObjectsMap
	) {
		this.newObjects = newObjects;
		this.oldObjects = oldObjects;
		this.newObjectsMap = newObjectsMap;
		this.oldObjectsMap = oldObjectsMap;
		this.objectIds = newObjectsMap != null ? newObjectsMap.keySet() : new Set<Id>();
	}
}
