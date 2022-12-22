$json = Get-Content -Path .\sources.json -Raw | ConvertFrom-Json
$json = $json | Sort-Object -Property langCode

$markdown = @"
<!-- markdownlint-disable MD038 -->
# personalDictionaries

A collection of dictionaries for personal use.

## Usage

Select the language of the dictionary you want to use, and copy `*.dict` file to your spelling dictionary folder, determined by each application.

> **Warning**
>
> This repository split words in the dictionary files if contains whitespace (```` ````) or hyphen (``-``).
> This is done to reduce the size of the dictionary files, and to make them easier to read by some apps and extensions.
> However, this may cause some false positives for some editor that handle symbols as a part of the word.
> If you want to use the original dictionary files, you can find them in the `original` folder.

## Format

All `.dict` files are UTF-8 encoded text files, with one word per line, no spaces, no punctuation, no capitalization.

## Dictionaries Sources

> **Note**
>
> You can [use sources.json](sources.json) file, which contains all the information about the dictionaries included in this repository. This README is automatically generated from that file using [readmeGen.ps1](readmeGen.ps1) script.

| Language Code | Native Name | English Name | Dictionary | Source | License | Notes |
| ------------: | :----------- | :---------- | :--------- | :----- | :------ | :---- |

"@

foreach ($lang in $json) {
    $licenses = @(); $sources = @(); $rlicenses = @()
    foreach ($s in $lang.sources) {
        # Get SPDX data, if AND OR operators are used, parse them, then recombine
        if ($s.license -match "AND") {
            foreach ($license in ($s.license -csplit "AND")) {
                $license = $license.Trim()
                $rlicenses += "[$license](https://spdx.org/licenses/$license.html)"
            }
            $s.license = $rlicenses -join " and "
        }
        elseif ($s.license -match "OR") {
            foreach ($license in ($s.license -csplit "OR")) {
                $license = $s.license.Trim()
                $rlicenses += "[$license](https://spdx.org/licenses/$license.html)"
            }
            $s.license = $rlicenses -join " or "
        }
        else {
            $s.license = $s.license.Trim()
            $s.license = "[$($s.license)](https://spdx.org/licenses/$($s.license).html)"
        }
        if ($lang.sources.Count -gt 1) {
            $licenses += "**$($s.name)**: $($s.license)"
        }
        else {
            $licenses += $s.license
        }
        $sources += "[$($s.name)]($($s.uri))"
    }
    $sources = $sources -join ", "
    $license = $licenses -join ", "
    $path = $lang.dictPath
    $markdown += "| ``$($lang.langCode)`` | $($lang.native) | $($lang.english) | [$path]($($lang.langCode)/$path) | $($sources) | $($license) | $($lang.notes) |`n"
}

$markdown += @"

## License

This repository is licensed under the [Unlicense](http://unlicense.org/). However, the dictionaries hosted in this repository are not necessarily in the public domain. Please check the license of each dictionary included in their respective language folders.
"@

$markdown | Out-File -FilePath .\README.md -Encoding utf8
