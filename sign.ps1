param(
    [Parameter(mandatory=$false)]
    [bool]$dryrun=$false,
    [Parameter(mandatory=$false)]
    [string]$certicate="Open Source Developer, Sarin Na Wangkanai"
)

Write-Host "NuGet Certificate: $certicate"  -ForegroundColor Magenta

Remove-Item -Path .\signed\*.*    -Force -ErrorAction SilentlyContinue
Remove-Item -Path .\artifacts\*.* -Force -ErrorAction SilentlyContinue

New-Item -Path artifacts -ItemType Directory -Force | Out-Null
New-Item -Path signed    -ItemType Directory -Force | Out-Null

dotnet --version
dotnet clean    -c Release -tl
dotnet restore
dotnet build    -c Release -tl
Get-ChildItem  .\src\ -Recurse Wangkanai.*.dll | where { $_.Directory -like "*Release*" } | foreach {
    signtool sign /fd SHA256 /t http://timestamp.digicert.com /n $certicate $_.FullName
}

dotnet pack -c Release -tl -o .\artifacts --include-symbols -p:SymbolPackageFormat=snupkg

dotnet nuget sign .\artifacts\*.nupkg  -v normal --timestamper http://timestamp.digicert.com --certificate-subject-name $certicate -o .\signed
dotnet nuget sign .\artifacts\*.snupkg -v normal --timestamper http://timestamp.digicert.com --certificate-subject-name $certicate -o .\signed

if ($dryrun)
{
    Write-Host "Dryrun: Cryptography" -ForegroundColor Yellow;
    exit;
}

dotnet nuget push .\signed\*.nupkg --skip-duplicate -k $env:NUGET_API_KEY  -s https://api.nuget.org/v3/index.json
dotnet nuget push .\signed\*.nupkg --skip-duplicate -k $env:GITHUB_API_PAT -s https://nuget.pkg.github.com/wangkanai/index.json
