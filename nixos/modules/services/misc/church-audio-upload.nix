{config, pkgs, lib, ...}:

with lib;

{

### config interface options. Place these in your /etc/nixos/configuration.nix

  options = {

    # this should pattern the structure of the configuration in the main config
    # file of the os
    services.church-audio-upload = {
      enable = mkOption {
        default = false;
        description = "Uploads .mp3 files once placed in a queue directory found in /data/church_audio to our webserver.";
      };
    };
  };


### Configuraton

  config = mkIf config.services.church-audio-upload.enable {

    networking.defaultMailServer = {
      authPassFile = "/data/church_audio/smtp-authpass";
      directDelivery = true;
      setSendmail = true;
      hostName = "smtp.gmail.com:587";
      authUser = "noah.harvey247@gmail.com";
      domain = "gmail.com";
      useSTARTTLS = true;
    };

    systemd.services.church-audio-upload = {
      description = "church-audio-upload service";  

      # make sure the network is enabled so ftp will work
      wants = ["network.target"];

      # this is required in order for this service to start by default
      wantedBy = ["multi-user.target"];

      # run once every hour
      startAt = "*-*-* *:10,20,30,40,50:00";

      # Command to run
      script = "${pkgs.church-audio-upload}/upload.fish";
    };
  };
}
