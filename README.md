<a name="readme-top"></a>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/HoyongJeong/wattmon">
    <img src="https://github.com/othneildrew/Best-README-Template/blob/master/images/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">wattmon</h3>

  <p align="center">
    CPU Package Watt Monitor
    <br />
  </p>
</div>


<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#how-it-works">How It Works</a>
    </li>
    <li>
      <a href="#installation">Installation</a>
    </li>
  </ol>
</details>


<!-- ABOUT THE PROJECT -->
## About The Project

Telegraf is a nice application to help you collect metrics from your system. However, the function to monitor the power of AMD series CPUs is inconvenient. This is a simple shell script to measure power draw by CPU package in a Linux system and send the measurement to the InfluxDB server.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- HOW IT WORKS -->
## How It Works

Most modern CPUs support Running Average Power Limit (RAPL) interfaces for reporting the accumulated energy consumption. It primarily serves to manage and monitor power consumption and thermal output. AMD's Zen supports a Model-Specific Registers (MSR) interface that is semi-compatible with RAPL.
In the latest Ubuntu machine which has an AMD CPU (5900X), I could read the current cumulative energy counter in micro joules by printing out content in `/sys/devices/virtual/powercap/intel-rapl/intel-rapl:0/energy_uj`. In every second, my script differentiates the energy counter in order to calculate power in watts.


<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- INSTALLATION -->
## Installation

### Prerequisites
InfluxDB v2 CLI client is required.

### Build
```sh
git clone https://github.com/HoyongJeong/wattmon
cd wattmon
sudo ln -s `pwd`/wattmond.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start wattmond.service
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>
