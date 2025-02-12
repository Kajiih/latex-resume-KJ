# Kajih's LaTeX multilingual resume

A LateX resume based on [Jesse Miller's resume](<https://github.com/jam643/resume>) with support for several languages and easy exporting in different formats (`pdf`, `png`, `txt`)

## Screenshots

<p align="center">
    <img alt="Screenshot" src="images/resume-en.png" width="300">
    <img alt="Screenshot" src="images/resume-fr.png" width="300">
</p>

## How to use?

- Install the export dependencies: `ImageMagick` and `pdftotext`
- Edit the `main.tex` files and the different files in `/content` directory
- After generating the pdfs, run `export.sh` to export as `png` and `txt`

### New languages or resume focus

- To create a version for a new language, copy `resume_research-en.tex` and modify the `resumelanguage` variable, then add the content for this language inside `\IfLanguageName{<language>}{<content>}{}`
- To create a new resume focus instead, modify the `resumeFocus` variable and write content inside `\ifthenelse{\equal{\resumeFocus}{<focus>}}{<content>}{}`
