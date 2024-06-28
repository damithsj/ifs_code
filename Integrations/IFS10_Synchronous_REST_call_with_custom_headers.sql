--Use IFS_XML_TO_JSON transformer in the routing address to convert xml to json
-- tribute goes to https://community.ifs.com/ifs-framework-experience-employees-partners-only-109/how-to-enable-synchronous-message-flow-in-ifs-rest-sender-7550

DECLARE
  json_clob_  CLOB;
  request_    ifsapp.Plsqlap_Document_API.Document;
BEGIN
  request_ := ifsapp.Plsqlap_Document_API.New_Document('Input');
  ifsapp.Plsqlap_Document_API.Add_Attribute(request_,'CustomerNo','XXXXX');
  ifsapp.Plsqlap_Document_API.Add_Attribute(request_, 'FirstName', 'Chris');
  ifsapp.Plsqlap_Document_API.Add_Attribute(request_, 'LastName', 'Pratt');
  ifsapp.Plsqlap_Document_API.Add_Attribute(request_, 'Address1', 'Colombo');
  ifsapp.Plsqlap_Document_API.Add_Attribute(request_, 'Address2', 'Colombo');
  ifsapp.Plsqlap_Document_API.Add_Attribute(request_, 'City', 'Colombo');
  ifsapp.Plsqlap_Document_API.Add_Attribute(request_, 'Gender', 'Male');
  ifsapp.Plsqlap_Document_API.Add_Attribute(request_, 'MobileNo', '071111111');
  ifsapp.Plsqlap_Document_API.Add_Attribute(request_, 'LandNo', '0111111111');

  ifsapp.Plsqlap_Document_API.To_Xml(json_clob_, request_);

  ifsapp.plsql_rest_sender_API.Call_Rest_EndPoint3(rest_service_ => NULL,
                                                   xml_          => json_clob_,
                                                   http_method_  => 'POST',
                                                   http_req_headers_ =>'header1:value1, header2:value2',
                                                   sender_       => 'IFS',
                                                   receiver_     => 'INT');
  Dbms_Output.put_line(json_clob_);
END;