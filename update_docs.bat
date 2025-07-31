@echo off
SETLOCAL EnableDelayedExpansion

REM ---
REM update_docs.bat: Scans the projects and updates the README.md file.
REM ---

echo.
echo 📝 Updating documentation...
echo.

SET README_FILE=README.md
SET TEMP_README=README.temp.md

REM --- Part 1: Read the README content up to the projects list ---
(for /f "delims=" %%a in ('findstr /n "^" %README_FILE%') do (
    set "line=%%a"
    set "line=!line:*:=!"
    if "!line!"=="## Available Projects" (
        goto :found_projects_section
    )
    echo !line!
)) > %TEMP_README%

:found_projects_section
REM --- Part 2: Write the new, generated projects list ---
(
    echo ## Available Projects
    echo.
    echo This framework currently manages the following projects and recipes:
    echo.
) >> %TEMP_README%

pushd projects
for /d %%p in (*) do (
    echo - **%%p**
    for /f "delims=" %%r in ('dir /b /a-d "%%p\config_*.json"') do (
        set "recipe_file=%%r"
        set "recipe_name=!recipe_file:config_=!"
        set "recipe_name=!recipe_name:.json=!"
        echo   - `!recipe_name!`
    )
    echo.
)
popd >> %TEMP_README%

(
    echo.
    echo ---
) >> %TEMP_README%


REM --- Part 3: Find the end of the old projects list and append the rest of the file ---
set "found_end=false"
for /f "delims=" %%a in ('findstr /n "^" %README_FILE%') do (
    set "line=%%a"
    set "line=!line:*:=!"
    if "!line!"=="---" (
        set "found_end=true"
    )
    if "!found_end!"=="true" (
        if not "!line!"=="---" (
            echo !line!
        )
    )
) >> %TEMP_README%


REM --- Part 4: Replace the old README with the new one ---
move /y %TEMP_README% %README_FILE% > nul

echo.
echo ✅ README.md has been successfully updated.
echo.

ENDLOCAL
