<!-- markdownlint-disable MD038 -->
# personalDictionaries

A collection of dictionaries for personal use.

## Usage

Select the language of the dictionary you want to use, and copy *.dict file to your spelling dictionary folder, determined by each application.

> **Warning**
>
> This repository split words in the dictionary files if contains whitespace (`` ``) or hyphen (`-`).
> This is done to reduce the size of the dictionary files, and to make them easier to read by some apps and extensions.
> However, this may cause some false positives for some editor that handle symbols as a part of the word.
> If you want to use the original dictionary files, you can find them in the original folder.

## Format

All .dict files are UTF-8 encoded text files, with one word per line, no spaces, no punctuation, no capitalization.

## Dictionaries Sources

> **Note**
>
> You can [use sources.json](sources.json) file, which contains all the information about the dictionaries included in this repository. This README is automatically generated from that file using [readmeGen.ps1](readmeGen.ps1) script.

| Language Code | Native Name | English Name | Dictionary | Source | License | Notes |
| ------------: | :----------- | :---------- | :--------- | :----- | :------ | :---- |
| `en_US` | English | English | [en_US.main.dict](en_US/en_US.main.dict) | [jeremy-rifkin/Wordlist](https://github.com/jeremy-rifkin/Wordlist) | [MIT](https://spdx.org/licenses/MIT.html) |  |
| `id_ID` | Bahasa Indonesia | Indonesian | [id_ID.main.dict](id_ID/id_ID.main.dict) | [WordList::ID::KBBI](https://github.com/perlancar/perl-WordList-ID-KBBI), [geovedi/indonesian-wordlist](https://github.com/geovedi/indonesian-wordlist) | **WordList::ID::KBBI**: [Artistic-1.0](https://spdx.org/licenses/Artistic-1.0.html) and [GPL-1.0-or-later](https://spdx.org/licenses/GPL-1.0-or-later.html), **geovedi/indonesian-wordlist**: [CC0](https://spdx.org/licenses/CC0.html) |  |

## License

This repository is licensed under the [Unlicense](http://unlicense.org/). However, the dictionaries hosted in this repository are not necessarily in the public domain. Please check the license of each dictionary included in their respective language folders.
