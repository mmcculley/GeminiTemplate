@echo off
REM A simple build and verification script for the prompt templates.
REM It runs the assembly script to verify the partyvenue_planner example.

echo Verifying partyvenue_planner prompt...
python assemble_prompt.py examples/partyvenue_planner/config.json --verify
