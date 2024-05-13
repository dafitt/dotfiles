# overlay, to follow git repos directly
{ channels, inputs, ... }:

final: prev: {
  #PACKAGE = inputs.PACKAGE.packages.${prev.system}.PACKAGE;
}
