var inputJson = require('./newmanExport.json');
var outputJson = require('./Environment.json');
var listObj = [];
for(var i=3;i<5;i++)
{
var insertObj = new Object();
insertObj.key = inputJson.values[i].name;
insertObj.type = "text";
insertObj.value = inputJson.values[i].value;
insertObj.enabled = true;
listObj.push(insertObj);
(outputJson.values).push(listObj[i-3]);
}
var finalObj = JSON.stringify(listObj);
var obj=eval("("+finalObj+")");
//(outputJson.values).push(listObj[0]);
//(outputJson.values).push(listObj[1]);
console.log(JSON.stringify(outputJson))
