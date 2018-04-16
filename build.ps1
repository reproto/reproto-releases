param()

if (-not (Get-Command Compress-7Zip -errorAction SilentlyContinue)) {
    Write-Host "installing: 7Zip4PowerShell"
    Install-Package -Scope CurrentUser -Force 7Zip4PowerShell -ProviderName PowerShellGet
}

$osname = "windows"
$arch = "x86_64"
$version = (Get-Content -Path build_version)
$tuple = "$version-$osname-$arch"
$target = "target"
$bin = [io.path]::combine($target, "bin", "reproto")
$upload = [io.path]::combine("target", "upload")
$archive = [io.path]::combine($upload, "reproto-$tuple.tar.gz")
$git = "https://github.com/reproto/reproto"

Write-Host "Running Cargo:"
iex "cargo install --root $target --git $git --tag $version reproto"

if (-not (Test-Path $bin)) {
    throw "missing: $bin"
}

New-Item -path $archive -type directory

Compress-7Zip -ArchiveFileName "$upload\reproto-$tuple.tar" -Path $bin
Compress-7Zip -ArchiveFileName "$upload\reproto-$tuple.tar.gz" -Path "reproto-$tuple.tar"

Remove-Item -path "$upload\reproto-$tuple.tar"

exit 0