$erroractionPreference = 'silentlycontinue'

                                                       
 write-output @"
 ____            _____                           ___   '
|    \ ___ _____| __  |___ ___ ___ ___   ___ ___|_  |  
|  |  | . |     |    -| -_|  _| . |   |_| . |_ -|_| |_ 
|____/|___|_|_|_|__|__|___|___|___|_|_|_|  _|___|_____|
                                        |_|
"@

$target = Read-Host "[?] Domain to query [domain.com]"
$dict = Read-Host "[?] Path to Wordlist [.\path\to\file.txt]"

foreach ($line in Get-Content $dict) {
    write-host "[*] test $line.$target"
    if (resolve-dnsname -Name $line'.'$target) {
    $test = resolve-dnsname -Name $line'.'$target | Format-list -Property IPAddress | out-string    
        if (-Not [string]::IsNullOrEmpty($test)) {
            if (-Not [string]::IsNullOrWhiteSpace($test)) {
                write-output "[!] FOUND ! $line.$target"
                $output = resolve-dnsname -Name $line'.'$target | Format-Table -Property Name,Type,IPAddress
                write-output "$line.$target" >> .\$target'_result.txt'
                Out-File -InputObject $output -FilePath .\$target'_result.txt' -Append
            }
        }
    }
}
