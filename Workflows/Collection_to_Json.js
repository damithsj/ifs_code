var SpinJSON = org.camunda.spin.Spin.JSON;
var qrArr = execution.getVariable("QuickReport_942483");
var firstElement = qrArr[0]; // QR contains only one record. Therefore take the first element
var jsonObject = SpinJSON(firstElement);
execution.setVariable("varJsonBody", jsonObject.toString());
