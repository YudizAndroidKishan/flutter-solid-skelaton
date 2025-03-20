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
         lib/features/"$FEATURE_NAME"/domain/repositories \
         lib/features/"$FEATURE_NAME"/domain/usecases \
         lib/features/"$FEATURE_NAME"/presentation/bloc_or_provider \
         lib/features/"$FEATURE_NAME"/presentation/pages \
         lib/features/"$FEATURE_NAME"/presentation/widgets

# Create placeholder files in data/datasources
touch lib/features/"$FEATURE_NAME"/data/datasources/"${FEATURE_NAME}_local_datasource.dart"
touch lib/features/"$FEATURE_NAME"/data/datasources/"${FEATURE_NAME}_remote_datasource.dart"

# Create placeholder files in data/models
touch lib/features/"$FEATURE_NAME"/data/models/"${FEATURE_NAME}_model.dart"

# Create placeholder files in data/repositories
touch lib/features/"$FEATURE_NAME"/data/repositories/"${FEATURE_NAME}_repository_impl.dart"

# Create placeholder files in domain/entities
touch lib/features/"$FEATURE_NAME"/domain/entities/"${FEATURE_NAME}.dart"

# Create placeholder files in domain/repositories
touch lib/features/"$FEATURE_NAME"/domain/repositories/"${FEATURE_NAME}_repository.dart"

# Create placeholder files in domain/usecases
touch lib/features/"$FEATURE_NAME"/domain/usecases/get_current_user_usecase.dart
touch lib/features/"$FEATURE_NAME"/domain/usecases/login_usecase.dart
touch lib/features/"$FEATURE_NAME"/domain/usecases/logout_usecase.dart

# Create placeholder files in presentation/bloc_or_provider
touch lib/features/"$FEATURE_NAME"/presentation/bloc_or_provider/"${FEATURE_NAME}_bloc.dart"
touch lib/features/"$FEATURE_NAME"/presentation/bloc_or_provider/"${FEATURE_NAME}_event.dart"
touch lib/features/"$FEATURE_NAME"/presentation/bloc_or_provider/"${FEATURE_NAME}_state.dart"

# Create placeholder files in presentation/pages
touch lib/features/"$FEATURE_NAME"/presentation/pages/"${FEATURE_NAME}_page.dart"

# Create placeholder files in presentation/widgets
touch lib/features/"$FEATURE_NAME"/presentation/widgets/"${FEATURE_NAME}_form.dart"

echo "Feature structure for '$FEATURE_NAME' created successfully."
