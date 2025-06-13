param(
    [Parameter(mandatory=$false)]
    [bool]$publish=$false,
    [Parameter(mandatory=$false)]
    [string]$name="Open Source Developer, Sarin Na Wangkanai"
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
Get-ChildItem   -Recurse Wangkanai.*.dll | where { $_.Directory -like "*Release*" } | foreach {
    signtool sign /fd SHA256 /t http://timestamp.digicert.com /n $name $_.FullName
}

dotnet pack     -c Release -tl -o .\artifacts --include-symbols -p:SymbolPackageFormat=snupkg

dotnet nuget sign .\artifacts\*.nupkg  -v normal --timestamper http://timestamp.digicert.com --certificate-subject-name $name -o .\signed
dotnet nuget sign .\artifacts\*.snupkg -v normal --timestamper http://timestamp.digicert.com --certificate-subject-name $name -o .\signed

if (!$publish)
{
    write-host "Skip update: System" -ForegroundColor Yellow;
    exit;
}
dotnet nuget push .\signed\*.nupkg --skip-duplicate -k $env:NUGET_API_KEY  -s https://api.nuget.org/v3/index.json
dotnet nuget push .\signed\*.nupkg --skip-duplicate -k $env:GITHUB_API_PAT -s https://nuget.pkg.github.com/wangkanai/index.json

