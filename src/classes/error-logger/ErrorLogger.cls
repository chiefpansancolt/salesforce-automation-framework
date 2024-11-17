/**
 * This class provides methods for logging errors in Salesforce by creating Error_Log__c records.
 * It captures relevant exception information such as type, message, stack trace, and execution context.
 * Additionally, it handles special cases like QueryExceptions and logs inaccessible fields.
 * 
 * @author Christopher Pezza (@chiefpansancolt)
 * @since 2024-11-17
 * @group Error Logger
 */
public with sharing class ErrorLogger {

    /**
     * Logs the given exception into an Error_Log__c record.
     * @param e <code>Exception</code> The exception to be logged.
     */
    public static void logError(Exception e) {
        logError(e, null);
    }

    /**
     * Logs the given exception and additional class name into an Error_Log__c record.
     * 
     * @param e <code>Exception</code> The exception to be logged.
     * @param className The class name where the error occurred (optional).
     */
    @SuppressWarnings('PMD.CognitiveComplexity, PMD.AvoidDebugStatements')
    public static void logError(Exception e, String className) {
        if (!Test.isRunningTest()) {
            try {
                // Create a new error log record
                Error_Log__c errorLog = new Error_Log__c();
                errorLog.Error_Type__c = e.getTypeName();
                errorLog.Error_Message__c = e.getMessage();
                errorLog.Stack_Trace__c = e.getStackTraceString();
                errorLog.Timestamp__c = System.now();
                errorLog.Execution_Context__c = getExecutionContext();
                errorLog.User__c = UserInfo.getUserId();

                // Add class name if provided
                if (className != null) {
                    errorLog.Class_Name__c = className;
                }

                // Capture cause of the exception
                Exception cause = (Exception)e.getCause();
                if (cause != null) {
                    errorLog.Error_Cause__c = cause.getMessage();
                }

                // Handle specific case for QueryException
                if (e instanceof QueryException) {
                    QueryException queryException = (QueryException)e;
                    Map<String, Set<String>> inaccessible = queryException.getInaccessibleFields();
                    Set<String> fields = new Set<String>();

                    for (String objectName : inaccessible.keySet()) {
                        for(String field : inaccessible.get(objectName)) {
                            fields.add(objectName + '.' + field);
                        }
                    }

                    errorLog.Inaccessible_Fields__c = String.join(fields, ' | ');
                }

                // Insert the error log record into the database
                Database.insert(errorLog);
            } catch (Exception loggingException) {
                // Log a failure message if the error log insertion fails
                System.debug(logginglevel.INFO, 'Failed to log the original error: ' + loggingException.getMessage());
                System.debug(logginglevel.ERROR, 'Original Error: ' + e.getMessage());
            }
        }
    }

    /**
     * Determines the execution context of the current operation (e.g., Batch, Future, Trigger).
     * @return `String`
     */
    private static String getExecutionContext() {
        if (System.isBatch()) {
            return 'Batch Job';
        } else if (System.isFuture()) {
            return 'Future';
        } else if (System.isQueueable()) {
            return 'Queueable';
        } else if (System.isScheduled()) {
            return 'Scheduled Job';
        } else if (Trigger.isExecuting) {
            return 'Trigger';
        }
        return 'User Interface';
    }
}
