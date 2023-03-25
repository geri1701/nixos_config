{ pkgs, ... }: {
  sops = {
    age.keyFile = "/home/geri/.config/sops/age/keys.txt";
    defaultSopsFile = ./sec/zero.yaml;
    secrets = {
      amazon = { };
      discord = { };
      github = { };
      gmx = { };
      google = { };
      gtoken = { };
      humble = { };
      iee = { };
      manning = { };
      mechanicalkeyboardsdotcom = { };
      no_starch_press = { };
      packt = { };
      paypal = { };
      pine64_forum = { };
      pine64_support = { };
      planery = { };
      scratch = { };
      sdf = { };
      steam = { };
      thalia = { };
      typingclub = { };
      typst = { };
      wienenergie = { };
    };
  };
}
