# ST3-CP-Environment
A strong Competitive Programming Environment using Sublime Text 3. This build works almost the same as traditional builds, except it uses PowerShell. Which makes it even more, umm.. Powerful.

## Problems of other builds:
  1. Doesn't have timeout. You have to manually end the task when a program takes too long or falls into some infinite loop.
  2. In case of infinite printing(caused by infinite loops), the output file becomes huge, makes the pc slow or totally hang, a restart might be needed to fix this.

## Features of this build:
  1. Uses file i/o.
  2. Has a timeout feature, terminates process after hitting timeout.
  3. Has an output size limit, terminates program when the output generated is out of control.
  4. Easily customizable.

## How it works:
  The build system calls PowerShell through CMD, then PowerShell runs Script.ps1, which then executes the entire process. So both the Script.ps1 file is needed to be in its required path.

## Variables in the script:
  * **$input**: Path to the input file
  * **$output**: Path to the output file
  * **$TimeoutTime**: Time limit in seconds, after which the process will terminate automatically.
  * **$MaxOutputSize**: in Megabytes, largest amount of data the program can print to the output file, after exceeding which, the process will terminate automatically, as a safety measure. 
  
  As they are variables, you can change them as you want to eg. You might want to change the paths. The default MaxOutputSize 1MB prints about 10^6 characters, so when you are participating in contests like FB HackerCup or Google CodeJam, you might want to increase this limit.

## Installation procedure:
  1. Install GCC/G++ compiler and set Variable Path (Or Clang or any other, change the Script accordingly)
  2. Getting PowerShell ready
        * **Enable PowerShell Scripting:** Open PowerShell as Administrator. Enter the following command, wait a bit, and confirm whatever that comes.
        ```
        Set-ExecutionPolicy RemoteSigned
        ```
        * **Speed-up PowerShell:** Enter the following commands. This will take a few minutes to finish.
        ```
        Set-Alias ngen (Join-Path ([Runtime.InteropServices.RuntimeEnvironment]::GetRuntimeDirectory()) ngen.exe)
        ngen update
        ```
  3. Add the Build System (provided here) in Sublime Text 3. Also copy the Script.ps1 file and change the path in Build System accordingly.

## What does it cost:
   Probably a few hundred milliseconds per run, for the sake of convenience.
