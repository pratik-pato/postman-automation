var sql = require('mssql');
var fs = require('fs');
function randomIntByModulo(min, max) {
  var i = (Math.random() * 32768) >>> 0;
  return (i % (min - max)) + min;
}

var cid = randomIntByModulo(1,5000);//Math.random()
var uid = "binaryLabs"+ cid.toString();
var colmn = "cif,id";
var row = cid+","+uid
var stream = fs.createWriteStream("./business.csv");
stream.once('open', function(fd) {
  stream.write(colmn+"\n");
  stream.write(row+"\n");
  stream.end();
});
sql.connect("mssql://sa:Pass1234@10.97.188.237:1433/cb83sp03").then(function() {
    // Query 
	//var del = "DELETE FROM BS_Customer where CustomerID = '8055';"
    var qry = "insert into BS_Customer(CustomerID,UserID,Password,FirstName,LastName,Address1,City,State,PostalCode,Country) values('"+cid+"','"+uid+"','"+cid+"','John','Doe','Add1','City','state','411030','India');"
    console.log("CONNECTED TO MSSQL with : mssql://sa:Pass1234@10.97.188.237:1433/cb83sp03")
    console.log(qry)
    //new sql.Request().query(del).then(function(recordset) {
        //console.dir(recordset);
    //}).catch(function(err) {
    //});
	new sql.Request().query(qry).then(function(recordset) {
        //console.dir(recordset);
    }).catch(function(err) {
    });
	});