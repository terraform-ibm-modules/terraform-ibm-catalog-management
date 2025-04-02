#!/bin/bash

############################################################################################################
## This script is used by the catalog pipeline to deploy the prereq catalog
############################################################################################################

set -e

DA_DIR="solutions/vpe-object"
TERRAFORM_SOURCE_DIR="solutions/catalog"
JSON_FILE="${DA_DIR}/catalogValidationValues.json"
TF_VARS_FILE="terraform.tfvars"

(
  cwd=$(pwd)
  cd ${TERRAFORM_SOURCE_DIR}
  echo "Provisioning pre-requisite catalog .."
  terraform init || exit 1

  # $VALIDATION_APIKEY is available in the catalog runtime
  {
    echo "ibmcloud_api_key=\"${VALIDATION_APIKEY}\""
    echo "label=\"$(openssl rand -hex 2)\""
    echo "kind=\"vpe\""
  } >> ${TF_VARS_FILE}
  terraform apply -input=false -auto-approve -var-file=${TF_VARS_FILE} || exit 1
  catalog_id=$(terraform output -state=terraform.tfstate -raw id)

  echo "Appending 'catalog_id' input variable values to ${JSON_FILE}.."

  cd "${cwd}"
  jq -r --arg catalog_id "${catalog_id}" \
        '. + {catalog_id: $catalog_id}' "${JSON_FILE}" > tmpfile && mv tmpfile "${JSON_FILE}" || exit 1

  echo "Pre-validation completed successfully."
)
