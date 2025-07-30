#!/bin/bash
# A simple build and verification script for the prompt templates.
# It runs the assembly script to verify the partyvenue_planner example.

echo "Verifying partyvenue_planner prompt..."
python3 assemble_prompt.py examples/partyvenue_planner/config.json --verify
