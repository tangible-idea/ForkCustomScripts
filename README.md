# GitCustomScripts
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
   chmod +x extract_files_from_branch.sh
3. Add a `Custom Command` in Fork Settings.
<img width="952" alt="스크린샷 2024-11-28 오후 5 36 13" src="https://github.com/user-attachments/assets/00ef9831-fd34-4ece-86fa-6ef66f576647">

4. Extract files by calling custom command that you made.
<img width="752" alt="스크린샷 2024-11-28 오후 5 38 21" src="https://github.com/user-attachments/assets/b05dfd6c-4a48-42f4-93b3-bd5640c8afc0">
