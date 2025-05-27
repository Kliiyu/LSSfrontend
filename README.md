# LSS Frontend

This guide will help you install and run the LSS Frontend application on Windows and Linux.

## Prerequisites

- Git
- Node.js and npm

## Getting Started

### Download from GitHub

1. Clone the repository using Git:
    ```
    git clone https://github.com/yourusername/LSSfrontend.git
    cd LSSfrontend
    ```

2. Alternatively, download the ZIP file from GitHub:
    - Go to the repository page
    - Click the "Code" button
    - Select "Download ZIP"
    - Extract the ZIP file to your preferred location

### Running on Windows

1. Open PowerShell as Administrator
2. Navigate to the project directory:
    ```
    cd C:\path\to\LSSfrontend
    ```
3. Run the start script:
    ```
    .\start.ps1
    ```
4. The application should now be running and accessible in your browser

### Running on Linux

1. Open Terminal
2. Navigate to the project directory:
    ```
    cd /path/to/LSSfrontend
    ```
3. Make the start script executable:
    ```
    chmod +x start.sh
    ```
4. Run the start script:
    ```
    ./start.sh
    ```
5. The application should now be running and accessible in your browser

## Troubleshooting

- If you encounter permission issues on Windows, make sure to run PowerShell as Administrator
- On Linux, ensure the `start.sh` script has execute permissions
- Check that Node.js and npm are properly installed on your system
