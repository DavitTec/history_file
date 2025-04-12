#!/bin/bash
# generate_history.sh
version=0.0.4
# Created: 2025-04-13
# Updated: 2025-04-14
# Author: David Mullins
# Contact: david@davit.ie
# Description: generate_history produces a markdown file, named <folder_name>_hist.md, in /docs/hist/ before and after changes.
# Usage: TODO: setup usage
# Default values
# Defaults
project_dir="."
eval export "$(cat .env)"

# Set project_name from folder
project_name=$(basename "$(realpath "$project_dir")")
# mode="" TODO: implement testing modes
logfile="./logs/history-log.md"
logfile_dir="./logs"
doc_dir="./docs"
output="$doc_dir/hist/${project_name}_hist.md"
# TODO: redo below with update_username script

# get username from .env
# if .env does not exist then create it
if [ ! -f .env ]; then
  echo "no .env found"
  exit 1
else
  echo " Found  .env and using it"
fi

USER_NAME=$AUTHOR
gitsrc="https://github.com/DavitTec/history_file#README.md"

NUM_COMMENTS=2                 # default 2
CURRENT_DATE=$(date +%Y-%m-%d) # Using current date: April 10, 2025

# Function to display help
show_help() {
  echo "Usage: $0 [options] [<number_of_comments>] [<logfile_dir>]"
  echo "Options:"
  echo "  -h    Display this help message"
  echo "  -v    Verbose mode"
  echo "  -r    Read history (not implemented)"
  echo "  -l    Read log (not implemented)"
  echo "  -u    Update (not implemented)"
  echo "  -n    New create (default behavior)"
  echo "Parameters:"
  echo "  <$project_name>       Name of the project (default: Name of Folder)"
  echo "  <number_of_comments>  Number of comments [0-20] (default: 2)"
  echo "  <logfile_dir>         Log file directory (default: ./logs/history-log.md)"
}

# Function to create History.md
create_history() {
  local project=$project_name
  local num=$1
  # local logfile_dir=$2  # NOT implemented

  # Create a directory for the log file if it doesn't exist
  mkdir -p "$(dirname "$logfile_dir")"

  # Create History.md
  cat >"$output" <<EOF
# ${project^}

created on: $CURRENT_DATE  by [generate_history_v$version]($gitsrc)

> Summary: [Description: <shorTitle> ](log/history-logs.md#Description ) ($USER_NAME)
>
> \`\`\`bash
> 
> \`\`\`

Notes:


[next>](#comment-1)  [Log file](log/history-logs.md)

---
EOF

  # Generate comments
  for ((i = 1; i <= num; i++)); do
    cat >>"$output" <<EOF
## Comment $i
| [Top](#${project,,}) | [<Previous](#comment-$((i - 1))) |[Next>](#comment-$((i + 1))) | [$CURRENT_DATE](log/logs.md#$CURRENT_DATE) |

> Summary: [History_Comment_$i](log/history-logs.md#history-comment-$i) ($USER_NAME)
>
> \`\`\`bash
> 
> \`\`\`
>
>  [sub-history_comment_$i](log/history-logs.md#sub-history-comment-$i) 

[Content ${i}-up](#comment-$i)

...
### subject $i

...
| [Top](#${project,,}) | [<Previous](#comment-$((i - 1))) |[Next>](#comment-$((i + 1)))| [References](#references) | [Footnotes](#footnotese-$i) | [Folder Attachments](./assets/comment-$i/Readme.md)|


### Footnotes $i

---
EOF
  done

  # Add References section
  cat >>"$output" <<EOF

## References

|[Top](#${project,,}) |
EOF

  # Create basic history-log.md
  cat >"$logfile" <<EOF
# History Log

---

## Description: 

## $CURRENT_DATE

Comments by $USER_NAME

EOF

  # Add log entries
  for ((i = 1; i <= num; i++)); do
    cat >>"$logfile" <<EOF
### History Comment $i

Comments by $USER_NAME

#### Sub History Comment $i

EOF
  done
}

############### MAIN ################

# Process options
VERBOSE=0
while getopts "hvrlun" opt; do
  case $opt in
  h)
    show_help
    exit 0
    ;;
  v) VERBOSE=1 ;;
  r | l | u)
    echo "Option -$opt not yet implemented"
    exit 1
    ;;
  n) ;; # Default behavior
  ?)
    show_help
    exit 1
    ;;
  esac
done

# Shift past the options
shift $((OPTIND - 1))

# Process parameters

# if docs directory does not exist, create it
if [ ! -d "$doc_dir/hist" ]; then
  mkdir -p "$doc_dir/hist"
fi

# if logs directory does not exist, create it
if [ ! -d "$logfile_dir" ]; then
  mkdir -p "$logfile_dir"
fi

# if $output_file does not exist, create it
if [ ! -f "$output" ]; then
  echo "$output does not exist. Creating it"
  create_history "${1:-$NUM_COMMENTS}"

fi

if [ $# -ge 1 ]; then
  if [[ "$1" =~ ^[0-9]+$ ]] && [ "$1" -ge 0 ] && [ "$1" -le 20 ]; then
    NUM_COMMENTS=$1
  else
    echo "Error: Number of comments must be between 0 and 20"
    exit 1
  fi
fi

if [ $# -ge 2 ]; then
  logfile="$2"
fi

# Main execution
if [ -f "$output" ]; then
  echo "$output already exists. Use -u to update (not implemented yet) or remove existing file first."
  exit 1
else
  [ $VERBOSE -eq 1 ] && echo "Creating $output for '$project' with $NUM_COMMENTS comments..."
  create_history "$project" "$NUM_COMMENTS" "$logfile"
  [ $VERBOSE -eq 1 ] && echo "$output and $logfile created successfully."
fi
