export default [
    {
        "title": "Home",
        "fileName": "index.html",
        "text": "Home Project Home Use the apexdox.homePagePath  setting to point to an HTML file that contains details about your project. The body of the HTML will show up here instead of this default!"
    },
    {
        "title": "ADMLDataProvider",
        "fileName": "ADMLDataProvider.html",
        "text": "ADMLDataProvider Abstract class that provides functionality for managing DML operations(insert, update, delete). This class supports adding operations, performing chunked DML actions, and clearing operations. Signature @SuppressWarnings('PMD.CognitiveComplexity') public abstract inherited sharing class ADMLDataProvider implements IDMLDataProvider Author Christopher Pezza(@chiefpansancolt) Since 2024-11-17 ADMLDataProvider Methods clear() addInsert(obj) addInsert(obj, immediate) addAllInsert(objs) addUpdate(obj) addAllUpdate(objs) addDelete(obj) addAllDelete(objs) getToInsert() getToUpdate() getToDelete() getToInsertChunks() getToUpdateChunks() getToDeleteChunks() mergeProviders(additionalProvider) clearInsert() clearUpdate() clearDelete() getInsertAction() getUpdateAction() getDeleteAction() clear() Clears all DML operations(insert, update, delete). Signature public virtual void clear() addInsert(obj) Adds a single SObject to the insert action list. Signature public virtual void addInsert(SObject obj) Parameters obj Type: SObject The SObject to be inserted. addInsert(obj, immediate) Adds a single SObject to the insert action list. Optionally performs immediate insert if specified. Signature public virtual void addInsert(SObject obj, Boolean immediate) Parameters obj Type: SObject The SObject to be inserted. immediate Type: Boolean If true, performs the insert immediately; otherwise, adds to the action list. addAllInsert(objs) Adds multiple SObjects to the insert action list. Signature public virtual void addAllInsert(List<SObject> objs) Parameters objs Type: List<SObject> The list of SObjects to be inserted. addUpdate(obj) Adds a single SObject to the update action list. Signature public virtual void addUpdate(SObject obj) Parameters obj Type: SObject The SObject to be updated. addAllUpdate(objs) Adds multiple SObjects to the update action list. Signature public virtual void addAllUpdate(List<SObject> objs) Parameters objs Type: List<SObject> The list of SObjects to be updated. addDelete(obj) Adds a single SObject to the delete action list. Signature public virtual void addDelete(SObject obj) Parameters obj Type: SObject The SObject to be deleted. addAllDelete(objs) Adds multiple SObjects to the delete action list. Signature public virtual void addAllDelete(List<SObject> objs) Parameters objs Type: List<SObject> The list of SObjects to be deleted. getToInsert() Returns a list of SObject names scheduled for insert. Signature public virtual List<String> getToInsert() Returns List<String> getToUpdate() Returns a list of SObject names scheduled for update. Signature public virtual List<String> getToUpdate() Returns List<String> getToDelete() Returns a list of SObject names scheduled for delete. Signature public virtual List<String> getToDelete() Returns List<String> getToInsertChunks() Returns a map of SObject chunks scheduled for insert. Signature public virtual Map<String, List<SObject>> getToInsertChunks() Returns Map<String, List<SObject>> getToUpdateChunks() Returns a map of SObject chunks scheduled for update. Signature public virtual Map<String, List<SObject>> getToUpdateChunks() Returns Map<String, List<SObject>> getToDeleteChunks() Returns a map of SObject chunks scheduled for delete. Signature public virtual Map<String, List<SObject>> getToDeleteChunks() Returns Map<String, List<SObject>> mergeProviders(additionalProvider) Merges the operations from another ADMLDataProvider into this one. Signature public virtual void mergeProviders(ADMLDataProvider additionalProvider) Parameters additionalProvider Type: ADMLDataProvider The provider whose operations will be merged. clearInsert() Clears insert operations. Signature public void clearInsert() clearUpdate() Clears update operations. Signature public void clearUpdate() clearDelete() Clears delete operations. Signature public void clearDelete() getInsertAction() Retrieves the insert action, initializing it if necessary. Signature private DMLAction getInsertAction() Returns DMLAction getUpdateAction() Retrieves the update action, initializing it if necessary. Signature private DMLAction getUpdateAction() Returns DMLAction getDeleteAction() Retrieves the delete action, initializing it if necessary. Signature private DMLAction getDeleteAction() Returns DMLAction ADMLDataProvider.DMLAction Inner class to handle DML operations for objects, including adding operations, calculating chunks, and clearing operations. Signature private virtual class DMLAction ADMLDataProvider.DMLAction Properties Name Signature operations protected List<Object> operations objectChunkMap protected Map<String, List<SObject>> objectChunkMap chunkObjectName protected List<String> chunkObjectName ADMLDataProvider.DMLAction Methods addOperation(obj) getObjectNameKeys() getObjectChunks() clear() calculate() getObjectNameKey(tp) calculateChunks() addOperation(obj) Adds a single operation to the list of operations. Signature public void addOperation(Object obj) Parameters obj Type: Object The object to be added. getObjectNameKeys() Returns the object names for the chunks of operations. Signature public List<String> getObjectNameKeys() Returns List<String> getObjectChunks() Returns a map of chunks for each object. Signature public Map<String, List<SObject>> getObjectChunks() Returns Map<String, List<SObject>> clear() Clears all operations and chunk data. Signature public void clear() calculate() Calculates the object chunks based on the current operations. Signature private void calculate() getObjectNameKey(tp) Generates the object name for a given SObject type. Signature private String getObjectNameKey(SObjectType tp) Parameters tp Type: SObjectType The SObject type. Returns String calculateChunks() Calculates the chunks for operations by grouping SObjects by their type. Signature private virtual void calculateChunks()"
    },
    {
        "title": "DMLUtility",
        "fileName": "DMLUtility.html",
        "text": "DMLUtility Utility class to handle DML operations such as insert, update, and delete. It performs all DML operations by calling specific methods for each type of operation. The class relies on an ADMLDataProvider instance to handle DML data. Signature @SuppressWarnings('PMD.OperationWithLimitsInLoop') public inherited sharing virtual class DMLUtility Author Christopher Pezza(@chiefpansancolt) Since 2024-11-17 DMLUtility Properties Name Signature provider private ADMLDataProvider provider DMLUtility Constructors DMLUtility(provider) DMLUtility(provider) Constructor to initialize the DMLUtility class with an ADMLDataProvider. Signature public DMLUtility(ADMLDataProvider provider) Parameters provider Type: ADMLDataProvider The <code>ADMLDataProvider</code> instance used to perform DML operations. DMLUtility Methods performAllDml() performUpdateDml() performInsertDml() performDeleteDml() performAllDml() Performs all DML operations: insert, update, and delete. Signature public virtual void performAllDml() performUpdateDml() Performs update DML operations. Iterates over the update items and applies the DML operation to each chunk of updated records. Signature public virtual void performUpdateDml() performInsertDml() Performs insert DML operations. Iterates over the insert items and applies the DML operation to each chunk of records to be inserted. Signature public virtual void performInsertDml() performDeleteDml() Performs delete DML operations. Iterates over the delete items and applies the DML operation to each chunk of records to be deleted. Signature public virtual void performDeleteDml()"
    },
    {
        "title": "IDMLDataProvider",
        "fileName": "IDMLDataProvider.html",
        "text": "IDMLDataProvider Interface for managing DML operations(insert, update, delete) on SObjects. This interface provides methods for adding single or multiple operations and retrieving chunks of operations for each DML action. Signature public interface IDMLDataProvider Author Christopher Pezza(@chiefpansancolt) Since 2024-11-17 IDMLDataProvider Methods clear() addInsert(obj) addInsert(obj, immediate) addAllInsert(objs) addUpdate(obj) addAllUpdate(objs) addDelete(obj) addAllDelete(objs) getToInsert() getToUpdate() getToDelete() getToInsertChunks() getToUpdateChunks() getToDeleteChunks() clear() Clears all DML operations(insert, update, delete). Signature void clear() addInsert(obj) Adds a single SObject to the insert operations list. Signature void addInsert(SObject obj) Parameters obj Type: SObject The SObject to be inserted. addInsert(obj, immediate) Adds a single SObject to the insert operations list, with an option to execute immediately. Signature void addInsert(SObject obj, Boolean immediate) Parameters obj Type: SObject The SObject to be inserted. immediate Type: Boolean If true, performs the insert immediately; otherwise, adds it to the list for later execution. addAllInsert(objs) Adds multiple SObjects to the insert operations list. Signature void addAllInsert(List<SObject> objs) Parameters objs Type: List<SObject> The list of SObjects to be inserted. addUpdate(obj) Adds a single SObject to the update operations list. Signature void addUpdate(SObject obj) Parameters obj Type: SObject The SObject to be updated. addAllUpdate(objs) Adds multiple SObjects to the update operations list. Signature void addAllUpdate(List<SObject> objs) Parameters objs Type: List<SObject> The list of SObjects to be updated. addDelete(obj) Adds a single SObject to the delete operations list. Signature void addDelete(SObject obj) Parameters obj Type: SObject The SObject to be deleted. addAllDelete(objs) Adds multiple SObjects to the delete operations list. Signature void addAllDelete(List<SObject> objs) Parameters objs Type: List<SObject> The list of SObjects to be deleted. getToInsert() Retrieves a list of object names scheduled for insert. Signature List<String> getToInsert() Returns List<String> getToUpdate() Retrieves a list of object names scheduled for update. Signature List<String> getToUpdate() Returns List<String> getToDelete() Retrieves a list of object names scheduled for delete. Signature List<String> getToDelete() Returns List<String> getToInsertChunks() Retrieves a map of chunks of SObjects scheduled for insert, grouped by object name. Signature Map<String, List<SObject>> getToInsertChunks() Returns Map<String, List<SObject>> getToUpdateChunks() Retrieves a map of chunks of SObjects scheduled for update, grouped by object name. Signature Map<String, List<SObject>> getToUpdateChunks() Returns Map<String, List<SObject>> getToDeleteChunks() Retrieves a map of chunks of SObjects scheduled for delete, grouped by object name. Signature Map<String, List<SObject>> getToDeleteChunks() Returns Map<String, List<SObject>>"
    },
    {
        "title": "ErrorLogger",
        "fileName": "ErrorLogger.html",
        "text": "ErrorLogger This class provides methods for logging errors in Salesforce by creating Error_Log__c records. It captures relevant exception information such as type, message, stack trace, and execution context. Additionally, it handles special cases like QueryExceptions and logs inaccessible fields. Signature public with sharing class ErrorLogger Author Christopher Pezza(@chiefpansancolt) Since 2024-11-17 ErrorLogger Properties Name Signature Annotations isTestMode private static Boolean isTestMode @TestVisible ErrorLogger Methods logError(e) logError(e, className) getExecutionContext() logError(e) Logs the given exception into an Error_Log__c record. Signature public static void logError(Exception e) Parameters e Type: Exception <code>Exception</code> The exception to be logged. logError(e, className) Logs the given exception and additional class name into an Error_Log__c record. Signature public static void logError(Exception e, String className) Parameters e Type: Exception <code>Exception</code> The exception to be logged. className Type: String The class name where the error occurred(optional). getExecutionContext() Determines the execution context of the current operation(e.g., Batch, Future, Trigger). Signature private static String getExecutionContext() Returns String"
    },
    {
        "title": "TriggerFrameworkTestDataFactory",
        "fileName": "TriggerFrameworkTestDataFactory.html",
        "text": "TriggerFrameworkTestDataFactory Data Factory for test Classes to create data for usage Signature @IsTest public with sharing class TriggerFrameworkTestDataFactory Author Christopher Pezza(@chiefpansancolt) Since 2024-11-24 TriggerFrameworkTestDataFactory Methods createAccount(name, performInsert) createTestObject(name, performInsert) createUser() createAccount(name, performInsert) Method to create an Account for testing. Signature public static Account createAccount(String name, Boolean performInsert) Parameters name Type: String <code>String</code> Name of the account to create. performInsert Type: Boolean <code>Boolean</code> Whether to insert the account into the database. Returns Account createTestObject(name, performInsert) Method to create a Test Object for testing. Signature public static Test_Object__c createTestObject(String name, Boolean performInsert) Parameters name Type: String <code>String</code> Name of the test object to create. performInsert Type: Boolean <code>Boolean</code> Whether to insert the account into the database. Returns Test_Object__c createUser() Find Profile and Create a new User with a profile of Standard User. Signature public static User createUser() Returns User"
    },
    {
        "title": "TriggerFrameworkTestQueryFactory",
        "fileName": "TriggerFrameworkTestQueryFactory.html",
        "text": "TriggerFrameworkTestQueryFactory Query Factory for Test Classes for common queries run in test classes. Signature @IsTest public with sharing class TriggerFrameworkTestQueryFactory Author Christopher Pezza(@chiefpansancolt) Since 2024-11-24 TriggerFrameworkTestQueryFactory Methods getErrorLogs() getAccounts() getTestObjectCount() getTestObjectName() getErrorLogs() Query all Error Logs created Signature public static List<Error_Log__c> getErrorLogs() Returns List<Error_Log__c> getAccounts() Get list of all Accounts. Signature public static List<Account> getAccounts() Returns List<Account> getTestObjectCount() Method to return Count of Test Objects Signature public static Decimal getTestObjectCount() Returns Decimal getTestObjectName() Method to return Name of Test Object Signature public static String getTestObjectName() Returns String"
    },
    {
        "title": "ATriggerHandler",
        "fileName": "ATriggerHandler.html",
        "text": "ATriggerHandler This class serves as a base implementation for trigger handler logic, providing default behavior for the various trigger events(before insert, update, delete, etc.). It implements the ITriggerHandler interface and extends ADMLDataProvider to process trigger actions. Subclasses should override specific methods to implement custom behavior. Signature @SuppressWarnings('PMD.StdCyclomaticComplexity') public abstract inherited sharing class ATriggerHandler extends ADMLDataProvider implements ITriggerHandler Author Christopher Pezza(@chiefpansancolt) Since 2024-11-17 ATriggerHandler Methods shouldExecute() isDoubleFireSafe() getType() beforeInsert(triggerData) afterInsert(triggerData) beforeUpdate(triggerData) afterUpdate(triggerData) beforeDelete(triggerData) afterDelete(triggerData) afterUndelete(triggerData) process(triggerData) shouldExecute() Determines if the handler should execute. Default is always true. Signature public virtual Boolean shouldExecute() Returns Boolean isDoubleFireSafe() Checks if the handler is safe for double firing. Default is always true. Signature public virtual Boolean isDoubleFireSafe() Returns Boolean getType() Returns the type of the handler. Subclasses should return the appropriate type. Signature public virtual Type getType() Returns Type beforeInsert(triggerData) Placeholder method for handling before insert trigger logic. Signature public virtual void beforeInsert(TriggerData triggerData) Parameters triggerData Type: TriggerData <code>TriggerData</code> The data for the trigger event. afterInsert(triggerData) Placeholder method for handling after insert trigger logic. Signature public virtual void afterInsert(TriggerData triggerData) Parameters triggerData Type: TriggerData <code>TriggerData</code> The data for the trigger event. beforeUpdate(triggerData) Placeholder method for handling before update trigger logic. Signature public virtual void beforeUpdate(TriggerData triggerData) Parameters triggerData Type: TriggerData <code>TriggerData</code> The data for the trigger event. afterUpdate(triggerData) Placeholder method for handling after update trigger logic. Signature public virtual void afterUpdate(TriggerData triggerData) Parameters triggerData Type: TriggerData <code>TriggerData</code> The data for the trigger event. beforeDelete(triggerData) Placeholder method for handling before delete trigger logic. Signature public virtual void beforeDelete(TriggerData triggerData) Parameters triggerData Type: TriggerData <code>TriggerData</code> The data for the trigger event. afterDelete(triggerData) Placeholder method for handling after delete trigger logic. Signature public virtual void afterDelete(TriggerData triggerData) Parameters triggerData Type: TriggerData <code>TriggerData</code> The data for the trigger event. afterUndelete(triggerData) Placeholder method for handling after undelete trigger logic. Signature public virtual void afterUndelete(TriggerData triggerData) Parameters triggerData Type: TriggerData <code>TriggerData</code> The data for the trigger event. process(triggerData) Processes the trigger actions based on the current trigger context. It determines whether to call before or after methods based on the trigger context. Signature public void process(TriggerData triggerData) Parameters triggerData Type: TriggerData <code>TriggerData</code> The data for the trigger event."
    },
    {
        "title": "ITriggerHandler",
        "fileName": "ITriggerHandler.html",
        "text": "ITriggerHandler Interface defining the methods for a trigger handler, including execution conditions and processing methods for various trigger events. This interface allows for pre-processing and post-processing logic to be applied during insert, update, delete, and undelete operations. Signature public interface ITriggerHandler Author Christopher Pezza(@chiefpansancolt) Since 2024-11-17 ITriggerHandler Methods shouldExecute() isDoubleFireSafe() getType() beforeInsert(triggerData) afterInsert(triggerData) beforeUpdate(triggerData) afterUpdate(triggerData) beforeDelete(triggerData) afterDelete(triggerData) afterUndelete(triggerData) shouldExecute() Determines if the trigger handler should be executed. Signature Boolean shouldExecute() Returns Boolean indicating whether the handler should execute. isDoubleFireSafe() Checks if the handler is safe from being triggered multiple times within the same context. Signature Boolean isDoubleFireSafe() Returns Boolean indicating if the handler is double fire safe. getType() Retrieves the Type of the trigger handler class. Signature Type getType() Returns Type representing the handler's class type. beforeInsert(triggerData) Executes logic before an insert operation. Signature void beforeInsert(TriggerData triggerData) Parameters triggerData Type: TriggerData <code>TriggerData</code> The data for the current trigger context. afterInsert(triggerData) Executes logic after an insert operation. Signature void afterInsert(TriggerData triggerData) Parameters triggerData Type: TriggerData <code>TriggerData</code> The data for the current trigger context. beforeUpdate(triggerData) Executes logic before an update operation. Signature void beforeUpdate(TriggerData triggerData) Parameters triggerData Type: TriggerData <code>TriggerData</code> The data for the current trigger context. afterUpdate(triggerData) Executes logic after an update operation. Signature void afterUpdate(TriggerData triggerData) Parameters triggerData Type: TriggerData <code>TriggerData</code> The data for the current trigger context. beforeDelete(triggerData) Executes logic before a delete operation. Signature void beforeDelete(TriggerData triggerData) Parameters triggerData Type: TriggerData <code>TriggerData</code> The data for the current trigger context. afterDelete(triggerData) Executes logic after a delete operation. Signature void afterDelete(TriggerData triggerData) Parameters triggerData Type: TriggerData <code>TriggerData</code> The data for the current trigger context. afterUndelete(triggerData) Executes logic after an undelete operation. Signature void afterUndelete(TriggerData triggerData) Parameters triggerData Type: TriggerData <code>TriggerData</code> The data for the current trigger context."
    },
    {
        "title": "TriggerData",
        "fileName": "TriggerData.html",
        "text": "TriggerData This class stores and provides access to the old and new values of records in a trigger context, including their maps and object IDs for processing. Signature public inherited sharing class TriggerData Author Christopher Pezza(@chiefpansancolt) Since 2024-11-17 TriggerData Properties Name Signature newObjects public List<SObject> newObjects oldObjects public List<SObject> oldObjects newObjectsMap public Map<Id, SObject> newObjectsMap oldObjectsMap public Map<Id, SObject> oldObjectsMap objectIds public Set<Id> objectIds TriggerData Constructors TriggerData(newObjects, oldObjects, newObjectsMap, oldObjectsMap) TriggerData(newObjects, oldObjects, newObjectsMap, oldObjectsMap) Constructor to initialize the TriggerData object with new and old objects, and their respective maps. Signature @SuppressWarnings('PMD.ExcessiveParameterList') public TriggerData(List<SObject> newObjects, List<SObject> oldObjects, Map<Id, SObject> newObjectsMap, Map<Id, SObject> oldObjectsMap) Parameters newObjects Type: List<SObject> A list of new SObject records(newly inserted or updated). oldObjects Type: List<SObject> A list of old SObject records(previously existing records). newObjectsMap Type: Map<Id, SObject> A map of SObject Ids to new SObject records. oldObjectsMap Type: Map<Id, SObject> A map of SObject Ids to old SObject records."
    },
    {
        "title": "TriggerPipeline",
        "fileName": "TriggerPipeline.html",
        "text": "TriggerPipeline This class manages the trigger pipeline execution by processing trigger handlers in a specified sequence for the given object type. It includes pre-processing, processing, and post-processing phases, handling DML operations and logging errors. Signature public without sharing class TriggerPipeline extends ADMLDataProvider Author Christopher Pezza(@chiefpansancolt) Since 2024-11-17 TriggerPipeline Properties Name Signature executedHandlers private Set<String> executedHandlers triggerHandlers private List<ATriggerHandler> triggerHandlers triggerData private TriggerData triggerData pipeline private List<Trigger_Pipeline__mdt> pipeline INSERT_OPERATION private static final String INSERT_OPERATION TriggerPipeline Constructors TriggerPipeline(objectType) TriggerPipeline(objectType) Constructor that initializes trigger data and pipeline metadata for a given object type. It also executes the pipeline if trigger handlers are available. Signature public TriggerPipeline(sObjectType objectType) Parameters objectType Type: sObjectType The <code>sObjectType</code> the pipeline is executing for TriggerPipeline Methods executePipeline() preProcessing() processing() postProcessing() getContextKey(handler) getPipeline(objectType) getOperation() getSequenceIndicator() executePipeline() Executes the trigger pipeline by calling pre-processing, processing, and post-processing methods. Signature private void executePipeline() preProcessing() Pre-processes the pipeline by determining which handlers are valid and should be executed. Signature private void preProcessing() processing() Processes each valid handler and executes its logic, ensuring no double execution. Signature private void processing() postProcessing() Post-processes the handlers, merging their providers and executing DML operations. Signature private void postProcessing() getContextKey(handler) Generates a unique context key for each handler based on its type and the current trigger operation. Signature private static String getContextKey(ITriggerHandler handler) Parameters handler Type: ITriggerHandler <code>ITriggerHandler</code> The trigger handler. Returns String getPipeline(objectType) Retrieves the pipeline metadata based on the object type, operation, and sequence(before/after). Signature @SuppressWarnings('PMD.ApexSOQLInjection') private static List<Trigger_Pipeline__mdt> getPipeline(sObjectType objectType) Parameters objectType Type: sObjectType The <code>sObjectType</code> the pipeline is executing for Returns List<Trigger_Pipeline__mdt> getOperation() Returns the current operation type(Insert, Update, Delete, Undelete) based on the trigger context. Signature private static String getOperation() Returns String getSequenceIndicator() Returns the sequence indicator based on whether the trigger is 'before' or 'after'. Signature private static String getSequenceIndicator() Returns String"
    }
];