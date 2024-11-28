# ForkCustomScripts
### Extract Modified Files Script

This script extracts the files modified in a specific Git branch (compared to the current branch), shows their directory structure, and compresses them into a ZIP file.

---

## Requirements

- **Git**: Ensure Git is installed and initialized in your repository.
- **ZIP Utility**: Ensure `zip` is installed on your system.
- **Optional `tree` Command**: Used to display the directory structure. If not installed, the script falls back to `find`.

---

## Installation

1. Save the script as `extract_modified_files.sh`.
2. Make it executable:
   ```bash
   chmod +x extract_modified_files.sh