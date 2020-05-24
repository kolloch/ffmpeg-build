let sources = import nix/sources.nix;
in

{ nixpkgs ? sources.nixpkgs
, pkgs ? import nixpkgs {} 
, ffmpeg ? pkgs.ffmpeg-full
, ffmpegSource ? sources.ffmpeg
}:

let depOverrides = ffmpeg.override {
    nvenc = false;
};

in depOverrides.overrideAttrs (attrs: rec {
    name = "${pname}-${version}";
    pname = "ffmpeg-full";
    version = "git-master";
    # Error applying patch
    patches = [];
    src = ffmpegSource;
})