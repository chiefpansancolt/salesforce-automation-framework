public with sharing class ErrorLogger {
    public static void logError(Exception e) {
        logError(e, null);
    }

	public static void logError(Exception e, String className) {
        if (!Test.isRunningTest()) {
            try {
                Error_Log__c errorLog = new Error_Log__c();
                errorLog.Error_Type__c = e.getTypeName();
                errorLog.Error_Message__c = e.getMessage();
                errorLog.Stack_Trace__c = e.getStackTraceString();
                errorLog.Timestamp__c = System.now();
                errorLog.Execution_Context__c = getExecutionContext();
                errorLog.User__c = UserInfo.getUserId();

                if (className != null) {
                    errorLog.Class_Name__c = className;
                }

                Exception cause = (Exception)e.getCause();
                if (cause != null) {
                    errorLog.Error_Cause__c = cause.getMessage();
                }

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

                Database.insert(errorLog);
            } catch (Exception loggingException) {
                System.debug('Failed to log the original error: ' + loggingException.getMessage());
                System.debug('Original Error: ' + e.getMessage());
            }
        }
	}

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
