/**
 * This class stores and provides access to the old and new values of records
 * in a trigger context, including their maps and object IDs for processing.
 *
 * @author Christopher Pezza (@chiefpansancolt)
 * @since 2024-11-17
 * @group Trigger Framework
 */
public inherited sharing class TriggerData {
	public List<SObject> newObjects;
	public List<SObject> oldObjects;
	public Map<Id, SObject> newObjectsMap;
	public Map<Id, SObject> oldObjectsMap;
	public Set<Id> objectIds;

	/**
	 * Constructor to initialize the TriggerData object with new and old objects,
	 * and their respective maps.
	 *
	 * @param newObjects A list of new SObject records (newly inserted or updated).
	 * @param oldObjects A list of old SObject records (previously existing records).
	 * @param newObjectsMap A map of SObject Ids to new SObject records.
	 * @param oldObjectsMap A map of SObject Ids to old SObject records.
	 */
	@SuppressWarnings('PMD.ExcessiveParameterList')
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
