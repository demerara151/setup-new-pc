# How to install clean nvidia display driver

Uninstall all bloatware, registered task, registry key, and telemetries with DDU.

Then install clean nvidia display driver using nvcleanstall.

## Dependencies

-   [DDU - Display Driver Uninstaller](https://www.wagnardsoft.com/)
-   [NVCleanstall](https://www.techpowerup.com/nvcleanstall/)

## Installation

Install dependencies via scoop.

```powershell
scoop install ddu nvcleanstall
```

### NVCleanstall

Open nvcleanstall from start menu or command line.

1. Click NEXT on the first page.

2. Select Recommended or Minimum at the bottom right and NEXT.

3. Check first three options and NEXT.

4. Click `Show in Folder`, then move that folder to Desktop.

### DDU

Restart computer with Safe Mode. Then open DDU.

1. Select driver category on the right. `GPU` and `nvidia`.

2. Click top left button to delete old driver completely.

3. Restart computer again.

## Reference

-   [DDU Guide Tutorial](https://www.wagnardsoft.com/content/ddu-guide-tutorial)
