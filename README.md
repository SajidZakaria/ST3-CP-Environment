# ST3-CP-Environment
A simple yet powerful Competitive Programming environment setup using PowerShell and Sublime Text 3

## Installation procedure (Brief for now):
  1. Install GCC/G++ compiler and set Variable Path (Or Clang or any other, change the Script accordingly)
  2. Enabling Powershell Scripting in Windows
        * Open PowerShell as Administrator. Enter the following command, wait a bit, and confirm whatever that comes.
        ```
        Set-ExecutionPolicy RemoteSigned
        ```
  3. Add the Build System (provided here) in Sublime Text 3. Also copy the Script.ps1 file and change the path in Build System accordingly.
  
## Disclaimer for setting paths (for Build System and Script files)
  It is highly recommended that you keep the syntaxes as they are. Change the paths where necessary. Don't change the placement of the quotation marks and other syntaxes as they are cruicial for successful execution. You should also look out for:
  * Don't use backslash for paths, both in the build and the script. Eg. C://Users/path is correct while C:\\Users\path is NOT
  * Don't forget the double slashes after C eg. C:// (or any local drives you're using)
