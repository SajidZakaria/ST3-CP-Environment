param($file, $PATH)

g++ -std=c++17 $file

# change the paths according to your input and output files

$input = 'C://Users/USERNAME/Documents/Coding/input.txt'
$output = 'C://Users/USERNAME/Documents/Coding/output.txt'

# TimeoutTime in Seconds, change according to your need
# MaxOutputSize in Megabytes, change according to your need

$TimeoutTime = 5
$MaxOutputSize = 1

$BeginTime = Get-Date
$flag = 0

$p = Start-Process ./a.exe -RedirectStandardInput $input -RedirectStandardOutput $output -NoNewWindow -passthru

While (-not $p.HasExited -And $p -ne $null) {
    $EndTime = Get-Date
    $CurDuration = (New-TimeSpan -Start $BeginTime -End $EndTime).TotalSeconds
    $CurDuration = [math]::Round($CurDuration, 1)

    $OutputSize = (Get-Item $output).length/1MB

    if($OutputSize -gt $MaxOutputSize) {
        $p | kill
        Write-Host -NoNewline "[Output limit reached. Process terminated: ";
        Write-Host -NoNewline($CurDuration); Write-Host ("s]"); $flag = 1; break
    }

    if($CurDuration -ge $TimeoutTime) {
        $p | kill
        Write-Host -NoNewline "[Process terminated due to timeout: "; 
        Write-Host -NoNewline($CurDuration); Write-Host ("s]"); $flag = 1; break
    }
}

$p | kill

exit
