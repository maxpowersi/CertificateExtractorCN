foreach($line in Get-Content .\input.txt) 
{
	$url = $line.Split(" ")[0]
	$puerto = $line.Split(" ")[1]
	Start-Process -NoNewWindow -Wait -FilePath ".\SSLCertDownloader.exe" -ArgumentList "$url $puerto $url.cer" | Out-Null
}

clear

$currentPath = (Get-Item .).FullName + "\"

foreach($line in Get-Content .\input.txt) 
{
	$url = $line.Split(" ")[0]
	$CRT = New-Object System.Security.Cryptography.X509Certificates.X509Certificate
	$CRT.Import($currentPath +  $url+ ".cer")
	Write ($CRT.Subject.Split("=")[1]).Split(",")[0]	
}

Get-ChildItem . -recurse -include *.cer | remove-item