# https://github.com/Momi-V/NixOS/compare/main...v3-fix
# https://discourse.nixos.org/t/pre-rfc-gradual-transition-of-nixos-x86-64-baseline-to-x86-64-v3-with-an-intermediate-step-to-x86-64-v2/35924/72
{
  # Inputs from your flake.
  ...
}:
# x64_v3 Fixes
final: prev: {
  # https://github.com/assimp/assimp/issues/6342
  # assimp = prev.assimp.overrideAttrs (old: {
  #   NIX_CFLAGS_COMPILE = (old.NIX_CFLAGS_COMPILE or "") + " -ffp-contract=on";
  # });

  # https://github.com/godotengine/godot/issues/91217
  # https://github.com/godotengine/godot/pull/95158
  # embree = prev.embree.overrideAttrs (old: {
  #   cmakeFlags = (old.cmakeFlags or [ ]) ++ [
  #     "-DEMBREE_ISA_SSE2=OFF"
  #     "-DEMBREE_ISA_SSE42=OFF"
  #   ];
  # });

  # https://lists.xenproject.org/archives/html/xen-devel/2025-01/msg00439.html
  # FIX for gcc.tune = "generic";
  # xen = prev.xen.overrideAttrs (old: {
  #   patches = (old.patches or [ ]) ++ [
  #     (prev.writeText "xen-text-alignment.patch" ''
  #       --- a/xen/arch/x86/boot/Makefile
  #       +++ b/xen/arch/x86/boot/Makefile
  #       @@ -44,2 +44,2 @@
  #       -text_gap := 0x010200
  #       -text_diff := 0x408020
  #       +text_gap := 0x010240
  #       +text_diff := 0x608040
  #     '')
  #   ];
  # });
}
