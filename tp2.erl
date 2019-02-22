-module (tp2).
-export ([livreLePlusCher / 0, livreLeMoinsCher / 0, trierPrixDeVente / 0, livreAuteur / 1]).
-record(livre, {isbn, titre = "", auteur1 = "", auteur2 = "", edition = "", prix_achat,
	prix_vente, nombre_exemplaire_initial, nombre_exemplaire_actuel, date_verification_inventaire}).

createList() -> [
	#livre{isbn = 25142, titre = "Deux auteurs pour un livre", auteur1 = "Adrienne LeLandais",
		auteur2 = "Blanche LeTemplier", edition = "Quelque chose", prix_achat = 4.69,
		prix_vente = 10.62, nombre_exemplaire_initial = 10, nombre_exemplaire_actuel = 9,
		date_verification_inventaire = "20/02/2018"},
	#livre{isbn = 2080710028, titre = "Manifeste du parti communiste", auteur1 = "Karl Marx",
		auteur2 = "Friedrich Engels", edition = "Mass Market", prix_achat = 1.99,
		prix_vente = 6.26, nombre_exemplaire_initial = 41, nombre_exemplaire_actuel = 8,
		date_verification_inventaire = "20/02/2019"},
	#livre{isbn = 2221088913, titre = "Maison Atreides", auteur1 = "Brian Herbert",
		auteur2 = "Kevin Anderson", edition = "Mass Market", prix_achat = 7.99,
		prix_vente = 10.79, nombre_exemplaire_initial = 15, nombre_exemplaire_actuel = 3,
		date_verification_inventaire = "20/08/2017"},
	#livre{isbn = 2290088404, titre = "De bons presages", auteur1 = "Terry Pratchett",
		auteur2 = "Neil Gaiman", edition = "J AI LU", prix_achat = 3.21,
		prix_vente = 7.20, nombre_exemplaire_initial = 11, nombre_exemplaire_actuel = 6,
		date_verification_inventaire = "20/06/2017"},
	#livre{isbn = 2277007099, titre = "Le visage de Dieu", auteur1 = "Igor Bogdanov",
		auteur2 = "Grichka Bogdanov", edition = "J AI LU", prix_achat = 0.95,
		prix_vente = 6.21, nombre_exemplaire_initial = 109, nombre_exemplaire_actuel = 52,
		date_verification_inventaire = "20/06/2011"}
].

getHighestPrice([], Price) -> Price;
getHighestPrice([H | T], Price) when H#livre.prix_achat > Price -> getHighestPrice(T, H#livre.prix_achat);
getHighestPrice([_ | T], Price) -> getHighestPrice(T, Price).

livreLePlusCher() ->
	List = createList(),
	lists:keysearch(getHighestPrice(List, 0), #livre.prix_achat, List).

getLowestPrice([], Price) -> Price;
getLowestPrice([H | T], -1) -> getLowestPrice(T, H#livre.prix_vente);
getLowestPrice([H | T], Price) when H#livre.prix_vente < Price -> getLowestPrice(T, H#livre.prix_vente);
getLowestPrice([_ | T], Price) -> getLowestPrice(T, Price).
	
livreLeMoinsCher() ->
	List = createList(),
	lists:keysearch(getLowestPrice(List, -1), #livre.prix_vente, List).
	
trierPrixDeVente() ->
	lists:reverse(lists:keysort(#livre.prix_vente, createList())).
	
fuseAuteurList(false, false) -> io:fwrite('Aucun livre trouve');
fuseAuteurList(ListAuteur1, false) -> ListAuteur1;
fuseAuteurList(false, ListAuteur2) -> ListAuteur2;
fuseAuteurList(ListAuteur1, ListAuteur2) -> [ListAuteur1 | ListAuteur2].
	
livreAuteur(Auteur) ->
	List = createList(),
	ListAuteur1 = lists:keysearch(Auteur, #livre.auteur1, List),
	ListAuteur2 = lists:keysearch(Auteur, #livre.auteur2, List),
	fuseAuteurList(ListAuteur1, ListAuteur2).