---
title: Passwords
---

# Requesting credentials

PowerShell has built in support for credentials based on a username and password.  To display a prompt to the user to allow them to enter a username and password use

``` powershell
Get-Credential -Message "Custom message to display to the user" -UserName UserName
```

This will return a **PSCredential** object with the password stored as a secure string

# Storing credentials

## In a file

PowerShell supports converting a SecureString into a regular string in encrypted form.  The Windows Data Protected APIs (DPAPI) is used to ensure that only the current user is able to get the password in plain text.  Once you have the credential object use **Convert-FromSecureString** to get a string suitable for storage

``` powershell
# Prompt the user for their credentials
$credentialType = "storage sample"
$credential = Get-Credential -Message $credentialType -UserName $env:UserName

# Store the credentials in encrypted form within their user profile
$encryptedPassword = ConvertFrom-SecureString -SecureString $credential.Password
$storedCredentialPath = Join-Path -Path $env:APPDATA -ChildPath "Credentials"
if ( -not ( Test-Path $storedCredentialPath ) ) {
    New-Item -Path $storedCredentialPath -ItemType Directory | Out-Null
}
$credentialFileName = Join-Path -Path $storedCredentialPath -ChildPath ( "{0}.dat" -f $credentialType )
Set-Content -Path $credentialFileName -Value @( $credential.UserName, $encryptedPassword )

# Read the password back into a credential object
$storedCredential = Get-Content -Path $credentialFileName
$userName = $storedCredential[0]
$securePassword = ConvertTo-SecureString -String $storedCredential[1]
$retrievedCredential = New-Object -TypeName PSCredential -ArgumentList $userName, $securePassword
```

## Windows credential manager

PowerShell gallery has a module **CredentialManager** which can be used to interact with the Windows credential manager for secure storage of credentials.  Install the module via

``` powershell
Install-Module -Name CredentialManager -Scope CurrentUser
```

Then store credentials by

``` powershell
Import-Module CredentialManager

# Prompt the user for their credentials
$credentialType = "storage sample"
$credential = Get-Credential -Message $credentialType -UserName $env:UserName

New-StoredCredential -Type Generic -Target "Name to show in credential manager" -Credentials $credential -Persist LocalMachine 
```

# Passing a password from PowerShell to C#

Extract the password from the secure string on the PSCredential and use the DPAPI to encrypt and base64 encode the result to send it over to C#

``` powershell
function ConvertTo-EncryptedBase64 {
    <#
        .Synopsis
            Converts a secure string into a encrypted base64 string which can be passed into other tools e.g. a C# progream

        .Description
            Used to provide a way to accept credentials from a user in a PowerShell session and pass them to other programs without the password appearing in plain text at any point.  It will exist as plain text in memory for a short period of time while the conversion is taking place
    #>
    [CmdletBinding()]
    param (
        # Secure string whose value is to be encrypted using the DPAPI and converted to a base64 encoded string
        [ValidateNotNull()]
        [System.Security.SecureString]
        $SecureString
    )

    $secureStringContents = [System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($SecureString);
    $secureStringBytes = New-Object -TypeName byte[] ( $SecureString.Length * 2 )
    try
    {
        [System.Runtime.InteropServices.Marshal]::Copy($secureStringContents, $secureStringBytes, 0, $secureStringBytes.Length)

        try {
            $protectedBytes = [System.Security.Cryptography.ProtectedData]::Protect($secureStringBytes, $null, [System.Security.Cryptography.DataProtectionScope]::CurrentUser)
        }
        finally {
            # 0 out the plain text password password in managed memory
            [Array]::Clear($secureStringBytes, 0, $secureStringBytes.Length);
        }
    }
    finally
    {
        # 0 and remove the password from unmanaged memory
        [System.Runtime.InteropServices.Marshal]::ZeroFreeCoTaskMemUnicode($secureStringContents)
    }

    [System.Convert]::ToBase64String($protectedBytes);
}

$cred = Get-Credential -Message "password passing example" -UserName $env:USERNAME
ConvertTo-EncryptedBase64 -SecureString $cred.Password
```

On the C# side reverse the process, convert the base64 string into bytes and decrypt.  Then construct the securestring one character at a time

``` c#
public static SecureString SecureStringFromEncryptedBase64String(string encryptedBase64String)
{
    var encryptedBytes = Convert.FromBase64String(encryptedBase64String);
    var unprotectedBytes = ProtectedData.Unprotect(encryptedBytes, null, DataProtectionScope.CurrentUser);

    var secureString = new SecureString();

    try
    {
        // characters in C# are unicode and so take up two bytes.  Take the decrypted bytes in pairs
        // and convert into a character and add to the secure string
        var num = unprotectedBytes.Length / 2;
        for (var index = 0; index < num; ++index)
        {
            var c = (char)((uint)unprotectedBytes[2 * index + 1] * 256U + (uint)unprotectedBytes[2 * index]);
            secureString.AppendChar(c);
        }
    }
    finally
    {
        // Make sure to remove the unencrypted password from memory as soon as we are done
        Array.Clear(unprotectedBytes, 0, unprotectedBytes.Length);
    }

    return secureString;
}
```