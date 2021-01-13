param($file, $PATH)

###################################################################################

# change the paths of $input and $output according to your input and output files
# TimeoutTime in Seconds, change according to your need
# MaxOutputSize in Megabytes, change according to your need

$input = 'D:\CP\input.txt'
$output = 'D:\CP\output.txt'
$TimeoutTime = 10
$MaxOutputSize = .5

###################################################################################

$PATH = $PATH + '\a.exe'
$command = 'Start-Process ' + "'$PATH'" + ' -RedirectStandardInput ' + "'$input'"
$command = $command + ' -RedirectStandardOutput ' + "'$output'" + ' -NoNewWindow -Wait -passthru'

$proc = Get-Process a -ErrorAction SilentlyContinue
if($proc) {$proc | kill}

Clear-Content $output

g++ -std=c++17 $file
$BeginTime = Get-Date
$MaxOutputSize = $MaxOutputSize

if($LastExitCode -ne 0) {
    Write-Host "[ERROR in Compilation]"
    exit
}

$block = {
    param([string]$a)
    $p = iex $a;
    $p.ExitCode
}

$PS = [PowerShell]::Create()
$PS.AddScript($block) | Out-NULL
$PS.AddArgument($command) | Out-NULL

$BeginTime = Get-Date

Set-ItemProperty "HKCU:\Software\Microsoft\Windows\Windows Error Reporting" -Name DontShowUI -Value 1

$job = $PS.BeginInvoke() 

while(-Not $job.IsCompleted) {
    $EndTime = Get-Date
    $CurDuration = (New-TimeSpan -Start $BeginTime -End $EndTime).TotalSeconds
    $CurDuration = [math]::Round($CurDuration, 1)

    $OutputSize = (Get-Item $output).length/1MB

    if($OutputSize -gt $MaxOutputSize) {
        $proc = Get-Process a -ErrorAction SilentlyContinue
        if($proc) {$proc | kill}
        Write-Host -NoNewline "[Output limit reached. Process terminated: ";
        Write-Host -NoNewline($CurDuration); Write-Host ("s]"); exit
    }

    if(($CurDuration - .5) -ge $TimeoutTime) {
        $proc = Get-Process a -ErrorAction SilentlyContinue
        if($proc) {$proc | kill}
        Write-Host -NoNewline "[Process terminated due to timeout: "; 
        Write-Host -NoNewline($TimeoutTime); Write-Host ("s]"); exit
    }
}

$tim = Get-Date
$result = $PS.EndInvoke($job)
if($result[0] -ne 0) {
    Write-Host "RUNTIME ERROR"
    Write-Host "Process Terminated with exit code", $result[0]
}

Set-ItemProperty "HKCU:\Software\Microsoft\Windows\Windows Error Reporting" -Name DontShowUI -Value 0

exit
