
Create an index of SCHEMA.OBJECT names that appear in source code files

# Get the tokens and build index file

./get-all-tokens.sh

# Search for SCHEMA.OBJECT

./find-obj.sh SCHEMA.OBJECT

# Examples


Find all objects in a BTEQ	file, and get dependendent objects as well.

```bash

for obj in $( ./find-obj.sh  CUSTOMERS_PRE2STG.btq | cut -f2 -d: )
do
	./find-obj.sh $obj
done | cut -f2 -d: | tr -d '[;()]"--"' |  grep -v README.md | sort -u

CUSTOMERS_PRE2STG.BTQ
PRD_METADATA.JOB_LOG
PRD_METADATA.JOB_LOG_T
PRD_PRE_STAGE.W6ASSIGNMENTS
PRD_PRE_STAGE.W6ASSIGNMENTS_ENGINEERS
PRD_PRE_STAGE.W6AUDITHISTORY
PRD_PRE_STAGE.W6CUSTOMERS
PRD_PRE_STAGE.W6STATUSREASON_SHOWONSTATUSES
PRD_PRE_STAGE.W6TASKS
PRD_STG_OI.CUSTOMERS
PRD_STG_OI.PURGE_DAYS
PRD_STG_WRK.CUSTOMERS

```


