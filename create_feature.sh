#!/bin/bash

# Check if a feature name was provided
if [ -z "$1" ]; then
  echo "Usage: $0 <feature_name>"
  exit 1
fi

FEATURE_NAME=$1

echo "Creating feature structure for: $FEATURE_NAME"

# Create directories for the feature
mkdir -p lib/features/"$FEATURE_NAME"/data/datasources \
         lib/features/"$FEATURE_NAME"/data/models \
         lib/features/"$FEATURE_NAME"/data/repositories \
         lib/features/"$FEATURE_NAME"/domain/entities \
         lib/features/"$FEATURE_NAME"/domain/usecases \
         lib/features/"$FEATURE_NAME"/presentation/pages \
         lib/features/"$FEATURE_NAME"/presentation/widgets \
         lib/features/"$FEATURE_NAME"/presentation/bloc_or_provider

# Create placeholder files
touch lib/features/"$FEATURE_NAME"/presentation/pages/"${FEATURE_NAME}_page.dart"
touch lib/features/"$FEATURE_NAME"/presentation/bloc_or_provider/"${FEATURE_NAME}_bloc.dart"

echo "Feature structure for '$FEATURE_NAME' created successfully."
