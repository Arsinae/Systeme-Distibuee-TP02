-module (tp1).
-export ([voyage / 2]).

voyage(_, Prix) when is_integer(Prix), Prix < 0 -> io:fwrite('Argent negatif~n');
voyage(_, Prix) when not is_integer(Prix) -> io:fwrite('Le prix n est pas un nombre~n');
voyage('japon', Prix) -> io:fwrite('~w JPY~n', [Prix / 0.0126]);
voyage('etats unis', Prix) -> io:fwrite('~w USD~n', [Prix / 1.3595]);
voyage('europe', Prix) -> io:fwrite('~w EUR~n', [Prix / 1.4475]);
voyage('angleterre', Prix) -> io:fwrite('~w GBP~n', [Prix / 1.6995]);
voyage('suisse', Prix) -> io:fwrite('~w CHF~n', [Prix / 1.3451]);
voyage('arabie saoudite', Prix) -> io:fwrite('~w SAR~n', [Prix / 0.3964]);
voyage('afrique du sud', Prix) -> io:fwrite('~w ZAR~n', [Prix / 0.1042]);
voyage('argentine', Prix) -> io:fwrite('~w ARS~n', [Prix / 0.0934]);
voyage('australie', Prix) -> io:fwrite('~w AUD~n', [Prix / 1.0343]);
voyage('bahamas', Prix) -> io:fwrite('~w BSD~n', [Prix / 1.4462]);
voyage('barbade', Prix) -> io:fwrite('~w BBD~n', [Prix / 0.7366]);
voyage('bresil', Prix) -> io:fwrite('~w BRL~n', [Prix / 0.4220]);
voyage(_, _) -> io:fwrite('Le pays choisi n est pas dans la liste~n').

