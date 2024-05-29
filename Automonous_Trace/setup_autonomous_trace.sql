DECLARE

   columns_ Database_SYS.ColumnTabType;

BEGIN

   Database_SYS.Reset_Column_Table(columns_);
   Database_SYS.Set_Table_Column( columns_ , 'TRACE_ID' , 'VARCHAR2(30)', 'Y' );
   Database_SYS.Set_Table_Column( columns_ , 'TEXT' , 'VARCHAR2(4000)', 'Y' );
   Database_SYS.Set_Table_Column( columns_ , 'TIMESTAMP', 'DATE', 'Y');
   Database_SYS.Create_Table('AUTONOMOUS_TRACE_TAB', columns_);
   -- using default Table Space and Sizing
END;
/

CREATE OR REPLACE PROCEDURE Autonomous_Trace( trace_id_ IN VARCHAR2, text_ IN VARCHAR2 )
AS
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   INSERT INTO autonomous_trace_tab(
                                 trace_id,
                                 text,
                                 timestamp )
   VALUES (
         SUBSTR(trace_id_, 1, 30),
         SUBSTR(text_, 1, 4000),
         SYSDATE );
   COMMIT;
END Autonomous_Trace;
/