{ config, lib, pkgs, ... }:
let 
  inherit (import ../../global/variables.nix) gpu;
in {

  imports = [] ++ 
  (if gpu == "nvidia" then [./nvidia] else[] );

}