{ lib, ... }: {
  options = {
    monitorSettingsOption = lib.mkOption {
      type = lib.types.str;
    };
    firefoxPixelsPerPxOption = lib.mkOption {
      type = lib.types.str;
    };
  };
}
