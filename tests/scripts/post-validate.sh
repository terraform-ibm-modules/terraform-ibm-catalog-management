#!/bin/bash

#############################################################################################################
# This script is used by the catalog pipeline to destroy the pre-req catalog                               #
#############################################################################################################

set -e

TERRAFORM_SOURCE_DIR="solutions/catalog"
TF_VARS_FILE="terraform.tfvars"

(
  cd "${TERRAFORM_SOURCE_DIR}"
  echo "Destroying pre-requisite catalog..."
  terraform destroy -input=false -auto-approve -var-file="${TF_VARS_FILE}" || exit 1

  echo "Post-validation completed successfully."
)
