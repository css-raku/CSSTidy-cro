unit class CSSTidy;

use CSS::Stylesheet;
has CSS::Stylesheet $!stylesheet handles<warnings>;

submethod TWEAK(Str:D :$css!) {
    $!stylesheet .= parse: $css, :!warn;
}

method optimize returns Str:D {
    $!stylesheet.Str;
}
