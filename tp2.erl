-module (tp2).
-export ([livreLePlusCher / 0, livreLeMoinsCher / 0, trierPrixDeVente / 0,
	livreEntreDate / 2, livreMeilleurProfit / 0, livreAuteur / 1]).
-include("tp2.hrl").

createList() -> [
	#livre{isbn = 25142, titre = "Deux auteurs pour un livre", auteur1 = "Adrienne LeLandais",
		auteur2 = "Blanche LeTemplier", edition = "Quelque chose", prix_achat = 4.69,
		prix_vente = 10.62, nombre_exemplaires_initial = 10, nombre_exemplaires_actuel = 9,
		date_verification_inventaire = calendar:date_to_gregorian_days({2018, 02, 20})},
	#livre{isbn = 2080710028, titre = "Manifeste du parti communiste", auteur1 = "Karl Marx",
		auteur2 = "Friedrich Engels", edition = "Mass Market", prix_achat = 1.99,
		prix_vente = 6.26, nombre_exemplaires_initial = 41, nombre_exemplaires_actuel = 8,
		date_verification_inventaire = calendar:date_to_gregorian_days({2019, 02, 20})},
	#livre{isbn = 2221088913, titre = "Maison Atreides", auteur1 = "Brian Herbert",
		auteur2 = "Kevin Anderson", edition = "Mass Market", prix_achat = 7.99,
		prix_vente = 10.79, nombre_exemplaires_initial = 15, nombre_exemplaires_actuel = 3,
		date_verification_inventaire = calendar:date_to_gregorian_days({2017, 08, 20})},
	#livre{isbn = 2290088404, titre = "De bons presages", auteur1 = "Terry Pratchett",
		auteur2 = "Neil Gaiman", edition = "J AI LU", prix_achat = 3.21,
		prix_vente = 7.20, nombre_exemplaires_initial = 11, nombre_exemplaires_actuel = 6,
		date_verification_inventaire = calendar:date_to_gregorian_days(2017, 06, 20)},
	#livre{isbn = 2277007099, titre = "Le visage de Dieu", auteur1 = "Igor Bogdanov",
		auteur2 = "Grichka Bogdanov", edition = "J AI LU", prix_achat = 0.95,
		prix_vente = 6.21, nombre_exemplaires_initial = 109, nombre_exemplaires_actuel = 52,
		date_verification_inventaire = calendar:date_to_gregorian_days(2011, 06, 20)}
].

	%	Q1

livreLePlusCher() ->
	lists:nth(1, lists:reverse(lists:keysort(#livre.prix_achat, createList()))).
	
	%	Q2

livreLeMoinsCher() ->
	lists:nth(1, lists:keysort(#livre.prix_vente, createList())).
	
	%	Q3
	
trierPrixDeVente() ->
	lists:reverse(lists:keysort(#livre.prix_vente, createList())).
	
	%	Q4
	
calcProfit(Book) ->
	(Book#livre.prix_vente - Book#livre.prix_achat) * (Book#livre.nombre_exemplaires_initial - Book#livre.nombre_exemplaires_actuel).

getBestProfit([], _, Book) -> Book;
getBestProfit([H | T], Profit, _) when (H#livre.prix_vente - H#livre.prix_achat) * (H#livre.nombre_exemplaires_initial - H#livre.nombre_exemplaires_actuel) > Profit
	-> getBestProfit(T, calcProfit(H), H);
getBestProfit([_ | T], Profit, Book) -> getBestProfit(T, Profit, Book).
	
livreMeilleurProfit() ->
	List = createList(),
	getBestProfit(List, -1, null).
	
	%	Q5
	
getBookVerified([], _, _, BookList) -> BookList;
getBookVerified([H | T], Date1, Date2, BookList) when H#livre.date_verification_inventaire >= Date1, H#livre.date_verification_inventaire =< Date2 ->
	getBookVerified(T, Date1, Date2, BookList ++ [H]);
getBookVerified([_ | T], Date1, Date2, BookList) -> getBookVerified(T, Date1, Date2, BookList).
	
livreEntreDate({Annee1, Mois1, Jour1}, {Annee2, Mois2, Jour2}) ->
	Date1 = calendar:date_to_gregorian_days(Annee1, Mois1, Jour1),
	Date2 = calendar:date_to_gregorian_days(Annee2, Mois2, Jour2),
	getBookVerified(createList(), Date1, Date2, []).

	%	Q6
fuseAuteurList(false, false) -> io:fwrite('Aucun livre trouve~n');
fuseAuteurList(ListAuteur1, false) -> ListAuteur1;
fuseAuteurList(false, ListAuteur2) -> ListAuteur2;
fuseAuteurList(ListAuteur1, ListAuteur2) -> [ListAuteur1 | ListAuteur2].
	
livreAuteur(Auteur) ->
	List = createList(),
	ListAuteur1 = lists:keysearch(Auteur, #livre.auteur1, List),
	ListAuteur2 = lists:keysearch(Auteur, #livre.auteur2, List),
	fuseAuteurList(ListAuteur1, ListAuteur2).