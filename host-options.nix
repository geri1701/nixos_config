{ lib, ... }: {
  options = {
    monitorSettingsOption = lib.mkOption {
      type = lib.types.str;
    };
    firefoxPixelsPerPxOption = lib.mkOption {
      type = lib.types.str;
    };
    outputDeviceOption = lib.mkOption {
      type = lib.types.str;
    };
  };
}
