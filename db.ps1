param(
    [parameter(Mandatory=$false)] [string]$add,
    [Parameter(Mandatory=$false)] [switch]$list,
    [Parameter(Mandatory=$false)] [switch]$remove,
    [Parameter(Mandatory=$false)] [switch]$clean,
    [Parameter(Mandatory=$false)] [switch]$reset
)

$startup="./src/Server/Wangkanai.Caster.Server.csproj"
$project="./src/Persistence/Wangkanai.Caster.Persistence.csproj"

if ($add)
{
    dotnet ef migrations add $add --startup-project $startup --project $project
}
if ($list -eq $true)
{
    dotnet ef migrations list --startup-project $startup --project $project --no-connect
}
if ($remove)
{
    dotnet ef migrations remove --startup-project $startup --project $project --force
}
if($clean)
{
    rimraf ./src/Persistence/Migrations
}
if($reset)
{
    ./db.ps1 -clean
    ./db.ps1 -add "initial"
}
