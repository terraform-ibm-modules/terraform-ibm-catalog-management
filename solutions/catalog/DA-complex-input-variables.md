# Configuring complex inputs for Catalog Management in IBM Cloud projects

Several input variables in the IBM Cloud [Catalog Management deployable architecture](https://cloud.ibm.com/catalog#deployable_architecture) use complex object types. You specify these inputs when you configure deployable architecture.

* [Target Accounts](#target-accounts) (`target_accounts`)

## Target Accounts <a name="target-accounts"></a>

The `target_accounts` input variable allows you to define one or more IBM Cloud accounts with which the catalog will be shared. This enables you to grant access to other IBM Cloud accounts, allowing them to view or use the catalog contents.

- Variable name: `target_accounts`
- Type: A list of objects, each describing a target account configuration.
- Default value: An empty map (`[]`)

Note: This variable can only be set during an update operation on the catalog and it cannot be specified during catalog creation.

### Options for target_accounts
- `name` (required): Name of the target account.

- `label` (required): A label for the target account context for easy identification and documentation..

- `api_key` (optional): The IAM API key for the target account. Required for authentication if a trusted profile is not provided.

- `trusted_profile_id` (optional): The Trusted Profile ID to authenticate the sharing of the catalog with the target account without using an API key.

- `project_id` (optional): The project ID within the target account. If specified, either api_key or trusted_profile_id is required.

- `target_service_id` (optional): The IAM Service ID associated with the target account.

### Constraints
- At least one of `api_key` or `trusted_profile_id` must be provided for target account.
- Configurable only during catalog updates, not during creation.

### Example Usage
```
target_accounts = [
  {
    name               = "dev-account"
    label              = "Dev Account"
    api_key            = "abcdxxxefgh"
    project_id         = "12345"
    trusted_profile_id = null
    target_service_id  = null
  },
  {
    name               = "prod-account"
    label              = "Prod Account"
    api_key            = null
    project_id         = null
    trusted_profile_id = "Profile-5xxx-1xxx-4xxx-axxx-2xxxxxxx"
    target_service_id  = "ServiceId-dxxxxx-5xxx-4xxx-axxx-axxxxxx"
  }
]
```

For more information, refer to the the [IBM Cloud Terraform Provider documentation for Catalog Management](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.78.2/docs/resources/cm_catalog).
