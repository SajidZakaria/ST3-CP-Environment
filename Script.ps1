param($file, $PATH)

###################################################################################
# change the paths of $input and $output according to your input and output files
# TimeoutTime in Seconds, change according to your need
# MaxOutputSize in Megabytes, change according to your need

$input = 'C:\Users\USER\Documents\Cod ing\input.txt'
$output = 'C:\Users\USER\Documents\Cod ing\output.txt'
$TimeoutTime = 5
$MaxOutputSize = 1MB
###################################################################################


                        ### Cancel Previous Processes ###
###################################################################################
$procs = Get-Content "$PSScriptRoot\running.txt" -ErrorAction SilentlyContinue

Foreach($proc in $procs) {
    Stop-Process -ID $proc -Force -ErrorAction SilentlyContinue
}

Clear-Content $output
@("$PID") +  (Get-Content "$PSScriptRoot\running.txt" -ErrorAction SilentlyContinue) | Set-Content "$PSScriptRoot\running.txt" -ErrorAction SilentlyContinue

$proc = Get-Process a -ErrorAction SilentlyContinue;
if($proc) {$proc | kill}
###################################################################################


                        ### Prepare Current Build ###
###################################################################################
$PATH = $PATH + '\a.exe';

$inputP = "`"$input`""
$outputP = "`"$output`""

$MaxOutputSize = [int]$MaxOutputSize

g++ -std=c++17 "$file"
if($LastExitCode -ne 0) {
    Write-Host "[ERROR in Compilation]"
    exit;
}

Set-ItemProperty "HKCU:\Software\Microsoft\Windows\Windows Error Reporting" -Name DontShowUI -Value 1

$timer = [Diagnostics.Stopwatch]::StartNew()
###################################################################################


$p = Start-Process $PSScriptRoot\script.bat -ArgumentList $inputP,$outputP -NoNewWindow -Passthru

while(-not $p.HasExited -And $p -ne $null) {
    $OutputSize = (Get-Item $output).length
    if($OutputSize -gt $MaxOutputSize) {
        $timer.stop()
        $execTime = [math]::Round($timer.Elapsed.TotalSeconds, 2)
        if($p.HasExited) {break}
        $p | kill -ErrorAction SilentlyContinue
        $proc = Get-Process a -ErrorAction SilentlyContinue
        $proc | kill -ErrorAction SilentlyContinue

        Write-Host -NoNewline "[Output limit reached. Process terminated: ";
        Write-Host -NoNewline($execTime); Write-Host ("s]");

        Clear-Content "$PSScriptRoot\running.txt"
        exit
    }

    if($timer.Elapsed.TotalSeconds -ge $TimeoutTime) {
        $timer.stop()
        $execTime = [math]::Round($timer.Elapsed.TotalSeconds, 2)
        if($p.HasExited) {break}
        $p | kill -ErrorAction SilentlyContinue
        Write-Host -NoNewline "[Process terminated due to timeout: "; 
        Write-Host -NoNewline($execTime); Write-Host ("s]");

        Out-Null

        $proc = Get-Process a -ErrorAction SilentlyContinue
        $proc | kill -ErrorAction SilentlyContinue
        Clear-Content "$PSScriptRoot\running.txt"
        exit
    }
}

$p | kill -ErrorAction SilentlyContinue
$timer.stop()
$execTime = [math]::Round($timer.Elapsed.TotalSeconds, 2)
Write-Host -NoNewline "[Process executed in: $execTime"
Write-Host "s]"

Set-ItemProperty "HKCU:\Software\Microsoft\Windows\Windows Error Reporting" -Name DontShowUI -Value 0

Clear-Content "$PSScriptRoot\running.txt"
exit
