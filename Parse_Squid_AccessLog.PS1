# Citra IT - Excelência em TI
# Script para fazer "parsing" do access.log do squid
# @Author: luciano@citrait.com.br
# @Version: 1.0

CLS
Write-Host "Parsing file $($args[0]). Please Wait..."
#$raw = Get-Content -Path $args[0]

#$raw | ForEach-Object {
Get-Content -Path $args[0] | ForEach-Object {
	$full_line = $_
	#$fields = $full_line.split(" ", [StringSplitOptions]::RemoveEmptyEntries)
	$url = $full_line.split(" ", [StringSplitOptions]::RemoveEmptyEntries)[6]
	$invalid = $False
	If($url.StartsWith("/"))
	{
		$invalid = $True
	}ElseIf($url.StartSwith("http://"))
	{
		$url = $url.Replace("http://", "")
	}ElseIf($url.StartSwith("https://"))
	{
		$url = $url.Replace("https://", "")
	}
	
	If (-Not ($invalid))
	{
		$domain = [Regex]::Match($url, "(?<domain>[^/]+)").Groups["domain"].Value
		$domain = $domain.Replace(":443", "")
		$domain = $domain.Replace(":80", "")
		$domain
	}
	
		
	<#
		$fields[0] = timestamp (unix)
		$fields[1] = elapsed
		$fields[2] = source ip
		$fields[3] = TCP_MISS/DENIED/NONE/HIT (code/status)
		$fields[4] = bytes
		$fields[5] = method
		$fields[6] = URL 
		$fields[7] = user
		$fields[8] = hierarchy code
		$fields[9] = type  (content-type)
	#>
} | Sort -U | Out-GridView -Wait 

Write-Host "Done..."




