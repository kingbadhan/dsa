#!/bin/bash

# Set the input file and output file variables
INPUT_FILE=input.txt
OUTPUT_FILE=output.txt

# Get the script file from the command line argument
SCRIPT_FILE=$1

# Check if the script file exists
if [ ! -f "$SCRIPT_FILE" ]; then
  echo "Error: Script file '$SCRIPT_FILE' does not exist"
  exit 1
fi

# Determine the language based on the file extension
case "${SCRIPT_FILE##*.}" in
  py)
    LANGUAGE=python
    ;;
  java)
    LANGUAGE=java
    ;;
  cpp|cc)
    LANGUAGE=c++
    ;;
  c)
    LANGUAGE=c
    ;;
  *)
    echo "Unsupported language: ${SCRIPT_FILE##*.}"
    exit 1
    ;;
esac

# Check if the input file exists
if [ ! -f "$INPUT_FILE" ]; then
  echo "Error: Input file '$INPUT_FILE' does not exist"
  exit 1
fi

# Execute the script based on the language
case "$LANGUAGE" in
  python)
    python "$SCRIPT_FILE" < "$INPUT_FILE" > "$OUTPUT_FILE"
    ;;
  java)
    javac "$SCRIPT_FILE"
    java "${SCRIPT_FILE%.java}" < "$INPUT_FILE" > "$OUTPUT_FILE"
    ;;
  c|c++)
    gcc "$SCRIPT_FILE" -o "${SCRIPT_FILE%.c*}"
    "./${SCRIPT_FILE%.c*}" < "$INPUT_FILE" > "$OUTPUT_FILE"
    ;;
  *)
    echo "Unsupported language: $LANGUAGE"
    exit 1
    ;;
esac