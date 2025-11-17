{
  python3Packages,
  fetchFromGitHub,
  pkgs,
}:

 python3Packages.buildPythonApplication {
  pname = "rffmpeg";
  version = "e7f3b63";
  pyproject = false;

  src = fetchFromGitHub {
    owner = "Robotboy26";
    repo = "rffmpeg";
    rev = "e7f3b63";
    sha256 = "sha256-v/8xMdqlk/krmBjFGzJuhGhVBwZlCSrEUbzHltQ+1Q0=";
  };

  buildInputs = [ python3Packages.click python3Packages.yamllint ];

  buildPhase = ''
      ${python3Packages.pyinstaller}/bin/pyinstaller -F rffmpeg
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp dist/rffmpeg $out/bin
    ln -s ${pkgs.ffmpeg}/bin/ffmpeg $out/bin/ffmpeg
    ln -s ${pkgs.ffmpeg}/bin/ffprobe $out/bin/ffprobe
    runHook postInstall
  '';

  postInstall = ''
  '';
}
