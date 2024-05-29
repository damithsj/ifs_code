## Add autonomous trace
```sql
Autonomous_Trace('Call to Get_basic',  dbms_utility.format_call_stack);
```

## Query from the trace table
```sql
Select * from AUTONOMOUS_TRACE_TAB
```
## Delete from the trace table
```sql
DELETE from AUTONOMOUS_TRACE_TAB
```