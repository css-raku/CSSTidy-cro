unit class CSSTidy;

use CSS::Stylesheet;

method optimize(Str:D $css) {
    my CSS::Stylesheet $stylesheet .= parse($css);
    $stylesheet.Str;
}
