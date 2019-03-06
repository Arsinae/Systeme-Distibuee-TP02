-module (tp3).
-export ([classeDesAdresses / 0]).

lireFichier(Fichier) -> 
  {ok, ToutesLignes} = file:open(Fichier, [read]), 
  recupererLignes(ToutesLignes, []).
  
recupererLignes(ToutesLignes, Lignes) ->
  case file:read_line(ToutesLignes) of
		{ok, Ligne} -> recupererLignes(ToutesLignes, Lignes ++ [string:trim(Ligne)]);
		eof -> Lignes
  end.
	
stringToInt(Token) ->
	{Int, _} = string:to_integer(Token),
	Int.
	
isOctet(Integer) ->
	{Int, Reste} = string:to_integer(Integer),
	if
		Int == error; Reste /= [] -> false;
		Int < 0; Int > 255 -> false;
		true -> true
	end.
	
isIntegers(TokenList) ->
	(length(TokenList) == 4) andalso isOctet(lists:nth(1, TokenList)) andalso isOctet(lists:nth(2, TokenList))
	andalso isOctet(lists:nth(3, TokenList)) andalso isOctet(lists:nth(4, TokenList)).

creerAdresse([], Adresses) -> Adresses;
creerAdresse([H | T], Adresses) ->
	Token = string:tokens(H, "."),
	Check = isIntegers(Token),
	if
		Check ->
			Elem1 = stringToInt(lists:nth(1, Token)),
			Elem2 = stringToInt(lists:nth(2, Token)),
			Elem3 = stringToInt(lists:nth(3, Token)),
			Elem4 = stringToInt(lists:nth(4, Token)),
			creerAdresse(T, Adresses ++ [{Elem1, Elem2, Elem3, Elem4}]);
		true ->
			creerAdresse(T, Adresses ++ ['erreur'])
	end.
	
printAdress({Octet1, Octet2, Octet3, Octet4}) ->
	io:fwrite('~w.~w.~w.~w : ', [Octet1, Octet2, Octet3, Octet4]);
printAdress(_) ->
	io:fwrite('Adresse : ', []).
	
boucleLocale({127, 0, 0, 1}) -> true;
boucleLocale(_) -> false.

adressePrivee({Octet1, 0, 0, 0}) when Octet1 == 10; Octet1 == 127 -> true;
adressePrivee({172, Octet2, _, _}) when Octet2 >= 16, Octet2 < 32 -> true;
adressePrivee({192, 168, Octet3, _}) when Octet3 < 255 -> true;
adressePrivee({192, 168, 255, 0}) -> true;
adressePrivee(_) -> false.

classeA({0, 0, 0, Octet4}) when Octet4 > 0 -> true;
classeA({Octet1, _, _, _}) when Octet1 < 126 -> true;
classeA({126, _, _, Octet4}) when Octet4 < 255 -> true;
classeA(_) -> false.

classeB({128, 0, 0, Octet4}) when Octet4 > 0 -> true;
classeB({Octet1, _, _, _}) when Octet1 < 191 -> true;
classeB({191, _, _, Octet4}) when Octet4 < 255 -> true;
classeB(_) -> false.

classeC({192, 0, 0, Octet4}) when Octet4 > 0 -> true;
classeC({Octet1, _, _, _}) when Octet1 < 223 -> true;
classeC({223, _, _, Octet4}) when Octet4 < 255 -> true;
classeC(_) -> false.

classeD({Octet1, _, _, _}) when Octet1 >= 224, Octet1 =< 239 -> true;
classeD(_) -> false.

classeE({Octet1, _, _, _}) when Octet1 >= 240, Octet1 =< 247 -> true;
classeE(_) -> false.
	
typeClasse(Adresse) ->
	Locale = boucleLocale(Adresse), Privee = adressePrivee(Adresse),
	ClasseA = classeA(Adresse), ClasseB = classeB(Adresse),	ClasseC = classeC(Adresse),
	ClasseD = classeD(Adresse), ClasseE = classeE(Adresse),
	printAdress(Adresse),
	if 
		Locale -> io:fwrite('boucle locale ~n', []);
		Privee -> io:fwrite('adresse privee~n', []);
		ClasseA -> io:fwrite('classe A~n', []);
		ClasseB -> io:fwrite('classe B~n', []);
		ClasseC -> io:fwrite('classe C~n', []);
		ClasseD -> io:fwrite('classe D~n', []);
		ClasseE -> io:fwrite('classe E~n', []);
		true -> io:fwrite('erreur~n', [])
	end.

afficherClasses([]) -> 1;
afficherClasses([H | T]) -> typeClasse(H), afficherClasses(T).
  
classeDesAdresses() ->
	Lignes = lireFichier('mesTraces.txt'),
	Adresses = creerAdresse(Lignes, []),
	afficherClasses(Adresses).