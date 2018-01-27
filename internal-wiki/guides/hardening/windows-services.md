http://www.blackviper.com/

| Service | Baseline | Depends on |Notes |
| ------- | ----- | ----- | ----- |
| AxInstSV | Manual | RPC| ActiveX |
| AppReadiness | Manual | None | Init |
| AppHostSvc | ??? | (IIS) | Modifiable in CP |
| AppIDSvc | Trigger Start | AppID Driver, Crypto, RPC | AppLocker enforcement, verifications |
| AppInfo | Trigger Start  | RPC, UPS | Limit Admin Access (Requires safe mode if borked) |
| ALGS | Manual | ICS | Disable if ICS is gone |
| AppMgmt | Manual | None | Group Policy Software |
| PeerDistSvc | Disabled | None | Local Subnet Caching |
| BITS | Delayed Start/Started | COM+, RPC | Background web downloads |
| DiagTrack | Disabled | ??? | Telemetry |
| dmwappushsv | Disabled | ??? | Telemetry, Diagnostic |
| MapsBroker | Disabled | ??? | Maps |
| Fax | Disable | None | Go to CP to uninstall |
| iphlpsvc | Manual | (Depends) | Use if IPv6 |
| Offline Files | Disable | None | Cache Maintenence |
| RpcEptMapper | Disable | None | Backwards Compatibility |
| Spooler | (Depends) | None | If Printer |
| RemoteRegistry | Disabled | None | |
| SCardSvr | Disabled | None | Don't have them |
| SCPolicySvc | Disabled | None | See above |
| TabletInputService | Disabled | None | No Touch Keyboards |
| WMPNetworkSvc | Disable | UPnP for WMP |
| WwanSvc | Disabled | None | CDMA/GSM |
