
Create an index of SCHEMA.OBJECT names that appear in source code files

# Get the tokens and build index file

./get-all-tokens.sh

# Search for SCHEMA.OBJECT

./find-obj.sh SCHEMA.OBJECT

# Examples


## Find all objects in a BTEQ	file, and get first level dependendent objects as well.

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

## Find dependencies on object or file

```bash
>  ./find-deps.sh

usage: ./find-deps.sh search-term search-level

the default search level is 3

```

### Default Level 3

```bash
>  ./find-deps.sh PRD_STG_LRD.FINDER_LINK_TYPE
file:Proc/STG_LRD_PROCEDURE/PRD_STG_LRD.P_FINDER_LINK_TYPE
file:Table/STG_LRD_TABLE/PRD_STG_LRD.FINDER_LINK_TYPE
object:PRD_STG_LRD.FINDER_LINK_TYPE
object:PRD_TGT_EDW.FINDER_LINK_TYPE

```

### Level 4

```bash
>  ./find-deps.sh PRD_STG_LRD.FINDER_LINK_TYPE 4
file:Proc/STG_LRD_PROCEDURE/PRD_STG_LRD.P_FINDER_LINK_TYPE
file:Table/STG_LRD_TABLE/PRD_STG_LRD.FINDER_LINK_TYPE
file:Table/TGT_EDW_TABLE/PRD_TGT_EDW.FINDER_LINK_TYPE
file:View/TGT_EDV_VIEW/PRD_TGT_EDV.V_FINDER_LINK_TYPE
object:PRD_STG_LRD.FINDER_LINK_TYPE
object:PRD_TGT_EDW.FINDER_LINK_TYPE
```

### Default Level 3

```bash
>  ./find-deps.sh CUSTOMERS_PRE2STG.btq
file:Bteq/STAGING/CUSTOMERS_PRE2STG.btq
object:CUSTOMERS_PRE2STG.BTQ
... 9 lines deleted
object:PRD_STG_WRK.CUSTOMERS
```

### Level 4

```bash

>  ./find-deps.sh CUSTOMERS_PRE2STG.btq 4
file:Bteq/SL/ASSIGNMENTS_PRESTGTODWH.BTQ
... 187 lines deleted
file:View/TGT_EDV_VIEW/PRD_TGT_EDV.V_W6ASSIGNMENTS
object:CUSTOMERS_PRE2STG.BTQ
... 9 lines deleted
object:PRD_STG_WRK.CUSTOMERS
```

