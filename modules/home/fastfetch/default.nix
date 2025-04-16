{ config, pkgs, ... }:

{
    programs.fastfetch = {
        enable = true;
        settings = {
            logo = {
                source = "nixos_small";
                padding = {
                right = 1;
                };
            };
            display = {
                size = {
                binaryPrefix = "si";
                };
                color = "blue";
                separator = "  ";
            };
            modules = [
                {
                type = "datetime";
                key = "Date";
                format = "{1}-{3}-{11}";
                }
                {
                type = "datetime";
                key = "Time";
                format = "{14}:{17}:{20}";
                }
                "title"
                "os"
                "host"
                "karnel"
                "uptime"
                "packages"
                "shell"
                "display"
                "de"
                "wm"
                "terminal"
                "cpu"
                "gpu"
                "memory"
                "swap"
                "disk"
                "localip"
                "battery"
                "locale"
            ];
        };
    };
}