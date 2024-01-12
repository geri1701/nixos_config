{lib, ... }: {
    options = {
        monitorSettingsOption = lib.mkOption {
          type = lib.types.str;
        };
      };
}
