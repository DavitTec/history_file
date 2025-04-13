# Project History Template

Version 0.0.5

## Description

A bash script to generate a [history_file_hist.md](docs/hist/history_file_hist.md) document from a project ".env" file or create it.

If `.env` does not exist, use `gernerate_history.sh NUM` with options and/or (optional parameters) will create new history documents for a fictional user or current username.

This script will create a file name based on the folder name in which the script is executed e.g.

```bash
./myproject/gernerate_history.sh 5
```

will create ./myproject/docs/hist/myproject_hist.md and a log file in ./myproject/logs/history-log.md

The new myproject_hist.md will contain 5 sections. you can specify any number from 2 to 20 (max). It is possible to add more when required with an option flag `./myproject/gernerate_history.sh -u 5` will add 5 more sections.

Here's a solution that implements the initial generation functionality:

## Installation

To use this script:

Create a `.env` file from the example copy .env_example

```bash
  cp .env_example .env
```

1. make necessary changes to `.env`
2. Download and save `generate_history.sh` or git clone
3. Make it executable: `chmod +x generate_history.sh¸`
4. Run it with an example: ``./generate_history.sh 3`

## Features

#### TODO SHORT

Test

- [ ] Create a [history_file_hist.md](docs/hist/history_file_hist.md) file with 3 or more comments following a template structure
- [ ] Create a logs/history-log.md file
- [ ] Use the current date for all entries
- [ ] Handle the basic navigation links and structure
- [ ] Create necessary directories for the log file
- [ ] add Project header
- [ ] TEST 3 comment sections numbered 1-3
- [ ] Proper navigation links
- [ ] References section
- [ ] A basic history-log.md file with corresponding entries

### Current features

- -h shows help
- -v enables verbose output
- Handles all three parameters (project name, number of comments, log file path)
- Validate the number of comments (0-20)
- Creates directory structure if needed

### Not yet implemented

(but included in options for future expansion):

- -r (read history)
- -l (read log)
- -u (update existing file)
- Adding comments to the existing file
- Date updating functionality

The script checks if [history_file_hist.md](docs/history_file_hist.md) and [history-logs.md](logs/history-log.md) exists and won't overwrite it (future -u option will handle updates). 

The `generate_history.sh 3` example will produce a template format with 3 sections and room to add the additional functionality (updating dates, adding comments) in future iterations.

## Todo Long

If the [history_file_hist.md](docs/hist/history_file_hist.md) exists then there should be other function

1. To ADD more template comments under the last before the "References" subheading. If a comment number is provided as the 2nd parameter, then the accounting for the number of blank comments defaults to 1 or is optional to a max of 20.
2. Update the dates of the given Parameter number in both the [history_file_hist.md](docs/hist/history_file_hist.md) and [history-logs.md](logs/history-log.md) (however this functionality will be detailed and implemented later.

- The [history-logs.md](logs/history-log.md) is linked from each comment date of entry

- Heading is "# History Log" and its subheadings are "# \<date of entry or change> to match the entry in the main [history_file_hist.md](docs/hist/history_file_hist.md) file

- more later

- The starting point focused on the initial script to generate one or more "comments" customized to the serialized structure of the document, created by using the `generate_history.sh` script. 
  The [history_file_hist.md](docs/hist/history_file_hist.md) is the desired output of

  ```bash
  gernerate_history.sh 3
  ```
