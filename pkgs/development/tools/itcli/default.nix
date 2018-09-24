{ fetchgit, mkDerivation, base, bytestring, directory, filepath, mtl
, optparse-applicative, stdenv, text, time, uuid, yaml
}:
mkDerivation {
  pname = "itcli";
  version = "0.1.8.3";
  src = fetchgit { url = /data/git/itcli; inherit (builtins.fromJSON (builtins.readFile ./git.json)) rev sha256; };
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base bytestring directory filepath mtl optparse-applicative text
    time uuid yaml
  ];
  license = stdenv.lib.licenses.bsd3;
}
