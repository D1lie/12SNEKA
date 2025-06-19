# 12SNAKE - Advanced Web Vulnerability Scanner
████╗██████╗ ███████╗███╗ ██╗ █████╗ ██╗ ██╗███████╗
███║╚════██╗██╔════╝████╗ ██║██╔══██╗██║ ██╔╝██╔════╝
╚██║ █████╔╝███████╗██╔██╗ ██║███████║█████╔╝ █████╗
██║██╔═══╝ ╚════██║██║╚██╗██║██╔══██║██╔═██╗ ██╔══╝
██║███████╗███████║██║ ╚████║██║ ██║██║ ██╗███████╗
╚═╝╚══════╝╚══════╝╚═╝ ╚═══╝╚═╝ ╚═╝╚═╝ ╚═╝╚══════╝

Created by: d1lie

**12SNEKA** is a comprehensive web vulnerability scanner that integrates multiple security tools into a unified interface for efficient penetration testing and security assessments.

<p align="center">
  <img src="SC_12snake.png" alt="12SNEKA Interface Screenshot" style="width:100%;max-width:1200px;border:1px solid #ddd">
</p>


## Features

- **Multi-Tool Integration**: Combines 12 powerful security tools in one interface
- **Automated Scanning**: Streamlines the vulnerability assessment process
- **Comprehensive Coverage**: Detects various web vulnerabilities including:
  - SQL Injection
  - XSS vulnerabilities
  - Misconfigurations
  - Exposed sensitive information
  - Outdated components
- **User-Friendly Menu**: Interactive CLI interface for easy operation
- **Automated Tool Installation**: Checks and installs required dependencies
- **Reporting**: Option to save results to files for documentation

## Included Tools

1. **WhatWeb** - Web server fingerprinting
2. **WPScan** - WordPress vulnerability scanner
3. **Amass** - DNS enumeration and reconnaissance
4. **Nmap** - Port scanning and service detection
5. **Gobuster** - Directory/DNS brute-forcing
6. **Dirb** - Web directory scanning
7. **Nikto** - Web server scanner
8. **GoSpider** - Fast web spidering
9. **Katana** - Advanced web crawling
10. **SQLMap** - SQL injection testing
11. **Dalfox** - XSS scanning
12. **Nuclei** - Fast vulnerability scanning

## Installation

### Prerequisites
- Linux-based OS (Kali Linux recommended)
- Python 3.x
- Git
- sudo privileges

### Quick Installation

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y git
git clone https://github.com/D1lie/12SNEKA.git
cd 12SNEKA
chmod +x 12sneka.sh
./12sneka.sh
```

## Usage

After launching the script, you'll be presented with an interactive menu:

```bash
./12sneka.sh
```

### Basic Workflow:
1. Select a tool from the menu (1-12)
2. Enter the target URL/IP when prompted
3. Optionally specify an output file
4. View results in terminal or saved file
5. Run additional scans as needed

### Running All Scans:
Option 13 will run all available scans against a target sequentially.

## Configuration

The script automatically checks for and installs required tools. You can customize:
- Default wordlists (edit the script)
- Scan intensity parameters (modify tool commands)
- Output directory (change in script or specify per scan)

## Troubleshooting

If you encounter issues:
1. Verify all dependencies are installed:
   ```bash
   sudo apt install whatweb wpscan amass nmap gobuster dirb nikto gospider katana sqlmap dalfox nuclei
   ```
2. Ensure you have proper permissions
3. Check network connectivity to target
4. Verify target URL formatting (include http:// or https://)

## Disclaimer

⚠️ **Legal Notice**  
This tool is provided for **authorized security testing and educational purposes only**. Unauthorized scanning of websites or networks without explicit permission is illegal. The developers assume no liability for misuse of this software. Always obtain proper authorization before conducting security assessments.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please:
1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Open a pull request

Developed by **d1lie** | [GitHub Profile](https://github.com/D1lie)
