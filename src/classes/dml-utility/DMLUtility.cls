/**
 * Utility class to handle DML operations such as insert, update, and delete.
 * It performs all DML operations by calling specific methods for each type of operation.
 * The class relies on an ADMLDataProvider instance to handle DML data.
 * 
 * @author Christopher Pezza (@chiefpansancolt)
 * @since 2024-11-17
 * @group DML Utility
 */
@SuppressWarnings('PMD.OperationWithLimitsInLoop')
public inherited sharing virtual class DMLUtility {
    private ADMLDataProvider provider;

    /**
     * Constructor to initialize the DMLUtility class with an ADMLDataProvider.
     * @param provider The <code>ADMLDataProvider</code> instance used to perform DML operations.
     */
    public DMLUtility(ADMLDataProvider provider) {
        this.provider = provider;
    }

    /**
     * Performs all DML operations: insert, update, and delete.
     */
    public virtual void performAllDml() {
        performInsertDml();
        performUpdateDml();
        performDeleteDml();
    }

    /**
     * Performs update DML operations.
     * Iterates over the update items and applies the DML operation to each chunk of updated records.
     */
    public virtual void performUpdateDml() {
        for (String key : provider.getToUpdate()) {
            Database.update(provider.getToUpdateChunks().get(key), true);
        }
        provider.clearUpdate();
    }

    /**
     * Performs insert DML operations.
     * Iterates over the insert items and applies the DML operation to each chunk of records to be inserted.
     */
    public virtual void performInsertDml() {
        for (String key : provider.getToInsert()) {
            Database.insert(provider.getToInsertChunks().get(key), true);
        }
        provider.clearInsert();
    }

    /**
     * Performs delete DML operations.
     * Iterates over the delete items and applies the DML operation to each chunk of records to be deleted.
     */
    public virtual void performDeleteDml() {
        for (String key : provider.getToDelete()) {
            Database.delete(provider.getToDeleteChunks().get(key), true);
        }
        provider.clearDelete();
    }
}
