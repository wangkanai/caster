# Update package version in Directory.Build.props
$name = "Wangkanai.Caster";
$root = "D:\Sources\Caster\"
$e = [char]27

try {
    [Xml]$xml = Get-Content -Path .\Directory.Build.props;
    $version = $xml.Project.PropertyGroup.Version;
    if ($version.GetType().FullName -ne "System.String") {
        $version = $version[0];
    }
    Write-Host "Version:" $version -ForegroundColor Red;

    $package = Find-Package -Name $name -ProviderName NuGet -AllVersions
    $last = $package | Select-Object -First 1
    $latest = $last.Version;

    if ($latest -ne $version) {
        Write-Host $latest " < " $version " Update" -ForegroundColor Green;
        .\version.ps1 -dryrun $dryrun -certicate $certicate
    }
    else {
        Write-Host $latest " = " $version " Skip" -ForegroundColor DarkGray;
    }
}
catch {
    Write-Host "New " $latest -ForegroundColor Blue;
    .\sign.ps1 -dryrun $dryrun -certicate $certicate
}

if ($dryrun) {
    Write-Host "Dryrun skip version update" -ForegroundColor Yellow;
    exit;
}

try {
    $path = $root + "Directory.Build.props";
    $xml = New-Object System.Xml.XmlDocument
    $xml.PreserveWhitespace = $true
    $xml.Load($path);
    $node = $xml.SelectSingleNode("/Project/PropertyGroup/Version");
    $old = [System.Version]$node.InnerText;
    $new = [System.Version]::new($old.Major, $old.Minor, $old.Build + 1); #0);
    $node.InnerText = $new.ToString();
    $xml.Save($path);

    $result += [PSCustomObject]@{ NuGet = "$e[36m" + "$e[0m"; Version = "$e[32m$old => $new $e[0m" }
}
catch {
    $result += [PSCustomObject]@{ NuGet = "$e[31m" + "$e[0m"; Version = "$e[31mError $e[0m" }
}

$result
