DECLARE

  row_              fnd_model_design_data_tab%ROWTYPE;
  from_context_     VARCHAR2(2000) := 'FROM_CONTEXT';
  to_context_       VARCHAR2(2000) := 'TO_CONTEXT';
  model_id_         VARCHAR2(2000) :=  'ClientMetadata.client:DocumentRevision';
  published_        boolean;
  CURSOR get_page_rec IS 
     SELECT *
     FROM   ifsapp.fnd_model_design_data_tab
     WHERE  layer_no IN ( 90, 2)  -- 90 Draft, 2 published
     AND    scope_id = from_context_
     AND    model_id = model_id_;
     
-- Calc Hash from Model_Design_SYS     
FUNCTION Calc_Hash___(
   clob_ IN CLOB) RETURN VARCHAR2
IS
BEGIN
   IF (dbms_lob.getlength(clob_) > 0) THEN
      RETURN dbms_crypto.Hash(clob_, dbms_crypto.HASH_SH1);
   END IF;
   
   RETURN NULL;   
END Calc_Hash___;     

BEGIN
  DELETE FROM fnd_model_design_data_tab 
     WHERE  scope_id = to_context_
     AND    model_id = model_id_;

FOR rec_ IN get_page_rec LOOP    
   row_.model_id := rec_.model_id;
   row_.scope_id := to_context_;
   row_.data_id := rec_.data_id;
   row_.artifact := rec_.artifact;
   row_.name := rec_.name;
   row_.line_no := rec_.line_no;
   row_.layer_no := rec_.layer_no;
   rec_.reference := rec_.reference;
   row_.visibility:= rec_.visibility;
   row_.dependencies := rec_.dependencies;
   row_.schema_version := rec_.schema_version;
   row_.content := rec_.content;
   row_.based_on_content := rec_.based_on_content;
   row_.rowkey := sys_guid();
   row_.rowversion := sysdate;
   
   IF (row_.content_hash IS NULL) THEN
      row_.content_hash := Calc_Hash___(row_.content);      
   END IF;
   IF (row_.layer_no > 1 AND row_.based_on_content_hash IS NULL) THEN
      row_.based_on_content_hash := Calc_Hash___(row_.based_on_content);      
   END IF;

  INSERT 
      INTO fnd_model_design_data_tab 
      VALUES row_;
      row_ := NULL;
  END LOOP;

-- refresh timestamp   
  Model_Design_SYS.Refresh_Version(model_id_);
--publish
  published_  := Aurena_Designer_Util_API.Publish_Page_Configurations2(model_id_ ,  to_context_);

END;