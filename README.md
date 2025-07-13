# 🖥️ System Health Monitor

A lightweight bash script that monitors system resources and displays them with beautiful progress bars and color-coded output.

## ✨ Features

- 📊 **CPU Usage Monitoring** - Real-time CPU utilization with visual progress bars
- 💾 **Memory Usage Tracking** - RAM consumption monitoring across platforms
- 💽 **Disk Space Monitoring** - Storage usage with intelligent volume detection
- 🏃 **Top Processes Display** - Shows the most CPU-intensive processes
- 🌈 **Cross-Platform Support** - Works on macOS and Linux
- 🎨 **Beautiful Output** - Color-coded progress bars and clean formatting
- ⚡ **Fast & Lightweight** - Pure bash with minimal dependencies

## 🚀 Quick Start

### Installation

```bash
git clone https://github.com/anonymmized/sysmon-cli.git
cd sysmon-cli
chmod +x system_monitor.sh
```

### Usage

```bash
./system_monitor.sh
```

### Sample Output

```
🖥️ System Health Monitor
==================================
Detected OS: MacOS
CPU Usage:    [███░░░░░░░] 24%
Memory Usage: [████████░░] 86%
Disk Usage:   [██░░░░░░░░] 24%

🔥 Top 5 CPU processes:
   WindowServer  49.1%
   Obsidian      28.4%
   Chrome        12.3%
   Spotify        8.7%
   Terminal       3.2%
```

## 🎯 System Requirements

- **macOS**: macOS 10.12+ (Sierra or later)
- **Linux**: Any modern Linux distribution
- **Dependencies**: bash, awk, sed, grep (standard on most systems)

## 🔧 Technical Details

### CPU Monitoring
- **macOS**: Uses `top -l 1 -n 0` to get CPU usage
- **Linux**: Uses `vmstat` for CPU statistics

### Memory Monitoring
- **macOS**: Parses `top` output for physical memory usage
- **Linux**: Uses `free` command for memory statistics

### Disk Monitoring
- **macOS**: Intelligent detection of main data volume (`/System/Volumes/Data`)
- **Linux**: Standard root filesystem monitoring with `df`

### Process Monitoring
- Uses `ps aux` sorted by CPU usage
- Displays process name without full path for cleaner output

## 🌈 Color Coding

The script uses visual indicators to help you quickly identify system health:

- 🟢 **Green**: Normal usage (< 70%)
- 🟡 **Yellow**: Warning (70-85%)
- 🔴 **Red**: Critical (> 85%)

## 📁 Project Structure

```
sysmon-cli/
├── system_monitor.sh    # Main script
├── README.md           # This file
└── config/
    └── settings.conf   # Configuration file (optional)
```

## 🛠️ Development

### Adding New Metrics

The script is designed to be easily extensible. To add a new metric:

1. Create a new function following the pattern `detect_[metric]_usage()`
2. Use the universal `draw_progress_bar` function
3. Add OS-specific commands using the `$OS` variable

### Example:

```bash
detect_network_usage() {
    if [[ "$OS" == "MacOS" ]]; then
        # macOS specific command
        network_usage=$(your_command_here)
    elif [[ "$OS" == "Linux" ]]; then
        # Linux specific command
        network_usage=$(your_command_here)
    fi
    
    draw_progress_bar $network_usage "Network Usage"
}
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Setup

```bash
git clone https://github.com/anonymmized/sysmon-cli.git
cd sysmon-cli
chmod +x system_monitor.sh
```

### Running Tests

```bash
# Test on your system
./system_monitor.sh

# Test OS detection
bash -c "source system_monitor.sh; detectOS; echo $OS"
```

## 🙏 Acknowledgments

- Inspired by various system monitoring tools
- Thanks to the open-source community for bash scripting resources
- Built with ❤️ for system administrators and developers

## 📞 Support

If you encounter any issues or have questions:

1. Check the [Issues](https://github.com/anonymmized/sysmon-cli/issues) page
2. Create a new issue with detailed information about your system
3. Include the output of `uname -a` and the script's error messages

---

**Made with ❤️ by [anonymmized]**

*Star ⭐ this repository if you find it useful!*
