# Linux User Creation Bash Script

## Introduction

This repository contains a bash script, `create_users.sh`, designed to automate the creation of Linux user accounts and groups. This script reads a text file containing usernames and group names, creates the specified users and groups, sets up home directories with appropriate permissions, generates random passwords for the users, and logs all actions. Additionally, it securely stores the generated passwords.

## Script Overview

### Features

- Reads a text file containing usernames and group names.
- Creates users and groups as specified.
- Sets up home directories with appropriate permissions and ownership.
- Generates random passwords for the users.
- Logs all actions to `/var/log/user_management.log`.
- Stores generated passwords securely in `/var/secure/user_passwords.csv`.

### Usage

1. Clone the repository:
    ```bash
    git clone <repository-url>
    cd <repository-directory>
    ```

2. Ensure the script is executable:
    ```bash
    chmod +x create_users.sh
    ```

3. Prepare an input file (e.g., `user_list.txt`) with the following format:
    ```
    light; sudo,dev,www-data
    idimma; sudo
    mayowa; dev,www-data
    ```

4. Run the script with the input file as an argument:
    ```bash
    sudo bash create_users.sh user_list.txt
    ```

### Example Input File

Here is an example of the input file (`user_list.txt`):


### Output

- **Log File**: `/var/log/user_management.log` contains a log of all actions performed by the script.
- **Password File**: `/var/secure/user_passwords.csv` contains a list of all users and their passwords, delimited by commas.

## Technical Article

For a detailed explanation of the script, please refer to the technical article on Dev.to:

[Automating Linux User Creation with a Bash Script](https://dev.to/your-article-link)

This article provides a step-by-step breakdown of the script, explaining the reasoning behind each step and the overall approach to user and group management in Linux.

### HNG Internship

Learn more about the HNG Internship:
- [HNG Internship](https://hng.tech/internship)
- [HNG Hire](https://hng.tech/hire)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Special thanks to the HNG Internship program for providing this task and opportunity.
- Thanks to all contributors and mentors for their guidance and support.