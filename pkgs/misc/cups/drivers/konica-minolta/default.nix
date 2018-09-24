{ stdenv, perl }:

stdenv.mkDerivation {
  name = "konica-minolta-1.0";
  src = ./km.tar.gz;
  buildInputs = [ perl ];
  installPhase = ''
    PPD_DIR=$out/share/cups/model
    FILTER_DIR=$out/lib/cups/filter

    mkdir -p $PPD_DIR
    install -m644 ./KM*.ppd $PPD_DIR

    mkdir -p $FILTER_DIR
    install -m755 ./KM*.pl ./KM*.pm $FILTER_DIR
  '';
}
