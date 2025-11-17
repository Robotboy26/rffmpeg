{
  python3Packages,
  fetchFromGitHub,
  pkgs,
}:

 python3Packages.buildPythonApplication {
  pname = "rffmpeg";
  version = "c1d3ab5";
  pyproject = false;

  src = fetchFromGitHub {
    owner = "Robotboy26";
    repo = "rffmpeg";
    rev = "c1d3ab5";
    sha256 = "sha256-3aY/c9L7/hHmcGO90l6nMzssUNwKlbbYUs3YdXowIiE=";
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
