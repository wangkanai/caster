# Wangkanai Caster Server

A lightweight, high-performance NTRIP Caster Server built with .NET Core for distributing GNSS/GPS RTK correction data over the internet.

[[![NuGet Badge](https://buildstats.info/nuget/wangkanai.caster)](https://www.nuget.org/packages/wangkanai.caster)](https://img.shields.io/nuget/v/wangkanai.caster
)
[[![NuGet Pre Release](https://buildstats.info/nuget/wangkanai.caster?includePreReleases=true)](https://www.nuget.org/packages/wangkanai.caster)](https://img.shields.io/nuget/vpre/wangkanai.caster
)
[![caster-ci](https://github.com/wangkanai/caster/actions/workflows/dotnet.yml/badge.svg)](https://github.com/wangkanai/caster/actions/workflows/dotnet.yml)
[![Open Collective](https://img.shields.io/badge/open%20collective-support%20me-3385FF.svg)](https://opencollective.com/wangkanai)
[![Patreon](https://img.shields.io/badge/patreon-support%20me-d9643a.svg)](https://www.patreon.com/wangkanai)
[![GitHub](https://img.shields.io/github/license/wangkanai/caster)](https://github.com/wangkanai/caster/blob/main/LICENSE)

## What is an NTRIP Caster?

NTRIP (Networked Transport of RTCM via Internet Protocol) is a protocol designed to stream GNSS correction data over the internet. An NTRIP Caster serves as the central hub that receives data from base stations and distributes it to rovers (like surveying equipment, precision agriculture tools, and drones) for enhanced positioning accuracy.

## Key Features

- **RTK Base Support**: Set up and manage your own RTK base stations to provide centimeter-level accuracy for connected clients
- **Lightweight Design**: Optimized for minimal resource consumption, making it suitable for deployment on small servers or edge devices
- **DJI Drone Compatibility**: Specifically tested and optimized to work with DJI drone systems for precision flight and mapping
- **External Source Integration**:
  - Connect to third-party correction sources like:
  - BaseGNSS
  - RTK2go
  - CZEPOS
  - Other public/private NTRIP services
- **Intelligent Base Station Switching**: Automatically connects clients to the nearest base station by analyzing client GPGGA messages and recalculating optimal correction source
- **Protocol Support**: Full compatibility with both NTRIP version 1 and version 2 protocols
- **Cross-Platform**: Runs on Windows, Linux, and macOS thanks to .NET Core architecture

## Requirements

- .NET 8.0 or later
- Minimal hardware requirements - can run on low-spec devices
- Internet connectivity for external source integration

## Installation

```bash
# Clone the repository
git clone https://github.com/wangkanai/caster.git

# Build the project
cd caster
dotnet build

# Run the server
dotnet run
```

Docker container is also available:

```bash
docker pull wangkanai/caster
docker run -d -p 2101:2101 wangkanai/caster
```

## Configuration

Customize your caster instance through the simple configuration file:
- Define your own mountpoints
- Set up external source connections
- Configure base station priorities
- Adjust networking parameters

## Usage

### For Base Station Operators
Connect your GNSS receiver as a data source to provide correction data to others.

### For Rovers/Clients
Connect using any NTRIP client-compatible device, including DJI drones, survey equipment, or agricultural machinery.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
