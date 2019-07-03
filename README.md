
Create an index of SCHEMA.OBJECT names that appear in source code files

# Get the tokens

./get-all-tokens.sh

# Build the index

./build-index.pl

# Search for SCHEMA.OBJECT

./find-obj.sh SCHEMA.OBJECT

