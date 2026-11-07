$cert = "C:\Users\USER\waf.crt"
while ($true) {
  $t = Get-Date -f HH:mm:ss.fff
  $r = curl.exe --cacert $cert -s -m 1 -I https://192.168.56.100 2>$null
  if ($r) {
    $statut = ($r | Select-Object -First 1)
    $waf = ($r | Select-String "X-WAF")
    "$t  $statut  $waf"
  } else { "$t  ECHEC" }
  Start-Sleep -Milliseconds 500
}
