# ST3-CP-Environment

## April 5, 2021: Update with many improvements, including significant speed gain. Please follow the new procedure.

A strong Competitive Programming Environment using Sublime Text 3. This build works almost the same as traditional builds, except it uses PowerShell. Which makes it even more, umm.. Powerful.

## Problems of other builds:
  1. Doesn't have timeout. You have to manually end the task when a program takes too long or falls into some infinite loop.
  2. In case of infinite printing(caused by infinite loops), the output file becomes huge, makes the pc slow or totally hang, a restart might be needed to fix this.

## Features of this build:
  1. Uses file i/o.
  2. Has a timeout feature, terminates process after hitting timeout.
  3. Has an output size limit, terminates program when the output generated is out of control.
  4. Terminates immediately after a runtime error occurs. (Normally Windows takes a lot longer)
  5. Easily customizable.

## How it works:
  The build system calls PowerShell through CMD, then PowerShell runs Script.ps1, which then executes the entire process. So the Script.ps1 file is needed to be in its required path.

## Variables in the script:
  * **$input**: Path to the input file
  * **$output**: Path to the output file
  * **$TimeoutTime**: Time limit in seconds, after which the process will terminate automatically.
  * **$MaxOutputSize**: in Megabytes, largest amount of data the program can print to the output file, after exceeding which, the process will terminate automatically, as a safety measure. 
  
  As they are variables, you can change them as you want to eg. You might want to change the paths. The default MaxOutputSize 1MB prints about 10^6 characters, so when you are participating in contests like FB HackerCup or Google CodeJam, you might want to increase this limit.

## Installation procedure:
  1. Install GCC/G++ compiler and set Variable Path (Or Clang or any other, change the Script accordingly)
  2. Clone the repository or download as zip and extract (To avoid the hassle of creating new files).
  3. Create a new Build System in Sublime Text 3 using the code given in Build.txt file. Also change the path in the Build System according to where you put Script.ps1 file.
  4. Keep "script.bat" file in the same directory as "Script.ps1"
  5. Set the paths of input and output files in Script.ps1
  6. Run fix.reg (fixes problems with runtime errors).
  7. Optionally, to make the builds faster, you can precompile bits/stdc++.h (More on this here: https://codeforces.com/blog/entry/79026?#comment-644988)
  8. For convenience, make sure to enable save on build (Tools -> Save All on Build).
  
  This build uses C++ 17, so make sure you update your compiler. Or change the script to use older versions.

  ***Optional:***
  * **Speed-up PowerShell:** In some cases powershell startup time might be too slow(https://stackoverflow.com/a/59343705). To fix this, open powershell as Administrator and enter the following two commands one after another. This might take a few minutes to finish.
    ```
    Set-Alias ngen (Join-Path ([Runtime.InteropServices.RuntimeEnvironment]::GetRuntimeDirectory()) ngen.exe)
    ngen update
    ```

## What does it cost:
   Probably a few hundred milliseconds per run, for the sake of convenience.
