{stdenv, ncftp, ssmtp, ffmpeg, fish}:

stdenv.mkDerivation rec {
  version = "2.3";
  name = "church-audio-upload-${version}";
  src = /data/church_audio/src;

  buildInputs = [ncftp ssmtp ffmpeg fish];

  buildPhase = ''
    substitute upload.fish upload.fish.out\
      --replace fish ${fish}/bin/fish\
      --replace ffmpeg ${ffmpeg}/bin/ffmpeg\
      --replace ncftpput ${ncftp}/bin/ncftpput\
      --replace sendmail ${ssmtp}/bin/sendmail\
      --replace upload-version ${version}
  '';

  installPhase = ''
    mkdir -p $out
    cp upload.fish.out $out/upload.fish
    chmod a+x $out/upload.fish
  '';
}
