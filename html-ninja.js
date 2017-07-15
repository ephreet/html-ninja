function decrypt()
{
 var retstring = "";
 if (window.XMLHttpRequest)
 {// code for IE7+, Firefox, Chrome, Opera, Safari, SeaMonkey
  xmlhttp=new XMLHttpRequest();
 }
 else
 {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
 }
 xmlhttp.onreadystatechange=function()
 {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
  {
   retstring = xmlhttp.responseText;
  }
 }
 xmlhttp.open("GET", document.location, false);
 xmlhttp.send();
 src = retstring;

 var prevchar = "nil";
 var bits = "";
 var char = "";
 for (var i = 0, len = src.length; i < len; i++) {
  char = src.charAt(i);
  if (prevchar === " "){
   if (char === " "){
	bits = bits + "1";
	char = "nil";
   }else{
   	bits = bits + "0";
	char = "nil";
   }
  }
  prevchar = char;
 }
 bits = bits.replace(/(\S{8})/g,"$1 ");
 
 var binString = '';

 bits.split(' ').map(function(bin) {
    binString += String.fromCharCode(parseInt(bin, 2));
  });

 return binString;
 
}

var output = decrypt();

btoa(output); // if you want to use this data in some misterious ways ;)


