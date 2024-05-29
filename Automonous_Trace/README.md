# Autonomous trace to debug IFS issues

Bases on https://community.ifs.com/ifs-general-topics-employees-partners-only-79/use-of-autonomous-transactions-1288?tid=1288&fid=79

## Add autonomous trace
```sql
Autonomous_Trace('trace ID 1',  dbms_utility.format_call_stack);
```

## Query from the trace table
```sql
SELECT * FROM AUTONOMOUS_TRACE_TAB
```
## Delete from the trace table
```sql
DELETE FROM AUTONOMOUS_TRACE_TAB
```