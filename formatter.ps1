# Recurse directories with [a-z]{2,3}_[A-Z]{2,3} pattern, and open all .txt files

$dir = Get-ChildItem -Path . -Recurse -Directory

foreach ($d in $dir) {
    $files = Get-ChildItem -Path $d -Filter "*.dict"
    foreach ($f in $files) {
        Write-Host "`nFormatting $($f.Name)"
        Write-Host "`rImport dictionary" -NoNewline
        $d = Get-Content -Path $f
        Write-Host "`rSplitting words by space" -NoNewline
        $d = $d | ForEach-Object { $_.Split(" ") }
        Write-Host "`rSplitting words by dash" -NoNewline
        $d = $d | ForEach-Object { $_.Split("-") }
        Write-Host "`rSorting" -NoNewline
        $d = $d | Sort-Object
        Write-Host "`rRemoving duplicates" -NoNewline
        $d = $d | Get-Unique
        Write-Host "`rRemoving numbers" -NoNewline
        $d = $d | Where-Object { $_ -notmatch "[0-9]" }
        Write-Host "`rRemoving words with one character" -NoNewline
        $d = $d | Where-Object { $_ -notmatch "[^a-zA-Z]{1}" }
        Write-Host "`rLowercase words" -NoNewline
        $d = $d | ForEach-Object { $_.ToLower() }
        Write-Host "`rSorting Back" -NoNewline
        $d = $d | Get-Unique
        Write-Host "`rSaving to $($f.Name)"
        $d | Out-File -FilePath "$f" -Encoding UTF8
    }
}
