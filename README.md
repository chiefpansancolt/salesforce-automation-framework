# Salesforce Automation Framework

![GitHub release (latest by date)](https://img.shields.io/github/v/release/chiefpansancolt/salesforce-automation-framework?logo=github&style=flat-square)
[![Discord](https://img.shields.io/discord/450095227185659905?label=Discord&logo=discord&style=flat-square)](https://discord.gg/FPfA3w6)

## Features

- Trigger Framework
- Error Logger
- Template Record Trigger Flows
- Custom Permissions to Exclude Flow and Trigger

## Installation

To Install into your environment you will need to use SF CLI to deploy this repo or download the zip file attached to the release.

### Deploy with CLI

```bash
sf project deploy start -d src
```

### Deploy with Zip

Download from the latest [release](https://github.com/chiefpansancolt/salesforce-automation-framework/releases)

You can use workbench to deploy the zip file to your environment.

## Configuration

### Pre Setup Items

- Before implementing a new Pipeline assign `Trigger Framework Access` Permission set to all users that will possibly be using a Trigger Framework on an Object.
- Assign `Exclude User` Permission Set Group to any Integration User that you do not want Flows or Trigger to run for 100% of the time.

### Setup New Trigger Pipeline

1. Create a new Trigger on the object you wish to create. The trigger should mirror the below snippet when creating.

```java
trigger TestObjectTrigger on Test_Object__c(before insert, after insert, before update, after update, before delete, after delete, after undelete) {
	new TriggerPipeline(Schema.Test_Object__c.sObjectType);
}
```

Make sure to only include before insert and such for those you wish to use.

The Framework supports the below Trigger Contexts

- Before Insert
- After Insert
- Before Update
- After Update
- Before Delete
- After Delete
- After Undelete

2. Now you can create a Handler for your Trigger todo anything you are looking to do. Be sure to think about a couple things when determining how to breakdown your handlers to not have all your code in 1 Handler class. 

- Breakdown to handle a single related object like `TestObjectAccountHandler`
- Breakdown to be sure a Query is not duplicated in multiple Handlers
- Breakdown to be sure a DML for a record is done in a single Handler and not in multiple Handlers.

A Handler should look similar to the below snippet to implement. Only the `getType()` method is required in any handler, otherwise all others are optional for override.

```java
public with sharing class TestObjectHandler extends ATriggerHandler {
	// Optional if you want to fire all the time no need to check if it should or not.
	public override Boolean shouldExecute() {
		return !FeatureManagement.checkPermission('Exclude_Trigger');
	}

	/** Override this method and return the Type of the implementing trigger class
	 * (e.g. return Type.getName('NameOfImplementingTriggerClass'))
	 * (e.g. return NameOfImplementingTriggerClass.class
	 *
	 * Required do not delete method.
	 */
	public override Type getType() {
		return TestObjectHandler.class;
	}

	/**
	 * Override this method and set isDoubleFireSafe to true in any trigger that needs to set
	 * special rules for determining if a record has already been trigged upon. Only applies to
	 * update operations. Salesforce guarantees that triggers only fire once for insert and delete
	 * operations.
	 *
	 * @return a Boolean indicating if a trigger is using the double-fire safe trigger framework
	 *
	 * Optional if you want to fire only once.
	 */
	public override Boolean isDoubleFireSafe() {
		return false;
	}

	// Add Remove the methods below based on what is needed for your use case

	/**
	 * beforeInsert method to fire in the before insert context of a trigger.
	 *
	 * @param triggerData TriggerData the trigger data found in the Trigger class
	 */
	public override void beforeInsert(TriggerData triggerData) {
		beforeInsertCalled = true;
	}

	/**
	 * afterInsert method to fire in the after insert context of a trigger.
	 *
	 * @param triggerData TriggerData the trigger data found in the Trigger class
	 */
	public override void afterInsert(TriggerData triggerData) {
		afterInsertCalled = true;
	}

	/**
	 * beforeUpdate method to fire in the before update context of a trigger.
	 *
	 * @param triggerData TriggerData the trigger data found in the Trigger class
	 */
	public override void beforeUpdate(TriggerData triggerData) {
		beforeUpdateCalled = true;
	}

	/**
	 * afterUpdate method to fire in the after update context of a trigger.
	 *
	 * @param triggerData TriggerData the trigger data found in the Trigger class
	 */
	public override void afterUpdate(TriggerData triggerData) {
		afterUpdateCalled = true;
	}

	/**
	 * beforeDelete method to fire in the before delete context of a trigger.
	 *
	 * @param triggerData TriggerData the trigger data found in the Trigger class
	 */
	public override void beforeDelete(TriggerData triggerData) {
		beforeDeleteCalled = true;
	}

	/**
	 * afterDelete method to fire in the after delete context of a trigger.
	 *
	 * @param triggerData TriggerData the trigger data found in the Trigger class
	 */
	public override void afterDelete(TriggerData triggerData) {
		afterDeleteCalled = true;
	}

	/**
	 * afterUndelete method to fire in the after undelete context of a trigger.
	 *
	 * @param triggerData TriggerData the trigger data found in the Trigger class
	 */
	public override void afterUndelete(TriggerData triggerData) {
		afterUndeleteCalled = true;
	}
}
```

This framework supports a grouping DML to avoid to many DML's so you can add 1 or many records to a DML Utility and that DML will be performed at the end of the current pipeline.

Supported DML Utilities are:

- addInsert(sObject)
- addInsert(sObject, boolean)
- addInserts(List<sObject>)
- addUpdate(sObject)
- addUpdates(List<sObject>)
- addDlete(sObject)
- addDeletes(List<sObject>)

3. Once the file is created then you can create the Custom Metadata Type records for the Trigger Pipeline and Trigger Handler
	1. Create Trigger Pipline record in Custom Metadata Type Trigger_Pipeline__mdt. Be sure to select and enable all contexts you have a pipeline for.
	2. Now create a Trigger Handler in Custom Metadata Type Trigger_Handler__mdt and again check off all applicable Trigger Contexts to implement for said Handler.
	3. Repeat step 2 for each new handler you are implementing.

> [!TIP]
> Check out example implementation of a Trigger Framework on the Account object in the [example folder](/example/trigger-pipeline).

### Use Error Logger

You can add the Error Logger anywhere in your code but it is recommended to add it only in places that will fire when an error is to be produced or caught. To implement see the below examples of its implementations.

#### Just the Exception

```java
ErrorLogger.logError(e);
```

#### Exception and Class

```java
ErrorLogger.logError(e, 'TestObjectHandler');
```

> [!TIP]
> Check out example implementation of an Error Logger in the [example folder](/example/error-logger).

### Implementing Flows

When setting up flows be sure to setup in a logical manner of a single flow per object per context. While deviating from these guidelines is reasonable, be sure to be consistent and naming conventions are followed.

Flows could be setup in a manner as it follows:

- Account Record Trigger: Before Save No Bypass
- Account Record Trigger: Before Save
- Account Record Trigger: After Save
- Account Record Trigger: After Save (Email Alerts)
- Account Record Trigger: Before Delete
- Account Record Trigger: After Save Job (Update Name)

You can use the Templates provided to jump start the creation of the Before Save, After Save and Before Delete Flows with and without bypasses.

## Change Log

Check out the [Change Log](https://github.com/chiefpansancolt/salesforce-automation-framework/blob/main/CHANGELOG.md) for new breaking changes/features/bug fixes per release of a new version.

## Contributing

Bug Reports, Feature Requests, and Pull Requests are welcome on GitHub at [https://github.com/chiefpansancolt/salesforce-automation-framework](https://github.com/chiefpansancolt/salesforce-automation-framework). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](https://github.com/chiefpansancolt/salesforce-automation-framework/blob/main/.github/CODE_OF_CONDUCT.md) code of conduct.

To see more about Contributing check out this [document](https://github.com/chiefpansancolt/salesforce-automation-framework/blob/main/.github/CONTRIBUTING.md).

- Fork Repo and create new branch
- Once all is changed and committed create a pull request.

**Ensure all merge conflicts are fixed and CI is passing.**

## Development

Developing is done in your own development org and no methods can be renamed or removed since this is a managed package.

## License

Salesforce Automation Framework is available as open source under the terms of the [MIT License](https://github.com/chiefpansancolt/salesforce-automation-framework/blob/main/LICENSE).
