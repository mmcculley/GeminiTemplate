@echo off
SETLOCAL EnableDelayedExpansion
REM ---
REM init_project.bat: Creates the directory structure and boilerplate files for a new project.
REM ---
SET NEW_PROJECT_NAME=%1
IF "%NEW_PROJECT_NAME%"=="" (
    echo Error: Please provide a name for the new project.
    echo Usage: init_project.bat [NewProjectName]
    exit /b 1
)

SET TEMPLATE_DIR=meta\project_initializer
SET PROJECT_DIR=projects\%NEW_PROJECT_NAME%

echo.
echo 🚀 Initializing new project: %NEW_PROJECT_NAME%...
echo.

IF EXIST %PROJECT_DIR% (
    echo Error: A project named '%NEW_PROJECT_NAME%' already exists.
    exit /b 1
)

echo Creating directory: %PROJECT_DIR%
mkdir %PROJECT_DIR%

REM --- Create config from template ---
SET CONFIG_TEMPLATE=%TEMPLATE_DIR%\template_config.json
SET NEW_CONFIG_FILE=%PROJECT_DIR%\config_scaffold.json
echo Creating recipe: %NEW_CONFIG_FILE%
(for /f "delims=" %%a in (%CONFIG_TEMPLATE%) do (
    set "line=%%a"
    set "line=!line:{{PROJECT_NAME}}=%NEW_PROJECT_NAME%!"
    echo !line!
)) > %NEW_CONFIG_FILE%

REM --- Create rules from template ---
SET RULES_TEMPLATE=%TEMPLATE_DIR%\template_rules.md
SET NEW_RULES_FILE=%PROJECT_DIR%\rules_scaffold.md
echo Creating rules: %NEW_RULES_FILE%
(for /f "delims=" %%a in (%RULES_TEMPLATE%) do (
    set "line=%%a"
    set "line=!line:{{PROJECT_NAME}}=%NEW_PROJECT_NAME%!"
    echo !line!
)) > %NEW_RULES_FILE%

echo.
echo ---
echo ✅ Successfully initialized project: %NEW_PROJECT_NAME%
echo You can now customize the recipe and rules in `projects\%NEW_PROJECT_NAME%`
echo ---

ENDLOCAL